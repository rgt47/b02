# CLAUDE.md

Lecture 4 materials for PHB 243b (Practicum in Biostatistics) at UCSD covering version control with Git and GitHub.

## Rendering Documents

Quarto slides (revealjs format):
```bash
quarto render slides.qmd
```

Speaker notes (HTML and PDF):
```bash
quarto render speaker_notes.qmd
```

## Content Overview

This lecture covers:
- Why version control matters for reproducible research
- Git fundamentals: repositories, commits, branches, merges, remotes
- Basic Git workflow: edit → stage → commit cycle
- GitHub for cloud hosting and collaboration
- Branch-based workflows with pull requests
- Best practices: what to track vs. exclude (.gitignore)

## File Structure

- `slides.qmd` - Main lecture slides (revealjs)
- `slides_15jan26.html` - Rendered slides
- `speaker_notes.qmd` - Detailed speaker notes with expanded explanations
- `speaker_notes.pdf` - Rendered speaker notes

### Reference PDFs
- `bryan.pdf` - Jenny Bryan's materials on Git for R users
- `gitandgithubPLOS.pdf` - PLOS paper on Git/GitHub for science
- `github-classroom-guide.pdf` - Guide for GitHub Classroom setup
- `1806.09525v1.pdf` - Academic paper on version control
- `Implementing Version Control...pdf` - Teaching Git in statistics courses

## Key References

- Happy Git for the useR: https://happygitwithr.com
- Pro Git book: https://git-scm.com/book
- GitHub Education: https://education.github.com
