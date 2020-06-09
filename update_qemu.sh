#!/bin/bash

set -e
pushd $(dirname $0) > /dev/null

# Validate arguments
if [[ -z "$1" ]]; then
  echo "${0} [version]"
  exit 1
fi

VERSION="$1"
SOURCE=${SOURCE:-"https://github.com/stephanosio/zephyr-qemu/releases/download/zephyr-qemu-v${VERSION}"}

# Prompt user confirmation
echo "Source  = ${SOURCE}"
echo "Version = ${VERSION}"
echo

read -p "Do you want to proceed with updating 'zephyr-qemu' package? [y/n] " -n 1 -r
echo
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 2
fi

# Process packages
mkdir -p source

# Download source file
SOURCE_URL="${SOURCE}/zephyr-qemu-v${VERSION}_macos-x86_64.tar.gz"
SOURCE_FILE="source/zephyr-qemu-v${VERSION}.tar.gz"

if [ ! -f "${SOURCE_FILE}" ]; then
echo "  Downloading source file ..."
curl -f -# -L "${SOURCE_URL}" -o "${SOURCE_FILE}.tmp"
mv -f "${SOURCE_FILE}.tmp" "${SOURCE_FILE}"
fi

# Compute source file hash
echo "  Computing source file hash ..."
SOURCE_HASH=$(sha256sum "${SOURCE_FILE}" | awk '{print $1}')
echo "    ${SOURCE_HASH}"

# Update formula
FORMULA_FILE="Formula/zephyr-qemu.rb"

echo "  Updating formula ... "
sed -i -e "s#url \".*\"#url \"${SOURCE_URL}\"#g" "${FORMULA_FILE}"
sed -i -e "s/version \".*\"/version \"${VERSION}\"/g" "${FORMULA_FILE}"
sed -i -e "s/sha256 \".*\"/sha256 \"${SOURCE_HASH}\"/g" "${FORMULA_FILE}"

popd > /dev/null
