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
jprojectsetup::bootstrap(
  author_name = "Namn Namnsson",  # Namn i skripthuvuden
  overwrite   = FALSE            # TRUE skriver över befintliga filer
)
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

Platshållare som byts ut automatiskt:

| Platshållare | Ersätts med |
|---|---|
| `{{project_name}}` | Namn från .Rproj-filen |
| `{{author_name}}` | Argument till `bootstrap()` |
| `{{created_date}}` | Dagens datum |

