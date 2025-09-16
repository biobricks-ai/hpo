library(purrr)
library(vroom)
library(arrow)
library(stringr)
library(ontologyIndex)

outdir <- fs::dir_create("brick")

delete_useless_columns <- function(df) {
  df[, sapply(df, function(col) length(unique(col))) > 1]
}

# Get headers from text files (header found on line 1)
get_txt_headers <- function(file) {
	vroom::vroom_lines(file, n_max=1) |> sub(pattern = "#Format: ", replacement = "") |>
	strsplit(split="<tab>") |> unlist()
}

# Get headers from hpoa file (script detects header from the lines at top of file as header contains DatabaseID
get_hpoa_headers <- function(file) {
	top_of_file = vroom_lines(file, n_max=20)
	top_of_file[grepl(top_of_file, pattern = "#DatabaseID")] |> 
	sub(pattern = "#", replacement = "") |> strsplit(split="\t") |> unlist()
}

save_parquet <- function(file) {
  path <- fs::path_ext_remove(file) |> fs::path_ext_set("parquet") |> fs::path_file()
  if(grepl(x=file, pattern=".txt"))
  	df <- vroom::vroom(file,comment="#", delim="\t", col_names = get_txt_headers(file))
  else if(grepl(x=file, pattern=".obo"))
  	df <- get_ontology(file, propagate_relationships = "is_a", extract_tags = "everything") |> as.data.frame()
  else if(grepl(x=file, pattern = ".hpoa"))
  	df <- vroom::vroom(file,comment="#", delim="\t", col_names = get_hpoa_headers(file))
  delete_useless_columns(df) |>  arrow::write_parquet(fs::path(outdir,path))
}

# WRITE OUTS ================================================================================
fs::dir_ls(outdir) |> fs::file_delete() # delete files present in the directory
fs::dir_ls("download", regexp=".obo|.hpoa|.txt") |> walk(save_parquet) # Create parquet files