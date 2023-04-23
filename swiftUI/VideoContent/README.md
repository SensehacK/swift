# VideoContent App



## Video Kit




## Framework

Scheme: VideoStreamingKit


### XCFramework Commands

```bash
xcodebuild archive \
-scheme VideoStreamingKit \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath './build/VideoStreamingKit.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES


xcodebuild archive \
-scheme VideoStreamingKit \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath './build/VideoStreamingKit.framework-iphonesimulator.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES


xcodebuild archive \
-scheme VideoStreamingKit \
-configuration Release \
-destination 'platform=macOS,arch=x86_64,variant=Mac Catalyst' \
-archivePath './build/VideoStreamingKit.framework-catalyst.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES


xcodebuild -create-xcframework \
-framework './build/VideoStreamingKit.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/VideoStreamingKit.framework' \
-framework './build/VideoStreamingKit.framework-iphoneos.xcarchive/Products/Library/Frameworks/VideoStreamingKit.framework' \
-framework './build/VideoStreamingKit.framework-catalyst.xcarchive/Products/Library/Frameworks/VideoStreamingKit.framework' \
-output './build/VideoStreamingKit.xcframework'

```