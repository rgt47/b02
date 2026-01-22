# completed_tables_penguins.R
# Generate completed tables for Palmer Penguins analysis
# These tables show the actual results matching the SAP shell tables

library(gt)
library(tibble)
library(dplyr)
library(palmerpenguins)
library(broom)

penguins_clean <- penguins |>
  filter(!is.na(body_mass_g), !is.na(flipper_length_mm), !is.na(sex))

# -----------------------------------------------------------------------------
# Table 1: Baseline Characteristics by Species
# -----------------------------------------------------------------------------

calc_pct <- function(n, total) sprintf("%d (%.1f)", n, 100 * n / total)

species_n <- penguins_clean |> count(species) |> pull(n, name = species)
total_n <- nrow(penguins_clean)

island_by_species <- penguins_clean |>
  count(species, island) |>
  tidyr::pivot_wider(names_from = species, values_from = n, values_fill = 0)

sex_by_species <- penguins_clean |>
  count(species, sex) |>
  tidyr::pivot_wider(names_from = species, values_from = n, values_fill = 0)

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

format_p <- function(p) if (p < 0.001) "<0.001" else sprintf("%.3f", p)

island_total <- penguins_clean |> count(island)

table1_data <- tribble(
  ~Characteristic,
    ~Adelie, ~Chinstrap, ~Gentoo, ~Total, ~pvalue,
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
    continuous_stats$bill_length_mean[1],
    continuous_stats$bill_length_mean[2],
    continuous_stats$bill_length_mean[3],
    total_stats$bill_length_mean, "",
  "    Median [IQR]",
    continuous_stats$bill_length_med[1],
    continuous_stats$bill_length_med[2],
    continuous_stats$bill_length_med[3],
    total_stats$bill_length_med, format_p(p_bill_length),
  "Bill depth (mm)", "", "", "", "", "",
  "    Mean (SD)",
    continuous_stats$bill_depth_mean[1],
    continuous_stats$bill_depth_mean[2],
    continuous_stats$bill_depth_mean[3],
    total_stats$bill_depth_mean, "",
  "    Median [IQR]",
    continuous_stats$bill_depth_med[1],
    continuous_stats$bill_depth_med[2],
    continuous_stats$bill_depth_med[3],
    total_stats$bill_depth_med, format_p(p_bill_depth),
  "Flipper length (mm)", "", "", "", "", "",
  "    Mean (SD)",
    continuous_stats$flipper_mean[1],
    continuous_stats$flipper_mean[2],
    continuous_stats$flipper_mean[3],
    total_stats$flipper_mean, "",
  "    Median [IQR]",
    continuous_stats$flipper_med[1],
    continuous_stats$flipper_med[2],
    continuous_stats$flipper_med[3],
    total_stats$flipper_med, format_p(p_flipper),
  "Body mass (g)", "", "", "", "", "",
  "    Mean (SD)",
    continuous_stats$mass_mean[1],
    continuous_stats$mass_mean[2],
    continuous_stats$mass_mean[3],
    total_stats$mass_mean, "",
  "    Median [IQR]",
    continuous_stats$mass_med[1],
    continuous_stats$mass_med[2],
    continuous_stats$mass_med[3],
    total_stats$mass_med, format_p(p_mass)
)

completed_table_1 <- table1_data |>
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
    title = "Table 1. Baseline Characteristics by Penguin Species",
    subtitle = "Palmer Station, Antarctica (2007-2009)"
  ) |>

tab_footnote("Categorical variables presented as n (%); continuous variables as mean (SD) and median [IQR].") |>
  tab_footnote("P-values from chi-square test (categorical) or Kruskal-Wallis test (continuous).") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# -----------------------------------------------------------------------------
# Table 2: Correlation Matrix for Morphometric Variables
# -----------------------------------------------------------------------------

cor_matrix <- penguins_clean |>
  select(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) |>
  cor()

