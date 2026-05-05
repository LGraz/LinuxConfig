options(keep.source.pkgs = TRUE)
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

.Last <- function()
	if(interactive()) try(savehistory("~/.Rhistory"))

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
