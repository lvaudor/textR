# Use this file to install Linux software packages into the course image.
# R packages should be installed from requirements.R
# There is a list of available Linux packages at 
# https://packages.debian.org/testing/allpackages
# This file needs to run without interaction. You may need to use some of these args to apt-get:
# --assume-yes --assume-no --trivial-only --allow-downgrades --allow-remove-essential --allow-change-held-packages

# e.g., XML and Cairo graphics
# apt-get update && apt-get install --yes libxml2-dev libcairo2-dev
apt-get update && apt-get install --yes libxml2-dev
apt-get update && apt-get install --yes r-cran-igraph
apt-get update && apt-get install --yes r-cran-rcpp
apt-get update && apt-get install --yes libudunits2-dev
