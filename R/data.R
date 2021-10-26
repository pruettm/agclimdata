#' CDL Grid
#'
#' 2020 CDL aggregated to 1/16th degree resolution commonly used in
#' hydroclimatalogy data
#'
#' @format A data frame with 3 variables: \code{location}, \code{cdl_code} and
#'   \code{n}
"cdl_grid"

#' Elevation Grid
#'
#' CONUS dem aggregated to 1/16th degree resolution commonly used in
#' hydroclimatalogy data. Elevations are recorded as meters
#' above sea level and aggregated to min and median for each grid cell.
#'
#' @format A data frame with 3 variables: \code{location}, \code{min_elev} and
#'   \code{median_elev}
"elev_grid"

#' Grid Location data
#'
#' Lat, long, state, county, area (km^2), associated time zone longitude information
#' for each CONUS 1/16th degree grid
#'
#' @format A data frame with 6 variables: \code{location}, \code{lat}, \code{lon}, \code{state}, \code{county} and
#'   \code{area_km2}
"grid_stats"