table2_data <- tribble(
  ~Variable, ~bill_length, ~bill_depth, ~flipper_length, ~body_mass,
  "Bill length (mm)",
    "1.000",
    sprintf("%.3f", cor_matrix[1, 2]),
    sprintf("%.3f", cor_matrix[1, 3]),
    sprintf("%.3f", cor_matrix[1, 4]),
  "Bill depth (mm)",
    "",
    "1.000",
    sprintf("%.3f", cor_matrix[2, 3]),
    sprintf("%.3f", cor_matrix[2, 4]),
  "Flipper length (mm)",
    "",
    "",
    "1.000",
    sprintf("%.3f", cor_matrix[3, 4]),
  "Body mass (g)",
    "",
    "",
    "",
    "1.000"
)

completed_table_2 <- table2_data |>
  gt() |>
  cols_label(
    Variable = "",
    bill_length = "Bill Length",
    bill_depth = "Bill Depth",
    flipper_length = "Flipper Length",
    body_mass = "Body Mass"
  ) |>
  tab_header(
    title = "Table 2. Pearson Correlation Matrix for Morphometric Variables"
  ) |>
  tab_footnote("Values represent Pearson correlation coefficients (r).") |>
  tab_footnote("All correlations significant at p < 0.001.") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# -----------------------------------------------------------------------------
# Table 3: Simple Linear Regression Results
# -----------------------------------------------------------------------------

model1 <- lm(body_mass_g ~ flipper_length_mm, data = penguins_clean)
model1_tidy <- tidy(model1, conf.int = TRUE)
model1_glance <- glance(model1)

table3_data <- tribble(
  ~Parameter, ~Estimate, ~SE, ~CI, ~tvalue, ~pvalue,
  "Intercept",
    sprintf("%.2f", model1_tidy$estimate[1]),
    sprintf("%.2f", model1_tidy$std.error[1]),
    sprintf("[%.1f, %.1f]", model1_tidy$conf.low[1], model1_tidy$conf.high[1]),
    sprintf("%.2f", model1_tidy$statistic[1]),
    format_p(model1_tidy$p.value[1]),
  "Flipper length (mm)",
    sprintf("%.2f", model1_tidy$estimate[2]),
    sprintf("%.2f", model1_tidy$std.error[2]),
    sprintf("[%.1f, %.1f]", model1_tidy$conf.low[2], model1_tidy$conf.high[2]),
    sprintf("%.2f", model1_tidy$statistic[2]),
    format_p(model1_tidy$p.value[2])
)

completed_table_3 <- table3_data |>
  gt() |>
  cols_label(
    Parameter = "Parameter",
    Estimate = "Estimate",
    SE = "Std. Error",
    CI = "95% CI",
    tvalue = "t-value",
    pvalue = "p-value"
  ) |>
  tab_header(
    title = "Table 3. Simple Linear Regression: Body Mass Predicted by Flipper Length"
  ) |>
  tab_row_group(label = "Model Coefficients", rows = everything()) |>
  tab_footnote("Dependent variable: Body mass (g)") |>
  tab_footnote("Model: Body Mass = Intercept + Beta * Flipper Length") |>
  tab_source_note(sprintf(
    "R-squared: %.3f | Adjusted R-squared: %.3f | RMSE: %.1f g",
    model1_glance$r.squared, model1_glance$adj.r.squared,
    sqrt(mean(model1$residuals^2))
  )) |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# -----------------------------------------------------------------------------
# Table 4: Model Comparison (Simple vs Multiple Regression)
# -----------------------------------------------------------------------------

model2 <- lm(body_mass_g ~ flipper_length_mm + species, data = penguins_clean)
model3 <- lm(body_mass_g ~ flipper_length_mm + species + bill_length_mm +
  bill_depth_mm, data = penguins_clean)
model4 <- lm(body_mass_g ~ flipper_length_mm + species + bill_length_mm +
  bill_depth_mm + sex, data = penguins_clean)

g1 <- glance(model1)
g2 <- glance(model2)
g3 <- glance(model3)
g4 <- glance(model4)

rmse <- function(m) sqrt(mean(m$residuals^2))

