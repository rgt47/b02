# all_tables_penguins.R
# Generate all SAP shell tables and completed tables for Palmer Penguins
# Output: Single HTML file with all 10 tables (5 shells + 5 completed)

library(gt)
library(tibble)
library(dplyr)
library(tidyr)
library(palmerpenguins)
library(broom)

penguins_clean <- penguins |>
  filter(!is.na(body_mass_g), !is.na(flipper_length_mm), !is.na(sex))

format_p <- function(p) if (p < 0.001) "<0.001" else sprintf("%.3f", p)
calc_pct <- function(n, total) sprintf("%d (%.1f)", n, 100 * n / total)
rmse <- function(m) sqrt(mean(m$residuals^2))

# =============================================================================
# SHELL TABLES
# =============================================================================

# Table 1 Shell: Baseline Characteristics
shell_table_1 <- tribble(
  ~Characteristic, ~Adelie, ~Chinstrap, ~Gentoo, ~Total, ~pvalue,
  "Island, n (%)", "", "", "", "", "",
  "    Biscoe", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "",
  "    Dream", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "",
  "    Torgersen", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "X.XXX",
  "Sex, n (%)", "", "", "", "", "",
  "    Female", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "",
  "    Male", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "X.XXX",
  "Bill length (mm)", "", "", "", "", "",
  "    Mean (SD)", "XX.X (X.XX)", "XX.X (X.XX)", "XX.X (X.XX)", "XX.X (X.XX)", "",
  "    Median [IQR]", "XX.X [XX.X, XX.X]", "XX.X [XX.X, XX.X]",
    "XX.X [XX.X, XX.X]", "XX.X [XX.X, XX.X]", "X.XXX",
  "Bill depth (mm)", "", "", "", "", "",
  "    Mean (SD)", "XX.X (X.XX)", "XX.X (X.XX)", "XX.X (X.XX)", "XX.X (X.XX)", "",
  "    Median [IQR]", "XX.X [XX.X, XX.X]", "XX.X [XX.X, XX.X]",
    "XX.X [XX.X, XX.X]", "XX.X [XX.X, XX.X]", "X.XXX",
  "Flipper length (mm)", "", "", "", "", "",
  "    Mean (SD)", "XXX.X (X.XX)", "XXX.X (X.XX)", "XXX.X (X.XX)",
    "XXX.X (X.XX)", "",
  "    Median [IQR]", "XXX [XXX, XXX]", "XXX [XXX, XXX]", "XXX [XXX, XXX]",
    "XXX [XXX, XXX]", "X.XXX",
  "Body mass (g)", "", "", "", "", "",
  "    Mean (SD)", "XXXX (XXX)", "XXXX (XXX)", "XXXX (XXX)", "XXXX (XXX)", "",
  "    Median [IQR]", "XXXX [XXXX, XXXX]", "XXXX [XXXX, XXXX]",
    "XXXX [XXXX, XXXX]", "XXXX [XXXX, XXXX]", "X.XXX"
) |>
  gt() |>
  cols_label(
    Characteristic = "", Adelie = "Adelie\n(N=XXX)", Chinstrap = "Chinstrap\n(N=XXX)",
    Gentoo = "Gentoo\n(N=XXX)", Total = "Total\n(N=XXX)", pvalue = "p-value"
  ) |>
  tab_header(
    title = "Shell Table 1. Baseline Characteristics by Penguin Species",
    subtitle = "Palmer Station, Antarctica (2007-2009)"
  ) |>
  tab_footnote("Categorical: n (%); Continuous: mean (SD) and median [IQR].") |>
  tab_footnote("P-values: chi-square (categorical) or Kruskal-Wallis (continuous).") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")

# Table 2 Shell: Correlation Matrix
shell_table_2 <- tribble(
  ~Variable, ~bill_length, ~bill_depth, ~flipper_length, ~body_mass,
  "Bill length (mm)", "1.000", "", "", "",
  "Bill depth (mm)", "X.XXX", "1.000", "", "",
  "Flipper length (mm)", "X.XXX", "X.XXX", "1.000", "",
  "Body mass (g)", "X.XXX", "X.XXX", "X.XXX", "1.000"
) |>
  gt() |>
  cols_label(
    Variable = "", bill_length = "Bill Length", bill_depth = "Bill Depth",
    flipper_length = "Flipper Length", body_mass = "Body Mass"
  ) |>
  tab_header(title = "Shell Table 2. Pearson Correlation Matrix") |>
  tab_footnote("Values represent Pearson correlation coefficients (r).") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")

