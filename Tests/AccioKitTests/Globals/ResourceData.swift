import Foundation

enum ResourceData {
    static let iOSProjectFileContents: String = """
        // !$*UTF8*$!
        {
            archiveVersion = 1;
            classes = {
            };
            objectVersion = 50;
            objects = {

        /* Begin PBXBuildFile section */
                82E095BF222FCCA1006C0DC0 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E095BE222FCCA1006C0DC0 /* AppDelegate.swift */; };
                82E095C1222FCCA1006C0DC0 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E095C0222FCCA1006C0DC0 /* ViewController.swift */; };
                82E095C4222FCCA1006C0DC0 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 82E095C2222FCCA1006C0DC0 /* Main.storyboard */; };
                82E095C6222FCCA3006C0DC0 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 82E095C5222FCCA3006C0DC0 /* Assets.xcassets */; };
                82E095C9222FCCA3006C0DC0 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 82E095C7222FCCA3006C0DC0 /* LaunchScreen.storyboard */; };
                82E095D4222FCCA3006C0DC0 /* TestProject_iOSTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E095D3222FCCA3006C0DC0 /* TestProject_iOSTests.swift */; };
                82E095DF222FCCA3006C0DC0 /* TestProject_iOSUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E095DE222FCCA3006C0DC0 /* TestProject_iOSUITests.swift */; };
        /* End PBXBuildFile section */

        /* Begin PBXContainerItemProxy section */
                82E095D0222FCCA3006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E095B3222FCCA1006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E095BA222FCCA1006C0DC0;
                    remoteInfo = "TestProject-iOS";
                };
                82E095DB222FCCA3006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E095B3222FCCA1006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E095BA222FCCA1006C0DC0;
                    remoteInfo = "TestProject-iOS";
                };
        /* End PBXContainerItemProxy section */

        /* Begin PBXFileReference section */
                82E095BB222FCCA1006C0DC0 /* TestProject-iOS.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "TestProject-iOS.app"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E095BE222FCCA1006C0DC0 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
                82E095C0222FCCA1006C0DC0 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
                82E095C3222FCCA1006C0DC0 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
                82E095C5222FCCA3006C0DC0 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
                82E095C8222FCCA3006C0DC0 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "<group>"; };
                82E095CA222FCCA3006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E095CF222FCCA3006C0DC0 /* TestProject-iOSTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "TestProject-iOSTests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E095D3222FCCA3006C0DC0 /* TestProject_iOSTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TestProject_iOSTests.swift; sourceTree = "<group>"; };
                82E095D5222FCCA3006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E095DA222FCCA3006C0DC0 /* TestProject-iOSUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "TestProject-iOSUITests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E095DE222FCCA3006C0DC0 /* TestProject_iOSUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TestProject_iOSUITests.swift; sourceTree = "<group>"; };
                82E095E0222FCCA3006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
        /* End PBXFileReference section */

        /* Begin PBXFrameworksBuildPhase section */
                82E095B8222FCCA1006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E095CC222FCCA3006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E095D7222FCCA3006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXFrameworksBuildPhase section */

        /* Begin PBXGroup section */
                82E095B2222FCCA1006C0DC0 = {
                    isa = PBXGroup;
                    children = (
                        82E095BD222FCCA1006C0DC0 /* TestProject-iOS */,
                        82E095D2222FCCA3006C0DC0 /* TestProject-iOSTests */,
                        82E095DD222FCCA3006C0DC0 /* TestProject-iOSUITests */,
                        82E095BC222FCCA1006C0DC0 /* Products */,
                    );
                    sourceTree = "<group>";
                };
                82E095BC222FCCA1006C0DC0 /* Products */ = {
                    isa = PBXGroup;
                    children = (
                        82E095BB222FCCA1006C0DC0 /* TestProject-iOS.app */,
                        82E095CF222FCCA3006C0DC0 /* TestProject-iOSTests.xctest */,
                        82E095DA222FCCA3006C0DC0 /* TestProject-iOSUITests.xctest */,
                    );
                    name = Products;
                    sourceTree = "<group>";
                };
                82E095BD222FCCA1006C0DC0 /* TestProject-iOS */ = {
                    isa = PBXGroup;
                    children = (
                        82E095BE222FCCA1006C0DC0 /* AppDelegate.swift */,
                        82E095C0222FCCA1006C0DC0 /* ViewController.swift */,
                        82E095C2222FCCA1006C0DC0 /* Main.storyboard */,
                        82E095C5222FCCA3006C0DC0 /* Assets.xcassets */,
                        82E095C7222FCCA3006C0DC0 /* LaunchScreen.storyboard */,
                        82E095CA222FCCA3006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-iOS";
                    sourceTree = "<group>";
                };
                82E095D2222FCCA3006C0DC0 /* TestProject-iOSTests */ = {
                    isa = PBXGroup;
                    children = (
                        82E095D3222FCCA3006C0DC0 /* TestProject_iOSTests.swift */,
                        82E095D5222FCCA3006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-iOSTests";
                    sourceTree = "<group>";
                };
                82E095DD222FCCA3006C0DC0 /* TestProject-iOSUITests */ = {
                    isa = PBXGroup;
                    children = (
                        82E095DE222FCCA3006C0DC0 /* TestProject_iOSUITests.swift */,
                        82E095E0222FCCA3006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-iOSUITests";
                    sourceTree = "<group>";
                };
        /* End PBXGroup section */

        /* Begin PBXNativeTarget section */
                82E095BA222FCCA1006C0DC0 /* TestProject-iOS */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E095E3222FCCA3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-iOS" */;
                    buildPhases = (
                        82E095B7222FCCA1006C0DC0 /* Sources */,
                        82E095B8222FCCA1006C0DC0 /* Frameworks */,
                        82E095B9222FCCA1006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                    );
                    name = "TestProject-iOS";
                    productName = "TestProject-iOS";
                    productReference = 82E095BB222FCCA1006C0DC0 /* TestProject-iOS.app */;
                    productType = "com.apple.product-type.application";
                };
                82E095CE222FCCA3006C0DC0 /* TestProject-iOSTests */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E095E6222FCCA3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-iOSTests" */;
                    buildPhases = (
                        82E095CB222FCCA3006C0DC0 /* Sources */,
                        82E095CC222FCCA3006C0DC0 /* Frameworks */,
                        82E095CD222FCCA3006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E095D1222FCCA3006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-iOSTests";
                    productName = "TestProject-iOSTests";
                    productReference = 82E095CF222FCCA3006C0DC0 /* TestProject-iOSTests.xctest */;
                    productType = "com.apple.product-type.bundle.unit-test";
                };
                82E095D9222FCCA3006C0DC0 /* TestProject-iOSUITests */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E095E9222FCCA3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-iOSUITests" */;
                    buildPhases = (
                        82E095D6222FCCA3006C0DC0 /* Sources */,
                        82E095D7222FCCA3006C0DC0 /* Frameworks */,
                        82E095D8222FCCA3006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E095DC222FCCA3006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-iOSUITests";
                    productName = "TestProject-iOSUITests";
                    productReference = 82E095DA222FCCA3006C0DC0 /* TestProject-iOSUITests.xctest */;
                    productType = "com.apple.product-type.bundle.ui-testing";
                };
        /* End PBXNativeTarget section */

        /* Begin PBXProject section */
                82E095B3222FCCA1006C0DC0 /* Project object */ = {
                    isa = PBXProject;
                    attributes = {
                        LastSwiftUpdateCheck = 1010;
                        LastUpgradeCheck = 1010;
                        ORGANIZATIONNAME = "Jamit Labs GmbH";
                        TargetAttributes = {
                            82E095BA222FCCA1006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                            };
                            82E095CE222FCCA3006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                                TestTargetID = 82E095BA222FCCA1006C0DC0;
                            };
                            82E095D9222FCCA3006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                                TestTargetID = 82E095BA222FCCA1006C0DC0;
                            };
                        };
                    };
                    buildConfigurationList = 82E095B6222FCCA1006C0DC0 /* Build configuration list for PBXProject "TestProject-iOS" */;
                    compatibilityVersion = "Xcode 9.3";
                    developmentRegion = en;
                    hasScannedForEncodings = 0;
                    knownRegions = (
                        en,
                        Base,
                    );
                    mainGroup = 82E095B2222FCCA1006C0DC0;
                    productRefGroup = 82E095BC222FCCA1006C0DC0 /* Products */;
                    projectDirPath = "";
                    projectRoot = "";
                    targets = (
                        82E095BA222FCCA1006C0DC0 /* TestProject-iOS */,
                        82E095CE222FCCA3006C0DC0 /* TestProject-iOSTests */,
                        82E095D9222FCCA3006C0DC0 /* TestProject-iOSUITests */,
                    );
                };
        /* End PBXProject section */

        /* Begin PBXResourcesBuildPhase section */
                82E095B9222FCCA1006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E095C9222FCCA3006C0DC0 /* LaunchScreen.storyboard in Resources */,
                        82E095C6222FCCA3006C0DC0 /* Assets.xcassets in Resources */,
                        82E095C4222FCCA1006C0DC0 /* Main.storyboard in Resources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E095CD222FCCA3006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E095D8222FCCA3006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXResourcesBuildPhase section */

        /* Begin PBXSourcesBuildPhase section */
                82E095B7222FCCA1006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E095C1222FCCA1006C0DC0 /* ViewController.swift in Sources */,
                        82E095BF222FCCA1006C0DC0 /* AppDelegate.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E095CB222FCCA3006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E095D4222FCCA3006C0DC0 /* TestProject_iOSTests.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E095D6222FCCA3006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E095DF222FCCA3006C0DC0 /* TestProject_iOSUITests.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXSourcesBuildPhase section */

        /* Begin PBXTargetDependency section */
                82E095D1222FCCA3006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E095BA222FCCA1006C0DC0 /* TestProject-iOS */;
                    targetProxy = 82E095D0222FCCA3006C0DC0 /* PBXContainerItemProxy */;
                };
                82E095DC222FCCA3006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E095BA222FCCA1006C0DC0 /* TestProject-iOS */;
                    targetProxy = 82E095DB222FCCA3006C0DC0 /* PBXContainerItemProxy */;
                };
        /* End PBXTargetDependency section */

        /* Begin PBXVariantGroup section */
                82E095C2222FCCA1006C0DC0 /* Main.storyboard */ = {
                    isa = PBXVariantGroup;
                    children = (
                        82E095C3222FCCA1006C0DC0 /* Base */,
                    );
                    name = Main.storyboard;
                    sourceTree = "<group>";
                };
                82E095C7222FCCA3006C0DC0 /* LaunchScreen.storyboard */ = {
                    isa = PBXVariantGroup;
                    children = (
                        82E095C8222FCCA3006C0DC0 /* Base */,
                    );
                    name = LaunchScreen.storyboard;
                    sourceTree = "<group>";
                };
        /* End PBXVariantGroup section */

        /* Begin XCBuildConfiguration section */
                82E095E1222FCCA3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_SEARCH_USER_PATHS = NO;
                        CLANG_ANALYZER_NONNULL = YES;
                        CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                        CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
                        CLANG_CXX_LIBRARY = "libc++";
                        CLANG_ENABLE_MODULES = YES;
                        CLANG_ENABLE_OBJC_ARC = YES;
                        CLANG_ENABLE_OBJC_WEAK = YES;
                        CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                        CLANG_WARN_BOOL_CONVERSION = YES;
                        CLANG_WARN_COMMA = YES;
                        CLANG_WARN_CONSTANT_CONVERSION = YES;
                        CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                        CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                        CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                        CLANG_WARN_EMPTY_BODY = YES;
                        CLANG_WARN_ENUM_CONVERSION = YES;
                        CLANG_WARN_INFINITE_RECURSION = YES;
                        CLANG_WARN_INT_CONVERSION = YES;
                        CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                        CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                        CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                        CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                        CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                        CLANG_WARN_STRICT_PROTOTYPES = YES;
                        CLANG_WARN_SUSPICIOUS_MOVE = YES;
                        CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                        CLANG_WARN_UNREACHABLE_CODE = YES;
                        CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                        CODE_SIGN_IDENTITY = "iPhone Developer";
                        COPY_PHASE_STRIP = NO;
                        DEBUG_INFORMATION_FORMAT = dwarf;
                        ENABLE_STRICT_OBJC_MSGSEND = YES;
                        ENABLE_TESTABILITY = YES;
                        GCC_C_LANGUAGE_STANDARD = gnu11;
                        GCC_DYNAMIC_NO_PIC = NO;
                        GCC_NO_COMMON_BLOCKS = YES;
                        GCC_OPTIMIZATION_LEVEL = 0;
                        GCC_PREPROCESSOR_DEFINITIONS = (
                            "DEBUG=1",
                            "$(inherited)",
                        );
                        GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                        GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                        GCC_WARN_UNDECLARED_SELECTOR = YES;
                        GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                        GCC_WARN_UNUSED_FUNCTION = YES;
                        GCC_WARN_UNUSED_VARIABLE = YES;
                        IPHONEOS_DEPLOYMENT_TARGET = 12.1;
                        MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                        MTL_FAST_MATH = YES;
                        ONLY_ACTIVE_ARCH = YES;
                        SDKROOT = iphoneos;
                        SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                        SWIFT_OPTIMIZATION_LEVEL = "-Onone";
                    };
                    name = Debug;
                };
                82E095E2222FCCA3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_SEARCH_USER_PATHS = NO;
                        CLANG_ANALYZER_NONNULL = YES;
                        CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                        CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
                        CLANG_CXX_LIBRARY = "libc++";
                        CLANG_ENABLE_MODULES = YES;
                        CLANG_ENABLE_OBJC_ARC = YES;
                        CLANG_ENABLE_OBJC_WEAK = YES;
                        CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                        CLANG_WARN_BOOL_CONVERSION = YES;
                        CLANG_WARN_COMMA = YES;
                        CLANG_WARN_CONSTANT_CONVERSION = YES;
                        CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                        CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                        CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                        CLANG_WARN_EMPTY_BODY = YES;
                        CLANG_WARN_ENUM_CONVERSION = YES;
                        CLANG_WARN_INFINITE_RECURSION = YES;
                        CLANG_WARN_INT_CONVERSION = YES;
                        CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                        CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                        CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                        CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                        CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                        CLANG_WARN_STRICT_PROTOTYPES = YES;
                        CLANG_WARN_SUSPICIOUS_MOVE = YES;
                        CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                        CLANG_WARN_UNREACHABLE_CODE = YES;
                        CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                        CODE_SIGN_IDENTITY = "iPhone Developer";
                        COPY_PHASE_STRIP = NO;
                        DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                        ENABLE_NS_ASSERTIONS = NO;
                        ENABLE_STRICT_OBJC_MSGSEND = YES;
                        GCC_C_LANGUAGE_STANDARD = gnu11;
                        GCC_NO_COMMON_BLOCKS = YES;
                        GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                        GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                        GCC_WARN_UNDECLARED_SELECTOR = YES;
                        GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                        GCC_WARN_UNUSED_FUNCTION = YES;
                        GCC_WARN_UNUSED_VARIABLE = YES;
                        IPHONEOS_DEPLOYMENT_TARGET = 12.1;
                        MTL_ENABLE_DEBUG_INFO = NO;
                        MTL_FAST_MATH = YES;
                        SDKROOT = iphoneos;
                        SWIFT_COMPILATION_MODE = wholemodule;
                        SWIFT_OPTIMIZATION_LEVEL = "-O";
                        VALIDATE_PRODUCT = YES;
                    };
                    name = Release;
                };
                82E095E4222FCCA3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-iOS/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-iOS";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                    };
                    name = Debug;
                };
                82E095E5222FCCA3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-iOS/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-iOS";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                    };
                    name = Release;
                };
                82E095E7222FCCA3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        BUNDLE_LOADER = "$(TEST_HOST)";
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-iOSTests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-iOSTests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                        TEST_HOST = "$(BUILT_PRODUCTS_DIR)/TestProject-iOS.app/TestProject-iOS";
                    };
                    name = Debug;
                };
                82E095E8222FCCA3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        BUNDLE_LOADER = "$(TEST_HOST)";
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-iOSTests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-iOSTests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                        TEST_HOST = "$(BUILT_PRODUCTS_DIR)/TestProject-iOS.app/TestProject-iOS";
                    };
                    name = Release;
                };
                82E095EA222FCCA3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-iOSUITests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-iOSUITests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                        TEST_TARGET_NAME = "TestProject-iOS";
                    };
                    name = Debug;
                };
                82E095EB222FCCA3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-iOSUITests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-iOSUITests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                        TEST_TARGET_NAME = "TestProject-iOS";
                    };
                    name = Release;
                };
        /* End XCBuildConfiguration section */

        /* Begin XCConfigurationList section */
                82E095B6222FCCA1006C0DC0 /* Build configuration list for PBXProject "TestProject-iOS" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E095E1222FCCA3006C0DC0 /* Debug */,
                        82E095E2222FCCA3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E095E3222FCCA3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-iOS" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E095E4222FCCA3006C0DC0 /* Debug */,
                        82E095E5222FCCA3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E095E6222FCCA3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-iOSTests" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E095E7222FCCA3006C0DC0 /* Debug */,
                        82E095E8222FCCA3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E095E9222FCCA3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-iOSUITests" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E095EA222FCCA3006C0DC0 /* Debug */,
                        82E095EB222FCCA3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
        /* End XCConfigurationList section */
            };
            rootObject = 82E095B3222FCCA1006C0DC0 /* Project object */;
        }

        """

