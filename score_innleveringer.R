# Kode for å lese inn og score innleveringer
# Forutsetter at alle innleveringer er csv-filer på likt format
fasit <- read_csv2("data/fasit.csv")

score_innlevering <- function(score, fasit) {
  fasit %>% 
    left_join(score, by = c("tilsynid")) %>% 
    mmae(truth = total_karakter, estimate = final_prediction) %>% 
    pull(.estimate)
}

# Lager naiv-innlevering som baseline
fasit %>%
  mutate(final_prediction = 0.7) %>% 
  select(tilsynid, dato, final_prediction) %>% 
  write_csv2("output/naiv_prediksjon.csv")

files <- fs::dir_ls("output", regexp = "*.csv")
innleveringer <- map(files, read_csv2)

scores <- map_dbl(
  innleveringer,
  ~ score_innlevering(score = .x, fasit = fasit),
  .id = lag
)

resultatliste <- tibble(scores = scores, lag = names(scores)) %>% 
  arrange(scores)

resultatliste
