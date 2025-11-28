#!/bin/bash

# Show everything that executes in this script
set -x

# rm & tee need this on first run
mkdir --parents output

# Cleanup previous output
/bin/rm --preserve-root=all --recursive --force -- output/*

# Do the thing
strictdoc --debug export --config=strictdoc.toml --formats=html --output-dir=output/ . | tee output/strictdoc.log
