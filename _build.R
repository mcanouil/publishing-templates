devnull <- sapply(
  X = sapply(
    X = list.files("xaringan-remarkjs", full.names = TRUE),
    FUN = list.files,
    pattern = "\\.Rmd$",
    full.names = TRUE
  ),
  FUN = function(itemplate) {
    rmarkdown::render(
      input = itemplate,
      output_file = sub("\\.Rmd", "\\.html", sub("-.*/", "-", itemplate)),
      output_dir = "docs",
      quiet = TRUE
    )
  }
)

devnull <- sapply(
  X = sapply(
    X = list.files("quarto-revealjs", full.names = TRUE),
    FUN = list.files,
    pattern = "\\.qmd$",
    full.names = TRUE
  ),
  FUN = function(itemplate) {
    quarto::quarto_render(
      input = itemplate,
      output_file = file.path("docs", sub("\\.qmd", "\\.html", sub("-.*/", "-", itemplate))),
      quiet = TRUE
    )
  }
)

dir.create("thumbs", showWarnings = FALSE, mode = "0755")
Sys.setenv(CHROMOTE_CHROME = "/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser")
invisible(lapply(
  X = list.files(
    path = "docs",
    pattern = "\\.html$",
    full.names = TRUE
  ),
  FUN = function(ihtml) {
    webshot2::webshot(
      url = ihtml,
      file = file.path("thumbs", sub("\\.html", ".png", basename(ihtml))),
      vwidth = 1920,
      vheight = 1080
    )
  }
))
