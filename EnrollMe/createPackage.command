#!/bin/bash

GIT_ROOT_DIR="$(dirname ${BASH_SOURCE[0]})"
PKG_VERSION="$(date +%Y.%m.%d).1"

PKG_ROOT=$(mktemp -d)
echo "####### Create package"

mkdir -p "${PKG_ROOT}/etc/sudoers.d"
cp -r "${GIT_ROOT_DIR}/com-github-ygini-enrollme-sudoers" "${PKG_ROOT}/etc/sudoers.d"

mkdir -p "${PKG_ROOT}/usr/local/bin"
cp -r "${GIT_ROOT_DIR}/com.github.ygini.enrollme.sh" "${PKG_ROOT}/usr/local/bin"

mkdir -p "${PKG_ROOT}/Library/Application Support/com.github.ygini.hello-it/CustomScripts"
cp -r "${GIT_ROOT_DIR}/com.github.ygini.enrollme.hello-it.sh" "${PKG_ROOT}/Library/Application Support/com.github.ygini.hello-it/CustomScripts"

pkgbuild --root "${PKG_ROOT}" --identifier "com.github.ygini.enrollme" --scripts "${GIT_ROOT_DIR}/pkg_scripts" --version "${PKG_VERSION}" "${GIT_ROOT_DIR}/EnrollMeForHelloIT-${PKG_VERSION}.pkg"

rm -rf "${PKG_ROOT}"

exit 0
