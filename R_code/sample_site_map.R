## Create map of Muskegon Lake with points indicating Outlet and Deep sample collection sites

library(ggmap)

# Extract coordinates for Muskegon Lake 
lakesite_coordinates <- read.csv("/local/workdir/myb7/Diversity_Productivity/data/metadata/ML_GPS_Coordinates.csv") %>%
  dplyr::select(lakesite, Latitude, Longitude) %>%
  dplyr::rename(Lat = Latitude, Long = Longitude)

lakesite_coordinates_2 <- lakesite_coordinates[3:4,]

# Set map boundaries 
map <- get_map(c(-86.35, 43.21, -86.235, 43.265),  #left/bottom/right/top
               zoom = 13, maptype = "toner-background")

# Plot map of Muskegon Lake
sample_map <- ggmap(map) + xlab("Longitude") + ylab("Latitude") +
  theme(axis.text = element_text(size = 10, color = "black"),
        axis.title = element_text(size = 12, color = "black", face = "bold")) +
  geom_point(data = lakesite_coordinates_2, 
             aes(x=Long, y=Lat), color="black", fill = "yellow", size=4, shape = 21) +
  geom_text(data = lakesite_coordinates_2,
            aes(x=Long, y=Lat, label=lakesite), col="black", cex=4, vjust = 0.5,hjust = -0.25)

# Save map as PNG
ggsave(filename = "/workdir/myb7/figures/sample_site_map.png", plot = sample_map, width = 10, height = 8, dpi = 300, units = "cm")
