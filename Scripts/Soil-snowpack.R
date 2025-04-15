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
mutate(datetime = ymd_h(Date), 
       Stream = 'Hungerford')    
wade_snow <- read.csv(file.path(directory_path, "met-station/mansfield-noaa-WY22-WY23-3855342.csv")) %>%
  mutate(datetime = ymd(DATE), 
         Stream = 'Wade')    
#snow_dt <- "%Y-%m-%d" # trying to set up convert posixct function
#convert_to_POSIXct(wade_snow, "DATE", snow_dt) # again, figure this out in future

# Met data (air temp, precip)
hford_met <- read.csv(file.path(directory_path, "met-station/hungerford_2020-2024_met_2024-11-08.csv"))
wade_met <- read.csv(file.path(directory_path, "met-station/wade_2020-2024_met_2024-11-08.csv"))

# Plot soil temp vs snowpack

# Combine data for each site
wade_data <- left_join(wade_soil, wade_snow, by = "datetime") %>%
  mutate(Stream = "Wade")

hford_data <- left_join(hford_soil, hford_snow, by = "datetime") %>%
  mutate(Stream = "Hungerford")

hford_data_wwy23 <- define_winter(hford_data, "datetime", 2023)
wade_data_wwy23 <- define_winter(wade_data, "datetime", 2023)


# Create the scatter plot for both stream sites
ggplot(wade_data_wwy23, aes(x = TemperatureSoilTemp_15cm_WW_pit5, y = SNWD)) +
  geom_point() +
  #facet_wrap(~ Stream, scales = "free") +  # Create separate panels for each stream site
  labs(
    x = "Soil Temperature (°C)",
    y = "Snowpack Depth (cm)",
    title = "Snowpack Depth vs Soil Temperature by Stream Site"
  ) +
  theme_minimal()

# For Hungerford site
ggplot(hford_data_wwy23, aes(x = TemperatureSoilTemp_15cm_HW_pit1, y = modeled_snow_depth_cm)) +
  geom_point() +
  labs(
    x = "Soil Temperature (°C)",
    y = "Snowpack Depth (cm)",
    title = "Snowpack Depth vs Soil Temperature by Stream Site"
  ) +
  theme_minimal()
