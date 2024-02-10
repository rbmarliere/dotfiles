#!/bin/bash

set -euo pipefail

packages=$(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' -printf '%P\n')
stow -Dv $packages
