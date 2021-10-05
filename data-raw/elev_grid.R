## code to prepare `elev_grid` dataset goes here
library(tidyverse)
library(exactextractr)
library(raster)
library(sf)

# read elevation
elevation <- raster("data-raw/LF2016_Elev_200_CONUS/Tif/LC16_Elev_200.tif")

# read VIC grid shapefile
vic <- read_sf("data-raw/CONUS_VIC/") |>
  st_transform(crs(cdl)) |>
  select(LAT, LON)

# Extract minimum elevation in each cell
elev_grid_min <- exact_extract(elevation, vic, fun = "min", append_cols = TRUE)

# Extract median elevation in each cell
elev_grid_median <- exact_extract(elevation, vic, fun = "median", append_cols = TRUE)

# combine min and median and creat location variable
elev_grid <- full_join(elev_grid_median, elev_grid_min) |>
  filter(!is.na(min), min > -5000, !is.na(median)) |>
  mutate(location = paste("data", LAT, LON, sep = "_")) |>
  select(location, min_elev = min, median_elev = median)

usethis::use_data(elev_grid, overwrite = TRUE, compress = "bzip2")
