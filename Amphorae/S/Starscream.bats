#!/usr/bin/env bats

export PROJECT_NAME=Starscream

setup() {

    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 3.0.5' "daltoniam" "${PROJECT_NAME}" > Cartfile

    echo "# ${BATS_TMPDIR}" >&3

}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds ${PROJECT_NAME}" {

    run carthage update --no-use-binaries --cache-builds

    [ "$status" -eq 0 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]

    # Mac
    [ -d "Carthage/Build/Mac/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/Mac/${PROJECT_NAME}.framework.dSYM" ]

    # iOS
    [ -d "Carthage/Build/iOS/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/iOS/${PROJECT_NAME}.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/iOS/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 2 ]

    # tvOS
    [ -d "Carthage/Build/tvOS/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/tvOS/${PROJECT_NAME}.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/tvOS/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 1 ]

    # watchOS
    [ -d "Carthage/Build/watchOS/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/watchOS/${PROJECT_NAME}.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/watchOS/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 1 ]
}

