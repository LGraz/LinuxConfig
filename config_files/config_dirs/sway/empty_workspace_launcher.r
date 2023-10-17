#!/bin/Rscript

args <- commandArgs()
args <- args[(length(args) - 1):length(args)]
print(args)
system (paste0('swaymsg "workspace number ', args[1], '"'))

workspaces <- system("swaymsg -p -t get_workspaces", intern = TRUE)
# Sys.sleep(2)
focused <- grep(" \\(focused\\)", workspaces)
is_empty_workspace <- grepl("Representation: ([a-zA-Z]\\[\\]|\\(null\\))", workspaces[focused + 3])
print(workspaces)
cat("Workspace empty:", is_empty_workspace, "\n")
if (is_empty_workspace) {
  print(paste("Execute:", args[2], "&"))
  system(paste(args[2], "&"))
}
