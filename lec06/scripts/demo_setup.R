# demo_setup.R
# Run this script before lecture to verify all prerequisites
# This ensures the live demo will work smoothly

cat("Checking prerequisites for Lecture 6 demo...\n")
cat("=============================================\n\n")

check_package <- function(pkg) {
  installed <- pkg %in% rownames(installed.packages())
  status <- if (installed) "OK" else "MISSING"
  cat(sprintf("  %-15s [%s]\n", pkg, status))
  installed
}

cat("1. Checking required packages:\n")
required_pkgs <- c("devtools", "usethis", "renv", "remotes",
                   "palmerpenguins", "tidyverse", "fs", "jsonlite")

results <- sapply(required_pkgs, check_package)

if (!all(results)) {
  cat("\n   Missing packages detected. Install with:\n")
  missing <- names(results)[!results]
  cat(sprintf("   install.packages(c(%s))\n",
              paste0('"', missing, '"', collapse = ", ")))
}

cat("\n2. Checking rrtools:\n")
if ("rrtools" %in% rownames(installed.packages())) {
  cat("  rrtools          [OK]\n")
} else {
  cat("  rrtools          [MISSING]\n")
  cat("   Install with: remotes::install_github('benmarwick/rrtools')\n")
}

cat("\n3. Checking Git:\n")
git_version <- tryCatch(
  system("git --version", intern = TRUE),
  error = function(e) NULL
)
if (!is.null(git_version)) {
  cat(sprintf("  %s [OK]\n", git_version))
} else {
  cat("  Git not found [MISSING]\n")
}

cat("\n4. Checking GitHub authentication:\n")
gh_token <- Sys.getenv("GITHUB_PAT")
if (nchar(gh_token) > 0) {
  cat("  GITHUB_PAT       [OK]\n")
} else {
  gh_token <- Sys.getenv("GITHUB_TOKEN")
  if (nchar(gh_token) > 0) {
    cat("  GITHUB_TOKEN     [OK]\n")
  } else {
    cat("  GitHub token     [NOT SET]\n")
    cat("   Run: usethis::create_github_token()\n")
    cat("   Then: gitcreds::gitcreds_set()\n")
  }
}

cat("\n5. Checking R version:\n")
cat(sprintf("  %s [%s]\n",
            R.version.string,
            if (as.numeric(R.version$major) >= 4) "OK" else "UPGRADE RECOMMENDED"))

cat("\n=============================================\n")
cat("Pre-lecture setup complete.\n")
cat("\nTo clean up any previous demo:\n")
cat("  unlink('~/Desktop/penguins_demo', recursive = TRUE)\n")
