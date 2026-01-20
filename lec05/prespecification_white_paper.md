# Pre-Specification and the Scientific Method: Protecting the Integrity of Statistical Inference

## A White Paper for Biostatistics Graduate Students

**PHB 243b: Practicum in Biostatistics**
**UC San Diego, Division of Biostatistics**
**January 2026**

---

## Abstract

The scientific method depends on a fundamental distinction between generating
hypotheses and testing them. When this boundary is violated---whether through
post-hoc hypothesis construction, selective reporting, or undisclosed
analytical flexibility---the inferential machinery of statistics breaks down.
This white paper examines the theoretical foundations and practical
implications of pre-specification in statistical analysis, drawing on
scholarly literature from methodology, philosophy of science, and empirical
investigations of research practices. We argue that pre-specification is not
merely a procedural safeguard but an expression of epistemic humility essential
to honest scientific inquiry. For biostatisticians working in collaborative
research environments, understanding and implementing pre-specification
represents a core professional competency.

---

## 1. Introduction: The Problem of Undisclosed Flexibility

In 2011, psychologist Daryl Bem published a paper in the *Journal of
Personality and Social Psychology* presenting experimental evidence for
precognition---the ability to perceive future events (Bem, 2011). The paper
passed peer review at a flagship journal and used standard statistical methods.
Yet the findings were, on their face, impossible according to known physics.

The Bem paper served as an unintentional stress test for the scientific
enterprise, revealing that something was deeply wrong with how research was
being conducted and reported. If standard methods could produce compelling
evidence for extrasensory perception, those methods could produce false
evidence for anything.

The ensuing decade brought what is now called the "replication crisis,"
characterized by systematic failures to reproduce published findings across
psychology, medicine, economics, and other fields. The Reproducibility Project:
Psychology, led by Brian Nosek and colleagues at the Center for Open Science,
attempted to replicate 100 published findings. Roughly 60% failed to replicate,
and effect sizes in successful replications were approximately half those
originally reported (Open Science Collaboration, 2015).

At the heart of this crisis lies a deceptively simple problem: the distinction
between predicting outcomes and explaining them after the fact. This white
paper examines why that distinction matters, how it is routinely violated, and
what biostatisticians can do to protect the integrity of their work.

---

## 2. The Theoretical Foundation: Prediction Versus Postdiction

### 2.1 The Logic of Hypothesis Testing

Classical frequentist inference rests on a thought experiment: if we repeated
this study infinitely under the null hypothesis, how often would we observe
results as extreme as these? The p-value quantifies this probability.
Critically, this calculation assumes the hypothesis was specified *before*
observing the data.

When a hypothesis is constructed *after* examining the data, the logical
foundation collapses. As Kerr (1998) observed in his seminal paper coining the
term "HARKing" (Hypothesizing After Results are Known):

> "HARKing is defined as presenting a post hoc hypothesis (i.e., one based on
> or informed by one's results) in one's research report as if it were, in
> fact, an a priori hypothesis."

The problem is not merely ethical but statistical. A p-value of 0.05
presupposes that the researcher would have reported a null result had the data
gone differently. When the hypothesis itself depends on the data, this
assumption is violated, and the stated Type I error rate becomes meaningless.

### 2.2 The Garden of Forking Paths

Andrew Gelman and Eric Loken (2013) introduced the metaphor of the "garden of
forking paths" to describe how analytical flexibility undermines inference even
without deliberate misconduct. At each decision point in a study---how to
define the outcome, which covariates to include, how to handle outliers,
whether to transform variables---researchers face branching choices. Each
branch seems reasonable given the data at hand, but the cumulative effect is
that the analysis is tailored to the particular dataset.

Gelman and Loken emphasize that this can occur without any conscious intent to
deceive:

> "The problem is there can be a large number of potential comparisons when the
> details of data analysis are highly contingent on data, without the
> researcher having to perform any conscious procedure of fishing or examining
> multiple p-values."

