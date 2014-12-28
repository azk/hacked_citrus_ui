rm(list=ls())

library("citrus")
library("shiny")
library("brew")

dataDir="/home/azk/lab/playground/cytof_fixes/10181_files/relabeled"

debugTemplate=F

runApp("inst/shinyGUI",launch.browser = T)