    static let macOSProjectFileContents: String = """
        // !$*UTF8*$!
        {
            archiveVersion = 1;
            classes = {
            };
            objectVersion = 50;
            objects = {

        /* Begin PBXBuildFile section */
                82E09692222FCCE3006C0DC0 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E09691222FCCE3006C0DC0 /* AppDelegate.swift */; };
                82E09694222FCCE3006C0DC0 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E09693222FCCE3006C0DC0 /* ViewController.swift */; };
                82E09696222FCCE3006C0DC0 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 82E09695222FCCE3006C0DC0 /* Assets.xcassets */; };
                82E09699222FCCE3006C0DC0 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 82E09697222FCCE3006C0DC0 /* Main.storyboard */; };
                82E096A5222FCCE3006C0DC0 /* TestProject_macOSTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E096A4222FCCE3006C0DC0 /* TestProject_macOSTests.swift */; };
                82E096B0222FCCE3006C0DC0 /* TestProject_macOSUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E096AF222FCCE3006C0DC0 /* TestProject_macOSUITests.swift */; };
        /* End PBXBuildFile section */

        /* Begin PBXContainerItemProxy section */
                82E096A1222FCCE3006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E09686222FCCE3006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E0968D222FCCE3006C0DC0;
                    remoteInfo = "TestProject-macOS";
                };
                82E096AC222FCCE3006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E09686222FCCE3006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E0968D222FCCE3006C0DC0;
                    remoteInfo = "TestProject-macOS";
                };
        /* End PBXContainerItemProxy section */

        /* Begin PBXFileReference section */
                82E0968E222FCCE3006C0DC0 /* TestProject-macOS.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "TestProject-macOS.app"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E09691222FCCE3006C0DC0 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
                82E09693222FCCE3006C0DC0 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
                82E09695222FCCE3006C0DC0 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
                82E09698222FCCE3006C0DC0 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
                82E0969A222FCCE3006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E0969B222FCCE3006C0DC0 /* TestProject_macOS.entitlements */ = {isa = PBXFileReference; lastKnownFileType = text.plist.entitlements; path = TestProject_macOS.entitlements; sourceTree = "<group>"; };
                82E096A0222FCCE3006C0DC0 /* TestProject-macOSTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "TestProject-macOSTests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E096A4222FCCE3006C0DC0 /* TestProject_macOSTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TestProject_macOSTests.swift; sourceTree = "<group>"; };
                82E096A6222FCCE3006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E096AB222FCCE3006C0DC0 /* TestProject-macOSUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "TestProject-macOSUITests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E096AF222FCCE3006C0DC0 /* TestProject_macOSUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TestProject_macOSUITests.swift; sourceTree = "<group>"; };
                82E096B1222FCCE3006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
        /* End PBXFileReference section */

        /* Begin PBXFrameworksBuildPhase section */
                82E0968B222FCCE3006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E0969D222FCCE3006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E096A8222FCCE3006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXFrameworksBuildPhase section */

        /* Begin PBXGroup section */
                82E09685222FCCE3006C0DC0 = {
                    isa = PBXGroup;
                    children = (
                        82E09690222FCCE3006C0DC0 /* TestProject-macOS */,
                        82E096A3222FCCE3006C0DC0 /* TestProject-macOSTests */,
                        82E096AE222FCCE3006C0DC0 /* TestProject-macOSUITests */,
                        82E0968F222FCCE3006C0DC0 /* Products */,
                    );
                    sourceTree = "<group>";
                };
                82E0968F222FCCE3006C0DC0 /* Products */ = {
                    isa = PBXGroup;
                    children = (
                        82E0968E222FCCE3006C0DC0 /* TestProject-macOS.app */,
                        82E096A0222FCCE3006C0DC0 /* TestProject-macOSTests.xctest */,
                        82E096AB222FCCE3006C0DC0 /* TestProject-macOSUITests.xctest */,
                    );
                    name = Products;
                    sourceTree = "<group>";
                };
                82E09690222FCCE3006C0DC0 /* TestProject-macOS */ = {
                    isa = PBXGroup;
                    children = (
                        82E09691222FCCE3006C0DC0 /* AppDelegate.swift */,
                        82E09693222FCCE3006C0DC0 /* ViewController.swift */,
                        82E09695222FCCE3006C0DC0 /* Assets.xcassets */,
                        82E09697222FCCE3006C0DC0 /* Main.storyboard */,
                        82E0969A222FCCE3006C0DC0 /* Info.plist */,
                        82E0969B222FCCE3006C0DC0 /* TestProject_macOS.entitlements */,
                    );
                    path = "TestProject-macOS";
                    sourceTree = "<group>";
                };
                82E096A3222FCCE3006C0DC0 /* TestProject-macOSTests */ = {
                    isa = PBXGroup;
                    children = (
                        82E096A4222FCCE3006C0DC0 /* TestProject_macOSTests.swift */,
                        82E096A6222FCCE3006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-macOSTests";
                    sourceTree = "<group>";
                };
                82E096AE222FCCE3006C0DC0 /* TestProject-macOSUITests */ = {
                    isa = PBXGroup;
                    children = (
                        82E096AF222FCCE3006C0DC0 /* TestProject_macOSUITests.swift */,
                        82E096B1222FCCE3006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-macOSUITests";
                    sourceTree = "<group>";
                };
        /* End PBXGroup section */

        /* Begin PBXNativeTarget section */
                82E0968D222FCCE3006C0DC0 /* TestProject-macOS */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E096B4222FCCE3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-macOS" */;
                    buildPhases = (
                        82E0968A222FCCE3006C0DC0 /* Sources */,
                        82E0968B222FCCE3006C0DC0 /* Frameworks */,
                        82E0968C222FCCE3006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                    );
                    name = "TestProject-macOS";
                    productName = "TestProject-macOS";
                    productReference = 82E0968E222FCCE3006C0DC0 /* TestProject-macOS.app */;
                    productType = "com.apple.product-type.application";
                };
                82E0969F222FCCE3006C0DC0 /* TestProject-macOSTests */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E096B7222FCCE3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-macOSTests" */;
                    buildPhases = (
                        82E0969C222FCCE3006C0DC0 /* Sources */,
                        82E0969D222FCCE3006C0DC0 /* Frameworks */,
                        82E0969E222FCCE3006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E096A2222FCCE3006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-macOSTests";
                    productName = "TestProject-macOSTests";
                    productReference = 82E096A0222FCCE3006C0DC0 /* TestProject-macOSTests.xctest */;
                    productType = "com.apple.product-type.bundle.unit-test";
                };
                82E096AA222FCCE3006C0DC0 /* TestProject-macOSUITests */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E096BA222FCCE3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-macOSUITests" */;
                    buildPhases = (
                        82E096A7222FCCE3006C0DC0 /* Sources */,
                        82E096A8222FCCE3006C0DC0 /* Frameworks */,
                        82E096A9222FCCE3006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E096AD222FCCE3006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-macOSUITests";
                    productName = "TestProject-macOSUITests";
                    productReference = 82E096AB222FCCE3006C0DC0 /* TestProject-macOSUITests.xctest */;
                    productType = "com.apple.product-type.bundle.ui-testing";
                };
        /* End PBXNativeTarget section */

        /* Begin PBXProject section */
                82E09686222FCCE3006C0DC0 /* Project object */ = {
                    isa = PBXProject;
                    attributes = {
                        LastSwiftUpdateCheck = 1010;
                        LastUpgradeCheck = 1010;
                        ORGANIZATIONNAME = "Jamit Labs GmbH";
                        TargetAttributes = {
                            82E0968D222FCCE3006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                            };
                            82E0969F222FCCE3006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                                TestTargetID = 82E0968D222FCCE3006C0DC0;
                            };
                            82E096AA222FCCE3006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                                TestTargetID = 82E0968D222FCCE3006C0DC0;
                            };
                        };
                    };
                    buildConfigurationList = 82E09689222FCCE3006C0DC0 /* Build configuration list for PBXProject "TestProject-macOS" */;
                    compatibilityVersion = "Xcode 9.3";
                    developmentRegion = en;
                    hasScannedForEncodings = 0;
                    knownRegions = (
                        en,
                        Base,
                    );
                    mainGroup = 82E09685222FCCE3006C0DC0;
                    productRefGroup = 82E0968F222FCCE3006C0DC0 /* Products */;
                    projectDirPath = "";
                    projectRoot = "";
                    targets = (
                        82E0968D222FCCE3006C0DC0 /* TestProject-macOS */,
                        82E0969F222FCCE3006C0DC0 /* TestProject-macOSTests */,
                        82E096AA222FCCE3006C0DC0 /* TestProject-macOSUITests */,
                    );
                };
        /* End PBXProject section */

        /* Begin PBXResourcesBuildPhase section */
                82E0968C222FCCE3006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E09696222FCCE3006C0DC0 /* Assets.xcassets in Resources */,
                        82E09699222FCCE3006C0DC0 /* Main.storyboard in Resources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E0969E222FCCE3006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E096A9222FCCE3006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXResourcesBuildPhase section */

        /* Begin PBXSourcesBuildPhase section */
                82E0968A222FCCE3006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E09694222FCCE3006C0DC0 /* ViewController.swift in Sources */,
                        82E09692222FCCE3006C0DC0 /* AppDelegate.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E0969C222FCCE3006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E096A5222FCCE3006C0DC0 /* TestProject_macOSTests.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E096A7222FCCE3006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E096B0222FCCE3006C0DC0 /* TestProject_macOSUITests.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXSourcesBuildPhase section */

        /* Begin PBXTargetDependency section */
                82E096A2222FCCE3006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E0968D222FCCE3006C0DC0 /* TestProject-macOS */;
                    targetProxy = 82E096A1222FCCE3006C0DC0 /* PBXContainerItemProxy */;
                };
                82E096AD222FCCE3006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E0968D222FCCE3006C0DC0 /* TestProject-macOS */;
                    targetProxy = 82E096AC222FCCE3006C0DC0 /* PBXContainerItemProxy */;
                };
        /* End PBXTargetDependency section */

        /* Begin PBXVariantGroup section */
                82E09697222FCCE3006C0DC0 /* Main.storyboard */ = {
                    isa = PBXVariantGroup;
                    children = (
                        82E09698222FCCE3006C0DC0 /* Base */,
                    );
                    name = Main.storyboard;
                    sourceTree = "<group>";
                };
        /* End PBXVariantGroup section */

        /* Begin XCBuildConfiguration section */
                82E096B2222FCCE3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_SEARCH_USER_PATHS = NO;
                        CLANG_ANALYZER_NONNULL = YES;
                        CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                        CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
                        CLANG_CXX_LIBRARY = "libc++";
                        CLANG_ENABLE_MODULES = YES;
                        CLANG_ENABLE_OBJC_ARC = YES;
                        CLANG_ENABLE_OBJC_WEAK = YES;
                        CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                        CLANG_WARN_BOOL_CONVERSION = YES;
                        CLANG_WARN_COMMA = YES;
                        CLANG_WARN_CONSTANT_CONVERSION = YES;
                        CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                        CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                        CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                        CLANG_WARN_EMPTY_BODY = YES;
                        CLANG_WARN_ENUM_CONVERSION = YES;
                        CLANG_WARN_INFINITE_RECURSION = YES;
                        CLANG_WARN_INT_CONVERSION = YES;
                        CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                        CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                        CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                        CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                        CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                        CLANG_WARN_STRICT_PROTOTYPES = YES;
                        CLANG_WARN_SUSPICIOUS_MOVE = YES;
                        CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                        CLANG_WARN_UNREACHABLE_CODE = YES;
                        CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                        CODE_SIGN_IDENTITY = "-";
                        COPY_PHASE_STRIP = NO;
                        DEBUG_INFORMATION_FORMAT = dwarf;
                        ENABLE_STRICT_OBJC_MSGSEND = YES;
                        ENABLE_TESTABILITY = YES;
                        GCC_C_LANGUAGE_STANDARD = gnu11;
                        GCC_DYNAMIC_NO_PIC = NO;
                        GCC_NO_COMMON_BLOCKS = YES;
                        GCC_OPTIMIZATION_LEVEL = 0;
                        GCC_PREPROCESSOR_DEFINITIONS = (
                            "DEBUG=1",
                            "$(inherited)",
                        );
                        GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                        GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                        GCC_WARN_UNDECLARED_SELECTOR = YES;
                        GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                        GCC_WARN_UNUSED_FUNCTION = YES;
                        GCC_WARN_UNUSED_VARIABLE = YES;
                        MACOSX_DEPLOYMENT_TARGET = 10.14;
                        MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                        MTL_FAST_MATH = YES;
                        ONLY_ACTIVE_ARCH = YES;
                        SDKROOT = macosx;
                        SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                        SWIFT_OPTIMIZATION_LEVEL = "-Onone";
                    };
                    name = Debug;
                };
                82E096B3222FCCE3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_SEARCH_USER_PATHS = NO;
                        CLANG_ANALYZER_NONNULL = YES;
                        CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                        CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
                        CLANG_CXX_LIBRARY = "libc++";
                        CLANG_ENABLE_MODULES = YES;
                        CLANG_ENABLE_OBJC_ARC = YES;
                        CLANG_ENABLE_OBJC_WEAK = YES;
                        CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                        CLANG_WARN_BOOL_CONVERSION = YES;
                        CLANG_WARN_COMMA = YES;
                        CLANG_WARN_CONSTANT_CONVERSION = YES;
                        CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                        CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                        CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                        CLANG_WARN_EMPTY_BODY = YES;
                        CLANG_WARN_ENUM_CONVERSION = YES;
                        CLANG_WARN_INFINITE_RECURSION = YES;
                        CLANG_WARN_INT_CONVERSION = YES;
                        CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                        CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                        CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                        CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                        CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                        CLANG_WARN_STRICT_PROTOTYPES = YES;
                        CLANG_WARN_SUSPICIOUS_MOVE = YES;
                        CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                        CLANG_WARN_UNREACHABLE_CODE = YES;
                        CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                        CODE_SIGN_IDENTITY = "-";
                        COPY_PHASE_STRIP = NO;
                        DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                        ENABLE_NS_ASSERTIONS = NO;
                        ENABLE_STRICT_OBJC_MSGSEND = YES;
                        GCC_C_LANGUAGE_STANDARD = gnu11;
                        GCC_NO_COMMON_BLOCKS = YES;
                        GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                        GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                        GCC_WARN_UNDECLARED_SELECTOR = YES;
                        GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                        GCC_WARN_UNUSED_FUNCTION = YES;
                        GCC_WARN_UNUSED_VARIABLE = YES;
                        MACOSX_DEPLOYMENT_TARGET = 10.14;
                        MTL_ENABLE_DEBUG_INFO = NO;
                        MTL_FAST_MATH = YES;
                        SDKROOT = macosx;
                        SWIFT_COMPILATION_MODE = wholemodule;
                        SWIFT_OPTIMIZATION_LEVEL = "-O";
                    };
                    name = Release;
                };
                82E096B5222FCCE3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                        CODE_SIGN_ENTITLEMENTS = "TestProject-macOS/TestProject_macOS.entitlements";
                        CODE_SIGN_STYLE = Automatic;
                        COMBINE_HIDPI_IMAGES = YES;
                        INFOPLIST_FILE = "TestProject-macOS/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/../Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-macOS";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                    };
                    name = Debug;
                };
                82E096B6222FCCE3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                        CODE_SIGN_ENTITLEMENTS = "TestProject-macOS/TestProject_macOS.entitlements";
                        CODE_SIGN_STYLE = Automatic;
                        COMBINE_HIDPI_IMAGES = YES;
                        INFOPLIST_FILE = "TestProject-macOS/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/../Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-macOS";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                    };
                    name = Release;
                };
                82E096B8222FCCE3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        BUNDLE_LOADER = "$(TEST_HOST)";
                        CODE_SIGN_STYLE = Automatic;
                        COMBINE_HIDPI_IMAGES = YES;
                        INFOPLIST_FILE = "TestProject-macOSTests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/../Frameworks",
                            "@loader_path/../Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-macOSTests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TEST_HOST = "$(BUILT_PRODUCTS_DIR)/TestProject-macOS.app/Contents/MacOS/TestProject-macOS";
                    };
                    name = Debug;
                };
                82E096B9222FCCE3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        BUNDLE_LOADER = "$(TEST_HOST)";
                        CODE_SIGN_STYLE = Automatic;
                        COMBINE_HIDPI_IMAGES = YES;
                        INFOPLIST_FILE = "TestProject-macOSTests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/../Frameworks",
                            "@loader_path/../Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-macOSTests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TEST_HOST = "$(BUILT_PRODUCTS_DIR)/TestProject-macOS.app/Contents/MacOS/TestProject-macOS";
                    };
                    name = Release;
                };
                82E096BB222FCCE3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        CODE_SIGN_STYLE = Automatic;
                        COMBINE_HIDPI_IMAGES = YES;
                        INFOPLIST_FILE = "TestProject-macOSUITests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/../Frameworks",
                            "@loader_path/../Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-macOSUITests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TEST_TARGET_NAME = "TestProject-macOS";
                    };
                    name = Debug;
                };
                82E096BC222FCCE3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        CODE_SIGN_STYLE = Automatic;
                        COMBINE_HIDPI_IMAGES = YES;
                        INFOPLIST_FILE = "TestProject-macOSUITests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/../Frameworks",
                            "@loader_path/../Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-macOSUITests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TEST_TARGET_NAME = "TestProject-macOS";
                    };
                    name = Release;
                };
        /* End XCBuildConfiguration section */

        /* Begin XCConfigurationList section */
                82E09689222FCCE3006C0DC0 /* Build configuration list for PBXProject "TestProject-macOS" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E096B2222FCCE3006C0DC0 /* Debug */,
                        82E096B3222FCCE3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E096B4222FCCE3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-macOS" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E096B5222FCCE3006C0DC0 /* Debug */,
                        82E096B6222FCCE3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E096B7222FCCE3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-macOSTests" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E096B8222FCCE3006C0DC0 /* Debug */,
                        82E096B9222FCCE3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E096BA222FCCE3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-macOSUITests" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E096BB222FCCE3006C0DC0 /* Debug */,
                        82E096BC222FCCE3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
        /* End XCConfigurationList section */
            };
            rootObject = 82E09686222FCCE3006C0DC0 /* Project object */;
        }
        """

