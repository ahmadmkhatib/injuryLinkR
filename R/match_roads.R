#' Match Injuries to Road Network
#'
#' Spatially matches injury points to OS Open Roads segments.
#'
#' @param injuries sf object of injury points
#' @param roads sf object of OS Open Roads
#' @param threshold_same Numeric distance threshold (default 50m)
#' @param threshold_fallback Numeric fallback threshold (default 100m)
#'
#' @return sf object with matched road attributes
#' @export
match_roads <- function(injuries, roads,
                        threshold_same = 50,
                        threshold_fallback = 100) {

  injuries <- sf::st_transform(injuries, 27700)
  roads <- sf::st_transform(roads, 27700)

  nearest <- sf::st_nearest_feature(injuries, roads)

  matched <- injuries %>%
    dplyr::mutate(
      road_link_id = roads$road_link_id[nearest]
    )

  return(matched)
}
