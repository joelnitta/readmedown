
<!-- README.md is generated from README.Rmd. Please edit that file -->

# readmedown

<!-- badges: start -->
<!-- badges: end -->

The goal of `readmedown` is render README files from Rmarkdown, with a
particular focus on README files for data repositories.

## Installation

You can install the development version of `readmedown` like so:

``` r
# install.packages("remotes")
remotes::install_github("joelnitta/readmedown")
```

## Motivation

Data README files are very important sources of metadata that describe
how other people can use the data you have made available in a
repository (such as [FigShare](https://figshare.com/) or
[Dryad](https://datadryad.org/stash)).

[Best practices for data README
files](https://data.research.cornell.edu/content/readme) are to include
as much information as possible about the format of each data file. This
can be tedious to track manually. By using
[Rmarkdown](https://bookdown.org/yihui/rmarkdown/), one can insert
summary statistics, names of variables, etc., directly into the output
document. This ensures your README files are accurate and saves time
if/when your data changes!

## Usage

For example, the `desc_data()` function helps describe dataframes. It
throws an error if your description of the data is wrong, thereby
ensuring that the README is accurate:

``` r
library(readmedown)

# Here are some example data: a small version of the 'mtcars' dataset
cars_small <- mtcars[1:10, 1:3]

# Let's describe these data with user-provided metadata
desc_data(
    cars_small,
    data.frame(
      col_names = c("mpg", "cyl", "disp"),
      desc = c("Miles per gallon", "Number of cylinders", "Displacement")
    )
  )
#> - mpg: Miles per gallon
#> - cyl: Number of cylinders
#> - disp: Displacement
```

By using the `results = "asis"` [chunk
option](https://yihui.org/knitr/options/), we can print the results of
`desc_data()` directly into the rendered output. For example, you could
produce the section below in a README file:

mtcars_small: A dataframe including 10 rows and 3 columns.

-   mpg: Miles per gallon
-   cyl: Number of cylinders
-   disp: Displacement

## Template README file

This package includes a [template Rmd README
file](inst/extdata/ReadmeTemplate.Rmd) based on this [awesome template
by the Cornell Research Data Management Service
Group](https://data.research.cornell.edu/content/readme).

I recommend using this template Rmd as a starting point for writing your
data README file. It can be rendered to plain text using
`plain_document()` provided by this package.

``` r
readme_rmd <- system.file(
  "extdata", "ReadmeTemplate.Rmd", package = "readmedown", mustWork = TRUE)
rmarkdown::render(readme_rmd)
#> processing file: ReadmeTemplate.Rmd
#> output file: ReadmeTemplate.knit.md
#> /usr/local/bin/pandoc +RTS -K512m -RTS ReadmeTemplate.knit.md --to plain --from markdown+autolink_bare_uris+tex_math_single_backslash --output ReadmeTemplate.txt --wrap auto --columns 72
#> 
#> Output created: ReadmeTemplate.txt
```

## License

-   [MIT](LICENSE.md)
