#!/bin/bash

GIT_ROOT_DIR="$(dirname ${BASH_SOURCE[0]})"
PKG_VERSION="1.6"

PKG_ROOT=$(mktemp -d)
echo "####### Create package"

mkdir -p "${PKG_ROOT}/etc/sudoers.d"
cp -r "${GIT_ROOT_DIR}/com-github-ygini-temporaryadmin-sudoers" "${PKG_ROOT}/etc/sudoers.d"

mkdir -p "${PKG_ROOT}/usr/local/bin"
cp -r "${GIT_ROOT_DIR}/com.github.ygini.temporaryadmin" "${PKG_ROOT}/usr/local/bin"
cp -r "${GIT_ROOT_DIR}/temporary_admin_standalone.sh" "${PKG_ROOT}/usr/local/bin"

mkdir -p "${PKG_ROOT}/Library/Application Support/com.github.ygini.hello-it/CustomScripts"
cp -r "${GIT_ROOT_DIR}/com.github.ygini.temporaryadmin.hello-it.sh" "${PKG_ROOT}/Library/Application Support/com.github.ygini.hello-it/CustomScripts"

mkdir -p "${PKG_ROOT}/Library/LaunchDaemons"
cp -r "${GIT_ROOT_DIR}/com.github.ygini.temporaryadmin.plist" "${PKG_ROOT}/Library/LaunchDaemons"

pkgbuild --root "${PKG_ROOT}" --identifier "com.github.ygini.temporaryadmin" --scripts "${GIT_ROOT_DIR}/pkg_scripts" --version "${PKG_VERSION}" "${GIT_ROOT_DIR}/TemporaryAdminCMDForHelloIT-${PKG_VERSION}.pkg"

rm -rf "${PKG_ROOT}"

exit 0
