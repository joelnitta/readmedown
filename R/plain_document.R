#' Convert to a plain text document
#'
#' Format for converting from R Markdown to a plain text document.
#'
#' As per pandoc documentation for
#' [`wrap`](https://pandoc.org/MANUAL.html#option--wrap), "With 'auto' (the
#' default), pandoc will attempt to wrap lines to the column width specified by
#' `columns` (default 72). With 'none', pandoc will not wrap lines at all. With
#' 'preserve', pandoc will attempt to preserve the wrapping from the source
#' document (that is, where there are nonsemantic newlines in the source, there
#' will be nonsemantic newlines in the output as well)."
#'
#' @param wrap Character vector of length 1; type of text wrapping
#' to use. Must choose one of "auto", "none", or "preserve".
#' @param columns Numeric vector of length 1; number of characters
#' to write per line.
#'
#' @return R Markdown output format to pass to rmarkdown::render()
#' @examples
#' # Write out an example Rmd file
#' rmd_tempfile <- tempfile(fileext = ".Rmd")
#' lines <- c(
#'   "---",
#'   "title: 'Report'",
#'   "output_format: plain_document",
#'   "---",
#'   "This is a **markdown document**. But the formatting is *gone*",
#'   "when rendered to _plain text_."
#' )
#' write(lines, rmd_tempfile)
#'
#' # Render to temporary text file
#' txt_tempfile <- tempfile(fileext = ".txt")
#' rmarkdown::render(
#'   rmd_tempfile, output_file = txt_tempfile,
#'   output_format = plain_document())
#'
#' # Check output
#' readLines(txt_tempfile)
#'
#' # Delete temporary files
#' unlink(rmd_tempfile)
#' unlink(txt_tempfile)
#'
#' @export
plain_document <- function(wrap = "auto", columns = 72) {
  # Check input
  assertthat::assert_that(assertthat::is.string(wrap))
  assertthat::assert_that(assertthat::is.number(columns))
  columns <- as.integer(columns)
  assertthat::assert_that(
    columns >= 1,
    msg = "'columns' must be greater than or equal to 1")
  assertthat::assert_that(
    wrap %in% c("auto", "none", "preserve"),
    msg = "'wrap' must be one of 'auto', 'none', or 'preserve'")

  # Set format
  rmarkdown::output_format(
    knitr = rmarkdown::knitr_options(opts_chunk = list(dev = 'png')),
    pandoc = rmarkdown::pandoc_options(
      to = "plain",
      args = c(
        "--wrap", wrap,
        "--columns", columns,
        "--citeproc"
      ),
      ext = ".txt"),
    clean_supporting = TRUE
  )
}
