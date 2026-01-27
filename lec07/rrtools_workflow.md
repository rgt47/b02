# Building a Reproducible Research Compendium with rrtools

This document walks through creating a complete research compendium using the
`rrtools` package. The resulting repository will include directories for R
code, tests, vignettes, and analysis materials.

## Prerequisites

Before starting, ensure you have:

- R 4.4+
- RStudio
- Git installed and configured
- A GitHub account
- The `pak` package installed

## Step 1: Install rrtools

```r
pak::pak("benmarwick/rrtools")
```

## Step 2: Create the Research Compendium

Navigate to the directory where you want to create your project (not inside an
existing R project), then run:

```r
rrtools::use_compendium("penguindemo")
```

This creates a new directory `penguindemo/` with the basic R package structure:

```
penguindemo/
├── DESCRIPTION
├── NAMESPACE
├── R/
└── penguindemo.Rproj
```

RStudio will open the new project automatically.

## Step 3: Initialize Git

In the RStudio Terminal or R console:

```r
usethis::use_git()
```

This initializes a Git repository and makes an initial commit.

## Step 4: Add a License

```r
usethis::use_mit_license()
```

This adds `LICENSE` and `LICENSE.md` files. Other options include
`use_gpl3_license()` or `use_cc0_license()`.

## Step 5: Create the Analysis Directory Structure

```r
rrtools::use_analysis()
```

When prompted, select option 1 (`top_level`) for the location. This creates:

```
penguindemo/
├── analysis/
│   ├── data/
│   │   ├── raw_data/
│   │   └── derived_data/
│   ├── figures/
│   ├── paper/
│   │   ├── paper.qmd
│   │   └── references.bib
│   └── templates/
│       └── template.docx
├── DESCRIPTION
├── LICENSE
├── LICENSE.md
├── NAMESPACE
├── R/
└── penguindemo.Rproj
```

## Step 6: Add Testing Infrastructure

```r
usethis::use_testthat()
```

This creates:

```
penguindemo/
├── tests/
│   ├── testthat/
│   └── testthat.R
...
```

To add a test file for a specific function:

```r
usethis::use_test("my_function")
```

This creates `tests/testthat/test-my_function.R`.

## Step 7: Add Vignettes

```r
usethis::use_vignette("getting-started")
```

This creates:

```
penguindemo/
├── vignettes/
│   └── getting-started.Rmd
...
```

It also updates `DESCRIPTION` with the necessary vignette dependencies.

## Step 8: Create a README

```r
rrtools::use_readme_qmd()
```

This generates `README.qmd` with:

- Badges for Binder and DOI
- Citation information
- License statement
- How to cite section

Render it with:

```r
quarto::quarto_render("README.qmd")
```

## Step 9: Add R Functions

Create R scripts in the `R/` directory. For example:

```r
usethis::use_r("data_cleaning")
```

This creates `R/data_cleaning.R`. Add your functions with roxygen2 documentation:

```r
#' Clean penguin data
#'
#' Removes rows with missing values and standardizes column names.
#'
#' @param data A data frame of raw penguin measurements
#' @return A cleaned data frame
#' @export
clean_penguin_data <- function(data) {
  data |>
    tidyr::drop_na() |>
    janitor::clean_names()
}
```

## Step 10: Update Dependencies

After writing your analysis code, scan for and add dependencies:

```r
rrtools::add_dependencies_to_description()
```

This parses your `.qmd` and `.R` files and updates the `DESCRIPTION` file with
required packages.

## Step 11: Set Up renv for Dependency Management

```r
renv::init()
```

This creates:

- `renv.lock` - snapshot of package versions
- `renv/` - local package library
- `.Rprofile` - activates renv on project load

After installing or updating packages:

```r
renv::snapshot()
```

## Step 12: Add Docker Support (Optional)

```r
rrtools::use_dockerfile()
```

This creates:

- `Dockerfile` - container definition based on rocker/verse
- `.github/workflows/` - GitHub Actions CI workflow

## Final Directory Structure

After completing all steps, your compendium will look like:

```
penguindemo/
├── .github/
│   └── workflows/
│       └── main.yml
├── analysis/
│   ├── data/
│   │   ├── raw_data/
│   │   └── derived_data/
│   ├── figures/
│   ├── paper/
│   │   ├── paper.qmd
│   │   └── references.bib
│   └── templates/
│       └── template.docx
├── R/
│   └── data_cleaning.R
├── renv/
├── tests/
│   ├── testthat/
│   │   └── test-data_cleaning.R
│   └── testthat.R
├── vignettes/
│   └── getting-started.Rmd
├── .Rprofile
├── DESCRIPTION
├── Dockerfile
├── LICENSE
├── LICENSE.md
├── NAMESPACE
├── README.md
├── README.qmd
├── penguindemo.Rproj
└── renv.lock
```

## Step 13: Connect to GitHub

```r
usethis::use_github()
```

This creates a GitHub repository and pushes your local commits.

## Quick Reference: All Commands in Order

```r
# 1. Install rrtools
pak::pak("benmarwick/rrtools")

# 2. Create compendium (run from parent directory)
rrtools::use_compendium("penguindemo")

# 3-4. Git and license
usethis::use_git()
usethis::use_mit_license()

# 5. Analysis structure
rrtools::use_analysis()

# 6-7. Tests and vignettes
usethis::use_testthat()
usethis::use_vignette("getting-started")

# 8. README
rrtools::use_readme_qmd()

# 9. Add R functions
usethis::use_r("data_cleaning")

# 10. Update dependencies
rrtools::add_dependencies_to_description()

# 11. renv
renv::init()

# 12. Docker (optional)
rrtools::use_dockerfile()

# 13. GitHub
usethis::use_github()
```

## References

- Marwick B, Boettiger C, Mullen L (2018). "Packaging Data Analytical Work
  Reproducibly Using R (and Friends)." *The American Statistician*, 72(1),
  80-88. https://doi.org/10.1080/00031305.2017.1375986

- rrtools GitHub repository: https://github.com/benmarwick/rrtools
