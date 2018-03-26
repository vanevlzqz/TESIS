
# Elimina de golpe elementos segun un patron

clean.envir <- function(pattern){
  
  objs <- ls(pos = ".GlobalEnv")
  rm(list = objs[grep(pattern, objs)], pos = ".GlobalEnv")
}

# Ej: 
# clean.envir("redmet10_")
# borra todos los objetos que su nombre contenga redmet10_

# Funcion para cargar todos los datos de un cierto directorio

read_all <- function(x, path) {
  
  x_short <- substr(x, 1, nchar(x)-4)
  # <<- es equivalente a assign(..., env = .GlobalEnv)
  assign(x_short, read.dbf(file = paste0(path, x)), 
         envir = .GlobalEnv)
}

# archivos <- ls()
# walk2(archivos, path, read_all)




















































































