#!/bin/bash

if [ $# -eq 0 ]; then
    PACKAGE_NAME=ActivePython-3.6.6.3606-linux-x86_64-glibc-2.12.tar.gz
else
    PACKAGE_NAME=$1
fi

VERSION=$(echo $PACKAGE_NAME | awk -F\- '{print $2}')
MAJOR_VERSION=$(echo $PACKAGE_NAME | awk -F\- '{print $2}' | awk -F\. '{print $1}')

sudo mkdir -p /opt/bin

if [ ! -f ${PACKAGE_NAME} ]; then
    wget http://downloads.activestate.com/ActivePython/releases/${VERSION}/${PACKAGE_NAME}
fi

mkdir ${PACKAGE_NAME%'.tar.gz'}
tar -xvzf ${PACKAGE_NAME} -C ${PACKAGE_NAME%'.tar.gz'} --strip-components=1
cd ${PACKAGE_NAME%'.tar.gz'}
sudo ./install.sh -I /opt/python/

sudo ln -sf /opt/python/bin/easy_install /opt/bin/easy_install
sudo ln -sf /opt/python/bin/pip /opt/bin/pip
sudo ln -sf /opt/python/bin/python${MAJOR_VERSION} /opt/bin/python${MAJOR_VERSION}
sudo ln -sf /opt/python/bin/virtualenv /opt/bin/virtualenv
sudo ln -sf /opt/bin/python${MAJOR_VERSION} /opt/bin/python

sudo pip install --upgrade pip

cd && sudo rm -rf ${PACKAGE_NAME} && sudo rm -rf ${PACKAGE_NAME%'.tar.gz'}