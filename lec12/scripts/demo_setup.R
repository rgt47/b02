# demo_setup.R
# Run this script before lecture to verify all prerequisites
# This ensures the live demo will work smoothly

cat("Checking prerequisites for Lecture 12 demo...\n")
cat("=============================================\n\n")

check_package <- function(pkg) {
  installed <- pkg %in% rownames(installed.packages())
  status <- if (installed) "OK" else "MISSING"
  cat(sprintf("  %-15s [%s]\n", pkg, status))
  installed
}

cat("1. Checking required R packages:\n")
required_pkgs <- c("devtools", "usethis", "renv", "remotes",
                   "rrtools", "testthat", "fs")

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

cat("\n5. Checking Docker:\n")
docker_version <- tryCatch(
  system("docker --version", intern = TRUE),
  error = function(e) NULL
)
if (!is.null(docker_version)) {
  cat(sprintf("  %s [OK]\n", docker_version))
} else {
  cat("  Docker not found [MISSING]\n")
  cat("   Install from: https://www.docker.com/get-started\n")
}

cat("\n6. Checking Docker daemon:\n")
docker_info <- tryCatch(
  system("docker info 2>&1", intern = TRUE, ignore.stderr = TRUE),
  error = function(e) NULL
)
if (!is.null(docker_info) && !any(grepl("error|Error", docker_info))) {
  cat("  Docker daemon    [RUNNING]\n")
} else {
  cat("  Docker daemon    [NOT RUNNING]\n")
  cat("   Start Docker Desktop application\n")
}

cat("\n7. Checking Docker Hub login:\n")
docker_login <- tryCatch({
  result <- system("docker info 2>&1 | grep -i username", intern = TRUE)
  length(result) > 0
}, error = function(e) FALSE)
if (docker_login) {
  cat("  Docker Hub       [LOGGED IN]\n")
} else {
  cat("  Docker Hub       [NOT LOGGED IN]\n")
  cat("   Run: docker login\n")
}

cat("\n8. Pre-pulling base Docker image:\n")
cat("   This speeds up the demo. Run manually if needed:\n")
cat("   docker pull rocker/r-ver:4.4.0\n")

cat("\n9. Checking R version:\n")
cat(sprintf("  %s [%s]\n",
            R.version.string,
            if (as.numeric(R.version$major) >= 4) "OK"
            else "UPGRADE RECOMMENDED"))

cat("\n=============================================\n")
cat("Pre-lecture setup complete.\n")
cat("\nTo clean up any previous demo:\n")
cat("  rm -rf ~/Desktop/adni.demo\n")
cat("\nTo pre-pull Docker base image:\n")
cat("  docker pull rocker/r-ver:4.4.0\n")
