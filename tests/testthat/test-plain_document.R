test_that("errors thrown on bad input", {
  expect_error(
    plain_document("ha"),
    "'wrap' must be one of 'auto', 'none', or 'preserve'"
  )
  expect_error(
    plain_document(c("ha", "foo")),
    "wrap is not a string \\(a length one character vector\\)"
  )
  expect_error(
    plain_document(columns = -10),
    "'columns' must be greater than or equal to 1"
  )
  expect_error(
    plain_document(columns = c(10, 1)),
    "columns is not a number \\(a length one numeric vector\\)"
  )
})

test_that("column argument works", {
  rmd_tempfile <- tempfile(fileext = ".Rmd")
  lines <- c(
    "---",
    "title: 'Report'",
    "output_format: plain_document",
    "---",
    "This text is 36 characters in length"
  )
  write(lines, rmd_tempfile)

  # Render to temporary text file
  txt_tempfile <- tempfile(fileext = ".txt")

  rmarkdown::render(
    rmd_tempfile, output_file = txt_tempfile,
    output_format = plain_document(columns = 40))
  rendered <- readLines(txt_tempfile)

  expect_equal(
    length(rendered), 1
  )

  rmarkdown::render(
    rmd_tempfile, output_file = txt_tempfile,
    output_format = plain_document(columns = 20))
  rendered <- readLines(txt_tempfile)

  expect_equal(
    length(rendered), 2
  )

  rmarkdown::render(
    rmd_tempfile, output_file = txt_tempfile,
    output_format = plain_document(columns = 10))
  rendered <- readLines(txt_tempfile)

  # 4, not 3 because pandoc avoids breaking up words
  expect_equal(
    length(rendered), 4
  )

 unlink(rmd_tempfile)
 unlink(txt_tempfile)

})

test_that("citing works", {
  temp_dir <- tempdir()

  rmd_tempfile <- paste0(temp_dir, "/temp.Rmd")
  lines <- c(
    "---",
    "title: 'Report'",
    "output_format: plain_document",
    "bibliography: temp.bib",
    "---",
    "Accoring to @me2022",
    "",
    "References"
  )
  write(lines, rmd_tempfile)

  bib_tempfile <- paste0(temp_dir, "/temp.bib")
  lines <- c(
    "@misc{me2022,",
    "  author = {Nitta, Joel H},",
    "  title = {My wonderful publication},",
    "  year = {2022}",
    "}"
  )
  write(lines, bib_tempfile)

  # Render to temporary text file
  txt_tempfile <- paste0(temp_dir, "/temp.txt")

  rmarkdown::render(
    rmd_tempfile, output_file = txt_tempfile,
    output_format = plain_document())

  results <- readLines(txt_tempfile)

  expect_equal(
    results[[1]],
    "Accoring to Nitta (2022)"
  )

  unlink(rmd_tempfile)
  unlink(bib_tempfile)
  unlink(txt_tempfile)

})
