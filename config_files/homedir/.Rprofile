options(keep.source.pkgs = TRUE); Sys.setenv(R_KEEP_PKG_SOURCE = "yes") # also in .Renviron
## CRAN mirror
r <- getOption("repos")
r["CRAN"] <- "https://stat.ethz.ch/CRAN/"
options(repos = r); rm(r)
options(save = "no")

## Ncpus / mc.cores
if ("parallel" %in% .packages(all.available=TRUE)){
  Ncores <- as.integer(parallel::detectCores() - 2)
  if (Ncores %in% 2:256) {
    options(Ncpus = Ncores)
    options(mc.cores = Ncores)
    # Sys.setenv(OPENBLAS_NUM_THREADS = Ncores) # for openblas
  }; rm(Ncores)
}


# help page in terminal
options(setWidthOnResize = TRUE)
options(help_type = "text")
options(max.print = 200)
options(formatR.args.newline = TRUE)
options(formatR.indent = 2)
options(vsc.rstudioapi = TRUE)
# options(warnPartialMatchArgs = TRUE)
# options(warnPartialMatchAttr = TRUE)
# options(warnPartialMatchDollar = TRUE)

# syler
if ("styler" %in% .packages(all.available=TRUE)){
options(languageserver.formatting_style = 
  function(options) {
    style <- styler::tidyverse_style(
      strict = FALSE,
      indent_by = 2,
      scope = "tokens" # I(c("line_breaks", "tokens", "spaces", "indentation"))
    )
    # style$space$set_space_between_eq_sub_and_comma <- NULL
    style
  })
}

if (interactive()){
  options(digits = 5)
  if ("rlang" %in% .packages(all.available=TRUE))
 
  rlang::global_entrace()
  options(rlang_backtrace_on_warning_report = "branch")
  options(rlang_backtrace_on_warning = "branch")
  options(rlang_backtrace_on_error_report = "branch")
  options(rlang_backtrace_on_error = "branch")

  if (Sys.getenv("RSTUDIO") == "" && Sys.getenv("POSITRON") == ""){
    options(prompt = "\001\033[0;35m\033[1m\002>\001\033[0m\002 ") # get pink prompt:
    options(prompt = "\001\033[0;35m\002>\001\033[0m\002 ") # get pink prompt:
  }

  .Last <- function()
    if(interactive()) try(savehistory("~/.Rhistory"))
}

if (interactive() && Sys.info()["nodename"] %in% c("tukey", "salem", "dirichlet") ) {
Rprofile_objs_interactive <- local({
# INTERACTIVE --------------------------------------------------
  ### VS-CODE MACROS -------------------------------------------
  # usage in combination with macros:
  r_obj_regex <- "((([[:alpha:]]|[.][._[:alpha:]])[._[:alnum:]]*)|[.])"

  findMethod <- function(generic, ...) {
    ch <- deparse(substitute(generic))
    f <- X <- function(x, ...) UseMethod("X")
    for (m in methods(ch)) assign(sub(ch, "X", m, fixed = TRUE), "body<-"(f, value = m))
    X(...)
  }

  # function that for each class of obj, finds all methods and nicely prints them
  class_methods <- function(class){
    ret <- list()
    if(!is.character(class)) {
      class <- class(class)
    }
    for (cl in class) {
      ret[[cl]] <- NULL
      m <- methods(class = cl)
      if (length(m) > 0) {
        ret[[cl]] <- attr(m, "info")$generic
    }}
    ret
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

  # evaluate and copy to clipboard
  eval_to_clipboard <- function(..., prefix="#> ", print_to_console=TRUE) {
    s <- capture.output(...)
    prefixed_s <- paste(prefix, s, sep = "", collapse = "\n")
    
    if(.Platform$OS.type == "windows")
      writeClipboard(prefixed_s)
    else
      # use the system() function to put the prefixed_s string into the clipboard using xclip (escaping all quotes)
      system(paste("echo '", gsub("'", "", prefixed_s), "' | wl-copy", sep = ""))

    cat("------------  Copied to clipboard:  ------------------\n\n")
    if(print_to_console) 
      cat(s, sep = "\n")
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

    # OVERRIDE library / require -----------------------------------------
    # Attempts to load a package; prompts to install via 'pak' if missing
    library <- require <- function(package, character.only = FALSE, quietly = TRUE, ...) {
      if (!character.only) {
        package <- as.character(substitute(package))
      }
      
      # Attempt to load normally
      loaded <- suppressWarnings(base::require(package, character.only = TRUE, quietly = TRUE, ...))
      
      # If missing, and we are in an interactive session (not a background job)
      if (!loaded && interactive()) {
        message(sprintf("\nPackage '%s' is not installed.", package))
        ans_install <- readline(prompt = "Install package with pak? [Y/n]: ")
        
        # Accept 'y', 'Y', or empty string (Enter key) as Yes
        if (trimws(tolower(ans_install)) %in% c("y", "")) {
          
          # Bootstrap pak if it's somehow missing
          if (!base::requireNamespace("pak", quietly = TRUE)) {
            utils::install.packages("pak", repos = "https://cloud.r-project.org/")
          }
          
          # Install the package
          message(sprintf("Installing %s...", package))
          pak::pkg_install(package)
          
          # Try loading it again
          loaded <- base::require(package, character.only = TRUE, quietly = TRUE)
          
          # If successful, prompt to append
          if (loaded) {
            ans_append <- readline(prompt = "Append to R-package-list? [Y/n]: ")
            
            if (trimws(tolower(ans_append)) %in% c("y", "")) {
              list_path <- "~/LinuxConfig/installation-scripts/pkg/r.txt"
              
              # Safely append using tryCatch
              tryCatch({
                write(package, file = list_path, append = TRUE)
                message(sprintf("Successfully appended '%s' to %s", package, list_path))
              }, error = function(e) {
                warning(sprintf("Could not append to list. Does the directory exist?\nError: %s", e$message))
              })
            }
          }
        } else {
          message("Aborting installation.")
        }
      }
      
      # Return whether the package is successfully loaded
      invisible(loaded)
    }
  # NO RSTUDIO / POSITRON --------------------------------------:
  if (interactive() && Sys.getenv("RSTUDIO") == "" && Sys.getenv("POSITRON") == ""){

  }


# -------------------------   END OF FILE --------------------------------------------
environment()  # Return the environment
})
# Attach the new environment to the search path
attach(Rprofile_objs_interactive, warn.conflicts = FALSE)
rm(Rprofile_objs_interactive)
}


