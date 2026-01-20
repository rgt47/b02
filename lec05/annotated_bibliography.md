# Annotated Bibliography: Palmer Penguins Dataset and Related Research

## PHB 243b - Project 1 Reference Materials

This annotated bibliography provides background literature for the Palmer
Penguins dataset, including the original ecological research, the data
science education context, and broader ecological studies of Pygoscelis
penguins in Antarctica.

---

## Primary Data Sources

### 1. Original Ecological Study

**Gorman KB, Williams TD, Fraser WR (2014).** Ecological sexual dimorphism
and environmental variability within a community of Antarctic penguins
(genus *Pygoscelis*). *PLOS ONE* 9(3): e90081.
https://doi.org/10.1371/journal.pone.0090081

*This is the original research paper from which the Palmer Penguins dataset
derives.* The study examined sexual size dimorphism and sex-specific foraging
niche partitioning among three penguin species (Adelie, Chinstrap, Gentoo) at
Palmer Station, Antarctica, during 2007-2009. Methods included morphometric
measurements (culmen length/depth, flipper length, body mass), molecular
sexing using P2/P8 primers, and stable isotope analysis (carbon-13 and
nitrogen-15) from blood samples to infer foraging ecology. Key findings:
Chinstrap penguins showed the greatest sexual size dimorphism, followed by
Gentoo and Adelie. Male Chinstrap and Gentoo penguins were enriched in
nitrogen-15 relative to females, suggesting consumption of higher
trophic-level prey. The study used information-theoretic model selection
(AICc) for statistical inference. **Relevance:** Essential reading for
understanding the biological context and data collection methods underlying
the dataset.

---

### 2. The palmerpenguins R Package Paper

**Horst AM, Hill AP, Gorman KB (2022).** Palmer Archipelago Penguins Data in
the palmerpenguins R Package: An alternative to Anderson's Irises. *The R
Journal* 14(1): 244-254.
https://doi.org/10.32614/RJ-2022-020

*The definitive paper introducing the palmerpenguins dataset for data science
education.* The authors make the case for replacing the iris dataset with
Palmer penguins data, citing several advantages: (1) complete metadata and
documentation versus iris's minimal provenance; (2) realistic missing values
and unequal sample sizes that better prepare students for real-world data;
(3) intuitive variable names (flipper length, bill depth) versus confusing
botanical terms; (4) ethical concerns about iris's publication history in
eugenics research. The paper demonstrates that penguins serves as a "near
drop-in replacement" for iris across common educational use cases: data
wrangling, visualization, linear modeling, PCA, and clustering. Downloaded
over 462,000 times since July 2020 CRAN release. **Relevance:** Explains why
this dataset was chosen for teaching and documents appropriate analytical
approaches.

---

## Broader Ecological Context

### 3. Climate Change and Penguin Populations

**Clucas GV, Dunn MJ, Dyke G, et al. (2014).** A reversal of fortunes:
climate change 'winners' and 'losers' in Antarctic Peninsula penguins.
*Scientific Reports* 4: 5024.
https://doi.org/10.1038/srep05024

*A landmark study on how climate change differentially affects the three
Pygoscelis species.* Using molecular techniques to assess demographic history
since the Last Glacial Maximum (LGM), the researchers found that all three
species initially benefited from post-LGM warming by expanding from glacial
refugia. However, current anthropogenic warming has caused a "reversal of
fortunes": Gentoo penguins continue to expand as climate "winners," while
Adelie and Chinstrap penguins have become "losers" with declining
populations. The mechanism involves decreased sea ice, loss of winter
habitat, and reduced krill availability. This decoupling of historic
responses from current trends suggests anthropogenic impacts outside the
range of natural variation. **Relevance:** Provides ecological context for
species differences observed in the dataset and motivation for conservation
research.

---

### 4. Global Chinstrap Population Assessment

**Strycker N, Wethington M, Borowicz A, et al. (2020).** A global population
assessment of the Chinstrap penguin (*Pygoscelis antarctica*). *Scientific
Reports* 10: 19474.
https://doi.org/10.1038/s41598-020-76479-3

*The first comprehensive global census of Chinstrap penguins.* Using
satellite imagery, drone imagery, and ground counts, researchers estimated
3.42 million breeding pairs across 375 extant colonies. Twenty-three
previously known colonies were found absent or extirpated, while 26 new or
unreported colonies were identified. Among colonies with historical data from
the 1980s, 45% have declined and only 18% have increased. **Relevance:**
Demonstrates modern methods for large-scale ecological assessment and
provides population context for the Chinstrap penguins in the Palmer dataset.

---

### 5. Gentoo Population Genetics

**Clucas GV, Younger JL, Kao D, et al. (2014).** Have historical climate
changes affected Gentoo penguin (*Pygoscelis papua*) populations in
Antarctica? *PLOS ONE* 9(4): e95375.
https://doi.org/10.1371/journal.pone.0095375

This study examined how climate change over the past 50 years in the West
Antarctic Peninsula (WAP) has affected Gentoo penguin populations. The
atmospheric temperature increase and changes in sea-ice dynamics have led to
population expansion of sub-Antarctic Gentoo penguins and retreat of Adelie
penguins. Using mitochondrial DNA analysis, researchers traced demographic
history and found that Gentoo populations show signatures of recent
expansion. **Relevance:** Explains why Gentoo penguins are the largest
species in the Palmer dataset and provides genetic context for species
differences.

---

