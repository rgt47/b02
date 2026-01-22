# shell_tables_penguins.R
# Generate SAP shell tables for Palmer Penguins analysis
# These tables show investigators the planned table structures without data

library(gt)
library(tibble)

# Table 1: Baseline Characteristics by Species
table1_shell <- tribble(
  ~Characteristic, ~"Adelie\n(N=XXX)", ~"Chinstrap\n(N=XXX)", ~"Gentoo\n(N=XXX)",
    ~"Total\n(N=XXX)", ~"p-value",
  "Island, n (%)", "", "", "", "", "",
  "    Biscoe", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "",

  "    Dream", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "",
  "    Torgersen", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "X.XXX",
  "Sex, n (%)", "", "", "", "", "",
  "    Female", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "",
  "    Male", "XX (XX.X)", "XX (XX.X)", "XX (XX.X)", "XXX (XX.X)", "X.XXX",
  "Bill length (mm)", "", "", "", "", "",
  "    Mean (SD)", "XX.X (X.XX)", "XX.X (X.XX)", "XX.X (X.XX)", "XX.X (X.XX)", "",
  "    Median [IQR]", "XX.X [XX.X, XX.X]", "XX.X [XX.X, XX.X]", "XX.X [XX.X, XX.X]",
    "XX.X [XX.X, XX.X]", "X.XXX",
  "Bill depth (mm)", "", "", "", "", "",
  "    Mean (SD)", "XX.X (X.XX)", "XX.X (X.XX)", "XX.X (X.XX)", "XX.X (X.XX)", "",
  "    Median [IQR]", "XX.X [XX.X, XX.X]", "XX.X [XX.X, XX.X]", "XX.X [XX.X, XX.X]",
    "XX.X [XX.X, XX.X]", "X.XXX",
  "Flipper length (mm)", "", "", "", "", "",
  "    Mean (SD)", "XXX.X (X.XX)", "XXX.X (X.XX)", "XXX.X (X.XX)", "XXX.X (X.XX)", "",
  "    Median [IQR]", "XXX [XXX, XXX]", "XXX [XXX, XXX]", "XXX [XXX, XXX]",
    "XXX [XXX, XXX]", "X.XXX",
  "Body mass (g)", "", "", "", "", "",
  "    Mean (SD)", "XXXX (XXX)", "XXXX (XXX)", "XXXX (XXX)", "XXXX (XXX)", "",
  "    Median [IQR]", "XXXX [XXXX, XXXX]", "XXXX [XXXX, XXXX]", "XXXX [XXXX, XXXX]",
    "XXXX [XXXX, XXXX]", "X.XXX"
)

shell_table_1 <- table1_shell |>
  gt() |>
  tab_header(
    title = "Table 1. Baseline Characteristics by Penguin Species",
    subtitle = "Palmer Station, Antarctica (2007-2009)"
  ) |>
  tab_footnote("Categorical variables presented as n (%); continuous variables as mean (SD) and median [IQR].") |>
  tab_footnote("P-values from chi-square test (categorical) or Kruskal-Wallis test (continuous).") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# Table 2: Correlation Matrix for Morphometric Variables
table2_shell <- tribble(
  ~Variable, ~"Bill Length", ~"Bill Depth", ~"Flipper Length", ~"Body Mass",
  "Bill length (mm)", "1.000", "", "", "",
  "Bill depth (mm)", "X.XXX", "1.000", "", "",
  "Flipper length (mm)", "X.XXX", "X.XXX", "1.000", "",
  "Body mass (g)", "X.XXX", "X.XXX", "X.XXX", "1.000"
)

shell_table_2 <- table2_shell |>
  gt() |>
  tab_header(
    title = "Table 2. Pearson Correlation Matrix for Morphometric Variables"
  ) |>
  tab_footnote("Values represent Pearson correlation coefficients (r).") |>
  tab_footnote("All correlations tested at alpha = 0.05 significance level.") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# Table 3: Simple Linear Regression Results
table3_shell <- tribble(
  ~Parameter, ~Estimate, ~"Std. Error", ~"95% CI", ~"t-value", ~"p-value",
  "Intercept", "XXXX.XX", "XXX.XX", "[XXXX.X, XXXX.X]", "XX.XX", "<0.001",
  "Flipper length (mm)", "XX.XX", "X.XX", "[XX.X, XX.X]", "XX.XX", "<0.001"
)

