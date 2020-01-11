#!/bin/sh

if test $(id -u) -gt 0; then
    echo "Please, run as root."; exit;
fi;

cp gitignore.sh /usr/bin/gitignore;
chmod a+x /usr/bin/gitignore;
