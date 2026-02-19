#' Build Full Injury Dataset
#'
#' Runs the full injury linkage pipeline.
#'
#' @export
build_injury_dataset <- function(collisions, casualties, vehicles,
                                 roads, oa) {

  inj <- create_injuries(collisions, casualties, vehicles)
  inj <- match_roads(inj, roads)
  inj <- assign_oa(inj, oa)

  return(inj)
}
