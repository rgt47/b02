---
title: "PHB 228: Statistical Computing"
subtitle: "Lecture 9: Introduction to the Bootstrap"
author: "Dr. Ronald G. Thomas"
date: "April 28, 2025"
format-notes: "Slides marked as 'REFERENCE ONLY' are included as learning resources for students and are placed at the end of the presentation"
format:
  revealjs:
    theme: serif
    slide-number: true
    code-fold: false
    code-tools: true
    highlight-style: github
    slideNumber: true
    smaller: false
    css: custom.css
    title-slide-attributes:
      data-background-image: "ucsdlibrary.jpeg"
      data-background-size: 25%
      data-background-position: right 5% bottom 5%
---

<style>
.question {
  background-color: #e6f7ff;
  border-left: 5px solid #1890ff;
  padding: 10px 15px;
  margin-top: 20px;
  border-radius: 5px;
}

.answer {
  background-color: #f6ffed;
  border-left: 5px solid #52c41a;
  padding: 10px 15px;
  margin-top: 10px;
  border-radius: 5px;
}

.reference-stamp {
  background-color: rgba(255,0,0,0.7);
  color: white;
  padding: 5px 10px;
  border-radius: 5px;
  font-size: 16px;
  position: absolute;
  top: 60px;
  right: 10px;
  z-index: 1000;
}
</style>

## Instructor Information {.smaller}

- **Instructor**: Dr. Ronald G. Thomas
- **Email**: rgthomas@ucsd.edu
- **Office Hours**: By appointment
- **TA**: Man Luo
- **Email**: maluo@ucsd.edu
- **Office Hours**: Wednesdays, 3:00 PM - 5:00 PM

:::{.notes}
- Welcome to Week 5 of our Statistical Computing course
- Today we'll begin learning about an important resampling technique: the bootstrap
- Please make note of office hours if you need help with homework or course concepts
- Remember that homework 4 will be assigned today
:::

## Lecture 9: Introduction to the Bootstrap {.subtitle}

## Today's Agenda {.smaller}

1. What is the bootstrap?
2. The fundamental bootstrap principle
3. Estimating standard errors
4. Bootstrap confidence intervals
5. Bootstrap distributions and sampling distributions
6. Implementation in R

:::{.notes}
- Today we'll cover the core concepts of bootstrap methodology
- We'll start with the basic idea and intuition
- Then examine how to apply it for standard errors and confidence intervals
- Finally, we'll see how to implement bootstrap methods in R
- This lecture pairs with next class where we'll explore more advanced bootstrap methods
:::

::: {.fragment .question}
**Question:** What statistical problems might become easier if we could repeatedly sample from a population?
:::

::: {.fragment .answer}
**Answer:** "If we could repeatedly sample, we could empirically estimate standard errors, create confidence intervals without relying on parametric assumptions, and better understand sampling distributions for complex statistics."
:::

## What is the Bootstrap? {.smaller}

Bootstrap is a computational resampling method that:

- Allows estimation of the sampling distribution of almost any statistic
- Uses the original sample as a stand-in for the population
- Creates new samples by resampling with replacement from the original data
- Was introduced by Bradley Efron in 1979

```r
# Basic bootstrap example in R
sample_mean <- function(data, indices) {
  mean(data[indices])
}

# Original data
my_data <- c(5, 10, 15, 20, 25)

# Single bootstrap resample (sampling with replacement)
bootstrap_indices <- sample(1:5, size=5, replace=TRUE)
bootstrap_sample <- my_data[bootstrap_indices]
bootstrap_mean <- mean(bootstrap_sample)
```

:::{.notes}
- The bootstrap is named after the phrase "pulling oneself up by one's bootstraps"
- It creates new samples from the original data, treating the sample as if it were the population
- Each bootstrap sample is the same size as the original, but created by sampling with replacement
- Efron's insight was that this approach can approximate the sampling distribution
- The concept is very intuitive but has deep theoretical underpinnings
:::

::: {.fragment .question}
**Question:** Why must bootstrap sampling be done with replacement?
:::

::: {.fragment .answer}
**Answer:** "Without replacement, every bootstrap sample would be identical to the original sample. Sampling with replacement creates variability that's necessary to estimate the sampling distribution."
:::

## The Fundamental Bootstrap Principle {.smaller}

The key insight: **substitute an estimate of the population for the true population**

In ideal world:
- Draw many samples from population F
- Calculate statistic θ̂ for each sample
- Examine the sampling distribution of θ̂

