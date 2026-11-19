#load tidyverse packages
library(dplyr) 
library(tidyr)
library(ggplot2)
# keep command-line arguments but define the three args
args     <- commandArgs(trailingOnly = TRUE)
species_a <- args[1] # The first argument is the name of the first species

# EXERCISE: Store the second arguments as species_b.
#
species_b <- args[2]

# EXERCISE: Convert the third argument to an integer and store it as image_size.
#
image_size <- as.integer(args[3])

# EXERCISE: Put species_a and species_b into one vector called selected_species.
# Maintain the vector of selected species
selected_species <- c(species_a, species_b)

#loading iris_data from datasets
iris_data <- datasets::iris

species_colours <- c(
  setosa = "tomato",
  versicolor = "steelblue",
  virginica = "gold"
)
# Keep only data from the selected species
#subsetting data with filter() without a pipe this is wrong
#filter(iris_data$Species %in% selected_species) you can also say 
#iris_subset <= iris-data %>% filter(species %in% selected_species)
iris_subset <- filter(iris_data, Species %in% selected_species)

# EXERCISE: Create an output filename using species_a and species_b.
#
# Example: "iris_setosa_vs_versicolor.png" 
#Dont change output_filename from before
#
output_file <- paste0(
   "iris_",
   species_a,
   "_vs_",
   species_b,
   ".png"
)

# Replace  plot() and legend() with ggplot()
#And create a species_plot

species_plot <- ggplot(iris_subset, 
                       aes(x = Petal.Width,
                          y = Petal.Length,
                          colour = Species)) + # mapping colour to species column
geom_point(shape = 19) +
labs(
     x = "Petal.Width",
     y = "Petal.Length", 
     title = paste(species_a, "and", species_b)
) +
scale_colour_manual(values = species_colours)
# Replace png() and dev.off() to close plot
if (is.na(image_size) || image_size <= 0) {
  stop("The third argument, image_size, must be a positive integer.")
}
ggsave(
  filename = output_file,
  plot = species_plot,
  width = image_size,
  height = image_size,
  units = "px",
  dpi = 150
)