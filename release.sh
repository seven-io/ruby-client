#!/bin/sh

gem build --strict

gem push "$(find . -name "*.gem" -print0 | xargs -r -0 ls -1 -t | head -1)"