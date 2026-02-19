#' Assign Output Areas
#'
#' Spatially assigns injuries to Output Areas.
#'
#' @param injuries sf injury dataset
#' @param oa sf Output Area boundaries
#'
#' @return sf object with OA codes
#' @export
assign_oa <- function(injuries, oa) {

  injuries <- sf::st_join(injuries, oa["OA11CD"], left = TRUE)

  return(injuries)
}
