# Lecture 6: Workspace Setup Checklist

Follow this checklist to verify you completed each step of the walkthrough.

## Part I: Software Installation

- [ ] R version 4.0+ confirmed (`R.version.string`)
- [ ] `remotes` package installed
- [ ] `devtools` package installed
- [ ] `usethis` package installed
- [ ] `renv` package installed
- [ ] `testthat` package installed
- [ ] `palmerpenguins` package installed
- [ ] `tidyverse` package installed
- [ ] `rrtools` package installed from GitHub
- [ ] All packages load without errors

## Part II: Create Research Compendium

- [ ] Working directory set to a stable location (not Dropbox/OneDrive)
- [ ] Compendium created with `rrtools::use_compendium("penguins.yourname")`
- [ ] New RStudio window opened automatically
- [ ] Analysis structure added with `rrtools::use_analysis()`
- [ ] Folder structure verified with `fs::dir_tree()`

Expected structure:

```
penguins.yourname/
├── DESCRIPTION
├── analysis/
│   ├── data/
│   │   ├── raw_data/
│   │   └── derived_data/
│   ├── figures/
│   └── paper/
│       └── paper.Rmd
└── R/
```

## Part III: Add Data

- [ ] Palmer penguins data exported to CSV:
  ```r
  write.csv(penguins, "analysis/data/raw_data/penguins.csv", row.names = FALSE)
  ```
- [ ] Data verified: 344 rows, 8 columns

## Part IV: Add Analysis Plan Template

- [ ] `analysis_plan_template.qmd` copied from Lecture 5
- [ ] File saved to `analysis/paper/analysis_plan.qmd`
- [ ] File exists: `file.exists("analysis/paper/analysis_plan.qmd")` returns TRUE

## Part V: Write Unit Tests

- [ ] testthat initialized with `usethis::use_testthat()`
- [ ] `tests/testthat/` folder exists

### Test 1: Data Validation

- [ ] Test file created: `usethis::use_test("data-validation")`
- [ ] Test code added to `tests/testthat/test-data-validation.R`:

```r
test_that("penguins data file exists and has correct dimensions", {
  data_path <- "analysis/data/raw_data/penguins.csv"
  expect_true(file.exists(data_path))
  penguins_data <- read.csv(data_path)
  expect_equal(nrow(penguins_data), 344)
  expect_equal(ncol(penguins_data), 8)
})
```

### Helper Function

- [ ] Function file created: `usethis::use_r("clean-data")`
- [ ] Function added to `R/clean-data.R`:

```r
#' Remove rows with missing values from penguins data
#'
#' @param data A data frame of penguin measurements
#' @return A data frame with complete cases only
clean_penguins <- function(data) {
  data[complete.cases(data), ]
}
```

### Test 2: Function Validation

- [ ] Test file created: `usethis::use_test("clean-data")`
- [ ] Test code added to `tests/testthat/test-clean-data.R`:

```r
test_that("clean_penguins removes rows with missing values", {
  test_data <- data.frame(
    species = c("Adelie", "Gentoo", "Chinstrap"),
    bill_length = c(39.1, NA, 46.5),
    body_mass = c(3750, 4500, NA)
  )
  cleaned <- clean_penguins(test_data)
  expect_equal(nrow(cleaned), 1)
  expect_equal(cleaned$species, "Adelie")
  expect_false(any(is.na(cleaned)))
})
```

### Run Tests

- [ ] Functions loaded: `devtools::load_all()`
- [ ] Tests run: `devtools::test()`
- [ ] Both tests pass (green checkmarks)

## Part VI: Version Control and GitHub

- [ ] Git initialized: `usethis::use_git()`
- [ ] Initial commit made
- [ ] renv initialized: `renv::init()`
- [ ] Packages snapshot taken: `renv::snapshot()`
- [ ] `renv.lock` file exists
- [ ] renv files committed (renv.lock, renv/, .Rprofile)
- [ ] GitHub repository created: `usethis::use_github(private = FALSE)`
- [ ] Browser opened to your new repository

## Part VII: Final Verification

- [ ] Project structure verified with `fs::dir_tree(recurse = 2)`
- [ ] `devtools::check()` runs with 0 errors

## Final Project Structure

Your project should look like this:

```
penguins.yourname/
├── DESCRIPTION
├── NAMESPACE
├── .Rprofile
├── renv.lock
├── analysis/
│   ├── data/
│   │   ├── raw_data/
│   │   │   └── penguins.csv
│   │   └── derived_data/
│   ├── figures/
│   └── paper/
│       ├── analysis_plan.qmd
│       └── paper.Rmd
├── R/
│   └── clean-data.R
├── renv/
│   └── ...
└── tests/
    ├── testthat.R
    └── testthat/
        ├── test-clean-data.R
        └── test-data-validation.R
```

## Next Steps

Before January 27:

1. **Fill in your analysis plan** - Edit `analysis/paper/analysis_plan.qmd`
2. **Commit changes regularly** - Use Git pane in RStudio
3. **Push to GitHub** - Keep your repository updated

## Troubleshooting

### "rrtools not found"

```r
remotes::install_github("benmarwick/rrtools")
```

### "GitHub PAT not found"

```r
usethis::create_github_token()
gitcreds::gitcreds_set()
```

### "Test failed"

1. Check file paths are correct
2. Make sure you saved all files
3. Run `devtools::load_all()` before `devtools::test()`

### "could not find function 'clean_penguins'"

```r
devtools::load_all()
```

### "renv::restore() fails"

```r
renv::clean()
renv::restore()
```

## Questions?

- **Office hours:** By appointment
- **Email:** rgthomas@ucsd.edu or maluo@ucsd.edu
- **Canvas:** Post in discussion board
