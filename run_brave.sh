#!/bin/bash
# Set CHROME_EXECUTABLE environment variable to point to Brave Browser on macOS
export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

# Run the Flutter application on Chrome target (which will now open Brave)
flutter run -d chrome
