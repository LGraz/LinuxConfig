#!/bin/Rscript

args <- commandArgs()
args <- args[(length(args) - 1):length(args)]
print(args)
system (paste0('swaymsg "workspace number ', args[1], '"'))

# check if is a flatpak
flatpak_list <- system("flatpak list", intern = TRUE)
flatpak_list_line <- flatpak_list[grep(args[2], flatpak_list, ignore.case = TRUE)][1]

workspaces <- system("swaymsg -p -t get_workspaces", intern = TRUE)
# Sys.sleep(2)
focused <- grep(" \\(focused\\)", workspaces)
is_empty_workspace <- grepl("Representation: ([a-zA-Z]\\[\\]|\\(null\\))", workspaces[focused + 3])

cat("Workspace empty:", is_empty_workspace, "\n")
if (is_empty_workspace) {
  if (!is.na(flatpak_list_line)) {
    flatpak_name <- strsplit(flatpak_list_line, "\\t")[[1]][2]
    command <- paste0("flatpak run ", flatpak_name)
  } else {
    command <- args[2]
  }
  print(paste("Execute:", command))
  system(command)
}
