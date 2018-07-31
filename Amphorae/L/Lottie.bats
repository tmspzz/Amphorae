#!/usr/bin/env bats

setup() {

    export PROJECT_NAME=lottie-ios
    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 2.5.0' "airbnb" "${PROJECT_NAME}" > Cartfile

    echo "# ${BATS_TMPDIR}" >&3

}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds lottie-ios" {

    # tvOS target is broken: https://github.com/airbnb/lottie-ios/issues/550
    run carthage update --platform iOS,macOS --no-use-binaries --cache-builds

    [ "$status" -eq 0 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]

    # Mac
    [ -d "Carthage/Build/Mac/Lottie.framework" ]
    [ -d "Carthage/Build/Mac/Lottie.framework.dSYM" ]

    # iOS
    [ -d "Carthage/Build/iOS/Lottie.framework" ]
    [ -d "Carthage/Build/iOS/Lottie.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/iOS/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 2 ]

    # tvOS target is broken: https://github.com/airbnb/lottie-ios/issues/550
    # [ -d "Carthage/Build/tvOS/Lottie.framework" ]
    # [ -d "Carthage/Build/tvOS/Lottie.framework.dSYM" ]

    # symbolmapsCount=$(ls -lR Carthage/Build/tvOS/*.bcsymbolmap | wc -l)
    # [ "$symbolmapsCount" -eq 1 ]
}