# Table 3 Shell: Simple Linear Regression
shell_table_3 <- tribble(
  ~Parameter, ~Estimate, ~SE, ~CI, ~tvalue, ~pvalue,
  "Intercept", "XXXX.XX", "XXX.XX", "[XXXX.X, XXXX.X]", "XX.XX", "<0.001",
  "Flipper length (mm)", "XX.XX", "X.XX", "[XX.X, XX.X]", "XX.XX", "<0.001"
) |>
  gt() |>
  cols_label(
    Parameter = "Parameter", Estimate = "Estimate", SE = "Std. Error",
    CI = "95% CI", tvalue = "t-value", pvalue = "p-value"
  ) |>
  tab_header(title = "Shell Table 3. Simple Linear Regression: Body Mass ~ Flipper Length") |>
  tab_footnote("Dependent variable: Body mass (g)") |>
  tab_source_note("R-squared: X.XXX | Adjusted R-squared: X.XXX | RMSE: XXX.X g")

# Table 4 Shell: Model Comparison
shell_table_4 <- tribble(
  ~Statistic, ~Model1, ~Model2, ~Model3, ~Model4,
  "R-squared", "X.XXX", "X.XXX", "X.XXX", "X.XXX",
  "Adjusted R-squared", "X.XXX", "X.XXX", "X.XXX", "X.XXX",
  "RMSE (g)", "XXX.X", "XXX.X", "XXX.X", "XXX.X",
  "AIC", "XXXX.X", "XXXX.X", "XXXX.X", "XXXX.X",
  "BIC", "XXXX.X", "XXXX.X", "XXXX.X", "XXXX.X",
  "F-statistic", "XXX.XX", "XXX.XX", "XXX.XX", "XXX.XX",
  "df (model, residual)", "(X, XXX)", "(X, XXX)", "(X, XXX)", "(X, XXX)",
  "p-value (F-test)", "<0.001", "<0.001", "<0.001", "<0.001"
) |>
  gt() |>
  cols_label(
    Statistic = "Statistic", Model1 = "Model 1\n(Flipper)", Model2 = "Model 2\n(+ Species)",
    Model3 = "Model 3\n(+ Bills)", Model4 = "Model 4\n(Full)"
  ) |>
  tab_header(title = "Shell Table 4. Model Comparison: Nested Regression Models") |>
  tab_spanner(label = "Linear Regression Models", columns = -Statistic) |>
  tab_footnote("Model 1: Flipper | Model 2: +Species | Model 3: +Bills | Model 4: +Sex")

# Table 5 Shell: Final Model Coefficients
shell_table_5 <- tribble(
  ~Parameter, ~Estimate, ~SE, ~CI, ~pvalue,
  "Intercept", "XXXX.XX", "XXX.XX", "[XXXX.X, XXXX.X]", "<0.001",
  "Flipper length (mm)", "XX.XX", "X.XX", "[XX.X, XX.X]", "<0.001",
  "Bill length (mm)", "XX.XX", "X.XX", "[XX.X, XX.X]", "X.XXX",
  "Bill depth (mm)", "XX.XX", "X.XX", "[XX.X, XX.X]", "X.XXX",
  "Species (ref: Adelie)", "", "", "", "",
  "    Chinstrap", "XXX.XX", "XX.XX", "[XXX.X, XXX.X]", "X.XXX",
  "    Gentoo", "XXX.XX", "XX.XX", "[XXX.X, XXX.X]", "<0.001",
  "Sex (ref: Female)", "", "", "", "",
  "    Male", "XXX.XX", "XX.XX", "[XXX.X, XXX.X]", "<0.001"
) |>
  gt() |>
  cols_label(
    Parameter = "Parameter", Estimate = "Estimate", SE = "Std. Error",
    CI = "95% CI", pvalue = "p-value"
  ) |>
  tab_header(
    title = "Shell Table 5. Final Model Coefficients",
    subtitle = "Body Mass ~ Morphometrics + Species + Sex"
  ) |>
  tab_footnote("Reference: Species = Adelie; Sex = Female") |>
  tab_source_note("R-squared: X.XXX | Adjusted R-squared: X.XXX | RMSE: XXX.X g")

