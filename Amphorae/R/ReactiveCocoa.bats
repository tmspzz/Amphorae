#!/usr/bin/env bats

setup() {

    export PROJECT_NAME=ReactiveCocoa
    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 8.0.0' "${PROJECT_NAME}" "${PROJECT_NAME}" > Cartfile

    echo $BATS_TMPDIR

}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds ReactiveCocoa" {

    run carthage update --no-use-binaries --cache-builds

    [ "$status" -eq 0 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]

    # Mac
    [ -d "Carthage/Build/Mac/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/Mac/${PROJECT_NAME}.framework.dSYM" ]
    [ -d "Carthage/Build/Mac/ReactiveMapKit.framework" ]
    [ -d "Carthage/Build/Mac/ReactiveMapKit.framework.dSYM" ]

    # iOS
    [ -d "Carthage/Build/iOS/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/iOS/${PROJECT_NAME}.framework.dSYM" ]
    [ -d "Carthage/Build/iOS/ReactiveMapKit.framework" ]
    [ -d "Carthage/Build/iOS/ReactiveMapKit.framework.dSYM" ]

    # tvOS
    [ -d "Carthage/Build/tvOS/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/tvOS/${PROJECT_NAME}.framework.dSYM" ]
    [ -d "Carthage/Build/tvOS/ReactiveMapKit.framework" ]
    [ -d "Carthage/Build/tvOS/ReactiveMapKit.framework.dSYM" ]

    # watchOS
    [ -d "Carthage/Build/watchOS/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/watchOS/${PROJECT_NAME}.framework.dSYM" ]
}