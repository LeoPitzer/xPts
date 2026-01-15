library(tidyverse)

matches <- read_csv("bundesliga_matches_clean.csv")
matches <- as_tibble(matches)


matches_clean <- matches %>%
  select(-Day, -Date, -Time, -Attendance, -Venue, -Match.Report, -Notes, -Referee)

matches_clean <- matches_clean %>%
  mutate(
    xG   = as.numeric(xG),
    xG.1 = as.numeric(xG.1)
  )

matches_clean <- matches_clean %>%
  filter(!is.na(xG))

xpts <- function(xG_for, xG_against, max_goals = 6) {
  
  # Alle möglichen Tore von 0 bis max_goals
  goals <- 0:max_goals
  
  # Poisson Wahrscheinlichkeiten
  p_for <- dpois(goals, xG_for)
  p_against <- dpois(goals, xG_against)
  
  # Wahrscheinlichkeit Matrix
  prob_matrix <- outer(p_for, p_against)
  
  # Gewinn, Remis, Verlust
  p_win  <- sum(prob_matrix[lower.tri(prob_matrix)])
  p_draw <- sum(diag(prob_matrix))
  # p_loss = 1 - p_win - p_draw  # optional
  
  # Expected Points
  3 * p_win + 1 * p_draw
}

matches_clean <- matches_clean %>%
  mutate(
    xPts_home = mapply(xpts, xG, xG.1),
    xPts_away = mapply(xpts, xG.1, xG)
  )





team_xpts <- matches_clean %>%
  # Heimteam
  select(Team = Home, xPts = xPts_home) %>%
  bind_rows(
    # Auswärtsteam
    matches_clean %>%
      select(Team = Away, xPts = xPts_away)
  )%>%
  group_by(Team) %>%
  summarise(
    xPts_total = sum(xPts),
    .groups = "drop"  # sorgt dafür, dass das Ergebnis kein grouped_df mehr ist
  ) %>%
  arrange(desc(xPts_total))
