#!/bin/bash
set -e

# Publish script for @pixelmeet/types
# Usage: ./publish.sh [version-type]
# Example: ./publish.sh patch
# Example: ./publish.sh minor
# Example: ./publish.sh major

VERSION_TYPE=${1:-patch}

if [[ ! "$VERSION_TYPE" =~ ^(patch|minor|major)$ ]]; then
  echo "Error: Invalid version type. Must be one of: patch, minor, major"
  echo "Usage: $0 [patch|minor|major]"
  exit 1
fi

echo "📦 Publishing @pixelmeet/types"
echo ""

# Get current version
CURRENT_VERSION=$(node -p "require('./package.json').version")
echo "Current version: $CURRENT_VERSION"

# Clean and build
echo "Cleaning dist folder..."
npm run clean

echo "Building package..."
npm run build

# Bump version
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

case $VERSION_TYPE in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
echo "New version: $NEW_VERSION"

# Update package.json version
node -e "
const fs = require('fs');
const pkg = require('./package.json');
pkg.version = '$NEW_VERSION';
fs.writeFileSync('./package.json', JSON.stringify(pkg, null, 2) + '\n');
"

# Commit version bump
git add package.json
git commit -m "chore(release): @pixelmeet/types@$NEW_VERSION"
git tag "v$NEW_VERSION"

# Publish to npm
echo "Publishing to npm..."
npm publish

# Push changes and tags
git push origin main
git push origin "v$NEW_VERSION"

echo ""
echo "✨ Successfully published @pixelmeet/types@$NEW_VERSION"
echo ""
echo "Next steps:"
echo "1. Update the main repo submodule reference:"
echo "   cd ../../.. && git submodule update --remote libs/shared/types"
echo "   git add libs/shared/types && git commit -m 'chore: update types to v$NEW_VERSION'"
echo ""
