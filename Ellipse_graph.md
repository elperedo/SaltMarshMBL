# Load the ggplot2 library
library(ggplot2)
library(scales)  # Load the scales library for formatting axis labels

# Create a data frame with the given data
data <- data.frame(
  x = c(91688, 53120, 195351, 88205, 85564, 560620, 194273, 235235, 77199, 628802, 948105, 415145, 212625, 276908, 4184, 15191, 4036, 3841, 2166, 819, 1813, 1794, 2283, 9438),
  y = c(51750, 26861, 98783, 36779, 41895, 214413, 88487, 119040, 27027, 214006, 259075, 169313, 104455, 144933, 1353, 5242, 958, 1176, 1129, 208, 210, 489, 901, 5431),
  group = c("ALJR", "ALJR", "ALJR", "ALJR", "ALJR", "ALJR", "ALJR", "ALJR", "ALSA", "ALSA", "ALSA", "ALSA", "ALSA", "ALSA", "MASA", "MASA", "MASA", "MASA", "MASA", "MASP", "MASP", "MASP", "MASP", "MASP"),
  color = c("#95A16E", "#95A16E", "#95A16E", "#95A16E", "#95A16E", "#95A16E", "#95A16E", "#95A16E", "#555C41", "#555C41", "#555C41", "#555C41", "#555C41", "#555C41", "#B16645", "#B16645", "#B16645", "#B16645", "#B16645", "#D1A460", "#D1A460", "#D1A460", "#D1A460", "#D1A460")
)

# Create the scatter plot with ellipses and regression lines forced to intercept at 0
p <- ggplot(data, aes(x, y, color = group, fill = group)) +
  geom_point(size = 3, shape = 16) +  # Using shape 16 for all data points
  stat_ellipse(aes(color = group), type = "t", alpha = 0.3) +  # Coloring ellipses with group color
  geom_smooth(method = "lm", se = FALSE, aes(group = group, color = group), formula = y ~ x + 0, size = 1) +  # Adding colored linear regression line with intercept forced to 0
  scale_color_manual(values = unique(data$color)) +  # Use unique colors for each group
  scale_fill_manual(values = unique(data$color)) +  # Use unique colors for each group
  labs(title = "ALSA124",  # Updated graph title
       x = "Mapped reads",
       y = "SNVs",
       color = "Group",
       fill = "Group") +
  theme_minimal()

# Format the axis labels using commas as thousand separators
p <- p + scale_x_continuous(labels = comma)
p <- p + scale_y_continuous(labels = comma)

# Save the plot as a PDF file
ggsave("scatter_plot_with_ellipses_ALSA124.pdf", plot = p, width = 8, height = 6)



# Load the ggplot2 library
library(ggplot2)
library(scales)  # Load the scales library for formatting axis labels

# Create a data frame with the given data
data <- data.frame(
  x = c(2340, 1549, 1959, 906, 2516, 2644, 2031, 2099, 937, 2854, 4537, 2054, 1368, 1665, 42444, 16869, 24673, 94327, 51265, 4752, 2788, 2481, 3028, 8328),
  y = c(535, 374, 523, 230, 691, 762, 583, 588, 251, 803, 1133, 611, 376, 549, 303, 248, 229, 597, 253, 59, 29, 33, 68, 482),
  group = c("ALJR", "ALJR", "ALJR", "ALJR", "ALJR", "ALJR", "ALJR", "ALJR", "ALSA", "ALSA", "ALSA", "ALSA", "ALSA", "ALSA", "MASA", "MASA", "MASA", "MASA", "MASA", "MASP", "MASP", "MASP", "MASP", "MASP"),
  color = c("#95A16E", "#95A16E", "#95A16E", "#95A16E", "#95A16E", "#95A16E", "#95A16E", "#95A16E", "#555C41", "#555C41", "#555C41", "#555C41", "#555C41", "#555C41", "#B16645", "#B16645", "#B16645", "#B16645", "#B16645", "#D1A460", "#D1A460", "#D1A460", "#D1A460", "#D1A460")
)

# Create the scatter plot with ellipses and regression lines forced to intercept at 0
p <- ggplot(data, aes(x, y, color = group, fill = group)) +
  geom_point(size = 3, shape = 16) +  # Using shape 16 for all data points
  stat_ellipse(aes(color = group), type = "t", alpha = 0.3) +  # Coloring ellipses with group color
  geom_smooth(method = "lm", se = FALSE, aes(group = group, color = group), formula = y ~ x + 0, size = 1) +  # Adding colored linear regression line with intercept forced to 0
  scale_color_manual(values = unique(data$color)) +  # Use unique colors for each group
  scale_fill_manual(values = unique(data$color)) +  # Use unique colors for each group
  labs(title = "ALSA124",  # Updated graph title
       x = "Mapped reads",
       y = "SNVs",
       color = "Group",
       fill = "Group") +
  theme_minimal()

# Format the axis labels using commas as thousand separators
p <- p + scale_x_continuous(labels = comma)
p <- p + scale_y_continuous(labels = comma)

# Save the plot as a PDF file
ggsave("scatter_plot_with_ellipses_MASA4.pdf", plot = p, width = 8, height = 6)

