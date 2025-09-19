# Title: R Cheatsheet in Action
# Description: A script demonstrating the dplyr and ggplot2 functions
#              from the provided R Tidyverse Cheatsheet.

# -- 1. SETUP --
# Load the tidyverse library, which includes dplyr, ggplot2, and more.
# The 'pacman' package manager is a good way to ensure it's installed.
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse)

# -- 2. CREATE SAMPLE DATA --
# Instead of loading from a URL, we'll create our own dataset (a tibble)
# about fictional Scottish islands. This makes the script self-contained.
islands_data <- tribble(
  ~island_name,    ~council_area,      ~population, ~area_sq_km,
  "Isle of Skye",    "Highland",           10000,       1656,
  "Isle of Mull",    "Argyll and Bute",     2800,        875,
  "Islay",           "Argyll and Bute",     3200,        620,
  "Jura",            "Argyll and Bute",      195,        367,
  "Isle of Arran",   "North Ayrshire",      4600,        432,
  "Bute",            "Argyll and Bute",     6500,        122,
  "Lewis and Harris", "Na h-Eileanan Siar", 21000,       2179,
  "Mainland, Orkney", "Orkney Islands",      17160,       523,
  "Mainland, Shetland", "Shetland Islands",  18760,       967
)

# -- 3. DATA MANIPULATION WITH DPLYR --
# This section uses the dplyr "verbs" from the cheatsheet.

# We'll use the pipe `%>%` to chain our operations together.

# Task: Find the population density for islands with more than 3,000 people,
#       and arrange them from most to least dense.

islands_summary <- islands_data %>%
  # Use filter() to keep rows with population > 3000
  filter(population > 3000) %>%

  # Use mutate() to create a new 'density' column
  mutate(density = population / area_sq_km) %>%

  # Use arrange() to sort the results by density in descending order
  arrange(desc(density)) %>%

  # Use select() to pick and rename columns for a clean final table
  select(
    Island = island_name,
    Council = council_area,
    Population = population,
    `Population Density (per Sq Km)` = density
  )

# Print the resulting summary table to the console
print("--- Summary of Densely Populated Islands ---")
print(islands_summary)


# Another Task: Calculate the total island population for each council area.
council_summary <- islands_data %>%
  # Use group_by() to group all rows by their council area
  group_by(Council = council_area) %>%

  # Use summarise() to collapse the groups and calculate the total population
  summarise(Total_Island_Population = sum(population))

print("--- Total Island Population by Council ---")
print(council_summary)


# -- 4. DATA VISUALIZATION WITH GGPLOT2 --
# This section uses ggplot2 to create plots from our manipulated data.

# Plot 1: Bar chart of total island population by council
# This uses the 'council_summary' table we just created.
population_by_council_plot <- council_summary %>%
  ggplot(aes(x = reorder(Council, Total_Island_Population), y = Total_Island_Population)) + # nolint: line_length_linter.
  geom_col(fill = "steelblue") +
  coord_flip() + # Flip coordinates to make council names easy to read
  labs(
    title = "Total Island Population by Council Area",
    subtitle = "Based on the sample dataset",
    x = "Council Area",
    y = "Total Population"
  ) +
  theme_minimal()

# Show the plot
print(population_by_council_plot)


# Plot 2: Scatter plot of Area vs. Population
# This uses the original 'islands_data' table.
area_vs_population_plot <- islands_data %>%
  ggplot(aes(x = area_sq_km, y = population)) +
  geom_point(aes(color = council_area, size = population), alpha = 0.8) +
  geom_text(aes(label = island_name), vjust = -1, size = 3) + # Add island names as labels # nolint: line_length_linter.
  labs(
    title = "Island Population vs. Land Area",
    x = "Area (Square Kilometers)",
    y = "Population",
    color = "Council Area" # This sets the title for the legend
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

# Show the plot
print(area_vs_population_plot)

# Use ggsave() to save the plots to files, as shown in the cheatsheet
ggsave("population_by_council.png", population_by_council_plot)
ggsave("area_vs_population.png", area_vs_population_plot)
