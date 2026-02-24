# RAVLT: Rey Auditory Verbal Learning Test

## What the Test Measures

The examiner reads a list of 15 unrelated words aloud at a rate of one
per second. The subject immediately recalls as many words as possible.
This procedure is repeated for five consecutive trials (Trials 1--5).
A different 15-word interference list is then presented once and recalled.
The subject is asked to recall the original list immediately after
interference, and again after a 30-minute delay. ADNIMERGE records four
derived scores from this protocol:

- **RAVLT_immediate**: Sum of words recalled across Trials 1--5
  (learning capacity; range typically 0--75)
- **RAVLT_learning**: Trial 5 minus Trial 1
  (learning rate across repetitions)
- **RAVLT_forgetting**: Trial 5 minus Delayed Recall
  (retention loss over the 30-minute delay)
- **RAVLT_perc_forgetting**: Percentage of Trial 5 words forgotten
  at delayed recall

## Why It Matters

The RAVLT dissects verbal memory into distinct components. *Immediate*
total reflects encoding capacity. *Learning* captures the benefit of
repetition. *Forgetting* isolates consolidation failure --- the same
hippocampal process measured by Logical Memory II. In AD, encoding is
impaired (low immediate total) and consolidation fails almost completely
(high percent forgetting), whereas in normal aging, encoding slows but
consolidation is largely preserved.

## Mean Scores by Diagnostic Group (ADNIMERGE Baseline)

| Score              |   CN        |   EMCI      |   LMCI      |   AD        |
|--------------------|-------------|-------------|-------------|-------------|
| Immediate          | 45.3 (10.0) | 39.4 (10.4) | 31.6 (9.6)  | 22.8 (7.5)  |
| Learning           |  5.9 (2.3)  |  5.2 (2.5)  |  3.5 (2.4)  |  1.9 (1.8)  |
| Forgetting         |  3.6 (3.0)  |  4.3 (2.9)  |  4.7 (2.7)  |  4.6 (1.8)  |
| Pct Forgetting     | 33.9 (29.4) | 46.8 (35.8) | 66.6 (36.0) | 89.4 (22.0) |

Note that raw forgetting (Trial 5 minus Delayed) is nearly flat across
groups because AD subjects have so little to forget. Percent forgetting
is the more informative measure: CN subjects retain two-thirds of
learned words; AD subjects lose nearly all of them.

## Conversion Rate by Quartile (MCI Subjects, 3-Year Follow-Up)

**RAVLT Immediate** (strongest RAVLT predictor, AUROC = 0.797):

| Quartile    | Score Range | N   | Conversion Rate |
|-------------|-------------|-----|-----------------|
| Lowest (Q1) | 11--28      | 149 | **53.7%**       |
| Q2          | 28--34      | 149 | 29.5%           |
| Q3          | 34--42      | 149 | 14.1%           |
| Highest (Q4)| 42--68      | 148 | **2.0%**        |

**RAVLT Percent Forgetting** (AUROC = 0.742):

| Quartile    | Score Range | N   | Conversion Rate |
|-------------|-------------|-----|-----------------|
| Lowest (Q1) | 0--33%      | 149 | **10.1%**       |
| Q2          | 33--57%     | 149 | 13.4%           |
| Q3          | 57--88%     | 149 | 24.2%           |
| Highest (Q4)| 88--100%    | 148 | **52.0%**       |

## Individual Predictor AUROCs

| RAVLT Score        | AUROC |
|--------------------|-------|
| Immediate          | 0.797 |
| Pct Forgetting     | 0.742 |
| Learning           | 0.699 |
| Forgetting (raw)   | 0.587 |

The immediate total is the single most predictive RAVLT measure: a
27-fold difference in conversion rate between the lowest and highest
quartiles (53.7% vs. 2.0%). Percent forgetting provides complementary
information about consolidation failure. Raw forgetting is the weakest
predictor because it conflates "nothing to forget" with "good
retention."

---
*Rendered on 2026-02-17 at 09:01 PST.*
*Source: /Users/zenn/Library/CloudStorage/Dropbox/prj/tch/02-phb243b-biostat/lec13/ravlt.md*
