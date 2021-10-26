## code to prepare `grid_stats` dataset goes here
library(foreign)
library(tidyverse)
library(lutz)

grid_stats <- read.dbf("data-raw/VICID_CO.DBF") |>
  janitor::clean_names() |>
  mutate(location = paste("data", vicclat, vicclon, sep = "_")) |>
  select(location, lat = vicclat,
         lon = vicclon, state, county, area_km2 = vic_km2) |>
  mutate(across(where(is.factor), as.character)) |>
  as_tibble() |>
  mutate(tz = lutz::tz_lookup_coords(lat, lon, method = "accurate"),
        offset = map(tz, lutz::tz_offset, dt = "2020-01-01")) |>
  unnest(offset) |>
  mutate(tz_long = case_when(zone == "EST" ~ -75,
                             zone == "CST" ~ -90,
                             zone == "MST" ~ -105,
                             zone == "PST" ~ -120)) |>
  select(-tz, -tz_name, -date_time, -zone, -is_dst, -utc_offset_h)



usethis::use_data(grid_stats, overwrite = TRUE, compress = "bzip2")
