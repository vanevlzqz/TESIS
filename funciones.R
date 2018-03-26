

########################################################################################

clean.envir <- function(pattern){
  
  objs <- ls(pos = ".GlobalEnv")
  rm(list = objs[grep(pattern, objs)], pos = ".GlobalEnv")
}

# clean.envir("rama_2")

########################################################################################

read_assign_all <- function(name = "redda", file.path = "/Users/Vanessa/Desktop/Datos_Excel/REDDA/10REDDA", pattern = NULL) {
  
  read_assign <- function(file){ 

    file_short <- substr(file, 1, nchar(file)-4)
    
    read.fun <- switch(substr(file, nchar(file)-2, nchar(file)),
                       "csv" = readr::read_csv,
                       "rds" = readRDS,
                       "xls" = gdata::read.xls,
                       "dbf" = foreign::read.dbf)
    
    assign(paste0(name, "_", file_short), 
       read.fun(paste0(file.path, "/",file)), 
       envir = .GlobalEnv)
  }
  
  archivos <- list.files(path = file.path)
  
  if(!is.null(pattern))
    archivos <- archivos[grep(pattern, archivos)]
  
  purrr::walk(archivos, read_assign)
}

# read_assign_all(name = "rama", file.path = "/Users/Vanessa/Desktop/Datos_Excel/RAMA")

########################################################################################

tidy_pollution <- function(pattern = "rama_2010", cols = c("FECHA", "TLA", "MER", "SAG")){
  
  df_tidy <- function(df){ 
    
    char_name <- deparse(substitute(df))
    ind <- grepl("201", strsplit(char_name, "") %>% unlist) %>% which + 2
    
    paste0(deparse(substitute(df)), "_tidy") <<- df %>% 
      select_(cols) %>% 
      gather_("estaciones", "valor", setdiff(names(.), "FECHA")) %>%
      mutate(pollutant = substr(char_name, ind, nchar = (char_name)))
  }
  
  objs <- ls(envir = .GlobalEnv)[grep(pattern, ls(envir = .GlobalEnv))]
  
  purrr::walk(objs, df_tidy)
}

# tidy_pollution(pattern = "rama_2010", cols = c("FECHA", "TLA", "MER", "SAG"))

########################################################################################

names_all <- function(pattern){

  objs <- ls(envir = .GlobalEnv)[grep(pattern, ls(envir = .GlobalEnv))]
  
  purrr::map(objs, function(x) parse(text = x) %>% eval %>% names)
}










































































