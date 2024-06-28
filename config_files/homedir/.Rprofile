Rprofile_environment <- local({

## CRAN mirror
r <- getOption("repos")
r["CRAN"] <- "https://stat.ethz.ch/CRAN/"
options(repos = r)


# help page in terminal
options(setWidthOnResize = TRUE)
options(help_type = "text")
options(digits = 5)
options(max.print = 200)
options("formatR.args.newline" = TRUE)
options("formatR.indent" = 2)
options("vsc.rstudioapi" = TRUE)
# options(warnPartialMatchArgs = TRUE)
# options(warnPartialMatchAttr = TRUE)
# options(warnPartialMatchDollar = TRUE)

# syler
options(languageserver.formatting_style = function(options) {
  style <- styler::tidyverse_style(
    strict = FALSE,
    indent_by = 2,
    scope = "tokens" # I(c("line_breaks", "tokens", "spaces", "indentation"))
  )
  # style$space$set_space_between_eq_sub_and_comma <- NULL
  style
})

## Ncores --- with 'parallel::detectCores' and checks if aviable
Ncores <- as.integer(parallel::detectCores() - 2)
if (!(Ncores %in% 1:256)) {
  Ncores <- 1L
}
options(Ncpus = Ncores)
options(mc.cores = Ncores)


### VS-CODE MACROS -------------------------------------------
# usage in combination with macros:
r_obj_regex <- "((([[:alpha:]]|[.][._[:alpha:]])[._[:alnum:]]*)|[.])"

findMethod <- function(generic, ...) {
  ch <- deparse(substitute(generic))
  f <- X <- function(x, ...) UseMethod("X")
  for (m in methods(ch)) assign(sub(ch, "X", m, fixed = TRUE), "body<-"(f, value = m))
  X(...)
}

what_method_is_called <- function(selected) {
  # use like: findMethhod("plot", mynumbers)
  findMethod <- function(generic, ...) {
    f <- X <- function(x, ...) UseMethod("X")
    for (m in methods(generic)) assign(sub(generic, "X", m, fixed = TRUE), "body<-"(f, value = m))
    X(...)
  }
  gsub("\\s", "", selected) # remove whitespace
  f_obj_name <- strsplit(selected, "\\(")[[1]]
  full.name <- findMethod(f_obj_name[1], get(f_obj_name[2]))
  cat(" ", paste0(rep("-", times = nchar(full.name)), collapse = ""), "\n ", full.name, "\n ", paste0(rep("-", times = nchar(full.name)), collapse = ""), "\n")
  aa <- getAnywhere(full.name)
  print(aa$where)
  cat("\nwith args:\n")
  print(args(aa$objs[[1]]))
  help(full.name)
}

if (interactive()) {



  # if not using rstudio:
  if (!(Sys.getenv("RSTUDIO") == "1")){
    options(prompt = "\001\033[0;35m\033[1m\002>\001\033[0m\002 ") # get pink prompt:
    options(prompt = "\001\033[0;35m\002>\001\033[0m\002 ") # get pink prompt:

    ## INSTALL HELPERS
    installed <- function(pattern, which = c("Package", "Version"), ...) {
      installed <- installed.packages(...)
      ind <- grep(pattern, installed[, "Package"], ignore.case = TRUE)
      installed[ind, which]
    }
    # only install if missing
    install <- function(pkgs, ...) {
      pkgs_not_installed <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]
      pkgs_installed <- pkgs[(pkgs %in% installed.packages()[, "Package"])]
      if (length(pkgs_installed) > 0)
        message(paste("Already Installed: ", paste(pkgs_installed,     collapse = "; ")))
      if (length(pkgs_not_installed) > 0){
        message(paste("NOW INSTALL: ",       paste(pkgs_not_installed, collapse = "; ")))
        for (pkg in pkgs_not_installed)
          try(utils::install.packages(pkg, ..., clean=TRUE))
      }
    }

    # colored output: --------------------------------------
    # remotes::install_github("https://github.com/jalvesaq/colorout")
    if (base::require(colorout, quietly = TRUE)) {
      setOutputColors(
        normal = 153, negnum = 153, zero = 189,
        number = 153, date = 153, string = 153,
        const = 141, false = 153, true = 153,
        infinite = 141, index = 30, stderror = 214,
        warn = 160, error = c(1, 16, 196),
        verbose = FALSE, zero.limit = 1e-7
      )
    }

    # evaluate and copy to clipboard
    eval_to_clipboard <- function(..., prefix="#> ", print_to_console=TRUE) {
      s <- capture.output(...)
      prefixed_s <- paste(prefix, s, sep = "", collapse = "\n")
      
      if(.Platform$OS.type == "windows")
        writeClipboard(prefixed_s)
      else
        # use the system() function to put the prefixed_s string into the clipboard using xclip (escaping all quotes)
        system(paste("echo '", gsub("'", "", prefixed_s), "' | xclip -selection clipboard", sep = ""))

      cat("------------  Copied to clipboard:  ------------------\n\n")
      if(print_to_console) 
        cat(s, sep = "\n")
    }

    # LIBRARY COMMAND -------------------------------------
    # trys to load, if fails, prompt to install -----------
    library <- require <- function(package, character.only = TRUE, quietly = TRUE, ...) {
      package <- as.character(substitute(package))
      # e <- base::require(package, quietly=TRUE)
      e <- base::require(package, character.only = TRUE, quietly = TRUE, ...)
      if (!e) {
        message(paste0(package, " not installed "))
        r <- readline(prompt = "Install package? (Y/n): ")
        if (grepl("^y$|^\\s*$", r, ignore.case = TRUE)) {
          message(paste("Installing", package))
          install.packages(package)
          base::require(package, character.only = TRUE, quietly = TRUE)
          r <- readline(prompt = "Append to R-package-list? (Y/n): ")
          if (grepl("^y$", r, ignore.case = TRUE)) {
            try_obj <- try(write(package, file = "~/LinuxConfig/installation-scripts/pkg/r.txt", append = TRUE))
            if(inherits(try_obj, "try-error"))
              message("Could not append to R-package-list")
              print(try_obj)
          }
        } else {
          message("Aborting installation.")
        }
      }
      invisible(e)
    }
  }
}


# -------------------------   END OF FILE --------------------------------------------
environment()  # Return the environment
})
# Attach the new environment to the search path
attach(Rprofile_environment, warn.conflicts = FALSE)
rm(Rprofile_environment)

# check if environment attached correctly
if(interactive()){
  if (!("Rprofile_environment" %in% search())){
    warning("Rprofile missing")
  }
} 

