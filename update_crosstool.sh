#!/bin/bash

set -e
pushd $(dirname $0) > /dev/null

PACKAGES=" \
  zephyr-crosstool-aarch64,aarch64-zephyr-elf \
  zephyr-crosstool-arm,arm-zephyr-eabi \
"

# Validate arguments
if [[ -z "$1" ]]; then
  echo "${0} [version]"
  exit 1
fi

VERSION="$1"
SOURCE=${SOURCE:-"https://github.com/stephanosio/zephyr-crosstool-ng/releases/download/zephyr-crosstool-ng-${VERSION}"}

# Prompt user confirmation
echo "Source  = ${SOURCE}"
echo "Version = ${VERSION}"
echo

read -p "Do you want to proceed with updating packages? [y/n] " -n 1 -r
echo
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 2
fi

# Process packages
mkdir -p source

for i in ${PACKAGES}; do
  IFS="," read PACKAGE_NAME PACKAGE_SOURCE <<< "${i}"

  echo "Update ${PACKAGE_NAME}"

  # Download source file
  SOURCE_URL="${SOURCE}/zephyr-crosstool-ng-${VERSION}_macos-x86_64_${PACKAGE_SOURCE}.tar.gz"
  SOURCE_FILE="source/${PACKAGE_NAME}-${VERSION}.tar.gz"

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
  FORMULA_FILE="Formula/${PACKAGE_NAME}.rb"

  echo "  Updating formula ... "
  sed -i -e "s#url \".*\"#url \"${SOURCE_URL}\"#g" "${FORMULA_FILE}"
  sed -i -e "s/version \".*\"/version \"${VERSION}\"/g" "${FORMULA_FILE}"
  sed -i -e "s/sha256 \".*\"/sha256 \"${SOURCE_HASH}\"/g" "${FORMULA_FILE}"
  sed -i -e "s/expected = \"(zephyr-crosstool-NG .*)\"/expected = \"(zephyr-crosstool-NG ${VERSION})\"/g" "${FORMULA_FILE}"

  echo
done

popd > /dev/null