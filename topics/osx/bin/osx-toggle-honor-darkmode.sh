#!/usr/bin/env bash

APP=${1}
CMD="id of app \"${APP}\""
APP_ID=$(echo ${CMD} | osascript 2>/dev/null)
if [[ ! -n "${APP_ID}" ]]; then
    echo Error: Unable to find id for app ${APP} 1>&2
    exit 1
fi

echo Found app id: ${APP_ID}

if [[ $(defaults read ${APP_ID} NSRequiresAquaSystemAppearance 2>/dev/null) -eq 1 ]]; then
    echo "Enabling honoring darkmode"
    defaults delete ${APP_ID} NSRequiresAquaSystemAppearance
else
    echo "Disabling honoring darkmode"
    defaults write ${APP_ID} NSRequiresAquaSystemAppearance -bool Yes
fi

echo Updated ${APP_ID}, restart the app.
