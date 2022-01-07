# Custom theme for data visualizations
plot_theme <- function(...) {
  theme_bw() + theme(
    # Set the outer margins of the plot to 1/5 of an inch on all sides
    #plot.margin = margin(0.2, 0.2, 0.2, 0.2, "in"),
    # Specify the default settings for the plot title
    plot.title = element_text(
      size = 22,
      face = "bold",
      family = "serif"
    ),
    # Specify the default settings for caption text
    plot.caption = element_text(
      size = 12,
      family = "serif"
    ),
    # Specify the default settings for subtitle text
    plot.subtitle = element_text(
      size = 16,
      family = "serif"
    ),
    # Specify the default settings for axis titles
    axis.title = element_text(
      size = 18,
      face = "bold",
      family = "serif"
    ),
    # Specify the default settings specific to the x axis title
    axis.title.y = element_text(margin = margin(r = 10, l = -10)),
    # Specify the default settings specific to the y axis title
    axis.title.x = element_text(margin = margin(t = 10, b = -10)),
    # Specify the default settings for x axis text
    axis.text.x = element_text(
      size = 12,
      family = "serif"
    ),
    # Specify the default settings for y axis text
    axis.text.y = element_text(
      size = 12,
      family = "serif"
    ),
    # Specify the default settings for legend titles
    legend.title = element_text(
      size = 16,
      face = "bold",
      family = "serif"
    ),
    # Specify the default settings for legend text
    legend.text = element_text(
      size = 14,
      family = "serif"
    ),
    # Additional Settings Passed to theme()
    ...
  )
}