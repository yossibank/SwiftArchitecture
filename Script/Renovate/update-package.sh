xcodebuild -resolvePackageDependencies -workspace SwiftArchitecture.xcworkspace -scheme Debug

cd BuildTools
xcodebuild -resolvePackageDependencies

xcrun --sdk macosx swift build -c release

xcrun --sdk macosx swift build -c release \
    --package-path .build/checkouts/LicensePlist \
    --product license-plist

.build/checkouts/LicensePlist/.build/release/license-plist \
    --package-path Package.resolved \
    --package-path ../SwiftArchitecture.xcworkspace/xcshareddata/swiftpm/Package.resolved \
    --output-path ../SwiftArchitecture/Sources/Settings.bundle

cd ../Macros/CodingKeys
xcodebuild -resolvePackageDependencies

cd ../StructBuilder
xcodebuild -resolvePackageDependencies