# =============================================================================
# COMPLETED TABLES
# =============================================================================

# Compute summary statistics
species_n <- penguins_clean |> count(species) |> pull(n, name = species)
total_n <- nrow(penguins_clean)

island_by_species <- penguins_clean |>
  count(species, island) |>
  pivot_wider(names_from = species, values_from = n, values_fill = 0)

sex_by_species <- penguins_clean |>
  count(species, sex) |>
  pivot_wider(names_from = species, values_from = n, values_fill = 0)

continuous_stats <- penguins_clean |>
  group_by(species) |>
  summarise(
    bill_length_mean = sprintf("%.1f (%.2f)", mean(bill_length_mm), sd(bill_length_mm)),
    bill_length_med = sprintf("%.1f [%.1f, %.1f]", median(bill_length_mm),
      quantile(bill_length_mm, 0.25), quantile(bill_length_mm, 0.75)),
    bill_depth_mean = sprintf("%.1f (%.2f)", mean(bill_depth_mm), sd(bill_depth_mm)),
    bill_depth_med = sprintf("%.1f [%.1f, %.1f]", median(bill_depth_mm),
      quantile(bill_depth_mm, 0.25), quantile(bill_depth_mm, 0.75)),
    flipper_mean = sprintf("%.1f (%.2f)", mean(flipper_length_mm), sd(flipper_length_mm)),
    flipper_med = sprintf("%.0f [%.0f, %.0f]", median(flipper_length_mm),
      quantile(flipper_length_mm, 0.25), quantile(flipper_length_mm, 0.75)),
    mass_mean = sprintf("%.0f (%.0f)", mean(body_mass_g), sd(body_mass_g)),
    mass_med = sprintf("%.0f [%.0f, %.0f]", median(body_mass_g),
      quantile(body_mass_g, 0.25), quantile(body_mass_g, 0.75)),
    .groups = "drop"
  )

total_stats <- penguins_clean |>
  summarise(
    bill_length_mean = sprintf("%.1f (%.2f)", mean(bill_length_mm), sd(bill_length_mm)),
    bill_length_med = sprintf("%.1f [%.1f, %.1f]", median(bill_length_mm),
      quantile(bill_length_mm, 0.25), quantile(bill_length_mm, 0.75)),
    bill_depth_mean = sprintf("%.1f (%.2f)", mean(bill_depth_mm), sd(bill_depth_mm)),
    bill_depth_med = sprintf("%.1f [%.1f, %.1f]", median(bill_depth_mm),
      quantile(bill_depth_mm, 0.25), quantile(bill_depth_mm, 0.75)),
    flipper_mean = sprintf("%.1f (%.2f)", mean(flipper_length_mm), sd(flipper_length_mm)),
    flipper_med = sprintf("%.0f [%.0f, %.0f]", median(flipper_length_mm),
      quantile(flipper_length_mm, 0.25), quantile(flipper_length_mm, 0.75)),
    mass_mean = sprintf("%.0f (%.0f)", mean(body_mass_g), sd(body_mass_g)),
    mass_med = sprintf("%.0f [%.0f, %.0f]", median(body_mass_g),
      quantile(body_mass_g, 0.25), quantile(body_mass_g, 0.75))
  )

p_island <- chisq.test(table(penguins_clean$species, penguins_clean$island))$p.value
p_sex <- chisq.test(table(penguins_clean$species, penguins_clean$sex))$p.value
p_bill_length <- kruskal.test(bill_length_mm ~ species, data = penguins_clean)$p.value
p_bill_depth <- kruskal.test(bill_depth_mm ~ species, data = penguins_clean)$p.value
p_flipper <- kruskal.test(flipper_length_mm ~ species, data = penguins_clean)$p.value
p_mass <- kruskal.test(body_mass_g ~ species, data = penguins_clean)$p.value

island_total <- penguins_clean |> count(island)

