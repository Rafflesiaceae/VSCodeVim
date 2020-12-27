#!/bin/bash
set -eo pipefail

# build
npm i
npx vsce package

# install
unset -v vsix
for file in ./*.vsix; do
  [[ $file -nt $vsix ]] && vsix=$file
done

[[ ! -f "$vsix" ]] && { printf "error: vsix-file does not exist \"%s\"\n" "$vsix" >&2; exit 1; }
code "--install-extension" "$vsix"
