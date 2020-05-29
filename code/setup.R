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
    # Tidyverse
    library("tidyverse")
})

#==============================================================================#
# ---- CONFLICTS ----
#==============================================================================#

suppressMessages({

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
    html_dir = here("data", "raw"),
    scraped  = here("data", "01-requestival-scraped.tsv")
)