table4_data <- tribble(
  ~Statistic, ~Model1, ~Model2, ~Model3, ~Model4,
  "R-squared",
    sprintf("%.3f", g1$r.squared),
    sprintf("%.3f", g2$r.squared),
    sprintf("%.3f", g3$r.squared),
    sprintf("%.3f", g4$r.squared),
  "Adjusted R-squared",
    sprintf("%.3f", g1$adj.r.squared),
    sprintf("%.3f", g2$adj.r.squared),
    sprintf("%.3f", g3$adj.r.squared),
    sprintf("%.3f", g4$adj.r.squared),
  "RMSE (g)",
    sprintf("%.1f", rmse(model1)),
    sprintf("%.1f", rmse(model2)),
    sprintf("%.1f", rmse(model3)),
    sprintf("%.1f", rmse(model4)),
  "AIC",
    sprintf("%.1f", AIC(model1)),
    sprintf("%.1f", AIC(model2)),
    sprintf("%.1f", AIC(model3)),
    sprintf("%.1f", AIC(model4)),
  "BIC",
    sprintf("%.1f", BIC(model1)),
    sprintf("%.1f", BIC(model2)),
    sprintf("%.1f", BIC(model3)),
    sprintf("%.1f", BIC(model4)),
  "F-statistic",
    sprintf("%.2f", g1$statistic),
    sprintf("%.2f", g2$statistic),
    sprintf("%.2f", g3$statistic),
    sprintf("%.2f", g4$statistic),
  "df (model, residual)",
    sprintf("(%d, %d)", g1$df, g1$df.residual),
    sprintf("(%d, %d)", g2$df - 1, g2$df.residual),
    sprintf("(%d, %d)", g3$df - 1, g3$df.residual),
    sprintf("(%d, %d)", g4$df - 1, g4$df.residual),
  "p-value (F-test)",
    format_p(g1$p.value),
    format_p(g2$p.value),
    format_p(g3$p.value),
    format_p(g4$p.value)
)

completed_table_4 <- table4_data |>
  gt() |>
  cols_label(
    Statistic = "Statistic",
    Model1 = "Model 1\n(Flipper Only)",
    Model2 = "Model 2\n(+ Species)",
    Model3 = "Model 3\n(+ Bill Measures)",
    Model4 = "Model 4\n(Full Model)"
  ) |>
  tab_header(
    title = "Table 4. Model Comparison: Nested Regression Models for Body Mass Prediction"
  ) |>
  tab_spanner(label = "Linear Regression Models", columns = -Statistic) |>
  tab_footnote("Model 1: Body Mass ~ Flipper Length") |>
  tab_footnote("Model 2: Body Mass ~ Flipper Length + Species") |>
tab_footnote("Model 3: Body Mass ~ Flipper Length + Species + Bill Length + Bill Depth") |>
  tab_footnote("Model 4: Body Mass ~ All morphometric predictors + Species + Sex") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# -----------------------------------------------------------------------------
# Table 5: Final Model Coefficients with Species Effects
# -----------------------------------------------------------------------------

model4_tidy <- tidy(model4, conf.int = TRUE)
model4_glance <- glance(model4)

get_coef_row <- function(term_name, display_name) {
  row <- model4_tidy |> filter(term == term_name)
  if (nrow(row) == 0) {
    return(c(display_name, "", "", "", ""))
  }
  c(
    display_name,
    sprintf("%.2f", row$estimate),
    sprintf("%.2f", row$std.error),
    sprintf("[%.1f, %.1f]", row$conf.low, row$conf.high),
    format_p(row$p.value)
  )
}

