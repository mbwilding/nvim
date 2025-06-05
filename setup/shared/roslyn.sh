#!/usr/bin/env bash

set -e

# Set desired major version override here (e.g., '4' for v4.x.x).
major_override=""

uname_os=$(uname | tr '[:upper:]' '[:lower:]')
if [[ "$uname_os" == "darwin" ]]; then
  os_name="osx"
  major_override="4"
elif [[ "$uname_os" == "linux" ]]; then
  os_name="linux"
else
  os_name="$uname_os"
fi

arch_raw=$(uname -m)
if [[ "$arch_raw" == "x86_64" ]]; then
  arch="x64"
elif [[ "$arch_raw" == "arm64" || "$arch_raw" == "aarch64" ]]; then
  arch="arm64"
else
  arch="$arch_raw"
fi

repo="Crashdummyy/roslynLanguageServer"

if [[ -n "$major_override" ]]; then
  # Attempt to find latest release for major version override
  releases_json=$(curl -s "https://api.github.com/repos/${repo}/releases?per_page=100")
  # Extract all tag_names that match the major version and filter out prereleases/drafts
  version=$(echo "$releases_json" | jq -r ".[] | select(.draft==false and .prerelease==false) | .tag_name" | grep -E "^v?${major_override}[.]" | sort -Vr | head -n1)
else
  # Default to latest release if no override
  latest_release_json=$(curl -s "https://api.github.com/repos/${repo}/releases/latest")
  version=$(echo "$latest_release_json" | jq -r '.tag_name')
fi

if [[ -z "$version" || "$version" == "null" ]]; then
  echo "Failed to fetch the latest version"
  exit 1
fi

base_url="https://github.com/${repo}/releases/download/${version}"
file_name="microsoft.codeanalysis.languageserver.${os_name}-${arch}.zip"
download_url="${base_url}/${file_name}"

destination="$HOME/.dotnet/roslyn"
rm -rf "${destination}"
mkdir -p "${destination}"

echo "Downloading from: ${download_url}"
curl -L -o "${file_name}" "${download_url}"
if [ $? -ne 0 ]; then
  echo "Error: Download failed"
  exit 1
fi

echo "Extracting ${file_name} into ${destination}"
unzip -o "${file_name}" -d "${destination}"
if [ $? -ne 0 ]; then
  echo "Error: Extraction failed"
  exit 1
fi

rm "${file_name}"

echo "Installation complete"

