#!/usr/bin/env bash
set -e

# Activate virtualenv if needed
if [ -d "venv" ]; then
  source venv/bin/activate
fi

echo "🚀 Running full UI regression suite..."
robot \
  --include regression \
  -d reports/ui/regression \
  tests/ui/saucedemo

echo "✅ Regression run complete. Reports in: reports/ui/regression"