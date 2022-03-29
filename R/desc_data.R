#' Describe rectangular data
#'
#' Intended use is for creating a description of rectangular data in a data
#' README file.
#'
#' @param data Dataframe
#' @param metadata Dataframe with two columns:
#' - "col_names" (column names in `data`)
#' - "desc" (description of each column).
#'
#' "col_names" must match column names in `data` exactly (including order)
#' @param bullet Character vector of length 1; type of bullet to print before
#' each line of output. May choose from '-', '*', or 'none'.
#' @param dbl_space Logical vector of length 1; should the output have double
#' spacing? (an extra line break between each line of text)
#'
#' @return Character string formatted for including in data README
#' @examples
#' cars_small <- mtcars[1:10, 1:3]
#' cars_metadata <- data.frame(
#'   col_names = c("mpg", "cyl", "disp"),
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
  assertthat::assert_that(
    ncol(metadata) == 2,
    msg = "metadata must have two columns")
  assertthat::assert_that(
    all(colnames(metadata) %in% c("col_names", "desc")),
    msg = "metadata column names must be 'col_names' and 'desc'")
  assertthat::assert_that(
    assertthat::noNA(metadata))
  assertthat::assert_that(
    assertthat::not_empty(metadata))

  col_names <- colnames(data)

  assertthat::assert_that(
    isTRUE(all.equal(col_names, metadata$col)),
    msg = "Column names of data do not match 'col_names' of metadata"
  )

  if (bullet == "-") bullet <- "- "
  if (bullet == "*") bullet <- "* "
  if (bullet == "none") bullet <- ""

  if (isTRUE(dbl_space)) return(
    glue::glue("{bullet}{metadata$col_names}: {metadata$desc}\n\n")
  )

  glue::glue("{bullet}{metadata$col_names}: {metadata$desc}\n")

}