This is distinct from the traditional concept of "fishing expeditions" where
researchers test numerous hypotheses and report only significant ones. The
garden of forking paths operates more subtly: researchers perform a single
analysis that seems natural given their data, but would have performed a
different "single natural analysis" had the data been different.

### 2.3 Researcher Degrees of Freedom

Simmons, Nelson, and Simonsohn (2011) formalized this problem as "researcher
degrees of freedom" in their influential paper "False-Positive Psychology."
Through simulation, they demonstrated that exploiting common analytical
choices---when to stop data collection, whether to include covariates, how to
handle outliers, whether to combine or separate conditions---could inflate the
nominal 5% Type I error rate to over 60%.

Their demonstration was particularly striking: using entirely standard and
defensible analytical practices, they "proved" that listening to the Beatles
song "When I'm Sixty-Four" made participants literally younger. The result was
nonsensical, but the methods that produced it were indistinguishable from
routine scientific practice.

---

## 3. Empirical Evidence: The Scope of the Problem

### 3.1 Survey Evidence on Questionable Research Practices

Self-report surveys consistently find high rates of questionable research
practices. John, Loewenstein, and Prelec (2012) surveyed over 2,000
psychologists and found:

- 56% admitted to deciding whether to collect more data after checking
  significance
- 46% admitted to selectively reporting studies that "worked"
- 38% admitted to excluding data post-hoc to achieve significance
- 35% admitted to reporting unexpected findings as if they were predicted

These are not rare aberrations but common practices, normalized within
scientific culture.

### 3.2 The Ioannidis Framework

John Ioannidis's 2005 paper "Why Most Published Research Findings Are False"
provided a mathematical framework for understanding how bias, low power, and
flexibility combine to produce unreliable science. He argued that the
probability a research finding is true depends on:

1. The prior probability the hypothesis is true
2. Statistical power
3. The significance threshold
4. The degree of bias (including analytical flexibility)

Under plausible assumptions about these parameters in many research fields,
Ioannidis concluded that more than half of published findings are likely false
positives. While the specific estimates remain debated (Jager & Leek, 2014),
the qualitative insight---that standard practices produce unacceptably high
false positive rates---has been widely accepted.

### 3.3 Evidence from Registered Reports

Perhaps the most compelling evidence comes from comparing registered reports
(where methods and analyses are peer-reviewed and accepted before data
collection) with traditional publications. A systematic analysis found that 61%
of registered reports reported null results, compared to an estimated 5-20% in
traditional literature (Allen & Mehler, 2019).

This dramatic difference cannot be explained by registered reports attracting
weaker hypotheses. Rather, it suggests that traditional publishing practices
systematically filter or transform results toward significance.

---

## 4. Pre-Specification as a Solution

### 4.1 The Concept of Pre-Registration

Pre-registration involves documenting a study's hypotheses, methods, and
analysis plan before data collection or analysis, depositing this document in a
time-stamped public repository. The Open Science Framework (osf.io), maintained
by the Center for Open Science, provides free infrastructure for this purpose.

As Nosek and colleagues (2018) argue in "The Preregistration Revolution":

> "Preregistration distinguishes confirmatory and exploratory analyses in order
> to retain the validity of their statistical inferences... Including a
> detailed analysis plan in the preregistration may additionally help reduce
> unintentional false positive inflation of results."

Pre-registration does not prohibit exploratory analysis. Rather, it creates
transparency about which analyses were planned versus discovered. This allows
readers to appropriately weight the evidence: planned confirmatory analyses
that reach significance provide stronger evidence than exploratory findings,
which require independent confirmation.

### 4.2 Statistical Analysis Plans in Clinical Research

Clinical trials provide a model for rigorous pre-specification that predates
the replication crisis by decades. The International Conference on
Harmonisation's E9 guideline, adopted by the FDA in 1998, requires:

> "Full details of the planned statistical analysis should be specified and
> documented before knowledge of the study results that may reveal the drug
> effects, which may be accomplished using a separate statistical analysis
> plan."

This requirement emerged from hard experience with therapeutic failures
presented as successes through post-hoc analytical manipulation. The
thalidomide tragedy of the 1960s led to the 1962 Kefauver-Harris Amendment
requiring evidence of efficacy, and subsequent decades refined standards for
what constitutes credible evidence.

The ICH E9(R1) addendum (2019) further strengthened these requirements by
introducing the "estimand" framework, requiring explicit pre-specification of:

- The treatment effect being estimated
- How intercurrent events (like dropouts) will be handled
- The target population
- Sensitivity analyses to assess robustness

### 4.3 Elements of a Strong Pre-Registration

Effective pre-registration specifies:

1. **Research questions and hypotheses**: Precisely stated, directional where
   appropriate
2. **Study design**: Population, sampling, randomization if applicable
3. **Variables**: Operational definitions of outcomes, predictors, covariates
4. **Sample size justification**: Power analysis or precision-based rationale
5. **Analysis plan**: Specific statistical models, including equation form
6. **Inference criteria**: Alpha level, multiple testing corrections,
   equivalence bounds
7. **Sensitivity analyses**: Pre-specified robustness checks
8. **Contingencies**: How deviations will be handled and reported

The discipline of writing a complete analysis plan before seeing data reveals
gaps in thinking. Creating "table shells"---empty results tables with headers
but no numbers---forces precision about what will actually be computed and
reported.

---

## 5. Addressing Objections and Limitations

### 5.1 "Pre-Registration Stifles Discovery"

Critics argue that requiring pre-specification inhibits exploratory science.
This conflates two distinct activities. As Wagenmakers et al. (2012) emphasize
in "An Agenda for Purely Confirmatory Research":

> "There is nothing wrong with exploration as long as it is explicitly
> acknowledged as such."

Pre-registration does not prohibit exploration; it requires honesty about which
findings emerged from planned tests versus data-driven discovery. Exploratory
findings are valuable---they generate hypotheses for future confirmation---but
they do not carry the same evidential weight as confirmatory tests.

Steegen et al. (2016) propose "multiverse analysis" as a complementary
approach: instead of selecting a single analytical path, researchers
systematically vary reasonable analytical choices and report the full
distribution of results. This acknowledges the garden of forking paths while
providing transparency about how conclusions depend on analytical decisions.

### 5.2 "Pre-Registration is Impractical for Some Research"

Certain research contexts pose genuine challenges for pre-registration:
qualitative research, field studies with unpredictable conditions, and analyses
of existing datasets where the analyst cannot be blind to data properties.

However, pre-registration templates now exist for many study types, including
secondary data analysis (Weston et al., 2019). For existing datasets, the
principle remains valuable: document analytical intentions before examining
relationships of interest, even if basic data properties are already known.

### 5.3 "Researchers Will Just Cheat"

Evidence suggests that poorly-specified pre-registrations leave substantial
room for flexibility, and some researchers do deviate from their stated plans
without disclosure. However, this argues for better pre-registration practice,
not abandonment of the approach.

Registered Reports---where journals commit to publishing based on
methodological quality before results are known---provide stronger protection
by removing publication bias entirely. Over 300 journals now offer this format.

---

## 6. Pre-Specification as Epistemic Humility

### 6.1 The Philosophical Foundation

Beyond its statistical function, pre-specification embodies a philosophical
stance: epistemic humility. This concept, rooted in the Socratic tradition,
involves acknowledging the limits of one's knowledge and the fallibility of
human reasoning.

As the philosopher Ian James Kidd articulates:

> "The virtue of epistemic humility therefore builds in, at the ground level,
> an acute sense of the fact that epistemic confidence is conditional, complex,
> contingent, and therefore fragile."

