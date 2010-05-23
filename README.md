
Introduction
------------

This is a collection of all my dotfiles which I share between my hosts.
Bash configuration files, git config, ssh public keys. Did I forget
something?


Bash
----

Because there are scripts which I want to use on some hosts but not on
others, the files are split up into standalone modules. The idea is to
be able to selectively load the modules from the top-level configuration
file.

There are two categories: files for non-interactive shells (profile) and
files for interactive shells (interactive). Load whichever is appropriate,
for example like this (in your .profile):

    for m in 00-setup 01-path 10-rvm; do
      . "~/.share.d/bash/profile/$m"
    done
