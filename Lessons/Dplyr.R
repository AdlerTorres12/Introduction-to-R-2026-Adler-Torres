library("dplyr")
head(starwars)
View(starwars)
starwars |> 
  filter(species == "Droid")
only_droids <- starwars |> 
  filter(species == "Droid")
only_droids

filter <- starwars |> 
  filter(skin_color== "light",
         eye_color== "brown")
View(filter)

View(starwars |> 
  arrange(skin_color))

View(starwars)

starwars |> 
  select(hair_color,
         skin_color,
         eye_color)
except <- starwars |> 
  select(!(height))
another <- starwars |> 
  select(-height)

starwars |> 
  select(contains('w'))


new_s <- starwars |> 
  mutate(mass_new = mass * 1000)
new_s
`print(n = ...)`
new_s |> 
  select(mass_new, mass, everything())

new_s2 <- starwars |> 
  mutate(mass_new2 = mass/10,
         .keep = "none")
new_s2


library('dplyr')
starwars |> 
  mutate(new_height = ifelse(height > 100,
                            "tall",
                            "small")) |> 
  select(height, new_height, everything()) |> 
  arrange(height)

library(ggplot2)
starwars |> 
  mutate(new_height = ifelse(height > 100,
                             "tall",
                             "small")) |> 
  select(height, new_height, everything()) |> 
  ggplot(aes(x=height, fill= new_height)) + 
  geom_histogram()
  

# Basic Statistics --------------------------------------------------------

starwars |> 
  summarise(mean_height=
              mean(height, na.rm=T))

starwars |> 
  group_by(species) |> 
  summarise(
    mean_height= mean(height, na.rm = TRUE),
    sd_height = sd(height, na.rm = TRUE),
  )
  

who |> 
  group_by(new_height) |> 
  count(homeworld)
  )

starwars |> sample_n(10)

install.packages("tidyverse")
