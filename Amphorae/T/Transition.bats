#!/usr/bin/env bats

export PROJECT_NAME=Transition

setup() {

    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 1.2.0' "Touchwonders" "${PROJECT_NAME}" > Cartfile

    echo "# ${BATS_TMPDIR}" >&3
}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds ${PROJECT_NAME}" {
    
    if [ -n "${skip_Transition}" ]; then
        skip "the variable skip_Transition is not empy: ${skip_Transition}"
    fi

    run carthage update --no-use-binaries --cache-builds

    [ "$status" -eq 0 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]

    export __BUILD_PLATFORM__=iOS

    # iOS
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/${__BUILD_PLATFORM__}/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 2 ]
}