#' Describe rectangular data
#'
#' Intended use is for creating a description of rectangular data in a data
#' README file.
#'
#' @param data Dataframe
#' @param metadata Dataframe with two columns:
#' - "col" (column names in `data`)
#' - "desc" (description of each column).
#'
#' "col" must match column names in `data` exactly (including order)
#' @param bullet Character vector of length 1; type of bullet to print before
#' each line of output. May choose from '-', '*', or 'none'.
#' @param dbl_space Logical vector of length 1; should the output have double
#' spacing? (an extra line break between each line of text)
#'
#' @return Character string formatted for including in data README
#' @examples
#' cars_small <- mtcars[1:10, 1:3]
#' cars_metadata <- data.frame(
#'   col = c("mpg", "cyl", "disp"),
#'   desc = c("Miles per gallon", "Number of cylinders", "Displacement")
#' )
#' desc_data(cars_small, cars_metadata)
#' @export
desc_data <- function(data, metadata, bullet = "-", dbl_space = FALSE) {

  # Check input
  assertthat::assert_that(assertthat::is.string(bullet))
  assertthat::assert_that(
    bullet %in% c("-", "*", "none")
  )
  assertthat::assert_that(assertthat::is.flag(dbl_space))
  assertthat::assert_that(is.data.frame(data))
  assertthat::assert_that(is.data.frame(metadata))

  # In case a tibble was provided, convert to data.frame
  metadata <- as.data.frame(metadata)

  # More checks
  assertthat::assert_that(
    ncol(metadata) == 2,
    msg = "metadata must have two columns")
  assertthat::assert_that(
    all(colnames(metadata) %in% c("col", "desc")),
    msg = "metadata column names must be 'col' and 'desc'")
  assertthat::assert_that(
    assertthat::noNA(metadata))
  assertthat::assert_that(
    assertthat::not_empty(metadata))
  assertthat::assert_that(
    isTRUE(all.equal(colnames(data), metadata$col)),
    msg = "Column names of data do not match 'col' of metadata"
  )

  if (bullet == "-") bullet <- "- "
  if (bullet == "*") bullet <- "* "
  if (bullet == "none") bullet <- ""

  if (isTRUE(dbl_space)) return(
    glue::glue("{bullet}{metadata$col}: {metadata$desc}\n\n")
  )

  glue::glue("{bullet}{metadata$col}: {metadata$desc}\n")

}