# Table 1 Completed: Baseline Characteristics
completed_table_1 <- tribble(
  ~Characteristic, ~Adelie, ~Chinstrap, ~Gentoo, ~Total, ~pvalue,
  "Island, n (%)", "", "", "", "", "",
  "    Biscoe",
    calc_pct(island_by_species$Adelie[1], species_n["Adelie"]),
    calc_pct(island_by_species$Chinstrap[1], species_n["Chinstrap"]),
    calc_pct(island_by_species$Gentoo[1], species_n["Gentoo"]),
    calc_pct(island_total$n[1], total_n), "",
  "    Dream",
    calc_pct(island_by_species$Adelie[2], species_n["Adelie"]),
    calc_pct(island_by_species$Chinstrap[2], species_n["Chinstrap"]),
    calc_pct(island_by_species$Gentoo[2], species_n["Gentoo"]),
    calc_pct(island_total$n[2], total_n), "",
  "    Torgersen",
    calc_pct(island_by_species$Adelie[3], species_n["Adelie"]),
    calc_pct(island_by_species$Chinstrap[3], species_n["Chinstrap"]),
    calc_pct(island_by_species$Gentoo[3], species_n["Gentoo"]),
    calc_pct(island_total$n[3], total_n), format_p(p_island),
  "Sex, n (%)", "", "", "", "", "",
  "    Female",
    calc_pct(sex_by_species$Adelie[1], species_n["Adelie"]),
    calc_pct(sex_by_species$Chinstrap[1], species_n["Chinstrap"]),
    calc_pct(sex_by_species$Gentoo[1], species_n["Gentoo"]),
    calc_pct(sum(penguins_clean$sex == "female"), total_n), "",
  "    Male",
    calc_pct(sex_by_species$Adelie[2], species_n["Adelie"]),
    calc_pct(sex_by_species$Chinstrap[2], species_n["Chinstrap"]),
    calc_pct(sex_by_species$Gentoo[2], species_n["Gentoo"]),
    calc_pct(sum(penguins_clean$sex == "male"), total_n), format_p(p_sex),
  "Bill length (mm)", "", "", "", "", "",
  "    Mean (SD)",
    continuous_stats$bill_length_mean[1], continuous_stats$bill_length_mean[2],
    continuous_stats$bill_length_mean[3], total_stats$bill_length_mean, "",
  "    Median [IQR]",
    continuous_stats$bill_length_med[1], continuous_stats$bill_length_med[2],
    continuous_stats$bill_length_med[3], total_stats$bill_length_med, format_p(p_bill_length),
  "Bill depth (mm)", "", "", "", "", "",
  "    Mean (SD)",
    continuous_stats$bill_depth_mean[1], continuous_stats$bill_depth_mean[2],
    continuous_stats$bill_depth_mean[3], total_stats$bill_depth_mean, "",
  "    Median [IQR]",
    continuous_stats$bill_depth_med[1], continuous_stats$bill_depth_med[2],
    continuous_stats$bill_depth_med[3], total_stats$bill_depth_med, format_p(p_bill_depth),
  "Flipper length (mm)", "", "", "", "", "",
  "    Mean (SD)",
    continuous_stats$flipper_mean[1], continuous_stats$flipper_mean[2],
    continuous_stats$flipper_mean[3], total_stats$flipper_mean, "",
  "    Median [IQR]",
    continuous_stats$flipper_med[1], continuous_stats$flipper_med[2],
    continuous_stats$flipper_med[3], total_stats$flipper_med, format_p(p_flipper),
  "Body mass (g)", "", "", "", "", "",
  "    Mean (SD)",
    continuous_stats$mass_mean[1], continuous_stats$mass_mean[2],
    continuous_stats$mass_mean[3], total_stats$mass_mean, "",
  "    Median [IQR]",
    continuous_stats$mass_med[1], continuous_stats$mass_med[2],
    continuous_stats$mass_med[3], total_stats$mass_med, format_p(p_mass)
) |>
  gt() |>
  cols_label(
    Characteristic = "",
    Adelie = sprintf("Adelie\n(N=%d)", species_n["Adelie"]),
    Chinstrap = sprintf("Chinstrap\n(N=%d)", species_n["Chinstrap"]),
    Gentoo = sprintf("Gentoo\n(N=%d)", species_n["Gentoo"]),
    Total = sprintf("Total\n(N=%d)", total_n),
    pvalue = "p-value"
  ) |>
  tab_header(
    title = "Completed Table 1. Baseline Characteristics by Penguin Species",
    subtitle = "Palmer Station, Antarctica (2007-2009)"
  ) |>
  tab_footnote("Categorical: n (%); Continuous: mean (SD) and median [IQR].") |>
  tab_footnote("P-values: chi-square (categorical) or Kruskal-Wallis (continuous).") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")

