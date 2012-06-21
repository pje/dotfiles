#!/usr/bin/env bash
set -e

[ -d /Applications/Sublime Text 2.app ] && (which subl || ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
