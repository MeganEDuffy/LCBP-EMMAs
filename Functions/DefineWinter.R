# --------------------------------------
# FUNCTION define_winter
# required packages: none
# description: defines meteorological winter for a given (water) year
# inputs: dataframe, dataframe column name with datetime, year
# outputs: 
########################################
define_winter <- function(df, datetime_col, year) {
  
  # Check if the datetime column exists in the dataframe
  if(!datetime_col %in% names(df)) {
    stop("The specified datetime column does not exist in the dataframe.")
  }
  
  # Convert the datetime column to Date type if it's not already
  df[[datetime_col]] <- as.Date(df[[datetime_col]])
  
  # Define the start and end dates for the water year
  wy_start <- as.Date(paste(year - 1, "-12-21", sep = ""))
  wy_end <- as.Date(paste(year, "-03-01", sep = ""))
  
  # Filter the dataframe for the water year
  df_filtered <- df %>%
    filter(df[[datetime_col]] >= wy_start & df[[datetime_col]] <= wy_end)
  
  # Return the filtered dataframe
  return(df_filtered)
  

} # end of function define_winter
# --------------------------------------
# define_winter()
