# Hackathon - ML-konkurranse på data fra mattilsynet

Dette repository inneholder referansemodeller til bruk i en Hackathon hvor formålet er å lage modeller som kan predikere hvilke score en gitt organisasjon vil få under en potensiell kontroll av mattilsynet.

Det finnes både referansemodeller i R (.Rmd) og Python (.ipynb). Begge referansemodellene inneholder i utgangspunktet samme informasjon.

## Scoring

Lagene scores basert på Macro Averaged Mean Absolute Error. Dette er et måltall som kan egne seg for å vurdere ordinale utfallsvariabler som er ubalansert.

## Data

Datasettet som brukes er hentet fra <https://data.norge.no/>.
