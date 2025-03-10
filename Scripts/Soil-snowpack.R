# Define the directory path where the data files are stored ----
directory_path <- "~//OneDrive/git-repos/LCBP_Soils/OriginalData/"
output_path <- "~//OneDrive/git-repos/LCBP_Soils/Outputs/"

# Libraries ----
library(pacman)
p_load(readxl, dplyr,ggplot2, knitr, patchwork, tidyr, lubridate, gridExtra)

# Source functions ----
source_batch("Functions")

# Read in data ----

# Resin data
lcbp_resins <- read.csv(file.path(directory_path, "soil-nutrients/Resin_timeseries.csv"))

# Soil temp data
hford_soil <- read.csv(file.path(directory_path, "soil-sensors/BREE_WY22-23/WY22-WY23_HW1_soil_temp_VWC_2025-02-22.csv")) %>%
  mutate(datetime = ymd_hms(Timestamp), 
         Stream = 'Hungerford')    
wade_soil <- read.csv(file.path(directory_path, "soil-sensors/BREE_WY22-23/WY22-WY23_WW5_soil_temp_2025-02-22.csv")) %>%
  mutate(datetime = ymd_hms(Timestamp), 
         Stream = 'Wade')

# Snowpack data
hford_snow <- read.csv(file.path(directory_path, "met-station/enf-noaa-precip-WYW23.csv")) %>%
mutate(date = ymd(DATE), 
       Stream = 'Hungerford')    
wade_snow <- read.csv(file.path(directory_path, "met-station/mansfield-noaa-WY22-WY23-3855342.csv")) %>%
  mutate(date = ymd(DATE), 
         Stream = 'Wade')    
#snow_dt <- "%Y-%m-%d" # trying to set up convert posixct function

# Met data (air temp, precip)
hford_met <- read.csv(file.path(directory_path, "met-station/hungerford_2020-2024_met_2024-11-08.csv"))
wade_met <- read.csv(file.path(directory_path, "met-station/wade_2020-2024_met_2024-11-08.csv"))

convert_to_POSIXct(wade_snow, "DATE", snow_dt)

