#### Center on Reinventing Public Education #### 
# Title: Helpful Functions
# Descriptions: A collection of helpful functions that you might need for the future
# Notes: -If you add a function, make sure you use require()/library() to indicate which libraries would be required if any. 
#        By including the libraries needed, the user wouldn't have to worry about requiring it themselves.
#        -You can either copy and paste the functions you want into your own code OR read this file in as a script [putting "source(Functions.R)" in your code]

# Function: Replaces Special Characters
# Libraries: gsubfn
no_more_special_characters <- function(df_col) {
  # need to replace the chracters
  require(gsubfn)
  # makes sure the columns are characters
  df_col <- as.character(df_col)
  # list of special characters to replace with
  unwanted_array = list(    'Š'='S', 'š'='s', 'Ž'='Z', 'ž'='z', 'À'='A', 'Á'='A', 'Â'='A', 'Ã'='A', 'Ä'='A', 'Å'='A', 'Æ'='A', 'Ç'='C', 'È'='E', 'É'='E',
                            'Ê'='E', 'Ë'='E', 'Ì'='I', 'Í'='I', 'Î'='I', 'Ï'='I', 'Ñ'='N', 'Ò'='O', 'Ó'='O', 'Ô'='O', 'Õ'='O', 'Ö'='O', 'Ø'='O', 'Ù'='U',
                            'Ú'='U', 'Û'='U', 'Ü'='U', 'Ý'='Y', 'Þ'='B', 'ß'='Ss', 'à'='a', 'á'='a', 'â'='a', 'ã'='a', 'ä'='a', 'å'='a', 'æ'='a', 'ç'='c',
                            'è'='e', 'é'='e', 'ê'='e', 'ë'='e', 'ì'='i', 'í'='i', 'î'='i', 'ï'='i', 'ð'='o', 'ñ'='n', 'ò'='o', 'ó'='o', 'ô'='o', 'õ'='o',
                            'ö'='o', 'ø'='o', 'ù'='u', 'ú'='u', 'û'='u', 'ý'='y', 'ý'='y', 'þ'='b', 'ÿ'='y' )
  # replaces the characters
  df_col <- gsubfn(paste(names(unwanted_array),collapse='|'), unwanted_array,df_col)
  
  return(df_col)
}

# Function: adds a lat and lon column using an address and zip
# Libraries: RJSONIO
# Notes: The code can be modified in the case where zip is unavailable. 
#        Just remove the zip from the argument and change full into: "full <- address"
geocodeAddress <- function(address, zip) {
  require(RJSONIO)
  full <- paste(address, zip, sep=" ")
  url <- "http://maps.google.com/maps/api/geocode/json?address="
  url <- URLencode(paste(url, full, "&sensor=false", sep = ""))
  x <- fromJSON(url, simplify = FALSE)
  if (x$status == "OK") {
    out <- c(x$results[[1]]$geometry$location$lat,
             x$results[[1]]$geometry$location$lng)
  } else {
    out <- NA
  }
  Sys.sleep(0.2)  # API only allows 5 requests per second
  out
}

# Function: retreieve whole numeric values from alphanumeric strings
# Libraries: stringr
# Note: only works to if the numbers are all together ie xx33232swe => GOOD    x332xx56 => BAD cause only gets 332
num_only <- function(x) {
  require(stringr)
  # sets to look for whole number
  regexp <- "[[:digit:]]+"
  x <- str_extract(x, regexp)
}