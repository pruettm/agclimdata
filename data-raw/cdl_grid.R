## code to prepare `cdl_grid` dataset goes here
library(tidyverse)
library(exactextractr)
library(raster)
library(sf)

# read 2020 CDL
cdl <- raster("data-raw/2020_30m_cdls/2020_30m_cdls.img")

# read VIC grid shapefile
vic <- read_sf("data-raw/CONUS_VIC/") |>
  st_transform(crs(cdl)) |>
  select(LAT, LON)

count_class <- function(values, coverage_fraction){
  table(values) |>
    as.data.frame()
}

# Extract cdl codes
cdl_grid <- exact_extract(cdl, vic, fun = count_class,
                          append_cols = TRUE)

cdl_grid |>
  mutate(location = paste("data", LAT, LON, sep = "_")) |>
  select(location, cdl_code = value, n = Freq)

usethis::use_data(cdl_grid, overwrite = TRUE, compress = "bzip2")