### 6. Trophic Interactions and the Sea Ice Hypothesis

**Cimino MA, Lynch HJ, Saba VS, Oliver MJ (2016).** Projected asymmetric
response of Adelie penguins to Antarctic climate change. *Scientific Reports*
6: 28785.
https://doi.org/10.1038/srep28785

Models project that Adelie penguin populations will respond asymmetrically to
continued climate change, with colonies in different regions showing
divergent trajectories depending on local sea ice conditions. The study used
species distribution models to forecast population changes under climate
scenarios. **Relevance:** Demonstrates predictive modeling approaches that
could be applied to morphometric relationships in the Palmer dataset.

---

### 7. Adélie Penguin Morphometric Sexing

**Polito MJ, Trivelpiece WZ (2008).** Transition to independence and evidence
of extended parental care in the gentoo penguin (*Pygoscelis papua*).
*Marine Biology* 154: 231-240.

**Ainley DG, Emison WB (1972).** Sexual size dimorphism in Adélie penguins.
*Ibis* 114: 267-271.

*Classic papers establishing morphometric approaches to penguin sexing.*
These studies demonstrated that bill dimensions and body mass can reliably
discriminate sex in Pygoscelis penguins, laying the groundwork for the
molecular validation in Gorman et al. (2014). Logistic regression models
using culmen measurements achieve high classification accuracy.
**Relevance:** Provides methodological background for using morphometric
predictors and validates the discriminant analysis applications common in
educational uses of the Palmer dataset.

---

## Data Science and Statistics Education

### 8. Release Announcement

**Hill AP (2020).** Release the penguins. *RStudio Education Blog*, July 28,
2020.
https://education.rstudio.com/blog/2020/07/palmerpenguins-cran/

The official announcement of the palmerpenguins package on CRAN. Describes
the motivation for creating the package, highlights key features (missing
values, Simpson's Paradox examples, multiple factor variables), and provides
example visualizations. Notes that the dataset is "a great intro dataset for
data exploration & visualization" suitable as an iris alternative.
**Relevance:** Documents the educational intent and provides introductory
examples.

---

### 9. Simpson's Paradox Example

**Pearl J (2014).** Comment: Understanding Simpson's Paradox. *The American
Statistician* 68(1): 8-13.

The Palmer Penguins dataset contains a well-known example of Simpson's
Paradox: the overall correlation between bill depth and body mass is
negative, but within each species the correlation is positive. This occurs
because Gentoo penguins have larger bodies but shallower bills than Adelie
penguins. **Relevance:** The dataset provides an accessible teaching example
for an important statistical phenomenon.

---

## Machine Learning Applications

### 10. Species Classification Studies

**Various authors (2020-2025).** Penguin species classification using machine
learning. Multiple sources including Kaggle notebooks and GitHub
repositories.

- https://www.kaggle.com/code/freddymoreno/using-machine-learning-to-classify-penguin-species
- https://github.com/ketanmakde/DT-RF_Penguin-Data-Antarctica
- https://github.com/hussaifm/penguins-dataset-R

*Educational implementations of classification algorithms.* Multiple
tutorials demonstrate species classification using the Palmer dataset with
decision trees (98.55% accuracy), random forests (100% accuracy), logistic
regression, k-nearest neighbors, and neural networks. The Gentoo species is
easily separable based on culmen depth; Adelie and Chinstrap show more
overlap but can be distinguished by culmen length. **Relevance:** Demonstrates
that the dataset supports machine learning education beyond traditional
statistical methods.

---

### 11. Body Mass Prediction (Regression)

**Scikit-learn MOOC (2021-2025).** The penguins datasets. INRIA.
https://inria.github.io/scikit-learn-mooc/python_scripts/trees_dataset.html

The scikit-learn massive open online course uses Palmer penguins to teach
regression concepts, specifically predicting body mass from flipper length.
Random forest models achieve RMSE of approximately 317g and R-squared of
0.877. The dataset demonstrates clear positive relationships between
morphometric variables that serve as intuitive examples for linear and
tree-based regression. **Relevance:** Validates the regression analyses
planned for Project 1.

---

## Citation for the Dataset

When using the Palmer Penguins data, cite both the R package and the original
data collection:

**Data package:**
Horst AM, Hill AP, Gorman KB (2020). palmerpenguins: Palmer Archipelago
(Antarctica) penguin data. R package version 0.1.0.
https://allisonhorst.github.io/palmerpenguins/
DOI: 10.5281/zenodo.3960218

**Original data collection:**
Gorman KB, Williams TD, Fraser WR (2014). Ecological sexual dimorphism and
environmental variability within a community of Antarctic penguins (genus
*Pygoscelis*). *PLOS ONE* 9(3): e90081.
https://doi.org/10.1371/journal.pone.0090081

**Data repository:**
Data originally published through the Environmental Data Initiative (EDI)
Data Portal, available under CC0 license in accordance with the Palmer
Station LTER Data Policy.

---

## Summary Table

| Reference | Type | Key Contribution |
|-----------|------|------------------|
| Gorman et al. 2014 | Original research | Source of morphometric data |
| Horst et al. 2022 | R Journal article | Dataset documentation, iris comparison |
| Clucas et al. 2014 | Ecology | Climate winners/losers framework |
| Strycker et al. 2020 | Population ecology | Global Chinstrap census methods |
| Hill 2020 | Education | Package release, teaching applications |

---

*Compiled for PHB 243b, January 2026*
