#!/usr/bin/env bats

export PROJECT_NAME=Macaw

setup() {

    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 0.9.2' "exyte" "${PROJECT_NAME}" > Cartfile

    echo "# ${BATS_TMPDIR}" >&3
}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds ${PROJECT_NAME}" {
    
    if [ -n "${skip_Macaw}" ]; then
        skip "the variable skip_Macaw is not empy: ${skip_Macaw}"
    fi

    run carthage update --no-use-binaries --cache-builds

    [ "$status" -eq 0 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]

    export __BUILD_PLATFORM__=Mac
    
    # Mac
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}OSX.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}OSX.framework.dSYM" ]

    export __BUILD_PLATFORM__=iOS

    # iOS
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/${__BUILD_PLATFORM__}/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 2 ]
}

