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

Disabling 'Topics'
------------------

If you want to disable any 'topics' set DOT\_EXCLUDE to match the topic names.

The following example would disable java and vagrant:

    DOT_EXCLUDE='(java|vagrant)'

OSX Specifics
-------------

1. [install homebrew](https://docs.brew.sh/Installation)
2. set shell

    echo /usr/local/bin/zsh | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh 

Other
-----

SSH - enable connection sharing - in ~/.ssh/config add

    ControlMaster auto
    ControlPath /tmp/ssh_%h_%p_%r

Notes
-----

Most customizations should happen in a system specific version of `~/.localrc`.
These vars/commands/etc will be included prior to the majority of ZSH commands.
In the case where you need to execute something after the rest of ZSH initialization
you can set a `DOTFILES_POST_INIT` variable in '~/.localrc'. This is a horrible
hack and probably a security concern, but hey you are basing your dotfiles off
mine so stop complaining.