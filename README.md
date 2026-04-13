# jproject_setup

Skapar standardmappstruktur och startfiler för nya R-analysprojekt.

## Installation

```r
# install.packages("pak")
pak::pak("jenshda/jproject_setup")
```

## Användning

1. Skapa ett nytt RStudio-projekt på önskad plats
2. Öppna projektet
3. Kör i konsolen:

```r
jproject_setup::bootstrap()
```

Funktionen skapar följande struktur:

```
projektnamn/
├── data/
│   ├── raw/
│   └── processed/
├── output/
│   ├── figures/
│   └── tables/
├── R/
│   └── functions.R
├── scripts/
│   ├── 00_main.R
│   ├── 01_prepare_data.R
│   └── 02_analysis.R
├── reports/
│   └── report.qmd
├── README.md
└── .gitignore
```

## Redigera mallfiler

Mallfilerna ligger under `inst/templates/` i paketets källkod.
Klona repot, redigera mallfilerna direkt, och installera om med:

```r
devtools::install_local("path/to/jproject_setup")
```

Platshållare som byts ut automatiskt:

| Platshållare | Ersätts med |
|---|---|
| `{{project_name}}` | Namn från .Rproj-filen |
| `{{author_name}}` | Argument till `bootstrap()` |
| `{{created_date}}` | Dagens datum |

## Argument

```r
bootstrap(
  author_name = "Jens Halford",  # Namn i skripthuvuden
  overwrite   = FALSE            # TRUE skriver över befintliga filer
)
```
