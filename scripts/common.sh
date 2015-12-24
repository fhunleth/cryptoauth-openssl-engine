#!/bin/bash
set -e
set -x
cd $(dirname $0)
cd ..
export TREE_TOP=${PWD}
export CERTSTORE=$TREE_TOP/certstore
export SCRIPTS=$TREE_TOP/scripts
export BIN_DIR=$TREE_TOP/install_dir/bin
export EX_DIR=$TREE_TOP/client-server

# Certificate names
export TMP_CERT_DIR=/tmp
export DEVICE_CERT=${TMP_CERT_DIR}/dev_cert
export DEVICE_KEY=${TMP_CERT_DIR}/dev_key.pem
export DEVICE_CSR=${TMP_CERT_DIR}/dev_csr.pem
export SIGNER_CERT=${TMP_CERT_DIR}/signer_cert
export SIGNER_PATH=${TMP_CERT_DIR}
export ROOT_CERT=${TMP_CERT_DIR}/root_cert
export SIGNER_BUNDLE=${TMP_CERT_DIR}/signer_bundle.pem

export LD_LIBRARY_PATH=$TREE_TOP/install_dir/lib
export LD_PRELOAD=/lib/x86_64-linux-gnu/libpthread.so.0
export PORT=49917

export ENGINE="-engine ateccx08"
export KEYGEN_ENGINE="-keygen_engine ateccx08"

if [ -z "$COMPANY" ]; then
    export COMPANY="homut"
fi

if [ -z "$USE_EXAMPLE" ]; then
    export USE_EXAMPLE=0
fi

if [ -z "$USE_ENGINE" ]; then
    export USE_ENGINE=0
fi

if [ -z "$USE_ATMEL_CA" ]; then
    export USE_ATMEL_CA=0
fi

if [ -z "$NEW_KEY" ]; then
    export NEW_KEY=0
fi

if [ $USE_ENGINE = "0" ]; then
    export ENGINE=
    export ENGINE_EX=
else
    export ENGINE="-engine ateccx08"
    export ENGINE_EX="-e ateccx08"
fi

if [ $USE_ENGINE = "0" ]; then
    export TARGET="client"
else
    export TARGET="client_eccx08"
fi

if [ -z "$USE_RSA" ]; then
    export USE_RSA=0
fi

if [ $USE_RSA = "0" ]; then
  RSA=
else
  RSA=rsa_
  if [ $USE_ENGINE = "0" ]; then
    KEYFORM=
  else
    KEYFORM="-keyform ENG"
  fi
fi

export CMD=${BIN_DIR}/openssl
#export CMD=${TREE_TOP}/cmd_openssl gdb 
#export CMD="gdb --args ${BIN_DIR}/openssl"
export CMD_EX="${EX_DIR}/exchange-tls12"
#export CMD_EX="gdb --args ${EX_DIR}/exchange-tls12"


