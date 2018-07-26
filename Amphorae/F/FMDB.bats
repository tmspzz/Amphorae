#!/usr/bin/env bats

setup() {

    export PROJECT_NAME=fmdb
    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 2.7.4' "ccgus" "${PROJECT_NAME}" > Cartfile

    echo $BATS_TMPDIR

}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds fmdb" {

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
}

