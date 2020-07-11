#==============================================================================#
# ---- LIBRARIES ----
#==============================================================================#

suppressPackageStartupMessages({
    # Package conflicts
    library("conflicted")
    # File paths
    library("fs")
    library("here")
    # Scraping
    library("rvest")
    # Spotify API
    library("spotifyr")
    # Embedding
    library("Rtsne")
    # Dates
    library("lubridate")
    # Presentation
    library("glue")
    library("knitr")
    # Tidyverse
    library("tidyverse")
})

#==============================================================================#
# ---- CONFLICTS ----
#==============================================================================#

suppressMessages({
    conflict_prefer("filter", "dplyr")
})

#==============================================================================#
# ---- KNITR ----
#==============================================================================#

DOCNAME <- knitr::current_input()
NOW <- Sys.time()

# Time chunks during knitting
knitr::knit_hooks$set(timeit = function(before) {
    if (before) {
        print(paste("Start:", Sys.time()))
        NOW <<- Sys.time()
    } else {
        print(paste("Stop:", Sys.time()))
        runtime <- Sys.time() - NOW
        print(runtime)
        paste(
            '<p class="timeit">',
            "Chunk time:", round(runtime, 2), attr(runtime, "units"),
            "</p>"
        )
    }
})

knitr::opts_chunk$set(
    autodep        = TRUE,
    cache          = FALSE,
    cache.path     = paste0("cache/", DOCNAME, "/"),
    cache.comments = FALSE,
    echo           = TRUE,
    error          = FALSE,
    fig.align      = "center",
    fig.width      = 10,
    fig.height     = 8,
    message        = FALSE,
    warning        = FALSE,
    timeit         = TRUE
)

OUT_DIR <- here("output", DOCNAME)
dir_create(OUT_DIR)

#==============================================================================#
# ---- ENVIRONMENT VARIABLES ----
#==============================================================================#

#==============================================================================#
# ---- FUNCTIONS ----
#==============================================================================#

#==============================================================================#
# ---- THEME ----
#==============================================================================#

theme_set(theme_minimal())

#==============================================================================#
# ---- PATHS ----
#==============================================================================#

PATHS <- list(
    spotify_secrets = here("code", "_spotify_secrets.R"),
    html_dir        = here("data", "raw"),
    scraped         = here("data", "01-requestival-scraped.tsv"),
    tidied          = here("data", "02-requestival-tidied.tsv"),
    augmented       = here("data", "03-requestival-augmented.tsv")
)

#==============================================================================#
# ---- SECRETS ----
#==============================================================================#

if (file_exists(PATHS$spotify_secrets)) {
    source(PATHS$spotify_secrets)
} else {
    rlang::warn(paste(
        "Spotify secrets file doesn't exist so some sections of the code won't",
        "be run. See the '_spotify_secrets.R.template' file in the'`code/'",
        "directory for details."
    ))
}