    static let tvOSProjectFileContents: String = """
        // !$*UTF8*$!
        {
            archiveVersion = 1;
            classes = {
            };
            objectVersion = 50;
            objects = {

        /* Begin PBXBuildFile section */
                82E0965B222FCCD2006C0DC0 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E0965A222FCCD2006C0DC0 /* AppDelegate.swift */; };
                82E0965D222FCCD2006C0DC0 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E0965C222FCCD2006C0DC0 /* ViewController.swift */; };
                82E09660222FCCD2006C0DC0 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 82E0965E222FCCD2006C0DC0 /* Main.storyboard */; };
                82E09662222FCCD3006C0DC0 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 82E09661222FCCD3006C0DC0 /* Assets.xcassets */; };
                82E0966D222FCCD3006C0DC0 /* TestProject_tvOSTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E0966C222FCCD3006C0DC0 /* TestProject_tvOSTests.swift */; };
                82E09678222FCCD3006C0DC0 /* TestProject_tvOSUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E09677222FCCD3006C0DC0 /* TestProject_tvOSUITests.swift */; };
        /* End PBXBuildFile section */

        /* Begin PBXContainerItemProxy section */
                82E09669222FCCD3006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E0964F222FCCD2006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E09656222FCCD2006C0DC0;
                    remoteInfo = "TestProject-tvOS";
                };
                82E09674222FCCD3006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E0964F222FCCD2006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E09656222FCCD2006C0DC0;
                    remoteInfo = "TestProject-tvOS";
                };
        /* End PBXContainerItemProxy section */

        /* Begin PBXFileReference section */
                82E09657222FCCD2006C0DC0 /* TestProject-tvOS.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "TestProject-tvOS.app"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E0965A222FCCD2006C0DC0 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
                82E0965C222FCCD2006C0DC0 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
                82E0965F222FCCD2006C0DC0 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
                82E09661222FCCD3006C0DC0 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
                82E09663222FCCD3006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E09668222FCCD3006C0DC0 /* TestProject-tvOSTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "TestProject-tvOSTests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E0966C222FCCD3006C0DC0 /* TestProject_tvOSTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TestProject_tvOSTests.swift; sourceTree = "<group>"; };
                82E0966E222FCCD3006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E09673222FCCD3006C0DC0 /* TestProject-tvOSUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "TestProject-tvOSUITests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E09677222FCCD3006C0DC0 /* TestProject_tvOSUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TestProject_tvOSUITests.swift; sourceTree = "<group>"; };
                82E09679222FCCD3006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
        /* End PBXFileReference section */

        /* Begin PBXFrameworksBuildPhase section */
                82E09654222FCCD2006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09665222FCCD3006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09670222FCCD3006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXFrameworksBuildPhase section */

        /* Begin PBXGroup section */
                82E0964E222FCCD2006C0DC0 = {
                    isa = PBXGroup;
                    children = (
                        82E09659222FCCD2006C0DC0 /* TestProject-tvOS */,
                        82E0966B222FCCD3006C0DC0 /* TestProject-tvOSTests */,
                        82E09676222FCCD3006C0DC0 /* TestProject-tvOSUITests */,
                        82E09658222FCCD2006C0DC0 /* Products */,
                    );
                    sourceTree = "<group>";
                };
                82E09658222FCCD2006C0DC0 /* Products */ = {
                    isa = PBXGroup;
                    children = (
                        82E09657222FCCD2006C0DC0 /* TestProject-tvOS.app */,
                        82E09668222FCCD3006C0DC0 /* TestProject-tvOSTests.xctest */,
                        82E09673222FCCD3006C0DC0 /* TestProject-tvOSUITests.xctest */,
                    );
                    name = Products;
                    sourceTree = "<group>";
                };
                82E09659222FCCD2006C0DC0 /* TestProject-tvOS */ = {
                    isa = PBXGroup;
                    children = (
                        82E0965A222FCCD2006C0DC0 /* AppDelegate.swift */,
                        82E0965C222FCCD2006C0DC0 /* ViewController.swift */,
                        82E0965E222FCCD2006C0DC0 /* Main.storyboard */,
                        82E09661222FCCD3006C0DC0 /* Assets.xcassets */,
                        82E09663222FCCD3006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-tvOS";
                    sourceTree = "<group>";
                };
                82E0966B222FCCD3006C0DC0 /* TestProject-tvOSTests */ = {
                    isa = PBXGroup;
                    children = (
                        82E0966C222FCCD3006C0DC0 /* TestProject_tvOSTests.swift */,
                        82E0966E222FCCD3006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-tvOSTests";
                    sourceTree = "<group>";
                };
                82E09676222FCCD3006C0DC0 /* TestProject-tvOSUITests */ = {
                    isa = PBXGroup;
                    children = (
                        82E09677222FCCD3006C0DC0 /* TestProject_tvOSUITests.swift */,
                        82E09679222FCCD3006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-tvOSUITests";
                    sourceTree = "<group>";
                };
        /* End PBXGroup section */

        /* Begin PBXNativeTarget section */
                82E09656222FCCD2006C0DC0 /* TestProject-tvOS */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E0967C222FCCD3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-tvOS" */;
                    buildPhases = (
                        82E09653222FCCD2006C0DC0 /* Sources */,
                        82E09654222FCCD2006C0DC0 /* Frameworks */,
                        82E09655222FCCD2006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                    );
                    name = "TestProject-tvOS";
                    productName = "TestProject-tvOS";
                    productReference = 82E09657222FCCD2006C0DC0 /* TestProject-tvOS.app */;
                    productType = "com.apple.product-type.application";
                };
                82E09667222FCCD3006C0DC0 /* TestProject-tvOSTests */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E0967F222FCCD3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-tvOSTests" */;
                    buildPhases = (
                        82E09664222FCCD3006C0DC0 /* Sources */,
                        82E09665222FCCD3006C0DC0 /* Frameworks */,
                        82E09666222FCCD3006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E0966A222FCCD3006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-tvOSTests";
                    productName = "TestProject-tvOSTests";
                    productReference = 82E09668222FCCD3006C0DC0 /* TestProject-tvOSTests.xctest */;
                    productType = "com.apple.product-type.bundle.unit-test";
                };
                82E09672222FCCD3006C0DC0 /* TestProject-tvOSUITests */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E09682222FCCD3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-tvOSUITests" */;
                    buildPhases = (
                        82E0966F222FCCD3006C0DC0 /* Sources */,
                        82E09670222FCCD3006C0DC0 /* Frameworks */,
                        82E09671222FCCD3006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E09675222FCCD3006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-tvOSUITests";
                    productName = "TestProject-tvOSUITests";
                    productReference = 82E09673222FCCD3006C0DC0 /* TestProject-tvOSUITests.xctest */;
                    productType = "com.apple.product-type.bundle.ui-testing";
                };
        /* End PBXNativeTarget section */

        /* Begin PBXProject section */
                82E0964F222FCCD2006C0DC0 /* Project object */ = {
                    isa = PBXProject;
                    attributes = {
                        LastSwiftUpdateCheck = 1010;
                        LastUpgradeCheck = 1010;
                        ORGANIZATIONNAME = "Jamit Labs GmbH";
                        TargetAttributes = {
                            82E09656222FCCD2006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                            };
                            82E09667222FCCD3006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                                TestTargetID = 82E09656222FCCD2006C0DC0;
                            };
                            82E09672222FCCD3006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                                TestTargetID = 82E09656222FCCD2006C0DC0;
                            };
                        };
                    };
                    buildConfigurationList = 82E09652222FCCD2006C0DC0 /* Build configuration list for PBXProject "TestProject-tvOS" */;
                    compatibilityVersion = "Xcode 9.3";
                    developmentRegion = en;
                    hasScannedForEncodings = 0;
                    knownRegions = (
                        en,
                        Base,
                    );
                    mainGroup = 82E0964E222FCCD2006C0DC0;
                    productRefGroup = 82E09658222FCCD2006C0DC0 /* Products */;
                    projectDirPath = "";
                    projectRoot = "";
                    targets = (
                        82E09656222FCCD2006C0DC0 /* TestProject-tvOS */,
                        82E09667222FCCD3006C0DC0 /* TestProject-tvOSTests */,
                        82E09672222FCCD3006C0DC0 /* TestProject-tvOSUITests */,
                    );
                };
        /* End PBXProject section */

        /* Begin PBXResourcesBuildPhase section */
                82E09655222FCCD2006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E09662222FCCD3006C0DC0 /* Assets.xcassets in Resources */,
                        82E09660222FCCD2006C0DC0 /* Main.storyboard in Resources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09666222FCCD3006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09671222FCCD3006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXResourcesBuildPhase section */

        /* Begin PBXSourcesBuildPhase section */
                82E09653222FCCD2006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E0965D222FCCD2006C0DC0 /* ViewController.swift in Sources */,
                        82E0965B222FCCD2006C0DC0 /* AppDelegate.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09664222FCCD3006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E0966D222FCCD3006C0DC0 /* TestProject_tvOSTests.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E0966F222FCCD3006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E09678222FCCD3006C0DC0 /* TestProject_tvOSUITests.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXSourcesBuildPhase section */

        /* Begin PBXTargetDependency section */
                82E0966A222FCCD3006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E09656222FCCD2006C0DC0 /* TestProject-tvOS */;
                    targetProxy = 82E09669222FCCD3006C0DC0 /* PBXContainerItemProxy */;
                };
                82E09675222FCCD3006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E09656222FCCD2006C0DC0 /* TestProject-tvOS */;
                    targetProxy = 82E09674222FCCD3006C0DC0 /* PBXContainerItemProxy */;
                };
        /* End PBXTargetDependency section */

        /* Begin PBXVariantGroup section */
                82E0965E222FCCD2006C0DC0 /* Main.storyboard */ = {
                    isa = PBXVariantGroup;
                    children = (
                        82E0965F222FCCD2006C0DC0 /* Base */,
                    );
                    name = Main.storyboard;
                    sourceTree = "<group>";
                };
        /* End PBXVariantGroup section */

        /* Begin XCBuildConfiguration section */
                82E0967A222FCCD3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_SEARCH_USER_PATHS = NO;
                        CLANG_ANALYZER_NONNULL = YES;
                        CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                        CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
                        CLANG_CXX_LIBRARY = "libc++";
                        CLANG_ENABLE_MODULES = YES;
                        CLANG_ENABLE_OBJC_ARC = YES;
                        CLANG_ENABLE_OBJC_WEAK = YES;
                        CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                        CLANG_WARN_BOOL_CONVERSION = YES;
                        CLANG_WARN_COMMA = YES;
                        CLANG_WARN_CONSTANT_CONVERSION = YES;
                        CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                        CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                        CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                        CLANG_WARN_EMPTY_BODY = YES;
                        CLANG_WARN_ENUM_CONVERSION = YES;
                        CLANG_WARN_INFINITE_RECURSION = YES;
                        CLANG_WARN_INT_CONVERSION = YES;
                        CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                        CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                        CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                        CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                        CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                        CLANG_WARN_STRICT_PROTOTYPES = YES;
                        CLANG_WARN_SUSPICIOUS_MOVE = YES;
                        CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                        CLANG_WARN_UNREACHABLE_CODE = YES;
                        CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                        COPY_PHASE_STRIP = NO;
                        DEBUG_INFORMATION_FORMAT = dwarf;
                        ENABLE_STRICT_OBJC_MSGSEND = YES;
                        ENABLE_TESTABILITY = YES;
                        GCC_C_LANGUAGE_STANDARD = gnu11;
                        GCC_DYNAMIC_NO_PIC = NO;
                        GCC_NO_COMMON_BLOCKS = YES;
                        GCC_OPTIMIZATION_LEVEL = 0;
                        GCC_PREPROCESSOR_DEFINITIONS = (
                            "DEBUG=1",
                            "$(inherited)",
                        );
                        GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                        GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                        GCC_WARN_UNDECLARED_SELECTOR = YES;
                        GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                        GCC_WARN_UNUSED_FUNCTION = YES;
                        GCC_WARN_UNUSED_VARIABLE = YES;
                        MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                        MTL_FAST_MATH = YES;
                        ONLY_ACTIVE_ARCH = YES;
                        SDKROOT = appletvos;
                        SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                        SWIFT_OPTIMIZATION_LEVEL = "-Onone";
                        TVOS_DEPLOYMENT_TARGET = 12.1;
                    };
                    name = Debug;
                };
                82E0967B222FCCD3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_SEARCH_USER_PATHS = NO;
                        CLANG_ANALYZER_NONNULL = YES;
                        CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                        CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
                        CLANG_CXX_LIBRARY = "libc++";
                        CLANG_ENABLE_MODULES = YES;
                        CLANG_ENABLE_OBJC_ARC = YES;
                        CLANG_ENABLE_OBJC_WEAK = YES;
                        CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                        CLANG_WARN_BOOL_CONVERSION = YES;
                        CLANG_WARN_COMMA = YES;
                        CLANG_WARN_CONSTANT_CONVERSION = YES;
                        CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                        CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                        CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                        CLANG_WARN_EMPTY_BODY = YES;
                        CLANG_WARN_ENUM_CONVERSION = YES;
                        CLANG_WARN_INFINITE_RECURSION = YES;
                        CLANG_WARN_INT_CONVERSION = YES;
                        CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                        CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                        CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                        CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                        CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                        CLANG_WARN_STRICT_PROTOTYPES = YES;
                        CLANG_WARN_SUSPICIOUS_MOVE = YES;
                        CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                        CLANG_WARN_UNREACHABLE_CODE = YES;
                        CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                        COPY_PHASE_STRIP = NO;
                        DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                        ENABLE_NS_ASSERTIONS = NO;
                        ENABLE_STRICT_OBJC_MSGSEND = YES;
                        GCC_C_LANGUAGE_STANDARD = gnu11;
                        GCC_NO_COMMON_BLOCKS = YES;
                        GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                        GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                        GCC_WARN_UNDECLARED_SELECTOR = YES;
                        GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                        GCC_WARN_UNUSED_FUNCTION = YES;
                        GCC_WARN_UNUSED_VARIABLE = YES;
                        MTL_ENABLE_DEBUG_INFO = NO;
                        MTL_FAST_MATH = YES;
                        SDKROOT = appletvos;
                        SWIFT_COMPILATION_MODE = wholemodule;
                        SWIFT_OPTIMIZATION_LEVEL = "-O";
                        TVOS_DEPLOYMENT_TARGET = 12.1;
                        VALIDATE_PRODUCT = YES;
                    };
                    name = Release;
                };
                82E0967D222FCCD3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_APPICON_NAME = "App Icon & Top Shelf Image";
                        ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME = LaunchImage;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-tvOS/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-tvOS";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 3;
                    };
                    name = Debug;
                };
                82E0967E222FCCD3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_APPICON_NAME = "App Icon & Top Shelf Image";
                        ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME = LaunchImage;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-tvOS/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-tvOS";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 3;
                    };
                    name = Release;
                };
                82E09680222FCCD3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        BUNDLE_LOADER = "$(TEST_HOST)";
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-tvOSTests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-tvOSTests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 3;
                        TEST_HOST = "$(BUILT_PRODUCTS_DIR)/TestProject-tvOS.app/TestProject-tvOS";
                    };
                    name = Debug;
                };
                82E09681222FCCD3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        BUNDLE_LOADER = "$(TEST_HOST)";
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-tvOSTests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-tvOSTests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 3;
                        TEST_HOST = "$(BUILT_PRODUCTS_DIR)/TestProject-tvOS.app/TestProject-tvOS";
                    };
                    name = Release;
                };
                82E09683222FCCD3006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-tvOSUITests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-tvOSUITests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 3;
                        TEST_TARGET_NAME = "TestProject-tvOS";
                    };
                    name = Debug;
                };
                82E09684222FCCD3006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-tvOSUITests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-tvOSUITests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 3;
                        TEST_TARGET_NAME = "TestProject-tvOS";
                    };
                    name = Release;
                };
        /* End XCBuildConfiguration section */

        /* Begin XCConfigurationList section */
                82E09652222FCCD2006C0DC0 /* Build configuration list for PBXProject "TestProject-tvOS" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E0967A222FCCD3006C0DC0 /* Debug */,
                        82E0967B222FCCD3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E0967C222FCCD3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-tvOS" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E0967D222FCCD3006C0DC0 /* Debug */,
                        82E0967E222FCCD3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E0967F222FCCD3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-tvOSTests" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E09680222FCCD3006C0DC0 /* Debug */,
                        82E09681222FCCD3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E09682222FCCD3006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-tvOSUITests" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E09683222FCCD3006C0DC0 /* Debug */,
                        82E09684222FCCD3006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
        /* End XCConfigurationList section */
            };
            rootObject = 82E0964F222FCCD2006C0DC0 /* Project object */;
        }
        """

