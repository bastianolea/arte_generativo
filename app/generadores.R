generador <- function(
    modo = 8, # algoritmo
    t = 0.001, # tiempo entre pasos
    simbolo = "|", vacio = " ",
    n = 1e4, # duración del loop
    rng_min = 1,
    rng_max = 18) {
  
  t <- ifelse(t == 0, 0.001, t)
  
  # función que escribe al archivo de texto
  imprimir <- function(texto) {
    write(texto, file = "output.txt", sep = "", append = TRUE) # al archivo
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
      Sys.sleep(t/2)
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
      Sys.sleep(t)
    }
  }
}
