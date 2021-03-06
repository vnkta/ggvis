# Modifying scales
library(ggvis)

set.seed(1014)
df <- data.frame(x = 1:5, y = 5:1, z = runif(5))

# Override default scale property
ggvis(df, props(x = ~x, y = ~x),
  layer_point(),
  dscale("x", "numeric", trans = "log"),
  dscale("y", "numeric", trans = "log")
)
save_spec("scales/log.json")

# Override default scale name
ggvis(df, props(x = ~x, y = ~x, fill = prop(~z, scale = "blah")),
  layer_point(),
  dscale("fill", "numeric", name = "blah")
)
save_spec("scales/custom.json")

# Dual scale
ggvis(df, props(x = ~x),
  layer_point(props(y = prop(~y, scale = "y-y"), fill := "red")),
  layer_point(props(y = prop(~z, scale = "y-z"))),
  dscale("y", "numeric", name = "y-y"),
  dscale("y", "numeric", name = "y-z")
)
save_spec("scales/dual.json")

# Numeric domains
ggvis(df, props(x = ~x, y = ~x, fill = ~z),
  layer_point(),
  dscale("x", "numeric", domain = c(0, 10)),
  dscale("fill", "numeric", domain = c(0, 2))
)
save_spec("scales/domain_numeric.json")
