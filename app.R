library(shiny)
library(bslib)

ui <- page_fillable(
  theme = bslib::bs_theme(bg = "#15191E",
                          fg = "#E5E5E5"),
  
  div(style = css(height = "100%",
                  font_family = "Menlo",
                  font_size = "90%",
                  width = "100%",
                  overflow = "none",
                  display = "flex",
                  overflow_wrap = "break-all",
                  text_wrap = "wrap",
                  white_space = "break-spaces",
                  flex_direction = "column-reverse"),
  
           textOutput('stream'),
  )
)

server <- function(input, output, session) {
  
  stream <- reactiveFileReader(
    intervalMillis = 10,
    session,
    filePath  = 'output.txt',
    readFunc = readLines
  )
  
  output$stream <- renderText({
    # browser()
    texto <- stream()
    largo <- length(texto)
    ultimas <- texto[(largo-300):largo]
    
    unidas <- paste0(ultimas, sep = "", collapse = "")
    return(unidas)
    })
}

# Run the application 
shinyApp(ui, server)