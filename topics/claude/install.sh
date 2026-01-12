#!/usr/bin/env bash
set -e
cd "$(dirname $0)"
mkdir -p ~/.claude
ln -fs "$(pwd)/CLAUDE.md" ~/.claude/CLAUDE.md
