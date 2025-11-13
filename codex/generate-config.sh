#!/usr/bin/env bash
# Generate ~/.codex/config.toml from template with actual secrets
# This script sources shell secrets and substitutes them into the template

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_FILE="$SCRIPT_DIR/dot-codex/config.toml.template"
OUTPUT_FILE="$HOME/.codex/config.toml"
SECRETS_FILE="$HOME/.bashrc.d/99-secrets.bash"

# Check if template exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Template file not found: $TEMPLATE_FILE"
    exit 1
fi

# Check if secrets file exists
if [ ! -f "$SECRETS_FILE" ]; then
    echo "Warning: Secrets file not found: $SECRETS_FILE"
    echo "Creating config from template without substitution..."
    cp "$TEMPLATE_FILE" "$OUTPUT_FILE"
    echo "  Please edit $OUTPUT_FILE and replace REPLACE_WITH_YOUR_* placeholders"
    exit 0
fi

# Source the secrets file
source "$SECRETS_FILE"

# Create output directory if it doesn't exist
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Copy template and perform substitutions
cp "$TEMPLATE_FILE" "$OUTPUT_FILE"

# Substitute environment variables
if [ -n "$GITHUB_TOKEN" ]; then
    sed -i.bak "s|REPLACE_WITH_YOUR_GITHUB_TOKEN|$GITHUB_TOKEN|g" "$OUTPUT_FILE"
fi

if [ -n "$GITHUB_PERSONAL_ACCESS_TOKEN" ]; then
    sed -i.bak "s|REPLACE_WITH_YOUR_GITHUB_TOKEN|$GITHUB_PERSONAL_ACCESS_TOKEN|g" "$OUTPUT_FILE"
fi

if [ -n "$OBSIDIAN_API_KEY" ]; then
    sed -i.bak "s|REPLACE_WITH_YOUR_OBSIDIAN_API_KEY|$OBSIDIAN_API_KEY|g" "$OUTPUT_FILE"
fi

if [ -n "$ALM_URL" ]; then
    sed -i.bak "s|REPLACE_WITH_ALM_URL|$ALM_URL|g" "$OUTPUT_FILE"
fi

if [ -n "$ALM_USERNAME" ]; then
    sed -i.bak "s|REPLACE_WITH_USERNAME|$ALM_USERNAME|g" "$OUTPUT_FILE"
fi

if [ -n "$ALM_PASSWORD" ]; then
    sed -i.bak "s|REPLACE_WITH_PASSWORD|$ALM_PASSWORD|g" "$OUTPUT_FILE"
fi

if [ -n "$SONARQUBE_TOKEN" ]; then
    sed -i.bak "s|REPLACE_WITH_YOUR_TOKEN|$SONARQUBE_TOKEN|g" "$OUTPUT_FILE"
fi

if [ -n "$SONARQUBE_ORG" ]; then
    sed -i.bak "s|REPLACE_WITH_YOUR_ORG|$SONARQUBE_ORG|g" "$OUTPUT_FILE"
fi

# Remove backup file
rm -f "$OUTPUT_FILE.bak"

echo "✓ Generated $OUTPUT_FILE with secrets from $SECRETS_FILE"
