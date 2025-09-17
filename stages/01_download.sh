#!/usr/bin/env bash

local_dir=$(pwd)
download_dir="$local_dir/download"
mkdir -p "$download_dir"

files=("phenotype.hpoa" "genes_to_phenotype.txt" "hp.obo" "phenotype_to_genes.txt")

assets=$(curl -s https://api.github.com/repos/obophenotype/human-phenotype-ontology/releases/latest)

for f in "${files[@]}"; do
  url=$(echo "$assets" | jq -r --arg name "$f" \
    '.assets[] | select(.name==$name) | .browser_download_url')
  if [ -n "$url" ] && [ "$url" != "null" ]; then
    echo "Downloading $f"
    curl -L -o "$download_dir/$f" "$url"
  else
    echo "Asset $f not found in latest release"
  fi
done