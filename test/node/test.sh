#!/usr/bin/env bash

source dev-container-features-test-lib

check "node symlink" test -L /usr/local/bin/node
check "npm symlink" test -L /usr/local/bin/npm
check "node executable" test -x /usr/local/bin/node

NODE_BIN=$(readlink -f /usr/local/bin/node)
check "node resolves" test -x "$NODE_BIN"
check "node mode 755" [ "$(stat -c %a "$NODE_BIN")" = "755" ]
check "node under nvm" bash -c "case \"$NODE_BIN\" in /usr/local/share/nvm/versions/node/*) ;; *) exit 1 ;; esac"
check "node runs" node --version
check "npm runs" npm --version

reportResults