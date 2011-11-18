My way or some other one
========================

We all owe to everyone before us and the current incarnation of this owes most
to [@holman's dotfiles](https://github.com/holman/dotfiles)

His are organized better, and I should have probably just forked his, but I
already had this repo on a bunch of machines and it's easier to just pull install.

Also I'm not a fan of projects where the top level contains a ton of folders.

Install
-------

After clone run:

    ./install.sh

You can allso call `./install.sh` with `-i` (or `--interactive`) to confirm
each step of the install process.

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

