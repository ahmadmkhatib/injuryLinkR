#' Create Injury-Level Dataset
#'
#' Joins collisions, casualties and vehicles and creates a unique injury_id.
#'
#' @param collisions Data frame of STATS19 collisions
#' @param casualties Data frame of STATS19 casualties
#' @param vehicles Data frame of STATS19 vehicles
#'
#' @return sf object of injury-level dataset
#' @export
create_injuries <- function(collisions, casualties, vehicles) {

  injuries <- casualties %>%
    dplyr::left_join(collisions, by = "collision_index") %>%
    dplyr::left_join(vehicles,
                     by = c("collision_index", "vehicle_reference")) %>%
    dplyr::mutate(
      injury_id = paste0(collision_index, "_", casualty_reference),
      year = as.integer(format(date, "%Y")),
      month = as.integer(format(date, "%m"))
    )

  return(injuries)
}