# Table 2 Completed: Correlation Matrix
cor_matrix <- penguins_clean |>
  select(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) |>
  cor()

completed_table_2 <- tribble(
  ~Variable, ~bill_length, ~bill_depth, ~flipper_length, ~body_mass,
  "Bill length (mm)", "1.000", sprintf("%.3f", cor_matrix[1, 2]),
    sprintf("%.3f", cor_matrix[1, 3]), sprintf("%.3f", cor_matrix[1, 4]),
  "Bill depth (mm)", "", "1.000", sprintf("%.3f", cor_matrix[2, 3]),
    sprintf("%.3f", cor_matrix[2, 4]),
  "Flipper length (mm)", "", "", "1.000", sprintf("%.3f", cor_matrix[3, 4]),
  "Body mass (g)", "", "", "", "1.000"
) |>
  gt() |>
  cols_label(
    Variable = "", bill_length = "Bill Length", bill_depth = "Bill Depth",
    flipper_length = "Flipper Length", body_mass = "Body Mass"
  ) |>
  tab_header(title = "Completed Table 2. Pearson Correlation Matrix") |>
  tab_footnote("Values represent Pearson correlation coefficients (r).") |>
  tab_footnote("All correlations significant at p < 0.001.") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")

# Fit models
model1 <- lm(body_mass_g ~ flipper_length_mm, data = penguins_clean)
model2 <- lm(body_mass_g ~ flipper_length_mm + species, data = penguins_clean)
model3 <- lm(body_mass_g ~ flipper_length_mm + species + bill_length_mm +
  bill_depth_mm, data = penguins_clean)
model4 <- lm(body_mass_g ~ flipper_length_mm + species + bill_length_mm +
  bill_depth_mm + sex, data = penguins_clean)

m1_tidy <- tidy(model1, conf.int = TRUE)
m1_glance <- glance(model1)

# Table 3 Completed: Simple Linear Regression
completed_table_3 <- tribble(
  ~Parameter, ~Estimate, ~SE, ~CI, ~tvalue, ~pvalue,
  "Intercept",
    sprintf("%.2f", m1_tidy$estimate[1]), sprintf("%.2f", m1_tidy$std.error[1]),
    sprintf("[%.1f, %.1f]", m1_tidy$conf.low[1], m1_tidy$conf.high[1]),
    sprintf("%.2f", m1_tidy$statistic[1]), format_p(m1_tidy$p.value[1]),
  "Flipper length (mm)",
    sprintf("%.2f", m1_tidy$estimate[2]), sprintf("%.2f", m1_tidy$std.error[2]),
    sprintf("[%.1f, %.1f]", m1_tidy$conf.low[2], m1_tidy$conf.high[2]),
    sprintf("%.2f", m1_tidy$statistic[2]), format_p(m1_tidy$p.value[2])
) |>
  gt() |>
  cols_label(
    Parameter = "Parameter", Estimate = "Estimate", SE = "Std. Error",
    CI = "95% CI", tvalue = "t-value", pvalue = "p-value"
  ) |>
  tab_header(title = "Completed Table 3. Simple Linear Regression: Body Mass ~ Flipper Length") |>
  tab_footnote("Dependent variable: Body mass (g)") |>
  tab_source_note(sprintf("R-squared: %.3f | Adjusted R-squared: %.3f | RMSE: %.1f g",
    m1_glance$r.squared, m1_glance$adj.r.squared, rmse(model1)))

# Table 4 Completed: Model Comparison
g1 <- glance(model1); g2 <- glance(model2); g3 <- glance(model3); g4 <- glance(model4)

