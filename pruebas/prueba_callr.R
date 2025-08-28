library(callr)

generador <- function() {
  wait <- Sys.sleep
  n <- 1e3
  t <-  0.01
  
  # archivo
  con <- "output.txt"
  
  # borrar contenido
  write("", file = con)
  
  for (i in 1:n) {
    cantidad <- sample(1:18, 1)
    
    if (i %% 2 == 0) {
      texto <- paste(rep(" ", cantidad), collapse = "")
    } else {
      texto <- paste(rep("|", cantidad), collapse = "")
    }
    
    write(texto, file = con, sep = "", append = TRUE) # al archivo
    # cat(texto) # a la consola
    wait(t)
  }
}

ruido <- callr::r_bg(generador)

ruido$interrupt()

ruido$read()