#!/usr/bin/env bash -e

make homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" # Make the `brew` command available for subsequent `make` recipes
make all
