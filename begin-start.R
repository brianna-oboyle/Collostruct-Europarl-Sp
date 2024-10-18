library(tidyverse)
library(collostructions)

df <- read_tsv('hacerse.txt', quote="")

df<- df |>
  mutate(`Query item` = tolower(`Query item`),
         Verb = str_split_fixed(`Query item`, " ", 3)[,2])

dfq <- read_tsv('quedarse.txt', quote="")

dfq<- dfq |>
  mutate(`Query item` = tolower(`Query item`),
         Verb = str_split_fixed(`Query item`, " ", 3)[,2])

tbl_h <- df |>
  filter(str_starts(`Query item`, "h")) |>
  count(Verb, name = "hacerse_freq")

tbl_q <- dfq |>
  filter(str_starts(`Query item`, "q")) |>
  count(Verb, name = "quedarse_freq")

tbl <- full_join(tbl_h, tbl_q) |>
  replace_na(list(hacerse_freq = 0, quedarse_freq = 0))

view(collex.dist(data.frame(tbl)))

dfv <- read_tsv('volverse.txt', quote="")

dfv<- dfv |>
  mutate(`Query item` = tolower(`Query item`),
         Verb = str_split_fixed(`Query item`, " ", 3)[,2])

tbl_h <- df |>
  filter(str_starts(`Query item`, "h")) |>
  count(Verb, name = "hacerse_freq")

tbl_v <- dfv |>
  filter(str_starts(`Query item`, "v")) |>
  count(Verb, name = "volverse_freq")

tbl2 <- full_join(tbl_h, tbl_v) |>
  replace_na(list(hacerse_freq = 0, volverse_freq = 0))

view(collex.dist(data.frame(tbl2)))
