#!/usr/bin/env bash

set -e

repo="microsoft/vscode-js-debug"
latest_release_json=$(curl -s "https://api.github.com/repos/${repo}/releases/latest")
version=$(echo "$latest_release_json" | jq -r '.tag_name')

if [[ "$version" == "null" || -z "$version" ]]; then
  echo "Failed to fetch the latest version"
  exit 1
fi

base_url="https://github.com/${repo}/releases/download/${version}"
file_name="js-debug-dap-${version}.tar.gz"
download_url="${base_url}/${file_name}"

destination="$HOME/.local/bin"
mkdir -p "${destination}"

echo "Downloading from: ${download_url}"
curl -L -o "${file_name}" "${download_url}"
if [ $? -ne 0 ]; then
  echo "Error: Download failed"
  exit 1
fi

echo "Extracting ${file_name} into ${destination}"
tar -xzvf "${file_name}" -C "${destination}"
if [ $? -ne 0 ]; then
  echo "Error: Extraction failed"
  exit 1
fi

rm "${file_name}"

echo "Installation complete"
