install.packages("readr")
install.packages("gganimate")
install.packages("ggplot2")

library(readr)
library(gganimate)
library(ggplot2)
library(dplyr)
library(ggthemes)

#challenge
reviews = read_csv("C:\\Users\\21264\\Desktop\\Lab 2 on ggplot2\\googleplaystore.csv") %>%
  filter(Category %in% c("GAME", "SOCIAL", "PRODUCTIVITY", "TOOLS", "EDUCATION"))

graph3 = reviews %>%
  ggplot(aes(x=Category, y=Rating, fill=Category)) +
  geom_boxplot() +
  theme_fivethirtyeight() +
  labs(title = "Google Play Store Ratings",
       y = "Rating (out of 5)",
       caption = "Source: Nadir") +
  theme(legend.position = "none",
        axis.title.y = element_text(),
        text = element_text(family="Poppins SemiBold"),
        panel.grid.major.x = element_blank(),
        axis.title.x = element_blank()) +
  scale_fill_tableau()

graph3.animation = graph3 +
  transition_states(Category, wrap = FALSE) +
  shadow_mark(alpha = 0.5) +
  enter_grow() +
  exit_fade() +
  ease_aes('back-out')
animate(graph3.animation, height = 500, width = 800, fps = 30, duration = 10,
        end_pause = 60, res = 100, renderer = gifski_renderer())
anim_save("playstore reviews.gif")