With bootstrap:
- Draw many samples from empirical distribution F̂ (the original sample)
- Calculate statistic θ̂* for each resample
- Use this bootstrap distribution to estimate properties of the sampling distribution

:::{.notes}
- The fundamental principle is the "plug-in" principle
- We replace the unknown population distribution F with the empirical distribution F̂
- Instead of drawing multiple samples from the population (impossible), we draw from our sample
- This gives us an approximation of the sampling distribution for our statistic
- The accuracy of this approximation has been well-studied mathematically
- Most effective when sample size is reasonably large (n ≥ 30)
:::

::: {.fragment .question}
**Question:** What is the empirical distribution F̂ in the bootstrap context?
:::

::: {.fragment .answer}
**Answer:** "The empirical distribution F̂ is the discrete distribution that puts probability 1/n on each of the n observed data points in our original sample."
:::

## Estimating Standard Errors {.smaller}

The bootstrap provides a universal method for estimating standard errors:

1. Draw B bootstrap samples (x₁*, x₂*, ..., xᵦ*) by sampling with replacement
2. Compute the statistic θ̂* for each bootstrap sample
3. Calculate the standard deviation of the bootstrap statistics:

$$SE_{boot} = \sqrt{\frac{1}{B-1} \sum_{i=1}^{B} (\hat{\theta}_i^* - \bar{\hat{\theta}}^*)^2}$$

Where $\bar{\hat{\theta}}^* = \frac{1}{B}\sum_{i=1}^{B} \hat{\theta}_i^*$

```r
# Bootstrap SE in R
library(boot)
boot_result <- boot(data=my_data, statistic=sample_mean, R=1000)
se_boot <- sd(boot_result$t)
```

:::{.notes}
- The standard error measures the variability of the sample statistic
- For some statistics (like the mean), we have simple formulas for SEs
- But for complex statistics, those formulas may not exist or be difficult to derive
- Bootstrap gives us a computational way to estimate SEs for virtually any statistic
- The accuracy depends on the number of bootstrap samples B
- Typically use B=1000 or more for standard error estimation
:::

::: {.fragment .question}
**Question:** For what types of statistics would bootstrap standard errors be particularly useful?
:::

::: {.fragment .answer}
**Answer:** "Bootstrap standard errors are especially useful for complex statistics like medians, correlation coefficients, regression coefficients in non-standard models, and custom statistics without known SE formulas."
:::

## Bootstrap Distributions vs. Sampling Distributions {.smaller}

Important to understand the relationship:

- **Sampling distribution**: Distribution of θ̂ when repeatedly sampling from population F
- **Bootstrap distribution**: Distribution of θ̂* when repeatedly sampling from empirical distribution F̂

Key differences:
- Bootstrap distribution is centered at the original sample statistic θ̂
- Sampling distribution is centered at the true parameter θ
- Bootstrap distribution approximates the shape and spread of sampling distribution
- Bootstrap does not improve the original estimate θ̂

:::{.notes}
- The bootstrap distribution is not exactly the same as the sampling distribution
- It's an estimate of the sampling distribution, centered at our observed statistic
- The bootstrap won't make a biased statistic unbiased
- But it will reveal the variability we would expect if we could sample repeatedly
- The bootstrap distribution can also reveal skewness and other properties
- This insight helps us understand when bootstrap methods will and won't work well
:::

::: {.fragment .question}
**Question:** Can the bootstrap be used to improve our point estimate θ̂?
:::

::: {.fragment .answer}
**Answer:** "Generally, no. The bootstrap is primarily used to assess the variability of θ̂, not to improve the point estimate itself. The mean of the bootstrap distribution is approximately the original estimate θ̂."
:::

## Bootstrap Confidence Intervals: Percentile Method {.smaller}

The simplest approach to bootstrap confidence intervals:

1. Generate B bootstrap samples and compute θ̂* for each
2. Order the bootstrap estimates: θ̂₍₁₎* ≤ θ̂₍₂₎* ≤ ... ≤ θ̂₍ᵦ₎*
3. For a 95% confidence interval, take the 2.5th and 97.5th percentiles:

$$CI_{95\%} = [\hat{\theta}_{(0.025B)}^*, \hat{\theta}_{(0.975B)}^*]$$

```r
# Percentile bootstrap CI in R
boot_result <- boot(data=my_data, statistic=sample_mean, R=1000)
percentile_ci <- quantile(boot_result$t, c(0.025, 0.975))
```

