#!/usr/bin/env bats

export PROJECT_NAME=BulletinBoard

setup() {

    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 2.0.1' "alexaubry" "${PROJECT_NAME}" > Cartfile

    echo "# ${BATS_TMPDIR}" >&3

}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds ${PROJECT_NAME}" {
    
    if [ -n "${skip_BulletinBoard}" ]; then
        skip "the variable skip_BulletinBoard is not empy: ${skip_BulletinBoard}"
    fi

    # tvOS does not compile
    run carthage update --no-use-binaries --cache-builds --platform iOS

    [ "$status" -eq 0 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]

    export __BUILD_PLATFORM__=iOS
    # iOS
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/BLTNBoard.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/BLTNBoard.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/${__BUILD_PLATFORM__}/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 2 ]
}

