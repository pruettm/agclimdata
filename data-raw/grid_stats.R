## code to prepare `grid_stats` dataset goes here
library(foreign)
library(tidyverse)

grid_stats <- read.dbf("data-raw/VICID_CO.DBF") |>
  janitor::clean_names() |>
  mutate(location = paste("data", vicclat, vicclon, sep = "_")) |>
  select(location, lat = vicclat,
         lon = vicclon, state, county, area_km2 = vic_km2) |>
  mutate(across(where(is.factor), as.character)) |>
  as_tibble()



usethis::use_data(grid_stats, overwrite = TRUE, compress = "bzip2")
