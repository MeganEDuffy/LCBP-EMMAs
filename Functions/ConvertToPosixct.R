# --------------------------------------
# FUNCTION convert_to_POSIXct
# required packages: lubridate
# description: converts a dataframe with datetime in a character format to R datetime
# inputs: dataframe name, dataframe's datetime column name, current (starting) datetime format type
# outputs: 
########################################
convert_to_POSIXct <- function(df, datetime_col, datetime_format) {

# assign parameter defaults
if (is.null(x) | is.null(y)) {
  x <- runif(10)
  y <- runif(10)
}

# Check if the datetime column exists in the dataframe
    if(!datetime_col %in% names(df)) {
      stop("The specified column does not exist in the dataframe.")
    }
    
    # Convert the specified column to POSIXct using the provided format
    df[[datetime_col]] <- as.POSIXct(df[[datetime_col]], format = datetime_format)
    
    # Return the modified dataframe
    return(df)
  
  
return(print('...checking function: convert_to_POSIXct()'))

} # end of function convert_to_POSIXct
# --------------------------------------
# convert_to_POSIXct()
