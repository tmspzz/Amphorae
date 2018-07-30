#!/usr/bin/env bats

export PROJECT_NAME=facebook-ios-sdk

setup() {

    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 4.35.0' "facebook" "${PROJECT_NAME}" > Cartfile

    echo "# ${BATS_TMPDIR}" >&3

}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds ${PROJECT_NAME}" {
    
    if [ -n "${skip_facebook_ios_sdk}" ]; then
        skip "the variable skip_facebook_ios_sdk is not empy ${skip_facebook_ios_sdk}"
    fi

    # tvOS does not compile
    run carthage update --no-use-binaries --cache-builds --platform iOS

    [ "$status" -eq 0 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]
    [ -e "Carthage/Build/.Bolts-ObjC.version" ]

    # iOS
    [ -d "Carthage/Build/iOS/FBSDKCoreKit.framework" ]
    [ -d "Carthage/Build/iOS/FBSDKCoreKit.framework.dSYM" ]
    [ -d "Carthage/Build/iOS/FBSDKLoginKit.framework" ]
    [ -d "Carthage/Build/iOS/FBSDKLoginKit.framework.dSYM" ]
    [ -d "Carthage/Build/iOS/FBSDKPlacesKit.framework" ]
    [ -d "Carthage/Build/iOS/FBSDKPlacesKit.framework.dSYM" ]
    [ -d "Carthage/Build/iOS/FBSDKShareKit.framework" ]
    [ -d "Carthage/Build/iOS/FBSDKShareKit.framework.dSYM" ]
    [ -d "Carthage/Build/iOS/Bolts.framework" ]
    [ -d "Carthage/Build/iOS/Bolts.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/iOS/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 10 ]
}