Pre-specification operationalizes this humility. By committing to analytical
decisions before seeing results, researchers acknowledge that their post-hoc
judgments cannot be trusted to remain objective. The plan serves as a contract
with one's future self and with the scientific community.

### 6.2 Implications for Collaborative Biostatistics

For biostatisticians working with clinical investigators, epidemiologists, and
other domain experts, pre-specification serves multiple functions:

1. **Disciplining the collaboration**: Writing a statistical analysis plan
   forces clarity about research questions before anyone has a stake in
   particular results.

2. **Protecting against pressure**: When results disappoint, investigators may
   pressure statisticians to "try different analyses." A pre-registered plan
   provides professional cover: "This is what we agreed to do."

3. **Enhancing credibility**: Results from pre-specified analyses carry more
   weight with regulators, reviewers, and the scientific community.

4. **Documenting expertise**: The SAP demonstrates the statistician's
   contribution to study design and analysis, supporting authorship claims and
   professional recognition.

Survey evidence confirms that practicing biostatisticians recognize this value:
72.3% rate statistical analysis plans as "absolutely essential" for effective
collaboration, placing this skill fourth among 16 team science competencies
(Slade et al., 2023).

---

## 7. Practical Recommendations for Graduate Training

### 7.1 Develop the Habit Early

Pre-specification should become automatic, not an afterthought. Graduate
students should write analysis plans for class projects, thesis work, and
collaborative research. The Palmer Penguins dataset used in this course
provides an ideal training ground: specify hypotheses about morphometric
relationships, commit to analytical approaches, then execute the plan.

### 7.2 Use Structured Templates

The Open Science Framework provides templates for various study types.
Discipline-specific resources exist for clinical trials (SPIRIT statement),
observational studies (STROBE), and systematic reviews (PROSPERO). Using these
templates ensures completeness and facilitates peer review.

### 7.3 Distinguish Confirmatory from Exploratory

Every analysis report should clearly identify which findings were pre-planned
and which emerged from exploration. This can be accomplished through section
headers, explicit labeling, or supplementary materials that reproduce the
original analysis plan.

### 7.4 Embrace Transparency About Deviations

Deviations from pre-specified plans are sometimes necessary and appropriate.
The key is transparent reporting: what was changed, why, and how results might
differ under the original specification. Sensitivity analyses comparing
pre-specified and modified approaches can quantify the impact.

### 7.5 Recognize the Limits

Pre-specification is not a panacea. It cannot compensate for poorly designed
studies, inadequate sample sizes, or flawed measurements. It is one component
of rigorous science, complementing but not replacing other methodological
virtues.

---

## 8. Conclusion

The scientific method's power derives from its discipline: hypotheses must
precede the data that test them. When this temporal order is violated---whether
through deliberate manipulation or unconscious flexibility---statistical
inference loses its foundation.

Pre-specification provides the institutional and procedural safeguards to
maintain this discipline. For biostatisticians, it represents both a technical
skill and an ethical commitment. The ability to write rigorous analysis plans,
maintain fidelity to them, and transparently document deviations distinguishes
professional practice from amateur data exploration.

As you begin Project 1 with the Palmer Penguins dataset, view the statistical
analysis plan not as bureaucratic overhead but as the intellectual heart of
your work. The plan is where scientific thinking happens. The analysis that
follows is merely execution.

---

## References

Allen, C., & Mehler, D. M. (2019). Open science challenges, benefits and tips
in early career and beyond. *PLOS Biology*, 17(5), e3000246.
https://doi.org/10.1371/journal.pbio.3000246

Bem, D. J. (2011). Feeling the future: Experimental evidence for anomalous
retroactive influences on cognition and affect. *Journal of Personality and
Social Psychology*, 100(3), 407-425. https://doi.org/10.1037/a0021524

Center for Open Science. (2025). Preregistration.
https://www.cos.io/initiatives/prereg

Food and Drug Administration. (1998). E9 Statistical Principles for Clinical
Trials: Guidance for Industry.
https://www.fda.gov/regulatory-information/search-fda-guidance-documents/e9-statistical-principles-clinical-trials