:::{.notes}
- The percentile method is intuitive and easy to implement
- It automatically accounts for skewness in the sampling distribution
- For symmetric distributions, it's similar to the normal-theory interval
- But it can be less accurate for small samples
- We'll see more sophisticated bootstrap CI methods in the next lecture
- For many applications, the percentile method works reasonably well
:::

::: {.fragment .question}
**Question:** Why might the percentile bootstrap interval be more appropriate than a standard t-interval for skewed data?
:::

::: {.fragment .answer}
**Answer:** "The percentile bootstrap interval naturally adapts to the shape of the sampling distribution. For skewed distributions, it can produce asymmetric intervals that better match the true sampling behavior, unlike t-intervals that always impose symmetry."
:::

## Monte Carlo Implementation {.smaller}

In practice, the bootstrap is implemented via Monte Carlo simulation:

1. Draw B random samples with replacement from the original data
2. Compute the statistic of interest for each bootstrap sample
3. Use the empirical distribution of these statistics

How many bootstrap samples (B) do we need?
- For standard errors: B = 200-500 is often sufficient
- For confidence intervals: B = 1000-2000 is recommended
- For complex problems: B = 10,000 or more may be needed

:::{.notes}
- The number of possible bootstrap samples is enormous: n^n for a sample of size n
- It's computationally infeasible to enumerate all possible bootstrap samples
- Therefore, we use Monte Carlo simulation to randomly generate bootstrap samples
- The Monte Carlo error decreases as B increases
- For most educational purposes, B=1000 provides a good balance of accuracy and speed
- In practice, you might want to use larger B for final results
:::

::: {.fragment .question}
**Question:** What can happen if we use too few bootstrap samples (e.g., B=50)?
:::

::: {.fragment .answer}
**Answer:** "With too few bootstrap samples, we introduce substantial Monte Carlo error. Our standard error estimates will be unstable, and confidence interval endpoints will be unreliable, especially for percentile-based methods."
:::

## When Does the Bootstrap Work Well? {.smaller}

The bootstrap is most effective when:

- Sample size is moderately large (n ≥ 30)
- The statistic of interest is "smooth" (small changes in data produce small changes in the statistic)
- The sampling distribution is not heavily influenced by a few extreme observations

Potential challenges arise with:
- Very small samples
- Extremely skewed distributions
- Statistics that depend heavily on extreme values
- Complex data structures (time series, spatial data)

:::{.notes}
- The bootstrap is an approximation method that works well in many cases
- But it's not a universal solution for all statistical problems
- Small sample sizes can be problematic - the empirical distribution is a poor estimate of F
- The sample may not contain important features of the population
- Understanding these limitations helps us apply bootstrap methods appropriately
- For small samples, parametric methods might be more appropriate
:::

::: {.fragment .question}
**Question:** Why might bootstrap methods struggle with the sample median when sample size is small (e.g., n=5)?
:::

::: {.fragment .answer}
**Answer:** "With small samples, the bootstrap distribution of the median is discrete and limited to the observed values. This poor approximation of the sampling distribution leads to inaccurate standard errors and confidence intervals."
:::

## Bootstrap in R {.smaller}

The `boot` package in R makes bootstrap analysis straightforward:

```r
library(boot)

# Define a function for your statistic
boot_statistic <- function(data, indices) {
  # Calculate the statistic on the resampled data
  resample <- data[indices]
  return(median(resample))
}

# Original data
my_data <- c(10, 14, 18, 23, 27, 32, 38, 42, 52, 68)

# Run the bootstrap
set.seed(123)  # For reproducibility
boot_result <- boot(data=my_data, statistic=boot_statistic, R=1000)

# Examine results
print(boot_result)
boot.ci(boot_result, type="perc")  # Percentile confidence interval

# Visualize bootstrap distribution
hist(boot_result$t, main="Bootstrap Distribution", 
     xlab="Median", breaks=20)
```

:::{.notes}
- The boot package is the standard way to perform bootstrap in R
- The key is defining your statistic function that accepts data and indices arguments
- Indices indicate which observations to use in each bootstrap sample
- The boot function handles the resampling for you
- You can then use boot.ci to compute various types of confidence intervals
- Visualizing the bootstrap distribution can provide valuable insights
:::

::: {.fragment .question}
**Question:** What is the role of the "indices" parameter in the boot statistic function?
:::

::: {.fragment .answer}
**Answer:** "The indices parameter contains the positions of observations randomly selected during resampling. Rather than creating actual bootstrap samples, the boot function passes these indices to your function, which then applies them to the original data to create the bootstrap sample."
:::

