# Logical Memory II: Intuition for ADNI MCI Classification

## What the Test Measures

The examiner reads two short paragraphs aloud --- ordinary narratives
about everyday events (e.g., a woman robbed while walking home). Each
paragraph contains 25 "story units" (specific details: names, numbers,
locations). The subject retells the story immediately (Logical Memory I)
and again after a **30-minute delay** (Logical Memory II). The score is
the count of story units correctly recalled after the delay. In
ADNIMERGE, this score is the variable `LDELTOTAL`.

## Why It Matters

Delayed paragraph recall isolates *episodic memory consolidation* ---
the ability to encode a new experience and retrieve it later. This is
precisely the faculty that deteriorates earliest in Alzheimer's disease
because the hippocampus and entorhinal cortex, responsible for
consolidation, are the first structures damaged by AD pathology. A
person who can repeat a story immediately but cannot recall it 30
minutes later is showing the hallmark of early hippocampal failure.

## ADNI Diagnostic Cutoffs (Education-Adjusted)

| Education    | LMCI  | EMCI  | CN   |
|--------------|-------|-------|------|
| 16+ years    | 0--8  | 9--11 | 12+  |
| 8--15 years  | 0--4  | 5--9  | 10+  |
| 0--7 years   | 0--2  | 3--6  | 7+   |

## Mean LDELTOTAL by Diagnostic Group (ADNIMERGE Baseline)

| Group | N     | Mean (SD)  |
|-------|-------|------------|
| CN    | 521   | 13.3 (3.3) |
| EMCI  | 404   | 9.1 (2.0)  |
| LMCI  | 659   | 4.0 (2.6)  |
| AD    | 400   | 1.4 (2.0)  |

## Conversion Rate by LDELTOTAL Quartile (MCI, 3-Year Follow-Up)

| Quartile       | Score Range | N   | Conversion Rate |
|----------------|-------------|-----|-----------------|
| Lowest (Q1)    | 0--3        | 149 | **57.7%**       |
| Q2             | 3--6        | 149 | 23.5%           |
| Q3             | 6--9        | 149 | 14.1%           |
| Highest (Q4)   | 9--15       | 148 | **4.1%**        |

A subject recalling fewer than 3 story units after 30 minutes has a 58%
chance of converting to AD within 3 years. A subject recalling 9 or
more has only a 4% chance. This 14-fold gradient makes `LDELTOTAL` one
of the strongest individual predictors in the Grassi et al. (2019)
analysis (univariate AUROC = 0.770).

---
*Rendered on 2026-02-17 at 08:52 PST.*
*Source: /Users/zenn/Library/CloudStorage/Dropbox/prj/tch/02-phb243b-biostat/lec13/logical_memory_ii.md*