    static let watchOSProjectFileContents: String = """
        // !$*UTF8*$!
        {
            archiveVersion = 1;
            classes = {
            };
            objectVersion = 50;
            objects = {

        /* Begin PBXBuildFile section */
                82E095F9222FCCBD006C0DC0 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E095F8222FCCBD006C0DC0 /* AppDelegate.swift */; };
                82E095FB222FCCBD006C0DC0 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E095FA222FCCBD006C0DC0 /* ViewController.swift */; };
                82E095FE222FCCBD006C0DC0 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 82E095FC222FCCBD006C0DC0 /* Main.storyboard */; };
                82E09600222FCCBE006C0DC0 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 82E095FF222FCCBE006C0DC0 /* Assets.xcassets */; };
                82E09603222FCCBE006C0DC0 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 82E09601222FCCBE006C0DC0 /* LaunchScreen.storyboard */; };
                82E0960E222FCCBE006C0DC0 /* TestProject_watchOSTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E0960D222FCCBE006C0DC0 /* TestProject_watchOSTests.swift */; };
                82E09619222FCCBE006C0DC0 /* TestProject_watchOSUITests.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E09618222FCCBE006C0DC0 /* TestProject_watchOSUITests.swift */; };
                82E0961E222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App.app in Embed Watch Content */ = {isa = PBXBuildFile; fileRef = 82E0961D222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App.app */; };
                82E09624222FCCBE006C0DC0 /* Interface.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 82E09622222FCCBE006C0DC0 /* Interface.storyboard */; };
                82E09626222FCCBF006C0DC0 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 82E09625222FCCBF006C0DC0 /* Assets.xcassets */; };
                82E0962D222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension.appex in Embed App Extensions */ = {isa = PBXBuildFile; fileRef = 82E0962C222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension.appex */; settings = {ATTRIBUTES = (RemoveHeadersOnCopy, ); }; };
                82E09632222FCCBF006C0DC0 /* InterfaceController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E09631222FCCBF006C0DC0 /* InterfaceController.swift */; };
                82E09634222FCCBF006C0DC0 /* ExtensionDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E09633222FCCBF006C0DC0 /* ExtensionDelegate.swift */; };
                82E09636222FCCBF006C0DC0 /* NotificationController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 82E09635222FCCBF006C0DC0 /* NotificationController.swift */; };
                82E09638222FCCBF006C0DC0 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 82E09637222FCCBF006C0DC0 /* Assets.xcassets */; };
        /* End PBXBuildFile section */

        /* Begin PBXContainerItemProxy section */
                82E0960A222FCCBE006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E095ED222FCCBD006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E095F4222FCCBD006C0DC0;
                    remoteInfo = "TestProject-watchOS";
                };
                82E09615222FCCBE006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E095ED222FCCBD006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E095F4222FCCBD006C0DC0;
                    remoteInfo = "TestProject-watchOS";
                };
                82E0961F222FCCBE006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E095ED222FCCBD006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E0961C222FCCBE006C0DC0;
                    remoteInfo = "TestProject-watchOS WatchKit App";
                };
                82E0962E222FCCBF006C0DC0 /* PBXContainerItemProxy */ = {
                    isa = PBXContainerItemProxy;
                    containerPortal = 82E095ED222FCCBD006C0DC0 /* Project object */;
                    proxyType = 1;
                    remoteGlobalIDString = 82E0962B222FCCBF006C0DC0;
                    remoteInfo = "TestProject-watchOS WatchKit Extension";
                };
        /* End PBXContainerItemProxy section */

        /* Begin PBXCopyFilesBuildPhase section */
                82E09640222FCCBF006C0DC0 /* Embed App Extensions */ = {
                    isa = PBXCopyFilesBuildPhase;
                    buildActionMask = 2147483647;
                    dstPath = "";
                    dstSubfolderSpec = 13;
                    files = (
                        82E0962D222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension.appex in Embed App Extensions */,
                    );
                    name = "Embed App Extensions";
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09644222FCCBF006C0DC0 /* Embed Watch Content */ = {
                    isa = PBXCopyFilesBuildPhase;
                    buildActionMask = 2147483647;
                    dstPath = "$(CONTENTS_FOLDER_PATH)/Watch";
                    dstSubfolderSpec = 16;
                    files = (
                        82E0961E222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App.app in Embed Watch Content */,
                    );
                    name = "Embed Watch Content";
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXCopyFilesBuildPhase section */

        /* Begin PBXFileReference section */
                82E095F5222FCCBD006C0DC0 /* TestProject-watchOS.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "TestProject-watchOS.app"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E095F8222FCCBD006C0DC0 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = "<group>"; };
                82E095FA222FCCBD006C0DC0 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = "<group>"; };
                82E095FD222FCCBD006C0DC0 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = "<group>"; };
                82E095FF222FCCBE006C0DC0 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
                82E09602222FCCBE006C0DC0 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = "<group>"; };
                82E09604222FCCBE006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E09609222FCCBE006C0DC0 /* TestProject-watchOSTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "TestProject-watchOSTests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E0960D222FCCBE006C0DC0 /* TestProject_watchOSTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TestProject_watchOSTests.swift; sourceTree = "<group>"; };
                82E0960F222FCCBE006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E09614222FCCBE006C0DC0 /* TestProject-watchOSUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "TestProject-watchOSUITests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E09618222FCCBE006C0DC0 /* TestProject_watchOSUITests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TestProject_watchOSUITests.swift; sourceTree = "<group>"; };
                82E0961A222FCCBE006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E0961D222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "TestProject-watchOS WatchKit App.app"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E09623222FCCBE006C0DC0 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Interface.storyboard; sourceTree = "<group>"; };
                82E09625222FCCBF006C0DC0 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
                82E09627222FCCBF006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E0962C222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension.appex */ = {isa = PBXFileReference; explicitFileType = "wrapper.app-extension"; includeInIndex = 0; path = "TestProject-watchOS WatchKit Extension.appex"; sourceTree = BUILT_PRODUCTS_DIR; };
                82E09631222FCCBF006C0DC0 /* InterfaceController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = InterfaceController.swift; sourceTree = "<group>"; };
                82E09633222FCCBF006C0DC0 /* ExtensionDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ExtensionDelegate.swift; sourceTree = "<group>"; };
                82E09635222FCCBF006C0DC0 /* NotificationController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NotificationController.swift; sourceTree = "<group>"; };
                82E09637222FCCBF006C0DC0 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
                82E09639222FCCBF006C0DC0 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
                82E0963A222FCCBF006C0DC0 /* PushNotificationPayload.apns */ = {isa = PBXFileReference; lastKnownFileType = text; path = PushNotificationPayload.apns; sourceTree = "<group>"; };
        /* End PBXFileReference section */

        /* Begin PBXFrameworksBuildPhase section */
                82E095F2222FCCBD006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09606222FCCBE006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09611222FCCBE006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09629222FCCBF006C0DC0 /* Frameworks */ = {
                    isa = PBXFrameworksBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXFrameworksBuildPhase section */

        /* Begin PBXGroup section */
                82E095EC222FCCBD006C0DC0 = {
                    isa = PBXGroup;
                    children = (
                        82E095F7222FCCBD006C0DC0 /* TestProject-watchOS */,
                        82E0960C222FCCBE006C0DC0 /* TestProject-watchOSTests */,
                        82E09617222FCCBE006C0DC0 /* TestProject-watchOSUITests */,
                        82E09621222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App */,
                        82E09630222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension */,
                        82E095F6222FCCBD006C0DC0 /* Products */,
                    );
                    sourceTree = "<group>";
                };
                82E095F6222FCCBD006C0DC0 /* Products */ = {
                    isa = PBXGroup;
                    children = (
                        82E095F5222FCCBD006C0DC0 /* TestProject-watchOS.app */,
                        82E09609222FCCBE006C0DC0 /* TestProject-watchOSTests.xctest */,
                        82E09614222FCCBE006C0DC0 /* TestProject-watchOSUITests.xctest */,
                        82E0961D222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App.app */,
                        82E0962C222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension.appex */,
                    );
                    name = Products;
                    sourceTree = "<group>";
                };
                82E095F7222FCCBD006C0DC0 /* TestProject-watchOS */ = {
                    isa = PBXGroup;
                    children = (
                        82E095F8222FCCBD006C0DC0 /* AppDelegate.swift */,
                        82E095FA222FCCBD006C0DC0 /* ViewController.swift */,
                        82E095FC222FCCBD006C0DC0 /* Main.storyboard */,
                        82E095FF222FCCBE006C0DC0 /* Assets.xcassets */,
                        82E09601222FCCBE006C0DC0 /* LaunchScreen.storyboard */,
                        82E09604222FCCBE006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-watchOS";
                    sourceTree = "<group>";
                };
                82E0960C222FCCBE006C0DC0 /* TestProject-watchOSTests */ = {
                    isa = PBXGroup;
                    children = (
                        82E0960D222FCCBE006C0DC0 /* TestProject_watchOSTests.swift */,
                        82E0960F222FCCBE006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-watchOSTests";
                    sourceTree = "<group>";
                };
                82E09617222FCCBE006C0DC0 /* TestProject-watchOSUITests */ = {
                    isa = PBXGroup;
                    children = (
                        82E09618222FCCBE006C0DC0 /* TestProject_watchOSUITests.swift */,
                        82E0961A222FCCBE006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-watchOSUITests";
                    sourceTree = "<group>";
                };
                82E09621222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App */ = {
                    isa = PBXGroup;
                    children = (
                        82E09622222FCCBE006C0DC0 /* Interface.storyboard */,
                        82E09625222FCCBF006C0DC0 /* Assets.xcassets */,
                        82E09627222FCCBF006C0DC0 /* Info.plist */,
                    );
                    path = "TestProject-watchOS WatchKit App";
                    sourceTree = "<group>";
                };
                82E09630222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension */ = {
                    isa = PBXGroup;
                    children = (
                        82E09631222FCCBF006C0DC0 /* InterfaceController.swift */,
                        82E09633222FCCBF006C0DC0 /* ExtensionDelegate.swift */,
                        82E09635222FCCBF006C0DC0 /* NotificationController.swift */,
                        82E09637222FCCBF006C0DC0 /* Assets.xcassets */,
                        82E09639222FCCBF006C0DC0 /* Info.plist */,
                        82E0963A222FCCBF006C0DC0 /* PushNotificationPayload.apns */,
                    );
                    path = "TestProject-watchOS WatchKit Extension";
                    sourceTree = "<group>";
                };
        /* End PBXGroup section */

        /* Begin PBXNativeTarget section */
                82E095F4222FCCBD006C0DC0 /* TestProject-watchOS */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E09645222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOS" */;
                    buildPhases = (
                        82E095F1222FCCBD006C0DC0 /* Sources */,
                        82E095F2222FCCBD006C0DC0 /* Frameworks */,
                        82E095F3222FCCBD006C0DC0 /* Resources */,
                        82E09644222FCCBF006C0DC0 /* Embed Watch Content */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E09620222FCCBE006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-watchOS";
                    productName = "TestProject-watchOS";
                    productReference = 82E095F5222FCCBD006C0DC0 /* TestProject-watchOS.app */;
                    productType = "com.apple.product-type.application";
                };
                82E09608222FCCBE006C0DC0 /* TestProject-watchOSTests */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E09648222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOSTests" */;
                    buildPhases = (
                        82E09605222FCCBE006C0DC0 /* Sources */,
                        82E09606222FCCBE006C0DC0 /* Frameworks */,
                        82E09607222FCCBE006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E0960B222FCCBE006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-watchOSTests";
                    productName = "TestProject-watchOSTests";
                    productReference = 82E09609222FCCBE006C0DC0 /* TestProject-watchOSTests.xctest */;
                    productType = "com.apple.product-type.bundle.unit-test";
                };
                82E09613222FCCBE006C0DC0 /* TestProject-watchOSUITests */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E0964B222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOSUITests" */;
                    buildPhases = (
                        82E09610222FCCBE006C0DC0 /* Sources */,
                        82E09611222FCCBE006C0DC0 /* Frameworks */,
                        82E09612222FCCBE006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E09616222FCCBE006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-watchOSUITests";
                    productName = "TestProject-watchOSUITests";
                    productReference = 82E09614222FCCBE006C0DC0 /* TestProject-watchOSUITests.xctest */;
                    productType = "com.apple.product-type.bundle.ui-testing";
                };
                82E0961C222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E09641222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOS WatchKit App" */;
                    buildPhases = (
                        82E0961B222FCCBE006C0DC0 /* Resources */,
                        82E09640222FCCBF006C0DC0 /* Embed App Extensions */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                        82E0962F222FCCBF006C0DC0 /* PBXTargetDependency */,
                    );
                    name = "TestProject-watchOS WatchKit App";
                    productName = "TestProject-watchOS WatchKit App";
                    productReference = 82E0961D222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App.app */;
                    productType = "com.apple.product-type.application.watchapp2";
                };
                82E0962B222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension */ = {
                    isa = PBXNativeTarget;
                    buildConfigurationList = 82E0963D222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOS WatchKit Extension" */;
                    buildPhases = (
                        82E09628222FCCBF006C0DC0 /* Sources */,
                        82E09629222FCCBF006C0DC0 /* Frameworks */,
                        82E0962A222FCCBF006C0DC0 /* Resources */,
                    );
                    buildRules = (
                    );
                    dependencies = (
                    );
                    name = "TestProject-watchOS WatchKit Extension";
                    productName = "TestProject-watchOS WatchKit Extension";
                    productReference = 82E0962C222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension.appex */;
                    productType = "com.apple.product-type.watchkit2-extension";
                };
        /* End PBXNativeTarget section */

        /* Begin PBXProject section */
                82E095ED222FCCBD006C0DC0 /* Project object */ = {
                    isa = PBXProject;
                    attributes = {
                        LastSwiftUpdateCheck = 1010;
                        LastUpgradeCheck = 1010;
                        ORGANIZATIONNAME = "Jamit Labs GmbH";
                        TargetAttributes = {
                            82E095F4222FCCBD006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                            };
                            82E09608222FCCBE006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                                TestTargetID = 82E095F4222FCCBD006C0DC0;
                            };
                            82E09613222FCCBE006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                                TestTargetID = 82E095F4222FCCBD006C0DC0;
                            };
                            82E0961C222FCCBE006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                            };
                            82E0962B222FCCBF006C0DC0 = {
                                CreatedOnToolsVersion = 10.1;
                            };
                        };
                    };
                    buildConfigurationList = 82E095F0222FCCBD006C0DC0 /* Build configuration list for PBXProject "TestProject-watchOS" */;
                    compatibilityVersion = "Xcode 9.3";
                    developmentRegion = en;
                    hasScannedForEncodings = 0;
                    knownRegions = (
                        en,
                        Base,
                    );
                    mainGroup = 82E095EC222FCCBD006C0DC0;
                    productRefGroup = 82E095F6222FCCBD006C0DC0 /* Products */;
                    projectDirPath = "";
                    projectRoot = "";
                    targets = (
                        82E095F4222FCCBD006C0DC0 /* TestProject-watchOS */,
                        82E09608222FCCBE006C0DC0 /* TestProject-watchOSTests */,
                        82E09613222FCCBE006C0DC0 /* TestProject-watchOSUITests */,
                        82E0961C222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App */,
                        82E0962B222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension */,
                    );
                };
        /* End PBXProject section */

        /* Begin PBXResourcesBuildPhase section */
                82E095F3222FCCBD006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E09603222FCCBE006C0DC0 /* LaunchScreen.storyboard in Resources */,
                        82E09600222FCCBE006C0DC0 /* Assets.xcassets in Resources */,
                        82E095FE222FCCBD006C0DC0 /* Main.storyboard in Resources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09607222FCCBE006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09612222FCCBE006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E0961B222FCCBE006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E09626222FCCBF006C0DC0 /* Assets.xcassets in Resources */,
                        82E09624222FCCBE006C0DC0 /* Interface.storyboard in Resources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E0962A222FCCBF006C0DC0 /* Resources */ = {
                    isa = PBXResourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E09638222FCCBF006C0DC0 /* Assets.xcassets in Resources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXResourcesBuildPhase section */

        /* Begin PBXSourcesBuildPhase section */
                82E095F1222FCCBD006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E095FB222FCCBD006C0DC0 /* ViewController.swift in Sources */,
                        82E095F9222FCCBD006C0DC0 /* AppDelegate.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09605222FCCBE006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E0960E222FCCBE006C0DC0 /* TestProject_watchOSTests.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09610222FCCBE006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E09619222FCCBE006C0DC0 /* TestProject_watchOSUITests.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
                82E09628222FCCBF006C0DC0 /* Sources */ = {
                    isa = PBXSourcesBuildPhase;
                    buildActionMask = 2147483647;
                    files = (
                        82E09636222FCCBF006C0DC0 /* NotificationController.swift in Sources */,
                        82E09634222FCCBF006C0DC0 /* ExtensionDelegate.swift in Sources */,
                        82E09632222FCCBF006C0DC0 /* InterfaceController.swift in Sources */,
                    );
                    runOnlyForDeploymentPostprocessing = 0;
                };
        /* End PBXSourcesBuildPhase section */

        /* Begin PBXTargetDependency section */
                82E0960B222FCCBE006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E095F4222FCCBD006C0DC0 /* TestProject-watchOS */;
                    targetProxy = 82E0960A222FCCBE006C0DC0 /* PBXContainerItemProxy */;
                };
                82E09616222FCCBE006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E095F4222FCCBD006C0DC0 /* TestProject-watchOS */;
                    targetProxy = 82E09615222FCCBE006C0DC0 /* PBXContainerItemProxy */;
                };
                82E09620222FCCBE006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E0961C222FCCBE006C0DC0 /* TestProject-watchOS WatchKit App */;
                    targetProxy = 82E0961F222FCCBE006C0DC0 /* PBXContainerItemProxy */;
                };
                82E0962F222FCCBF006C0DC0 /* PBXTargetDependency */ = {
                    isa = PBXTargetDependency;
                    target = 82E0962B222FCCBF006C0DC0 /* TestProject-watchOS WatchKit Extension */;
                    targetProxy = 82E0962E222FCCBF006C0DC0 /* PBXContainerItemProxy */;
                };
        /* End PBXTargetDependency section */

        /* Begin PBXVariantGroup section */
                82E095FC222FCCBD006C0DC0 /* Main.storyboard */ = {
                    isa = PBXVariantGroup;
                    children = (
                        82E095FD222FCCBD006C0DC0 /* Base */,
                    );
                    name = Main.storyboard;
                    sourceTree = "<group>";
                };
                82E09601222FCCBE006C0DC0 /* LaunchScreen.storyboard */ = {
                    isa = PBXVariantGroup;
                    children = (
                        82E09602222FCCBE006C0DC0 /* Base */,
                    );
                    name = LaunchScreen.storyboard;
                    sourceTree = "<group>";
                };
                82E09622222FCCBE006C0DC0 /* Interface.storyboard */ = {
                    isa = PBXVariantGroup;
                    children = (
                        82E09623222FCCBE006C0DC0 /* Base */,
                    );
                    name = Interface.storyboard;
                    sourceTree = "<group>";
                };
        /* End PBXVariantGroup section */

        /* Begin XCBuildConfiguration section */
                82E0963B222FCCBF006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_SEARCH_USER_PATHS = NO;
                        CLANG_ANALYZER_NONNULL = YES;
                        CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                        CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
                        CLANG_CXX_LIBRARY = "libc++";
                        CLANG_ENABLE_MODULES = YES;
                        CLANG_ENABLE_OBJC_ARC = YES;
                        CLANG_ENABLE_OBJC_WEAK = YES;
                        CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                        CLANG_WARN_BOOL_CONVERSION = YES;
                        CLANG_WARN_COMMA = YES;
                        CLANG_WARN_CONSTANT_CONVERSION = YES;
                        CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                        CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                        CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                        CLANG_WARN_EMPTY_BODY = YES;
                        CLANG_WARN_ENUM_CONVERSION = YES;
                        CLANG_WARN_INFINITE_RECURSION = YES;
                        CLANG_WARN_INT_CONVERSION = YES;
                        CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                        CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                        CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                        CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                        CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                        CLANG_WARN_STRICT_PROTOTYPES = YES;
                        CLANG_WARN_SUSPICIOUS_MOVE = YES;
                        CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                        CLANG_WARN_UNREACHABLE_CODE = YES;
                        CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                        CODE_SIGN_IDENTITY = "iPhone Developer";
                        COPY_PHASE_STRIP = NO;
                        DEBUG_INFORMATION_FORMAT = dwarf;
                        ENABLE_STRICT_OBJC_MSGSEND = YES;
                        ENABLE_TESTABILITY = YES;
                        GCC_C_LANGUAGE_STANDARD = gnu11;
                        GCC_DYNAMIC_NO_PIC = NO;
                        GCC_NO_COMMON_BLOCKS = YES;
                        GCC_OPTIMIZATION_LEVEL = 0;
                        GCC_PREPROCESSOR_DEFINITIONS = (
                            "DEBUG=1",
                            "$(inherited)",
                        );
                        GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                        GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                        GCC_WARN_UNDECLARED_SELECTOR = YES;
                        GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                        GCC_WARN_UNUSED_FUNCTION = YES;
                        GCC_WARN_UNUSED_VARIABLE = YES;
                        IPHONEOS_DEPLOYMENT_TARGET = 12.1;
                        MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
                        MTL_FAST_MATH = YES;
                        ONLY_ACTIVE_ARCH = YES;
                        SDKROOT = iphoneos;
                        SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
                        SWIFT_OPTIMIZATION_LEVEL = "-Onone";
                    };
                    name = Debug;
                };
                82E0963C222FCCBF006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_SEARCH_USER_PATHS = NO;
                        CLANG_ANALYZER_NONNULL = YES;
                        CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
                        CLANG_CXX_LANGUAGE_STANDARD = "gnu++14";
                        CLANG_CXX_LIBRARY = "libc++";
                        CLANG_ENABLE_MODULES = YES;
                        CLANG_ENABLE_OBJC_ARC = YES;
                        CLANG_ENABLE_OBJC_WEAK = YES;
                        CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
                        CLANG_WARN_BOOL_CONVERSION = YES;
                        CLANG_WARN_COMMA = YES;
                        CLANG_WARN_CONSTANT_CONVERSION = YES;
                        CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
                        CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
                        CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
                        CLANG_WARN_EMPTY_BODY = YES;
                        CLANG_WARN_ENUM_CONVERSION = YES;
                        CLANG_WARN_INFINITE_RECURSION = YES;
                        CLANG_WARN_INT_CONVERSION = YES;
                        CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
                        CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
                        CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
                        CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
                        CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
                        CLANG_WARN_STRICT_PROTOTYPES = YES;
                        CLANG_WARN_SUSPICIOUS_MOVE = YES;
                        CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
                        CLANG_WARN_UNREACHABLE_CODE = YES;
                        CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
                        CODE_SIGN_IDENTITY = "iPhone Developer";
                        COPY_PHASE_STRIP = NO;
                        DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
                        ENABLE_NS_ASSERTIONS = NO;
                        ENABLE_STRICT_OBJC_MSGSEND = YES;
                        GCC_C_LANGUAGE_STANDARD = gnu11;
                        GCC_NO_COMMON_BLOCKS = YES;
                        GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
                        GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
                        GCC_WARN_UNDECLARED_SELECTOR = YES;
                        GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
                        GCC_WARN_UNUSED_FUNCTION = YES;
                        GCC_WARN_UNUSED_VARIABLE = YES;
                        IPHONEOS_DEPLOYMENT_TARGET = 12.1;
                        MTL_ENABLE_DEBUG_INFO = NO;
                        MTL_FAST_MATH = YES;
                        SDKROOT = iphoneos;
                        SWIFT_COMPILATION_MODE = wholemodule;
                        SWIFT_OPTIMIZATION_LEVEL = "-O";
                        VALIDATE_PRODUCT = YES;
                    };
                    name = Release;
                };
                82E0963E222FCCBF006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_COMPLICATION_NAME = Complication;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-watchOS WatchKit Extension/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@executable_path/../../Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOS.watchkitapp.watchkitextension";
                        PRODUCT_NAME = "${TARGET_NAME}";
                        SDKROOT = watchos;
                        SKIP_INSTALL = YES;
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 4;
                        WATCHOS_DEPLOYMENT_TARGET = 5.1;
                    };
                    name = Debug;
                };
                82E0963F222FCCBF006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_COMPLICATION_NAME = Complication;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-watchOS WatchKit Extension/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@executable_path/../../Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOS.watchkitapp.watchkitextension";
                        PRODUCT_NAME = "${TARGET_NAME}";
                        SDKROOT = watchos;
                        SKIP_INSTALL = YES;
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 4;
                        WATCHOS_DEPLOYMENT_TARGET = 5.1;
                    };
                    name = Release;
                };
                82E09642222FCCBF006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                        CODE_SIGN_STYLE = Automatic;
                        IBSC_MODULE = TestProject_watchOS_WatchKit_Extension;
                        INFOPLIST_FILE = "TestProject-watchOS WatchKit App/Info.plist";
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOS.watchkitapp";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SDKROOT = watchos;
                        SKIP_INSTALL = YES;
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 4;
                        WATCHOS_DEPLOYMENT_TARGET = 5.1;
                    };
                    name = Debug;
                };
                82E09643222FCCBF006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                        CODE_SIGN_STYLE = Automatic;
                        IBSC_MODULE = TestProject_watchOS_WatchKit_Extension;
                        INFOPLIST_FILE = "TestProject-watchOS WatchKit App/Info.plist";
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOS.watchkitapp";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SDKROOT = watchos;
                        SKIP_INSTALL = YES;
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = 4;
                        WATCHOS_DEPLOYMENT_TARGET = 5.1;
                    };
                    name = Release;
                };
                82E09646222FCCBF006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-watchOS/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOS";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                    };
                    name = Debug;
                };
                82E09647222FCCBF006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-watchOS/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOS";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                    };
                    name = Release;
                };
                82E09649222FCCBF006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        BUNDLE_LOADER = "$(TEST_HOST)";
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-watchOSTests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOSTests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                        TEST_HOST = "$(BUILT_PRODUCTS_DIR)/TestProject-watchOS.app/TestProject-watchOS";
                    };
                    name = Debug;
                };
                82E0964A222FCCBF006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        BUNDLE_LOADER = "$(TEST_HOST)";
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-watchOSTests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOSTests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                        TEST_HOST = "$(BUILT_PRODUCTS_DIR)/TestProject-watchOS.app/TestProject-watchOS";
                    };
                    name = Release;
                };
                82E0964C222FCCBF006C0DC0 /* Debug */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-watchOSUITests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOSUITests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                        TEST_TARGET_NAME = "TestProject-watchOS";
                    };
                    name = Debug;
                };
                82E0964D222FCCBF006C0DC0 /* Release */ = {
                    isa = XCBuildConfiguration;
                    buildSettings = {
                        ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                        CODE_SIGN_STYLE = Automatic;
                        INFOPLIST_FILE = "TestProject-watchOSUITests/Info.plist";
                        LD_RUNPATH_SEARCH_PATHS = (
                            "$(inherited)",
                            "@executable_path/Frameworks",
                            "@loader_path/Frameworks",
                        );
                        PRODUCT_BUNDLE_IDENTIFIER = "com.jamitlabs.TestProject-watchOSUITests";
                        PRODUCT_NAME = "$(TARGET_NAME)";
                        SWIFT_VERSION = 4.2;
                        TARGETED_DEVICE_FAMILY = "1,2";
                        TEST_TARGET_NAME = "TestProject-watchOS";
                    };
                    name = Release;
                };
        /* End XCBuildConfiguration section */

        /* Begin XCConfigurationList section */
                82E095F0222FCCBD006C0DC0 /* Build configuration list for PBXProject "TestProject-watchOS" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E0963B222FCCBF006C0DC0 /* Debug */,
                        82E0963C222FCCBF006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E0963D222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOS WatchKit Extension" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E0963E222FCCBF006C0DC0 /* Debug */,
                        82E0963F222FCCBF006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E09641222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOS WatchKit App" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E09642222FCCBF006C0DC0 /* Debug */,
                        82E09643222FCCBF006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E09645222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOS" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E09646222FCCBF006C0DC0 /* Debug */,
                        82E09647222FCCBF006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E09648222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOSTests" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E09649222FCCBF006C0DC0 /* Debug */,
                        82E0964A222FCCBF006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
                82E0964B222FCCBF006C0DC0 /* Build configuration list for PBXNativeTarget "TestProject-watchOSUITests" */ = {
                    isa = XCConfigurationList;
                    buildConfigurations = (
                        82E0964C222FCCBF006C0DC0 /* Debug */,
                        82E0964D222FCCBF006C0DC0 /* Release */,
                    );
                    defaultConfigurationIsVisible = 0;
                    defaultConfigurationName = Release;
                };
        /* End XCConfigurationList section */
            };
            rootObject = 82E095ED222FCCBD006C0DC0 /* Project object */;
        }
        """
}
