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
- `student_checklist.md` - Student handout with commands and references
- `scripts/` - R scripts for demonstrations and table generation
- `figures/` - Generated output figures

## Lecture Material Development Guidelines

### Slide Design Principles

**Length and Pacing:**
- Target 40-50 slides for an 80-minute lecture
- Each slide should convey one main concept
- Include "DO THIS" action slides for hands-on sessions
- Add checkpoint slides after major steps to verify student progress

**Code Presentation:**
- Enable `code-copy: true` for clipboard copy functionality
- Use `eval: false` for demonstration code that students will run
- Keep code blocks under 15 lines; split longer code across slides
- For hands-on lectures, show both RStudio Console and Terminal alternatives

**Visual Hierarchy:**
- Use custom CSS classes for callout boxes:
  - `.do-this` (orange) - Action items for students
  - `.checkpoint` (green) - Verification points
  - `.warning-box` (red) - Common pitfalls
  - `.terminal-box` (blue) - Terminal/command-line alternatives

**Content Structure:**
- Begin with "Today's Topics" outline (numbered list)
- Organize into numbered Parts (e.g., "# Part I: Topic Name")
- End with Summary, Assignment, and Questions slides
- Include References slide with academic citations

### Quarto Slide Configuration

Standard YAML frontmatter for slides:
```yaml
format:
  revealjs:
    theme: serif
    slide-number: true
    code-fold: false
    code-tools: true
    code-copy: true
    highlight-style: github
    smaller: true
    css: ../custom.css
    title-slide-attributes:
      data-background-image: "../ucsdlibrary.jpeg"
      data-background-size: 25%
      data-background-position: right 5% bottom 5%
```

### Supporting Materials

**Speaker Notes (`speaker_notes.qmd`):**
- Include timing plan with cumulative minutes
- Document key discussion points and anticipated questions
- Add troubleshooting guide for common technical issues
- List prerequisites and setup verification steps

**Student Checklist (`student_checklist.md`):**
- Provide copy-paste ready code blocks
- Include quick reference tables for functions/commands
- Document assignment requirements and due dates
- Add links to official documentation

**Scripts (`scripts/`):**
- Use numbered prefixes: `01_`, `02_`, etc.
- Include header comments describing purpose
- For gt tables: `all_tables_*.R` generates shell and completed tables

### Hands-On Lab Lectures

For interactive workshop-style lectures:

1. **Dual-format instructions**: Show both RStudio and terminal commands
2. **Step numbering**: Use explicit "Step N:" headings
3. **Verification points**: After each major step, include a checkpoint
4. **Error handling**: Document common errors and solutions
5. **Completion checklist**: End with checkbox list of deliverables

### Assessment Materials

**Tests (`testX.tex`):**
- Use LaTeX for precise formatting control
- Target 2 pages for 30-minute tests
- Include answer key as separate markdown file
- Grade scale table at end of answer key

### Academic Tone

- Use scholarly language without hyperbole
- Cite sources using author-year format
- Acknowledge borrowed content in References section
- Avoid promotional language about tools or methods

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

## Related Blog Posts

Lecture content may draw from or expand upon posts in `~/prj/qblog/posts/`:

- `testingfordataanalysisworkflow/` - Testing data analysis workflows
- `palmerpenguinsregression/` - Palmer Penguins regression analysis

When developing lectures from blog content, acknowledge the source and expand
with lecture-specific examples and exercises.
