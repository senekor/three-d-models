#!/bin/bash
set -eo pipefail

sudo dnf install -y openscad

cargo binstall -y openscad-lsp
