dir.create("thumbs", showWarnings = FALSE, mode = "0755")
Sys.setenv(CHROMOTE_CHROME = "/Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser")

devnull <- sapply(
  X = sapply(
    X = list.files("xaringan-remarkjs", full.names = TRUE),
    FUN = list.files,
    pattern = "\\.Rmd$",
    full.names = TRUE
  ),
  FUN = function(itemplate) {
    ihtml <- sub("\\.Rmd", "\\.html", sub("-.*/", "-", itemplate))
    out <- rmarkdown::render(
      input = itemplate,
      output_file = ihtml,
      output_dir = "docs",
      quiet = TRUE
    )
    webshot2::webshot(
      url = out,
      file = file.path("thumbs", sub("\\.html", ".png", basename(ihtml))),
      vwidth = 1920,
      vheight = 1080
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
    quarto::quarto_render(input = itemplate, quiet = TRUE)
    ihtml <- sub("\\.qmd", "\\.html", itemplate)
    webshot2::webshot(
      url = ihtml,
      file = file.path(
        "thumbs",
        sub("\\.html", ".png", sub("\\.qmd", "\\.html", sub("-.*/", "-", itemplate)))
      ),
      vwidth = 1920,
      vheight = 1080
    )
    file.copy(
      from = ihtml,
      to = file.path(
        "docs",
        sub("\\.qmd", "\\.html", sub("-.*/", "-", itemplate))
      ),
      overwrite = TRUE
    )
    unlink(x = ihtml, force = TRUE)
  }
)
