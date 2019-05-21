#!/usr/bin/env bats
export PROJECT_NAME=HockeySDK-iOS

setup() {

    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 5.1' "bitstadium" "${PROJECT_NAME}" > Cartfile

    echo "# ${BATS_TMPDIR}" >&3

}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds ${PROJECT_NAME}" {

    carthage update --no-use-binaries --cache-builds
 
    [ 1 -eq 2 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]

    # iOS
    [ -d "Carthage/Build/iOS/HockeySDK.framework" ]
    [ -d "Carthage/Build/iOS/HockeySDK.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/iOS/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 2 ]

    # # tvOS
    # [ -d "Carthage/Build/tvOS/${PROJECT_NAME}.framework" ]
    # [ -d "Carthage/Build/tvOS/${PROJECT_NAME}.framework.dSYM" ]

    # symbolmapsCount=$(ls -lR Carthage/Build/tvOS/*.bcsymbolmap | wc -l)
    # [ "$symbolmapsCount" -eq 1 ]
}
