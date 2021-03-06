library(ggvis)

# Basic scatter plot
ggvis(mtcars, props(x = ~wt, y = ~mpg)) + layer_point()

# Variable transformations
ggvis(mtcars, props(x = ~wt, y = ~wt/mpg)) + layer_point()
ggvis(mtcars, props(x = ~factor(cyl), y = ~mpg)) + layer_point()


# With colour
# continuous:
ggvis(mtcars, props(x = ~wt, y = ~mpg, fill = ~cyl)) + layer_point()
# and discrete:
ggvis(mtcars, props(x = ~wt, y = ~mpg, fill = ~factor(cyl))) + layer_point()

# Use unscaled constant: 10 refers to 10 pixels from top
ggvis(mtcars, props(x = ~wt)) +
  layer_point(props(y = ~mpg)) +
  layer_point(props(y := 10, fill := "red"))

# Use scaled constant: 10 refers to data space
ggvis(mtcars, props(x = ~wt)) +
  layer_point(props(y = ~mpg)) +
  layer_point(props(y = 10, fill := "red"))

# Line and point graph
ggvis(mtcars, props(x = ~wt, y = ~mpg)) +
  mark_path() +
  layer_point(props(fill := "red"))

# Two marks
ggvis(mtcars, props(x = ~wt, y = ~mpg)) +
  layer_point() +
  layer_point(props(fill := "red", size := 25))

# Multiple nested layers
ggvis(mtcars, props(x = ~wt, y = ~mpg)) +
  layer(layer_point()) +
  layer(layer(layer_point(props(fill := "red", size := 25))))

# Two marks at different levels of the tree, with different mappings for a
# variable
ggvis(mtcars, props(x = ~wt, y = ~mpg)) +
  layer_point() +
  layer_point(props(fill := "red", y = ~qsec, size := 25))

# Two y scales
ggvis(mtcars, props(x = ~wt, y = ~mpg)) +
  layer_point() +
  layer_point(props(fill := "red", y = prop(~ qsec, scale = "yq"))) +
  dscale("y", "numeric", name = "yq")

# Two separate data sets, equal in the tree
mtc1 <- mtcars[1:10, ]
mtc2 <- mtcars[11:20, ]
ggvis(props(x = ~wt, y = ~mpg)) +
  layer_point(props(stroke := "black", fill := "black"), mtc1) +
  layer_point(props(fill := "red", size := 40), mtc2)

# Scatter plot with one set of points with `cyl` mapped to stroke,
# and another set with `am` mapped to fill
ggvis(mtcars, props(x = ~wt, y = ~mpg)) +
  layer_point(props(stroke = ~factor(cyl), fill := NA)) +
  layer_point(props(fill = ~factor(am), size := 25))

# Same as previous, but also with (useless) grouping in the layers
by_cyl <- pipeline(mtcars, by_group(cyl))
ggvis(by_cyl, props(x = ~wt, y = ~mpg)) +
  layer_point(props(stroke = ~factor(cyl), fill := NA)) +
  layer_point(props(fill = ~factor(am), size := 25))

# Use expression in a prop
ggvis(pressure, props(x = ~temperature, y = ~log(pressure))) + layer_point()

# Use variable from the calling environment
y_min <- min(log(pressure$pressure))
ggvis(pressure, props(x = ~temperature, y = ~log(pressure) - y_min)) +
  layer_point()
