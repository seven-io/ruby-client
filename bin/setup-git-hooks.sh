#!/bin/sh
set -e

# Configure the repository to use hooks from .githooks
git config core.hooksPath .githooks

# Ensure pre-commit hook is executable
if [ -f ".githooks/pre-commit" ]; then
  chmod +x .githooks/pre-commit
fi

echo "Git hooks enabled (core.hooksPath set to .githooks)."
