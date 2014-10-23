#!/bin/bash -e
#
# Purpose: Pack extensions for Chrome and Firefox
#

# gsed increment build revision
fver="version.txt"
orig_version=$(head -n 1 "$fver")
(gsed -r -i"" 's/^([0-9]+\.[0-9]\.)([0-9]+)/echo \1$((\2+1))/e' "$fver")
new_version=$(head -n 1 "$fver")

# bump Chrome update_manifest.xml
sed_update_manifest="s/\.crx\" version=\".*\\?\"/\.crx\" version=\"$new_version\"/"
(gsed -i"" "$sed_update_manifest" "extension/chrome/update_manifest.xml")

# bump Chrome manifest.json
sed_src_manifest="s/\"version\": \".*\\?\"/\"version\": \"$new_version\"/"
(gsed -i"" "$sed_src_manifest" "extension/chrome/src/manifest.json")
echo "Updated version in Chrome manifest.json & update_manifest.xml"

# Generate Chrome extension with crxmake.sh
sh crxmake.sh extension/chrome/src extension/chrome/install/user-support-addon.pem extension/chrome/install/user-support-addon.crx

echo "========="
echo "Done, we are now on version "$new_version" :)"
echo "========="
