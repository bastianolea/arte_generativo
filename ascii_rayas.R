wait <- Sys.sleep
n <- 2e4
t <-  0.0001




# intervalo regular que genera diagonales de vacío por cada 10 líneas
for (i in 1:n) {
  if (i %% 10 == 0) cat(" ") else cat("|")
  wait(t)
}

# patrón de ruido con figuras de vacío contínuas hacia abajo, como líneas de zebra
for (i in 1:n) {
  vacio <- paste(rep(" ", sample(1:6, 1)), collapse = "")
  if (i %% 10 == 0) cat(vacio) else cat("|")
  wait(t)
}

# genera una especie de lluvia regular con fondo vacío
for (i in 1:n) {
  vacio <- paste(rep(" ", i %% 10), collapse = "")
  if (i %% 2 == 1) cat(vacio) else cat("|")
  wait(t)
}

# genera barras diagonales con degradado
for (i in 1:n) {
  vacio <- paste(rep("|", i %% 10), collapse = "")
  if (i %% 2 == 1) cat(vacio) else cat(" ")
  wait(t)
}

# genera una especie de cuadrantes con degradado, o diagonales crecientes
for (i in 1:n) {
  vacio <- paste(rep("|", i %% 10), collapse = "")
  if (i %% 2 == 0) cat(vacio) else cat(" ")
  wait(t)
}

# para cada número, imprime x cantidad de rayas o vacío dependiendo del último dígito del número, por cada par/impar
# genera una especie de cuadrantes con degradado, o diagonales crecientes con más espaciado
for (i in 1:n) {
  vacio <- paste(rep(" ", i %% 10), collapse = "")
  rayas <- paste(rep("|", i %% 10), collapse = "")
  if (i %% 2 == 0) cat(vacio) else cat(rayas)
  wait(t)
}

# fondo blanco con muchos espacios distribuidos aleatoriamente
# el fondo se hace con secuencia de números al azar, interrumpidos por 1 espacio, por cada par/impar
for (i in 1:n) {
  cantidad <- sample(1:16, 1)
  rayas <- paste(rep("|", cantidad), collapse = "")
  if (i %% 2 == 0) cat(" ") else cat(rayas)
  wait(t)
}



# ruido con barras anchas
for (i in 1:n) {
  cantidad <- sample(1:18, 1)
  rayas <- paste(rep("|", cantidad), collapse = "")
  vacio <- paste(rep(" ", cantidad), collapse = "")
  if (i %% 2 == 0) cat(vacio) else cat(rayas)
  wait(t)
}

# ruido con barras anchas y líneas solas esporádicas entre medio
for (i in 1:n) {
  unos <- rep(1, 10)
  cantidad <- sample(c(unos, 1:18), 1)
  rayas <- paste(rep("|", cantidad), collapse = "")
  vacio <- paste(rep(" ", cantidad), collapse = "")
  if (i %% 2 == 0) cat(vacio) else cat(rayas)
  wait(t)
}

# lienzo blanco con puntos esparcidos
for (i in rpois(n, 10)) {
  rayas <- paste(rep("|", i), collapse = "")
  vacio <- " "
  if (i %% 2 == 0) cat(vacio) else cat(rayas)
  wait(t)
}

# distribución poisson, muy ruidosa con figuras geométricas esporádicas
for (i in rpois(n, 1)) {
  rayas <- paste(rep("|", i), collapse = "")
  vacio <- paste(rep(" ", i), collapse = "")
  if (i %% 2 == 0) cat(vacio) else cat(rayas)
  wait(t)
}

# secuencia de pares parejos, genera barras verticales o diagonales al cambiar cantidad de columnas
for (i in 1:n) {
  cantidad <- 8
  rayas <- paste(rep("|", cantidad), collapse = "")
  vacio <- paste(rep(" ", cantidad), collapse = "")
  if (i %% 2 == 0) cat(vacio) else cat(rayas)
  wait(1e-3)
}


# intervalo regular que parece panal
for (i in 1:n) {
  if (i %% 2 == 0) cat("-") else cat("|")
  wait(t)
}

# secuencia regular de barras y vacío
# se ve como que avanzan al achicar la ventana
for (i in 1:n) {
  x <- i %% 10
  if (x %in% c(1, 2, 3)) {
    cat("|")
    cat(paste(rep(" ", x), collapse = ""))
    wait(t)
  }
}
