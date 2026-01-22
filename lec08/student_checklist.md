# PHB 243b: Testing Data Analysis Workflows

## Lecture 8 Student Checklist - January 29, 2026

### Pre-Lecture Setup

- [ ] Ensure R 4.4+ and RStudio are installed
- [ ] Install required packages:

```r
install.packages(c("testthat", "assertr", "devtools", "palmerpenguins"))
```

- [ ] Have your Project 1 repository open and ready

---

### Part I: Why Test Data Analysis Code?

- [ ] Understand the two goals of testing:
  - Computational reproducibility (same code + data = same results)
  - Result correctness (outputs are accurate and meaningful)

- [ ] Recognize common failure modes:
  - Data problems (type changes, missing values, ID mismatches)
  - Code problems (package updates, edge cases, copy-paste errors)
  - Analysis problems (non-reproducible results, seed issues)

---

### Part II: Types of Tests

- [ ] **Unit tests**: Test individual functions in isolation
- [ ] **Data validation tests**: Verify data quality and structure
- [ ] **Integration tests**: Test complete workflows
- [ ] **Reproducibility tests**: Ensure deterministic results

---

### Part III: testthat Framework

#### Basic Structure

```r
library(testthat)

test_that("description of what we're testing", {
  # Arrange: set up test data
  x <- c(1, 2, 3, 4, 5)

  # Act: run the code
  result <- mean(x)

  # Assert: check expectations
  expect_equal(result, 3)
})
```

#### Common Expectations

| Function | Purpose |
|----------|---------|
| `expect_equal()` | Numeric equality with tolerance |
| `expect_identical()` | Exact match |
| `expect_true()` | Condition is TRUE |
| `expect_false()` | Condition is FALSE |
| `expect_type()` | Check R type |
| `expect_s3_class()` | Check S3 class |
| `expect_error()` | Function throws error |
| `expect_warning()` | Function throws warning |
| `expect_no_error()` | Function runs without error |

#### Test File Organization

```
tests/
├── testthat.R              # Test runner
└── testthat/
    ├── helper-test-data.R  # Shared utilities
    ├── test-data-loading.R
    ├── test-data-cleaning.R
    └── test-models.R
```

---

### Part IV: Data Validation with assertr

#### Pipeline Assertions

```r
library(assertr)

penguins |>
  verify(nrow(.) > 300) |>
  assert(within_bounds(0, 10000), body_mass_g) |>
  assert(in_set("Adelie", "Chinstrap", "Gentoo"), species)
```

#### assertr Functions

| Function | Purpose |
|----------|---------|
| `verify()` | Check logical condition on whole data |
| `assert()` | Check predicate on column values |
| `insist()` | Check row-wise computed predicates |

---

### Part V: Reproducibility Testing

#### Seed Management

```r
test_that("analysis is reproducible", {
  set.seed(42)
  results1 <- bootstrap_analysis(data, n_boots = 1000)

  set.seed(42)
  results2 <- bootstrap_analysis(data, n_boots = 1000)

  expect_equal(results1$estimate, results2$estimate)
})
```

#### Testing Known Results

```r
test_that("coefficients match expected values", {
  model <- lm(body_mass_g ~ flipper_length_mm, data = clean_data)
  coefs <- coef(model)

  # Test against pre-computed values
  expect_equal(coefs["(Intercept)"], -5780.83, tolerance = 0.1)
  expect_equal(coefs["flipper_length_mm"], 49.69, tolerance = 0.01)
})
```

---

### Part VI: Running Tests

```r
# Run all tests in package
devtools::test()

# Run specific test file
testthat::test_file("tests/testthat/test-models.R")

# Run tests matching pattern
testthat::test_dir("tests/testthat", filter = "data")
```

---

### Part VII: Continuous Integration

#### GitHub Actions Workflow

Create `.github/workflows/test-analysis.yml`:

```yaml
name: Test Analysis
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: r-lib/actions/setup-r@v2
    - uses: r-lib/actions/setup-r-dependencies@v2

    - name: Run tests
      run: |
        testthat::test_dir('tests/testthat')
      shell: Rscript {0}
```

---

### Assignment (Due Tuesday, February 3)

Add **two new tests** to your Project 1 repository:

1. Create or update `tests/testthat/test-models.R`
2. Tests should cover your regression analysis
3. Run `devtools::test()` and verify all tests pass
4. Commit and push to GitHub

#### Example Test Template

```r
# tests/testthat/test-models.R

test_that("body mass model has expected properties", {
  data <- read.csv("analysis/data/raw_data/penguins.csv")
  clean_data <- na.omit(data)

  model <- lm(body_mass_g ~ flipper_length_mm + species,
              data = clean_data)

  # Model structure
  expect_s3_class(model, "lm")
  expect_equal(length(coef(model)), 4)

  # Model quality
  r_squared <- summary(model)$r.squared
  expect_true(r_squared > 0.8)

  # Residuals are reasonable
  expect_true(abs(mean(resid(model))) < 1e-10)
})

test_that("model is reproducible", {
  data <- read.csv("analysis/data/raw_data/penguins.csv")
  clean_data <- na.omit(data)

  model1 <- lm(body_mass_g ~ flipper_length_mm + species, data = clean_data)
  model2 <- lm(body_mass_g ~ flipper_length_mm + species, data = clean_data)

  expect_equal(coef(model1), coef(model2))
})
```

---

### Testing Checklist for Project 1

- [ ] Data loading tests (file exists, correct dimensions)
- [ ] Data validation tests (ranges, types, missing patterns)
- [ ] Function unit tests (known inputs/outputs)
- [ ] Model tests (coefficients, diagnostics)
- [ ] Reproducibility tests (seeds, package versions)
- [ ] Integration tests (full pipeline runs)
- [ ] Output tests (files created, correct format)

---

### Quick Reference

| Task | Command |
|------|---------|
| Create test infrastructure | `usethis::use_testthat()` |
| Create new test file | `usethis::use_test("feature-name")` |
| Run all tests | `devtools::test()` |
| Run single file | `testthat::test_file("path/to/test.R")` |
| Check test coverage | `covr::package_coverage()` |

---

### Resources

- [testthat documentation](https://testthat.r-lib.org/)
- [assertr documentation](https://docs.ropensci.org/assertr/)
- [R Packages: Testing](https://r-pkgs.org/testing-basics.html)
- Wilson et al. (2017) "Good enough practices in scientific computing"

---

**Questions?**

- Office hours: By appointment
- Email: rgthomas@ucsd.edu or maluo@ucsd.edu
