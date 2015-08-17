#!/usr/bin/env bash
set -e

BASEDIR=$(dirname $0)
# base system settings
$BASEDIR/settings.sh

# install base packages
$BASEDIR/homebrew_install.sh

# install mjolnir lua libs
$BASEDIR/mjolnir_support.sh
