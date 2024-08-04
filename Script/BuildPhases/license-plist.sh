cd ../BuildTools

xcrun --sdk macosx swift build -c release \
    --package-path .build/checkouts/LicensePlist \
    --product license-plist

.build/checkouts/LicensePlist/.build/release/license-plist \
    --package-path Package.resolved \
    --package-path ../MultiModuleTemplate.xcworkspace/xcshareddata/swiftpm/Package.resolved \
    --output-path ../MultiModuleTemplate/Sources/Settings.bundle
