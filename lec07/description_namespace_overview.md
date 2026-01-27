# Understanding DESCRIPTION and NAMESPACE Files

When you create an R package (including a research compendium with rrtools),
two critical files control how your package works: `DESCRIPTION` and
`NAMESPACE`. This document explains the purpose of each.

## DESCRIPTION

The `DESCRIPTION` file is the metadata file for an R package. It defines what
the package is, who wrote it, and what it depends on.

### Key Fields

| Field | Purpose |
|-------|---------|
| `Package` | Package name |
| `Title` | One-line description (title case, no period) |
| `Version` | Version number (e.g., 0.1.0) |
| `Authors@R` | Author and maintainer info using `person()` |
| `Description` | Paragraph describing the package |
| `License` | License type (e.g., MIT, GPL-3) |
| `Depends` | Packages that must be attached (loaded) |
| `Imports` | Packages required but not attached |
| `Suggests` | Optional packages (for tests, vignettes, examples) |
| `Encoding` | Character encoding (typically UTF-8) |
| `LazyData` | Whether to lazy-load data (true/false) |

### Example DESCRIPTION

```
Package: penguindemo
Title: Analysis of Palmer Penguins Morphometric Data
Version: 0.1.0
Authors@R:
    person("Jane", "Doe", email = "jane@example.edu", role = c("aut", "cre"))
Description: Reproducible analysis of penguin bill and flipper measurements
    from the Palmer Archipelago. Includes data cleaning functions and
    statistical models for species classification.
License: MIT + file LICENSE
Encoding: UTF-8
Imports:
    dplyr,
    ggplot2,
    palmerpenguins
Suggests:
    testthat (>= 3.0.0),
    knitr,
    rmarkdown
```

### Why It Matters for Reproducibility

- `Imports` and `Suggests` declare all package dependencies
- `Version` tracks your project's development state
- Required for `renv` to manage dependencies correctly
- Enables `R CMD check` to validate your package
- Makes your work installable via `pak::pak()` or `devtools::install()`

## NAMESPACE

The `NAMESPACE` file controls what functions are **exported** (available to
users) and **imported** (available to your package code) in an R package.

### Key Directives

| Directive | Purpose |
|-----------|---------|
| `export(function_name)` | Makes a function available to users who load the package |
| `import(package)` | Makes all functions from another package available internally |
| `importFrom(package, function)` | Makes a specific function from another package available internally |

### Example NAMESPACE

```
export(clean_penguin_data)
export(fit_model)
importFrom(dplyr, filter)
importFrom(dplyr, mutate)
importFrom(stats, lm)
```

### How It Works in Practice

- You rarely edit `NAMESPACE` directly
- roxygen2 generates it automatically from your documentation comments
- `#' @export` in your function documentation adds the export directive
- `#' @importFrom dplyr filter` adds import directives

### Why It Matters for Reproducibility

- Explicit namespace management avoids function name conflicts (e.g.,
  `dplyr::filter` vs `stats::filter`)
- Documents exactly which external functions your code depends on
- Prevents accidental reliance on functions that happen to be loaded in your
  session

## Summary

| File | Controls | Edited By |
|------|----------|-----------|
| `DESCRIPTION` | Package metadata and dependencies | You (directly) |
| `NAMESPACE` | Function imports and exports | roxygen2 (from comments) |

Both files are essential for creating reproducible, shareable R code that
others can install and use reliably.
