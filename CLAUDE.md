# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Course materials repository for PHB 243b (Practicum in Biostatistics) at UCSD. Contains teaching slides, demonstrations, and documentation focused on reproducible R development workflows with Docker and renv, and multi-language data science (R, Python, Julia).

## Rendering Documents

Quarto slides (revealjs format):
```bash
quarto render slides_engines.qmd
quarto render docker_renv_slides.qmd
```

R Markdown to PDF (using xelatex for Unicode support):
```bash
Rscript -e "rmarkdown::render('multiple_engine.Rmd')"
```

Note: Some Rmd files reference `~/shr/preamble.tex` and `~/shr/zz.tools.R` as shared resources.

## Key Content Areas

- **Docker + renv workflow**: `docker_renv_slides.qmd`, `chat_outline_docker_renv.Rmd` demonstrate containerized reproducible R environments
- **Multi-language RMarkdown**: `multiple_engine.Rmd`, `slides_engines.qmd` show R-Python-Julia integration using reticulate and JuliaCall
- **Team science skills**: `docs/team-science-skills.qmd` presents survey data on essential biostatistician collaboration skills

## Directory Structure

- `data/` - datasets (symlinked as `a`)
- `figures/` - generated figures (symlinked as `f`)
- `scripts/` - R scripts (symlinked as `s`)
- `docs/` - additional course documents
- `demo/` - demonstration R scripts

## R-Python Integration Pattern

The multi-engine documents follow this pattern:
1. Load `reticulate` in R setup chunk
2. Prepare data as R data frame
3. Access R objects in Python via `r.object_name`
4. Access Python objects in R via `py$object_name`
