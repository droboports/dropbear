### ZLIB ###
_build_zlib() {
local VERSION="1.2.8"
local FOLDER="zlib-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://zlib.net/fossils/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --prefix="${DEPS}" --libdir="${DEST}/lib"
make
make install
rm -v "${DEST}/lib"/*.a
popd
}

### DROPBEAR ###
_build_dropbear() {
local VERSION="2015.67"
local FOLDER="dropbear-${VERSION}"
local FILE="${FOLDER}.tar.bz2"
local URL="https://matt.ucc.asn.au/dropbear/releases/${FILE}"

_download_bz2 "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEST}" --mandir="${DEST}/man" --with-zlib="${DEST}"
make
make install
popd
}

_build() {
  _build_zlib
  _build_dropbear
  _package
}
