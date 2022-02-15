# Kode for å lese inn og score innleveringer
# Forutsetter at alle innleveringer er csv-filer på likt format
fasit <- read_csv2("fasit.csv")

score_innlevering(score, fasit) {
  fasit %>% 
    left_join(score, by = c("tilsynid")) %>% 
    mmae(truth = total_karakter, score = score) %>% 
    pull(.estimate)
}

innleveringer <- fs::dir_map("innleveringer", read_csv2)

scores <- map_dfr(
  innleveringer,
  ~ score_innlevering(score = .x, fasit = fasit),
  .id = lag
)