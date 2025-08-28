generador <- function(
    modo = 8,
    t = 0.001,
    simbolo = "|", vacio = " ",
    n = 1e4,
    rng_min = 1,
    rng_max = 18) {
  
  # archivo
  con <- "output.txt"
  
  wait <- Sys.sleep
  
  # función que escribe al archivo de texto
  imprimir <- function(texto) {
    write(texto, file = con, sep = "", append = TRUE) # al archivo
  }
  
  # modos
  if (modo == 7) {
    
    for (i in 1:n) {
      cantidad <- sample(rng_min:rng_max, 1)
      rayas <- paste(rep(simbolo, cantidad), collapse = "")
      if (i %% 2 == 0) {
        texto <- vacio
      } else {
        texto <- rayas
      }
      
      imprimir(texto)
      wait(t/2)
    }
    
  } else if (modo == 8) {
    
    for (i in 1:n) {
      cantidad <- sample(rng_min:rng_max, 1)
      
      if (i %% 2 == 0) {
        texto <- paste(rep(vacio, cantidad), collapse = "")
      } else {
        texto <- paste(rep(simbolo, cantidad), collapse = "")
      }
      
      imprimir(texto)
      wait(t)
    }
  }
}
