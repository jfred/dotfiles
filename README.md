My way or some other one
========================

After clone run:

    ./install.sh

OSX Specifics
-------------

1. install XCode
2. install homebrew

    /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

3. install zsh, git, python, ruby, etc via brew

    ./extras/osx.sh

Other
-----

SSH - enable connection sharing - in ~/.ssh/config add

    ControlMaster auto
    ControlPath /tmp/ssh_%h_%p_%r
