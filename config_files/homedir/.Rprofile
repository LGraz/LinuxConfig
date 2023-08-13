## CRAN mirror
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://stat.ethz.ch/CRAN/"
  options(repos = r)
})

# help page in terminal
options(help_type = "text")
options(digits = 5)
options(max.print = 200)
options("formatR.args.newline" = TRUE)
options("formatR.indent" = 2)
options("vsc.rstudioapi" = TRUE)
# get pink prompt:
options(prompt="\033[0;35m\033[1m> \033[0m", continue ="\033[0;35m\033[1m+ \033[0m")

# some utility function
# `%grep%` <- function(x, pattern, ...) grep(pattern, x, value = TRUE, ...)

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

# Ncores --- with 'parallel::detectCores' and checks if aviable
options(Ncpus =
  if (any(rownames(utils::installed.packages()) == "parallel")) {
    max(as.integer(parallel::detectCores() - 2), 1L)
  } else {
    1L
  }
)


installed <- function(pattern, which = c("Package", "Version"), ...) {
  installed <- installed.packages(...)
  ind <- grep(pattern, installed[, "Package"], ignore.case = TRUE)
  installed[ind, which]
}


findMethod <- function(generic, ...) {
  ch <- deparse(substitute(generic))
  f <- X <- function(x, ...) UseMethod("X")
  for (m in methods(ch)) assign(sub(ch, "X", m, fixed = TRUE), "body<-"(f, value = m))
  X(...)
}

# usage in combination with macros: 
r_obj_regex <- "((([[:alpha:]]|[.][._[:alpha:]])[._[:alnum:]]*)|[.])"
what_method_is_called <- function(selected){
  # use like: findMethhod("plot", mynumbers)
  findMethod <- function(generic, ...) {
    f <- X <- function(x, ...) UseMethod("X")
    for (m in methods(generic)) assign(sub(generic, "X", m, fixed = TRUE), "body<-"(f, value = m))
    X(...)
  }
  gsub("\\s", "", selected) # remove whitespace
  f_obj_name <- strsplit(selected, "\\(")[[1]]
  full.name <- findMethod(f_obj_name[1], get(f_obj_name[2]))
  cat(" ",paste0(rep("-",times=nchar(full.name)), collapse = ""), "\n ", full.name, "\n ", paste0(rep("-",times=nchar(full.name)), collapse = ""), "\n")
  aa <- getAnywhere(full.name)
  print(aa$where)
  cat("\nwith args:\n")
  print(args(aa$objs[[1]]))
  help(full.name)
}