## Bootstrap vs. Traditional Methods {.smaller}

Advantages of bootstrap methods:
- Work for almost any statistic without deriving new formulas
- Don't require distributional assumptions (nonparametric)
- Naturally adapt to the shape of the sampling distribution
- Provide intuitive visualization of sampling variability

Limitations:
- Computationally intensive (less of an issue with modern computers)
- May not work well for small samples
- Cannot overcome fundamental limitations of the original data
- Bootstrap confidence intervals can have poor coverage in some cases

:::{.notes}
- Bootstrap methods complement rather than replace traditional methods
- For simple problems with well-understood statistics, traditional methods work fine
- Bootstrap shines for complex statistics or when assumptions are questionable
- The pedagogical value is significant - helps students understand sampling variability
- We'll explore more advanced bootstrap confidence intervals next time
- These can improve performance in challenging cases
:::

::: {.fragment .question}
**Question:** In what scenarios would you recommend using traditional methods over bootstrap methods?
:::

::: {.fragment .answer}
**Answer:** "Traditional methods are preferable when sample sizes are very small, when the statistic has a known sampling distribution under reasonable assumptions, or when computational resources are limited. They also provide analytical insights that numerical methods may obscure."
:::

## Summary {.smaller}

In this lecture, we've covered:

1. The fundamental principle of the bootstrap
2. Using bootstrap to estimate standard errors
3. Bootstrap distributions vs. sampling distributions
4. Percentile bootstrap confidence intervals
5. Implementation via Monte Carlo sampling
6. Situations where bootstrap works well or poorly
7. Practical implementation in R

Next lecture:
- More sophisticated bootstrap confidence intervals
- Bootstrap hypothesis testing
- Applications to regression and other models

:::{.notes}
- We've covered the essential concepts of bootstrap methodology
- The key insight is using the sample as a proxy for the population
- This powerful idea generalizes to many statistical problems
- Next time, we'll build on these concepts with more advanced methods
- We'll also see examples of bootstrap applied to regression and time series
- The homework will give you hands-on experience implementing bootstrap methods
:::

## Reference Material {.center}

The following slides are provided as reference material and are not part of the core lecture.

## Key Bootstrap Papers (Optional Reading) {.smaller .reference-only}

::: {.reference-stamp}
REFERENCE ONLY
:::

Essential readings on bootstrap methodology:

- Efron, B. (1979). "Bootstrap methods: Another look at the jackknife." *The Annals of Statistics*, 7(1), 1-26.
  - The original paper introducing the bootstrap

- Efron, B. and Tibshirani, R. (1986). "Bootstrap methods for standard errors, confidence intervals, and other measures of statistical accuracy." *Statistical Science*, 1(1), 54-77.
  - Accessible overview of basic bootstrap methodology

- Hesterberg, T. (2015). "What teachers should know about the bootstrap: Resampling in the undergraduate statistics curriculum." *The American Statistician*, 69(4), 371-386.
  - Pedagogical introduction with practical advice

:::{.notes}
- These papers provide the theoretical foundation for bootstrap methods
- Efron's original 1979 paper is remarkably readable
- The Hesterberg paper is particularly useful for teaching bootstrap methods
- Students interested in the theory should start with Efron and Tibshirani (1986)
- More advanced theoretical developments are covered in Efron's book "An Introduction to the Bootstrap"
:::

## Bootstrap Functions in R (Advanced) {.smaller .reference-only}

::: {.reference-stamp}
REFERENCE ONLY
:::

For more complex bootstrap applications in R:

```r
# Bootstrap with multiple statistics
boot_multi_stat <- function(data, indices) {
  resample <- data[indices]
  return(c(mean = mean(resample), 
           median = median(resample),
           sd = sd(resample)))
}

# Bootstrap for regression coefficients
library(boot)
boot_reg <- function(data, indices) {
  model <- lm(y ~ x, data = data[indices, ])
  return(coef(model))
}

# Stratified bootstrap
boot_strat <- boot(data, boot_statistic, R=1000, 
                   strata=factor_variable)

# Bootstrap confidence intervals
boot.ci(boot_result, type=c("norm", "perc", "bca"))
```

:::{.notes}
- These examples show more advanced applications of the boot package
- The boot function is very flexible and can handle multiple statistics
- Stratified bootstrap maintains the structure of categorical variables
- Different confidence interval methods have different properties
- The norm, perc, and bca methods are increasingly sophisticated
- We'll cover the BCa method in detail in the next lecture
:::
