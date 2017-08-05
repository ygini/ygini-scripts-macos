#!/bin/bash

GIT_ROOT_DIR="$(dirname ${BASH_SOURCE[0]})"
PKG_VERSION="1.0"

PKG_ROOT=$(mktemp -d)
echo "####### Create package"

mkdir -p "${PKG_ROOT}/Library/Application Support/com.github.ygini.hello-it/CustomScripts/com.github.ygini.temporaryadmin"
cp -r "${GIT_ROOT_DIR}/com.github.ygini.temporaryadmin" "${PKG_ROOT}/Library/Application Support/com.github.ygini.hello-it/CustomScripts/com.github.ygini.temporaryadmin"
cp -r "${GIT_ROOT_DIR}/com.github.ygini.temporaryadmin.hello-it.sh" "${PKG_ROOT}/Library/Application Support/com.github.ygini.hello-it/CustomScripts"

pkgbuild --root "${PKG_ROOT}" --identifier "com.github.ygini.temporaryadmin" --version "${PKG_VERSION}" "${GIT_ROOT_DIR}/TemporaryAdminCMDForHelloIT-${PKG_VERSION}.pkg"

rm -rf "${PKG_ROOT}"

exit 0
