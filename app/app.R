library(shiny)
library(bslib)
library(callr)

source("generadores.R", local = TRUE)
# generador()

anchos <- "100%"

ui <- page_fillable(
  theme = bslib::bs_theme(bg = "#181818",
                          fg = "#E5E5E5", 
                          primary = "#E5E5E5",
                          base_font = "Monaco",
                          font_scale = .6),
  
  # desactivar parpadeo al cargar
  busyIndicatorOptions(fade_opacity = 1),
  
  # css
  tags$style(".form-control {
             font-size:80%;
             padding: .2rem .4rem;
             border: solid 1px #282828;
             }"),
  
  layout_columns(
    gap = 0,
    col_widths = c(2, 10),
    
    card(min_height = "140px", 
         actionLink("iniciar", "iniciar"),
         actionLink("detener", "detener"),
         
         
         numericInput("modo", "modo",
                      value = 8, width = anchos),
         # selectInput("modo", "modo",
         #              choices = c(7, 8), width = anchos),
         
         layout_columns(gap = 20,
                        textInput("simbolo", "símbolo",
                                  value = "|", width = anchos),
                        
                        textInput("vacio", "vacío",
                                  value = " ", width = anchos),
         ),
         
         numericInput("tiempo", "tiempo",
                      value = 0.01,
                      min = 0.001,
                      max = 0.1,
                      step = 0.001,
                      width = anchos),
         
         numericInput("intervalo", "intervalo",
                      value = 20,
                      min = 1,
                      max = 200,
                      step = 5,
                      width = anchos),
         
         numericInput("rng_max", "max", 
                      value = 18, width = anchos),
         
         numericInput("rng_min", "min", 
                      value = 1, width = anchos),
         
         actionLink("limpiar", "limpiar"),
    ),
    
    card(
      div(style = css(height = "100%",
                      width = "100%",
                      font_family = "Monaco",
                      font_size = "80%",
                      line_height = 1.1,
                      display = "flex",
                      overflow = "hidden",
                      overflow_wrap = "break-all",
                      # word_wrap = "break-word",
                      # text_wrap = "nowrap",
                      white_space = "break-spaces",
                      flex_direction = "column-reverse"),
          
          textOutput('stream'),
      )
    )
  )
)

server <- function(input, output, session) {
  
  ejecutar <- function() {
    callr::r_bg(generador, 
                supervise = TRUE,
                args = list(modo = input$modo,
                            t = input$tiempo,
                            simbolo = input$simbolo,
                            vacio = input$vacio,
                            rng_max = input$rng_max,
                            rng_min = input$rng_min))
  }
  
  observeEvent(input$iniciar, {
    ruido <<- ejecutar()
  })
  
  stream <- reactiveFileReader(
    intervalMillis = \(x) as.numeric(input$intervalo),
    session,
    filePath  = 'output.txt',
    readFunc = readLines
  )
  
  output$stream <- renderText({
    # browser()
    
    texto <- stream()
    unido <- paste0(texto, collapse = "")
    letras <- strsplit(unido, split = "") |> unlist()
    
    # cortar texto
    max_chr <- 15000
    largo <- length(letras)
    limite <- ifelse(largo < max_chr, largo, max_chr)
    # letras <- letras[(largo-limite):largo]
    letras <- strtrim(letras, width = largo)
    unidas <- paste0(letras, sep = "", collapse = "")
    return(unidas)
  })
  
  observeEvent(input$detener, {
    ruido$interrupt()
  })
  
  # reiniciar al recibir input
  observeEvent(as.numeric(input$modo) | input$tiempo |
                 as.numeric(input$simbolo) | as.numeric(input$vacio) |
                 input$rng_max | input$rng_min, {
                   ruido$interrupt()
                   ruido <<- ejecutar()
                 }, ignoreInit = TRUE)
  
  # terminar proceso
  onStop(\(x) ruido$interrupt())
  
  # limpiar
  observeEvent(input$limpiar, {
    # ruido$interrupt()
    write("", file = "output.txt")
  })
}

# Run the application 
shinyApp(ui, server)