test_that("errors thrown on bad input", {
  cars_small <- mtcars[1:10, 1:3]
  cars_metadata_bad_names <- data.frame(
   col = c("mpg", "cyl", "displ"),
   desc = c("Miles per gallon", "Number of cylinders", "Displacement")
  )
  cars_metadata_bad_order <- data.frame(
    col = c("mpg", "displ", "cyl"),
    desc = c("Miles per gallon", "Displacement", "Number of cylinders")
  )
  cars_metadata_bad_missing <- data.frame(
    col = c("mpg", "cyl", "displ"),
    desc = c("Miles per gallon", "Number of cylinders", NA)
  )
  expect_error(
    desc_data(cars_small, cars_metadata_bad_order),
    "Column names of data do not match 'col' of metadata"
  )
  expect_error(
    desc_data(cars_small, cars_metadata_bad_names),
    "Column names of data do not match 'col' of metadata"
  )
  expect_error(
    desc_data(cars_small, cars_metadata_bad_missing),
    "metadata contains 1 missing values"
  )
})

test_that("tibble input works", {
  cars_small <- mtcars[1:10, 1:3]
  cars_metadata <- tibble::tribble(
    ~col, ~desc,
    "mpg", "Miles per gallon",
    "cyl", "Number of cylinders",
    "disp", "Displacement"
  )
  desc_data(cars_small, cars_metadata)
})
