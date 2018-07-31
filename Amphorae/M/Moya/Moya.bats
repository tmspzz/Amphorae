#!/usr/bin/env bats

export PROJECT_NAME=Moya

setup() {

    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    printf 'github "%s/%s" ~> 11.0.2' "${PROJECT_NAME}" "${PROJECT_NAME}" > Cartfile

    echo "# ${BATS_TMPDIR}" >&3

}

teardown() {

    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds ${PROJECT_NAME}" {
    
    if [ -n "${skip_moya}" ]; then
        skip "the variable skip_facebook_ios_sdk is not empy: ${skip_moya}"
    fi

    # tvOS does not compile
    run carthage update --no-use-binaries --cache-builds --platform iOS,tvOS,macOS

    [ "$status" -eq 0 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]
    [ -e "Carthage/Build/.Alamofire.version" ]
    [ -e "Carthage/Build/.ReactiveSwift.version" ]
    [ -e "Carthage/Build/.RxSwift.version" ]

    export __BUILD_PLATFORM__=Mac
    # Mac
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Alamofire.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Alamofire.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveMoya.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveMoya.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveSwift.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveSwift.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Result.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Result.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxBlocking.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxBlocking.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxCocoa.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxCocoa.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxMoya.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxMoya.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxSwift.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxSwift.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxTest.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxTest.framework.dSYM" ]

    export __BUILD_PLATFORM__=iOS

    # iOS
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Alamofire.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Alamofire.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveMoya.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveMoya.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveSwift.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveSwift.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Result.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Result.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxBlocking.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxBlocking.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxCocoa.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxCocoa.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxMoya.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxMoya.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxSwift.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxSwift.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxTest.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxTest.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/${__BUILD_PLATFORM__}/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 18 ]

    export __BUILD_PLATFORM__=tvOS

    # tvOS
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Alamofire.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Alamofire.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveMoya.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveMoya.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveSwift.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveSwift.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Result.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Result.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxBlocking.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxBlocking.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxCocoa.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxCocoa.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxMoya.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxMoya.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxSwift.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxSwift.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxTest.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxTest.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/${__BUILD_PLATFORM__}/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 9 ]

    #    export __BUILD_PLATFORM__=watchOS

    # watchOS -- Not working
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/${PROJECT_NAME}.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Alamofire.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Alamofire.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveMoya.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveMoya.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveSwift.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ReactiveSwift.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Result.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Result.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxBlocking.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxBlocking.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxCocoa.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxCocoa.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxMoya.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxMoya.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxSwift.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxSwift.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxTest.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/RxTest.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/${__BUILD_PLATFORM__}/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 9 ]
}