shell_table_3 <- table3_shell |>
  gt() |>
  tab_header(
    title = "Table 3. Simple Linear Regression: Body Mass Predicted by Flipper Length"
  ) |>
  tab_row_group(label = "Model Coefficients", rows = everything()) |>
  tab_footnote("Dependent variable: Body mass (g)") |>
  tab_footnote("Model: Body Mass = Intercept + Beta * Flipper Length") |>
  tab_source_note("R-squared: X.XXX | Adjusted R-squared: X.XXX | RMSE: XXX.X g") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# Table 4: Model Comparison (Simple vs Multiple Regression)
table4_shell <- tribble(
  ~Statistic, ~"Model 1\n(Flipper Only)", ~"Model 2\n(+ Species)",
    ~"Model 3\n(+ Bill Measures)", ~"Model 4\n(Full Model)",
  "R-squared", "X.XXX", "X.XXX", "X.XXX", "X.XXX",
  "Adjusted R-squared", "X.XXX", "X.XXX", "X.XXX", "X.XXX",
  "RMSE (g)", "XXX.X", "XXX.X", "XXX.X", "XXX.X",
  "AIC", "XXXX.X", "XXXX.X", "XXXX.X", "XXXX.X",
  "BIC", "XXXX.X", "XXXX.X", "XXXX.X", "XXXX.X",
  "F-statistic", "XXX.XX", "XXX.XX", "XXX.XX", "XXX.XX",
  "df (model, residual)", "(X, XXX)", "(X, XXX)", "(X, XXX)", "(X, XXX)",
  "p-value (F-test)", "<0.001", "<0.001", "<0.001", "<0.001"
)

shell_table_4 <- table4_shell |>
  gt() |>
  tab_header(
    title = "Table 4. Model Comparison: Nested Regression Models for Body Mass Prediction"
  ) |>
  tab_spanner(label = "Linear Regression Models", columns = -Statistic) |>
  tab_footnote("Model 1: Body Mass ~ Flipper Length") |>
  tab_footnote("Model 2: Body Mass ~ Flipper Length + Species") |>
  tab_footnote("Model 3: Body Mass ~ Flipper Length + Species + Bill Length + Bill Depth") |>
  tab_footnote("Model 4: Body Mass ~ All morphometric predictors + Species + Sex") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# Table 5: Final Model Coefficients with Species Effects
table5_shell <- tribble(
  ~Parameter, ~Estimate, ~"Std. Error", ~"95% CI", ~"p-value",
  "Intercept", "XXXX.XX", "XXX.XX", "[XXXX.X, XXXX.X]", "<0.001",
  "Flipper length (mm)", "XX.XX", "X.XX", "[XX.X, XX.X]", "<0.001",
  "Bill length (mm)", "XX.XX", "X.XX", "[XX.X, XX.X]", "X.XXX",
  "Bill depth (mm)", "XX.XX", "X.XX", "[XX.X, XX.X]", "X.XXX",
  "Species (ref: Adelie)", "", "", "", "",
  "    Chinstrap", "XXX.XX", "XX.XX", "[XXX.X, XXX.X]", "X.XXX",
  "    Gentoo", "XXX.XX", "XX.XX", "[XXX.X, XXX.X]", "<0.001",
  "Sex (ref: Female)", "", "", "", "",
  "    Male", "XXX.XX", "XX.XX", "[XXX.X, XXX.X]", "<0.001"
)

shell_table_5 <- table5_shell |>
  gt() |>
  tab_header(
    title = "Table 5. Multiple Linear Regression: Final Model Coefficients",
    subtitle = "Body Mass Predicted by Morphometric Variables, Species, and Sex"
  ) |>
  tab_footnote("Dependent variable: Body mass (g)") |>
  tab_footnote("Reference categories: Species = Adelie; Sex = Female") |>
  tab_source_note("R-squared: X.XXX | Adjusted R-squared: X.XXX | RMSE: XXX.X g") |>
  tab_source_note("Source: Palmer Penguins Dataset (Gorman et al., 2014)")


# Save tables as HTML
gtsave(shell_table_1, "shell_table_1_baseline.html")
gtsave(shell_table_2, "shell_table_2_correlation.html")
gtsave(shell_table_3, "shell_table_3_simple_regression.html")
gtsave(shell_table_4, "shell_table_4_model_comparison.html")
gtsave(shell_table_5, "shell_table_5_final_model.html")

# Print tables to console
cat("=" |> rep(70) |> paste(collapse = ""), "\n")
cat("SAP SHELL TABLES - Palmer Penguins Body Mass Analysis\n")
cat("=" |> rep(70) |> paste(collapse = ""), "\n\n")

shell_table_1
shell_table_2
shell_table_3
shell_table_4
shell_table_5

cat("\nAll shell tables saved as HTML files.\n")
