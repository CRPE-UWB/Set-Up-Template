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
backup <- data # allows you to keep a backup version of the file just in case + don't have to interact with AWS every time
data <- backup

# Cleaning --------------------------------------------------------------------------------------------------------
...


