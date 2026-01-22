# Lecture 12: ADNI Analysis with renv and Docker Checklist

Follow this checklist to verify you completed each step of the walkthrough.

## Part I: Software Verification

- [ ] Docker installed (`docker --version`)
- [ ] Docker Hub account created and logged in (`docker login`)
- [ ] R version 4.0+ confirmed (`R.version.string`)
- [ ] `renv` package installed
- [ ] `rrtools` package installed

## Part II: Create Research Compendium

- [ ] Working directory set to a stable location (not Dropbox/OneDrive)
- [ ] Compendium created with `rrtools::use_compendium("adni.yourname")`
- [ ] New RStudio window opened automatically
- [ ] Analysis structure added with `rrtools::use_analysis()`
- [ ] Folder structure verified with `fs::dir_tree()`

Expected structure:

```
adni.yourname/
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

## Part III: Add ADNI Data

- [ ] ADNI dataset downloaded from Canvas
- [ ] Data saved to `analysis/data/raw_data/adni_baseline.csv`
- [ ] Data verified: loads correctly with `read.csv()`

## Part IV: Initialize renv

- [ ] renv initialized with `renv::init()`
- [ ] `renv/` folder created
- [ ] `renv.lock` file created
- [ ] `.Rprofile` file created

### Install Analysis Packages

- [ ] `tidyverse` installed
- [ ] `survival` installed
- [ ] `tableone` installed
- [ ] `ggfortify` installed
- [ ] Package versions saved with `renv::snapshot()`

## Part V: Create Dockerfile

- [ ] `Dockerfile` created in project root
- [ ] Dockerfile contains:
  - Base image: `rocker/r-ver:4.4.0`
  - System dependencies installed
  - renv package installed
  - `renv.lock` copied
  - `renv::restore()` executed
- [ ] `.dockerignore` file created

### Dockerfile Template

```dockerfile
FROM rocker/r-ver:4.4.0

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

COPY renv.lock renv.lock
COPY renv/activate.R renv/activate.R
COPY .Rprofile .Rprofile

RUN R -e "renv::restore()"

CMD ["/bin/bash"]
```

## Part VI: Build and Test Docker Image

- [ ] Docker image built: `docker build -t username/adni-analysis:v1 .`
- [ ] Build completed without errors
- [ ] Container tested interactively:
  ```bash
  docker run --rm -it -v "$(pwd):/workspace" username/adni-analysis:v1
  ```
- [ ] Inside container: R packages load correctly
- [ ] Inside container: `sessionInfo()` shows expected versions

## Part VII: Version Control and Publishing

- [ ] Git initialized: `usethis::use_git()`
- [ ] Initial commit made
- [ ] GitHub repository created: `usethis::use_github(private = FALSE)`
- [ ] Docker image pushed: `docker push username/adni-analysis:v1`

## Part VIII: Final Verification

- [ ] Project structure verified with `fs::dir_tree(recurse = 2)`
- [ ] Collaborator workflow tested (clone, pull image, run container)

## Final Project Structure

Your project should look like this:

```
adni.yourname/
├── DESCRIPTION
├── Dockerfile
├── .dockerignore
├── NAMESPACE
├── .Rprofile
├── renv.lock
├── renv/
│   ├── activate.R
│   ├── library/
│   └── settings.json
├── analysis/
│   ├── data/
│   │   ├── raw_data/
│   │   │   └── adni_baseline.csv
│   │   └── derived_data/
│   ├── figures/
│   └── paper/
│       └── paper.Rmd
└── R/
```

## Key Commands Reference

### renv Commands

```r
renv::init()       # Initialize renv in project
renv::snapshot()   # Save package versions to renv.lock
renv::restore()    # Install packages from renv.lock
renv::status()     # Check for differences
```

### Docker Commands

```bash
docker build -t image:tag .              # Build image
docker run --rm -it image:tag            # Run interactively
docker run -v "$(pwd):/workspace" image  # Mount local directory
docker push username/image:tag           # Push to DockerHub
docker pull username/image:tag           # Pull from DockerHub
```

## Next Steps

Before February 17:

1. **Fill in your ADNI analysis plan** - Edit `analysis/paper/paper.Rmd`
2. **Add analysis functions** - Create files in `R/` folder
3. **Write unit tests** - Use `usethis::use_testthat()`
4. **Commit changes regularly** - Use Git pane in RStudio
5. **Rebuild Docker image** - If you add new packages, run
   `renv::snapshot()` and rebuild

## Troubleshooting

### "Docker daemon not running"

Start Docker Desktop application before running docker commands.

### "renv::restore() fails in Docker build"

Ensure these files exist and are not in `.dockerignore`:

- `renv.lock`
- `renv/activate.R`
- `.Rprofile`

### "Permission denied" on docker build

```bash
sudo docker build -t myimage .
```

### "Package installation fails in Docker"

Missing system dependency. Add to Dockerfile:

```dockerfile
RUN apt-get update && apt-get install -y \
    missing-library-name \
    && rm -rf /var/lib/apt/lists/*
```

### "Cannot connect to Docker daemon"

```bash
# Mac/Linux
sudo systemctl start docker
# Or restart Docker Desktop
```

### "Image too large"

Review `.dockerignore` to exclude unnecessary files:

```
.git
*.html
*.pdf
analysis/data/raw_data/*
```

## Questions?

- **Office hours:** By appointment
- **Email:** rgthomas@ucsd.edu or maluo@ucsd.edu
- **Canvas:** Post in discussion board
