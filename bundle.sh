#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

# Set variables
BUNDLE_NAME="Sinhala-Wije.bundle"
RESOURCE_DIR="$BUNDLE_NAME/Contents/Resources"
ICNS_FILE="sinhala-wije.icns" # Your icon file

# Clean up if previous build exists
rm -rf "$BUNDLE_NAME"
rm -f Sinhala-Wije-Keyboard.zip INSTALL.txt

# Create the bundle directory structure
mkdir -p "$RESOURCE_DIR"

# Create Info.plist
cat > "$BUNDLE_NAME/Contents/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key>
    <string>org.sls.keylayout.sinhala-wije</string>
    <key>CFBundleName</key>
    <string>Sinhala Wijesekara Keyboard</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleIconFile</key>
    <string>sinhala-wije.icns</string> <!-- linking the icon -->
</dict>
</plist>
EOF

# Create dummy layout (so file exists)
cat > "$RESOURCE_DIR/sinhala-wije.keylayout" << EOF
<?xml version="1.1" encoding="UTF-8"?>
<!DOCTYPE keyboard SYSTEM "file://localhost/System/Library/DTDs/KeyboardLayout.dtd">
<!-- Dummy content -->
EOF

# Overwrite keylayout with actual file
if [ -f "sinhala-wije.keylayout" ]; then
    cp "sinhala-wije.keylayout" "$RESOURCE_DIR/sinhala-wije.keylayout"
else
    echo "❌ Error: 'sinhala-wije.keylayout' not found!"
    exit 1
fi

# Copy icns file (strict)
if [ -f "$ICNS_FILE" ]; then
    cp "$ICNS_FILE" "$RESOURCE_DIR/"
    echo "✅ Icon '$ICNS_FILE' copied."
else
    echo "❌ Error: Icon file '$ICNS_FILE' not found!"
    exit 1
fi

# Create INSTALL.txt
cat > "INSTALL.txt" << 'EOF'
Installation Instructions:

1. Copy the Sinhala-Wije.bundle to either:
   - ~/Library/Keyboard Layouts/ (for current user only)
   - /Library/Keyboard Layouts/ (for all users, requires admin privileges)

2. Log out and log back in

3. Enable the keyboard layout:
   - Open System Settings
   - Go to Keyboard settings
   - Click on "Input Sources"
   - Click the + button
   - Look for "Sinhala Wije" under the input sources
   - Select and add it

The keyboard layout should now be available for use!
EOF

# Create a zip
zip -r Sinhala-Wije-Keyboard.zip "$BUNDLE_NAME" INSTALL.txt

# Cleanup
rm -rf "$BUNDLE_NAME" INSTALL.txt

echo "🎉 Installation package created: Sinhala-Wije-Keyboard.zip"
