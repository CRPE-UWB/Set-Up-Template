#### Center on Reinventing Public Education #### 
# Title: Should be concise, but descriptive enough to tell others what the code will contain
# Description: A brief description of what is in the code.
# Created by: User on MM-DD-YY
# Updated by: User on MM-DD-YY
# Data from: 
#     Website, S3, Google Drive, AWS, etc.   
# Link to Github: https://github.com/CRPE-UWB/
# Notes: Anything users should know before reading the rest of the code

# Set up --------------------------------------------------------------------------------------------------------
# Set working directory
setwd()

# Tell which libraries are required
library()

# Functions --------------------------------------------------------------------------------------------------------

# Connect to AWS --------------------------------------------------------------------------------------------------------

# Key ID - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Point this to wherever you store your AWS Credentials - - - - - - - 
access <- read.csv("pathway to your key") # its ok to push this up as long as it doesn't contain information about your key itself
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

key <- as.character(access[1,3])
secret <- as.character(access[1,4])

Sys.setenv(
  "AWS_ACCESS_KEY_ID" = key,
  "AWS_SECRET_ACCESS_KEY" = secret
)

bucket_list_data()

readAWS_csv <- function(filename, filepath, bucket){
  
  location <- filepath
  bucketname <- bucket
  
  save_object(paste(location, filename, sep ="/"), bucket = bucketname, file = filename)
  data <- read.csv(filename)
  
  if (file.exists(filename)) file.remove(filename)
  
  return(data)
}


data <- readAWS_csv("name-of-the-file.csv", "pathway-to-the-file" ,"database.crpe")
backup <- data # allows you to keep a backup version of the file just in case:
               # don't have to interact with AWS every time  =
data <- backup

# Cleaning --------------------------------------------------------------------------------------------------------
...

# Clean Specifically for the Database --------------------------------------------------------------------------------------------------------
# Make sure all NAs are turned into -99
data[is.na(ocr)] <- -99

# All Commas/"," must go away 
data[data == ","] <- ""
data <- as.data.frame(sapply(data, gsub, pattern=",", replacement="")) # stringr version

# All Tildes/"~" must be turned to Hyphens/"-" 
data[data == "~"] <- "-"
data <- as.data.frame(sapply(data, gsub, pattern="~", replacement="-")) # stringr version

# Change all special characters with 2 versions:
# 1) Use the Function from the Functions.R File, BUT it can only do one column at a time
data$col_name <- no_more_special_characters(data$col_name)
# 2) Use the stringr version that can be applied to all at once, BUT it can only change one character at a time
data <- as.data.frame(sapply(data, gsub, pattern="ñ", replacement="n")) # usually the problem
data <- as.data.frame(sapply(data, gsub, pattern="é", replacement="e")) # usually the problem
