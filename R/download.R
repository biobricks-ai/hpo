# This file downloads all data files from HPO
library(rvest)
library(purrr)
library(fs)
library(RSelenium)
library(tidyverse)
library(netstat)

# strsplit_grepl will parse out based on pattern and only return matches to extension
strsplit_grepl <- function(x, pattern, extension) { 
	temp = unlist(strsplit(x, pattern))
	temp[unlist(lapply(temp, FUN=grepl, pattern = extension))]
}

# Used to parse for files using ext1 and ext2
parse_for_files <- function(x, ext1, ext2) {
	strsplit_grepl(x, pattern=">", extension=ext1) |> 
	strsplit_grepl(pattern="<", extension=ext2) |>
	sub(pattern = " ", replacement = "")
}

# Will use firefox to open the HPO app to load file URLs.
get_page_source_firefox <- function(URL) {
	rD=rsDriver(browser="firefox", port=free_port(), verbose=F, 
		extraCapabilities=list(acceptInsecureCerts=TRUE,acceptUntrustedCerts=TRUE)) # Open firefox
	remDr <- rD[["client"]]
	remDr$navigate(URL) # go to URL
	page_source = remDr$getPageSource() # get page source after loading app
	remDr$close() # close session
	as.character(page_source) # return page source
}

options(timeout=1800) # download timeout
obo_address = "https://hpo.jax.org/app/download/ontology" # URL for ontology part of app
ann_address = "https://hpo.jax.org/app/download/annotation" # URL for annotation part of app

fs::dir_create("cache") # Create directory for downloads/intermediate files
URL_obo = get_page_source_firefox(obo_address) |> parse_for_files(ext1="http:.*[.]obo", 
	ext2="http:.*[.]obo$") # get URLs for ontology
URL_ann = get_page_source_firefox(ann_address) |> parse_for_files(ext1="http:.*[.]txt|http:.*[.]hpoa", 
	ext2="http:.*[.]txt$|http:.*[.]hpoa$") # get URLs for annotation
URLs = c(URL_obo, URL_ann)
files = strsplit_grepl(URLs, "/", "[.](hpoa$|txt$|obo$)") 
walk2(URLs, paste0("cache/", files), download.file) # Download files 