table5_data <- tribble(
  ~Parameter, ~Estimate, ~SE, ~CI, ~pvalue,
  "Intercept",
    sprintf("%.2f", model4_tidy$estimate[1]),
    sprintf("%.2f", model4_tidy$std.error[1]),
    sprintf("[%.1f, %.1f]", model4_tidy$conf.low[1], model4_tidy$conf.high[1]),
    format_p(model4_tidy$p.value[1]),
  "Flipper length (mm)",
    sprintf("%.2f", model4_tidy$estimate[2]),
    sprintf("%.2f", model4_tidy$std.error[2]),
    sprintf("[%.1f, %.1f]", model4_tidy$conf.low[2], model4_tidy$conf.high[2]),
    format_p(model4_tidy$p.value[2]),
  "Bill length (mm)",
    sprintf("%.2f", model4_tidy$estimate[model4_tidy$term == "bill_length_mm"]),
    sprintf("%.2f", model4_tidy$std.error[model4_tidy$term == "bill_length_mm"]),
    sprintf("[%.1f, %.1f]",
      model4_tidy$conf.low[model4_tidy$term == "bill_length_mm"],
      model4_tidy$conf.high[model4_tidy$term == "bill_length_mm"]),
    format_p(model4_tidy$p.value[model4_tidy$term == "bill_length_mm"]),
  "Bill depth (mm)",
    sprintf("%.2f", model4_tidy$estimate[model4_tidy$term == "bill_depth_mm"]),
    sprintf("%.2f", model4_tidy$std.error[model4_tidy$term == "bill_depth_mm"]),
    sprintf("[%.1f, %.1f]",
      model4_tidy$conf.low[model4_tidy$term == "bill_depth_mm"],
      model4_tidy$conf.high[model4_tidy$term == "bill_depth_mm"]),
    format_p(model4_tidy$p.value[model4_tidy$term == "bill_depth_mm"]),
  "Species (ref: Adelie)", "", "", "", "",
  "    Chinstrap",
    sprintf("%.2f", model4_tidy$estimate[model4_tidy$term == "speciesChinstrap"]),
    sprintf("%.2f", model4_tidy$std.error[model4_tidy$term == "speciesChinstrap"]),
    sprintf("[%.1f, %.1f]",
      model4_tidy$conf.low[model4_tidy$term == "speciesChinstrap"],
      model4_tidy$conf.high[model4_tidy$term == "speciesChinstrap"]),
    format_p(model4_tidy$p.value[model4_tidy$term == "speciesChinstrap"]),
  "    Gentoo",
    sprintf("%.2f", model4_tidy$estimate[model4_tidy$term == "speciesGentoo"]),
    sprintf("%.2f", model4_tidy$std.error[model4_tidy$term == "speciesGentoo"]),
    sprintf("[%.1f, %.1f]",
      model4_tidy$conf.low[model4_tidy$term == "speciesGentoo"],
      model4_tidy$conf.high[model4_tidy$term == "speciesGentoo"]),
    format_p(model4_tidy$p.value[model4_tidy$term == "speciesGentoo"]),
  "Sex (ref: female)", "", "", "", "",
  "    male",
    sprintf("%.2f", model4_tidy$estimate[model4_tidy$term == "sexmale"]),
    sprintf("%.2f", model4_tidy$std.error[model4_tidy$term == "sexmale"]),
    sprintf("[%.1f, %.1f]",
      model4_tidy$conf.low[model4_tidy$term == "sexmale"],
      model4_tidy$conf.high[model4_tidy$term == "sexmale"]),
    format_p(model4_tidy$p.value[model4_tidy$term == "sexmale"])
)

completed_table_5 <- table5_data |>
  gt() |>
  cols_label(
    Parameter = "Parameter",
    Estimate = "Estimate",
    SE = "Std. Error",
    CI = "95% CI",
    pvalue = "p-value"
  ) |>
  tab_header(
    title = "Table 5. Multiple Linear Regression: Final Model Coefficients",
    subtitle = "Body Mass Predicted by Morphometric Variables, Species, and Sex"
  ) |>
  tab_footnote("Dependent variable: Body mass (g)") |>
  tab_footnote("Reference categories: Species = Adelie; Sex = female") |>
  tab_source_note(sprintf(
    "R-squared: %.3f | Adjusted R-squared: %.3f | RMSE: %.1f g",
    model4_glance$r.squared, model4_glance$adj.r.squared, rmse(model4)
  )) |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# -----------------------------------------------------------------------------
# Save tables as HTML
# -----------------------------------------------------------------------------

gtsave(completed_table_1, "completed_table_1_baseline.html")
gtsave(completed_table_2, "completed_table_2_correlation.html")
gtsave(completed_table_3, "completed_table_3_simple_regression.html")
gtsave(completed_table_4, "completed_table_4_model_comparison.html")
gtsave(completed_table_5, "completed_table_5_final_model.html")

# Print tables to console
cat("=" |> rep(70) |> paste(collapse = ""), "\n")
cat("COMPLETED TABLES - Palmer Penguins Body Mass Analysis\n")
cat("=" |> rep(70) |> paste(collapse = ""), "\n\n")

completed_table_1
completed_table_2
completed_table_3
completed_table_4
completed_table_5

cat("\nAll completed tables saved as HTML files.\n")
