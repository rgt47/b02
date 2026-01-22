# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Course materials for PHB 243b (Practicum in Biostatistics) at UCSD, Winter 2026. Covers reproducible research workflows, statistical analysis plans, and collaborative biostatistics practice.

## Rendering Documents

Quarto slides (revealjs format):
```bash
quarto render slides.qmd
quarto render slides.qmd -o slides_$(date +%Y-%m-%d).html
```

Quarto documents to PDF:
```bash
quarto render document.qmd --to pdf
```

R Markdown to PDF (using xelatex for Unicode):
```bash
Rscript -e "rmarkdown::render('document.Rmd')"
```

Markdown to PDF with proper Unicode box-drawing:
```bash
pandoc doc.md -o doc.pdf --pdf-engine=xelatex -V monofont="DejaVu Sans Mono"
```

## Directory Structure

- `lec01/` through `lec20/` - Individual lecture folders following `_schedule.yml`
- `archive/` - Previous versions and reference materials
- `_variables.yml` - Course metadata (instructor, TA, schedule details)
- `_schedule.yml` - Lecture schedule with topics and project assignments
- `custom.css` - Shared CSS for revealjs slides

## Lecture Folder Convention

Each `lecXX/` folder typically contains:

- `slides.qmd` - Revealjs presentation (uses `../custom.css` and `../ucsdlibrary.jpeg`)
- `speaker_notes.qmd` - Extended notes for instructor
- `scripts/` - Numbered R scripts (e.g., `01_prepare_data.R`, `02_fit_models.R`)
- `figures/` - Generated output figures

## Quarto Slide Configuration

Standard YAML frontmatter for slides:
```yaml
format:
  revealjs:
    theme: serif
    slide-number: true
    css: ../custom.css
    title-slide-attributes:
      data-background-image: "../ucsdlibrary.jpeg"
      data-background-size: 25%
      data-background-position: right 5% bottom 5%
```

## Course Projects and Datasets

Four projects using these datasets (defined in `_schedule.yml`):

1. Palmer Penguins - Species classification, morphometric analysis
2. ADNI - Alzheimer's disease progression prediction
3. Stanford Open Policing - Racial disparities analysis
4. Licorice Gargle - RCT analysis of postoperative outcomes

## Variable Interpolation

Course documents use Quarto shortcodes for variables defined in `_variables.yml`:
```
{{< var instructor.name >}}
{{< var course.time >}}
```
