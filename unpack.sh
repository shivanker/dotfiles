#! /bin/sh

# No need for .git in homedir
mv .git .git.orig

# 'Unpack' all git sub-repos
find . -name '.git.orig' -exec bash -c 'mv $0 ${0/.git.orig/.git}' {} \;
