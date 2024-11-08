#!/bin/bash
set -eo pipefail

sudo dnf install -y \
    openscad \
    clang-tools-extra # for formatting with the vscode extension

cargo binstall -y openscad-lsp # for helix