completed_table_4 <- tribble(
  ~Statistic, ~Model1, ~Model2, ~Model3, ~Model4,
  "R-squared",
    sprintf("%.3f", g1$r.squared), sprintf("%.3f", g2$r.squared),
    sprintf("%.3f", g3$r.squared), sprintf("%.3f", g4$r.squared),
  "Adjusted R-squared",
    sprintf("%.3f", g1$adj.r.squared), sprintf("%.3f", g2$adj.r.squared),
    sprintf("%.3f", g3$adj.r.squared), sprintf("%.3f", g4$adj.r.squared),
  "RMSE (g)",
    sprintf("%.1f", rmse(model1)), sprintf("%.1f", rmse(model2)),
    sprintf("%.1f", rmse(model3)), sprintf("%.1f", rmse(model4)),
  "AIC",
    sprintf("%.1f", AIC(model1)), sprintf("%.1f", AIC(model2)),
    sprintf("%.1f", AIC(model3)), sprintf("%.1f", AIC(model4)),
  "BIC",
    sprintf("%.1f", BIC(model1)), sprintf("%.1f", BIC(model2)),
    sprintf("%.1f", BIC(model3)), sprintf("%.1f", BIC(model4)),
  "F-statistic",
    sprintf("%.2f", g1$statistic), sprintf("%.2f", g2$statistic),
    sprintf("%.2f", g3$statistic), sprintf("%.2f", g4$statistic),
  "df (model, residual)",
    sprintf("(%d, %d)", g1$df, g1$df.residual),
    sprintf("(%d, %d)", g2$df - 1, g2$df.residual),
    sprintf("(%d, %d)", g3$df - 1, g3$df.residual),
    sprintf("(%d, %d)", g4$df - 1, g4$df.residual),
  "p-value (F-test)",
    format_p(g1$p.value), format_p(g2$p.value),
    format_p(g3$p.value), format_p(g4$p.value)
) |>
  gt() |>
  cols_label(
    Statistic = "Statistic", Model1 = "Model 1\n(Flipper)", Model2 = "Model 2\n(+ Species)",
    Model3 = "Model 3\n(+ Bills)", Model4 = "Model 4\n(Full)"
  ) |>
  tab_header(title = "Completed Table 4. Model Comparison: Nested Regression Models") |>
  tab_spanner(label = "Linear Regression Models", columns = -Statistic) |>
  tab_footnote("Model 1: Flipper | Model 2: +Species | Model 3: +Bills | Model 4: +Sex")

# Table 5 Completed: Final Model Coefficients
m4_tidy <- tidy(model4, conf.int = TRUE)
m4_glance <- glance(model4)