Gelman, A., & Loken, E. (2013). The garden of forking paths: Why multiple
comparisons can be a problem, even when there is no "fishing expedition" or
"p-hacking" and the research hypothesis was posited ahead of time. Department
of Statistics, Columbia University.
http://www.stat.columbia.edu/~gelman/research/unpublished/p_hacking.pdf

Gelman, A. (2014). The statistical crisis in science. *American Scientist*,
102(6), 460-465.
https://www.americanscientist.org/article/the-statistical-crisis-in-science

International Council for Harmonisation. (2019). E9(R1) Statistical Principles
for Clinical Trials: Addendum on Estimands and Sensitivity Analysis in Clinical
Trials.
https://www.fda.gov/regulatory-information/search-fda-guidance-documents/e9r1-statistical-principles-clinical-trials-addendum-estimands-and-sensitivity-analysis-clinical

Ioannidis, J. P. A. (2005). Why most published research findings are false.
*PLOS Medicine*, 2(8), e124.
https://doi.org/10.1371/journal.pmed.0020124

Jager, L. R., & Leek, J. T. (2014). An estimate of the science-wise false
discovery rate and application to the top medical literature. *Biostatistics*,
15(1), 1-12. https://doi.org/10.1093/biostatistics/kxt007

John, L. K., Loewenstein, G., & Prelec, D. (2012). Measuring the prevalence of
questionable research practices with incentives for truth telling.
*Psychological Science*, 23(5), 524-532.
https://doi.org/10.1177/0956797611430953

Kerr, N. L. (1998). HARKing: Hypothesizing after the results are known.
*Personality and Social Psychology Review*, 2(3), 196-217.
https://doi.org/10.1207/s15327957pspr0203_4

Nosek, B. A., Ebersole, C. R., DeHaven, A. C., & Mellor, D. T. (2018). The
preregistration revolution. *Proceedings of the National Academy of Sciences*,
115(11), 2600-2606. https://doi.org/10.1073/pnas.1708274114

Open Science Collaboration. (2015). Estimating the reproducibility of
psychological science. *Science*, 349(6251), aac4716.
https://doi.org/10.1126/science.aac4716

Simmons, J. P., Nelson, L. D., & Simonsohn, U. (2011). False-positive
psychology: Undisclosed flexibility in data collection and analysis allows
presenting anything as significant. *Psychological Science*, 22(11), 1359-1366.
https://doi.org/10.1177/0956797611417632

Simonsohn, U., Simmons, J. P., & Nelson, L. D. (2020). Specification curve
analysis. *Nature Human Behaviour*, 4(11), 1208-1214.
https://doi.org/10.1038/s41562-020-0912-z

Slade, E., et al. (2023). Team science competencies for collaborative
biostatisticians. *The American Statistician*, 77(3), 267-275.
[Survey data on essential skills for biostatisticians in team science]

Steegen, S., Tuerlinckx, F., Gelman, A., & Vanpaemel, W. (2016). Increasing
transparency through a multiverse analysis. *Perspectives on Psychological
Science*, 11(5), 702-712. https://doi.org/10.1177/1745691616658637

Wagenmakers, E.-J., Wetzels, R., Borsboom, D., van der Maas, H. L. J., &
Kievit, R. A. (2012). An agenda for purely confirmatory research.
*Perspectives on Psychological Science*, 7(6), 632-638.
https://doi.org/10.1177/1745691612463078

Weston, S. J., Ritchie, S. J., Rohrer, J. M., & Przybylski, A. K. (2019).
Recommendations for increasing the transparency of analysis of preexisting
data sets. *Advances in Methods and Practices in Psychological Science*, 2(3),
214-227. https://doi.org/10.1177/2515245919848684

---

*Prepared for PHB 243b, Division of Biostatistics, UC San Diego*
*January 2026*
