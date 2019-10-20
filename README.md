
# earthquakes

<!-- badges: start -->
<!-- badges: end -->

The goal of earthquakes is to visualize the NOAA significant earthquake dataset

## Example

This is a basic example how to load and clean the data an plot an annotated timeline
for a subset of the data.

``` r
library(earthquakes)
data <- eq_clean_data(load_data())
data <- data[data$COUNTRY %in% c("GREECE", "TURKEY") & data$YEAR > 2005, ]
ggplot2::ggplot(data) +
  geom_timeline(ggplot2::aes(x = DATE, y = COUNTRY)) +
  geom_timeline_label(ggplot2::aes(x = DATE, y = COUNTRY, label = LOCATION_NAME))
```