completed_table_5 <- tribble(
  ~Parameter, ~Estimate, ~SE, ~CI, ~pvalue,
  "Intercept",
    sprintf("%.2f", m4_tidy$estimate[1]), sprintf("%.2f", m4_tidy$std.error[1]),
    sprintf("[%.1f, %.1f]", m4_tidy$conf.low[1], m4_tidy$conf.high[1]),
    format_p(m4_tidy$p.value[1]),
  "Flipper length (mm)",
    sprintf("%.2f", m4_tidy$estimate[2]), sprintf("%.2f", m4_tidy$std.error[2]),
    sprintf("[%.1f, %.1f]", m4_tidy$conf.low[2], m4_tidy$conf.high[2]),
    format_p(m4_tidy$p.value[2]),
  "Bill length (mm)",
    sprintf("%.2f", m4_tidy$estimate[m4_tidy$term == "bill_length_mm"]),
    sprintf("%.2f", m4_tidy$std.error[m4_tidy$term == "bill_length_mm"]),
    sprintf("[%.1f, %.1f]", m4_tidy$conf.low[m4_tidy$term == "bill_length_mm"],
      m4_tidy$conf.high[m4_tidy$term == "bill_length_mm"]),
    format_p(m4_tidy$p.value[m4_tidy$term == "bill_length_mm"]),
  "Bill depth (mm)",
    sprintf("%.2f", m4_tidy$estimate[m4_tidy$term == "bill_depth_mm"]),
    sprintf("%.2f", m4_tidy$std.error[m4_tidy$term == "bill_depth_mm"]),
    sprintf("[%.1f, %.1f]", m4_tidy$conf.low[m4_tidy$term == "bill_depth_mm"],
      m4_tidy$conf.high[m4_tidy$term == "bill_depth_mm"]),
    format_p(m4_tidy$p.value[m4_tidy$term == "bill_depth_mm"]),
  "Species (ref: Adelie)", "", "", "", "",
  "    Chinstrap",
    sprintf("%.2f", m4_tidy$estimate[m4_tidy$term == "speciesChinstrap"]),
    sprintf("%.2f", m4_tidy$std.error[m4_tidy$term == "speciesChinstrap"]),
    sprintf("[%.1f, %.1f]", m4_tidy$conf.low[m4_tidy$term == "speciesChinstrap"],
      m4_tidy$conf.high[m4_tidy$term == "speciesChinstrap"]),
    format_p(m4_tidy$p.value[m4_tidy$term == "speciesChinstrap"]),
  "    Gentoo",
    sprintf("%.2f", m4_tidy$estimate[m4_tidy$term == "speciesGentoo"]),
    sprintf("%.2f", m4_tidy$std.error[m4_tidy$term == "speciesGentoo"]),
    sprintf("[%.1f, %.1f]", m4_tidy$conf.low[m4_tidy$term == "speciesGentoo"],
      m4_tidy$conf.high[m4_tidy$term == "speciesGentoo"]),
    format_p(m4_tidy$p.value[m4_tidy$term == "speciesGentoo"]),
  "Sex (ref: female)", "", "", "", "",
  "    male",
    sprintf("%.2f", m4_tidy$estimate[m4_tidy$term == "sexmale"]),
    sprintf("%.2f", m4_tidy$std.error[m4_tidy$term == "sexmale"]),
    sprintf("[%.1f, %.1f]", m4_tidy$conf.low[m4_tidy$term == "sexmale"],
      m4_tidy$conf.high[m4_tidy$term == "sexmale"]),
    format_p(m4_tidy$p.value[m4_tidy$term == "sexmale"])
) |>
  gt() |>
  cols_label(
    Parameter = "Parameter", Estimate = "Estimate", SE = "Std. Error",
    CI = "95% CI", pvalue = "p-value"
  ) |>
  tab_header(
    title = "Completed Table 5. Final Model Coefficients",
    subtitle = "Body Mass ~ Morphometrics + Species + Sex"
  ) |>
  tab_footnote("Reference: Species = Adelie; Sex = female") |>
  tab_source_note(sprintf("R-squared: %.3f | Adjusted R-squared: %.3f | RMSE: %.1f g",
    m4_glance$r.squared, m4_glance$adj.r.squared, rmse(model4)))

# =============================================================================
# COMBINE AND SAVE TO SINGLE HTML FILE
# =============================================================================

html_output <- sprintf('<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Palmer Penguins Analysis Tables</title>
  <style>
    body { font-family: Arial, sans-serif; max-width: 1200px; margin: 0 auto; padding: 20px; }
    h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
    h2 { color: #34495e; margin-top: 40px; }
    .table-container { margin: 20px 0; }
    hr { border: none; border-top: 3px double #bdc3c7; margin: 40px 0; }
  </style>
</head>
<body>
  <h1>Palmer Penguins Body Mass Analysis</h1>
  <p>Statistical Analysis Plan Tables - PHB 243b Project 1</p>

  <hr>
  <h2>SHELL TABLES (Pre-Analysis)</h2>
  <p>These table shells show the planned structure before data analysis.</p>

  <div class="table-container">%s</div>
  <div class="table-container">%s</div>
  <div class="table-container">%s</div>
  <div class="table-container">%s</div>
  <div class="table-container">%s</div>

  <hr>
  <h2>COMPLETED TABLES (Post-Analysis)</h2>
  <p>These tables contain the actual analysis results.</p>

  <div class="table-container">%s</div>
  <div class="table-container">%s</div>
  <div class="table-container">%s</div>
  <div class="table-container">%s</div>
  <div class="table-container">%s</div>

</body>
</html>',
  as_raw_html(shell_table_1),
  as_raw_html(shell_table_2),
  as_raw_html(shell_table_3),
  as_raw_html(shell_table_4),
  as_raw_html(shell_table_5),
  as_raw_html(completed_table_1),
  as_raw_html(completed_table_2),
  as_raw_html(completed_table_3),
  as_raw_html(completed_table_4),
  as_raw_html(completed_table_5)
)

writeLines(html_output, "penguins_all_tables.html")

cat("=" |> rep(70) |> paste(collapse = ""), "\n")
cat("All 10 tables saved to: penguins_all_tables.html\n")
cat("=" |> rep(70) |> paste(collapse = ""), "\n")
