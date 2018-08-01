#!/usr/bin/env bats

export PROJECT_NAME=apollo-ios

setup() {

    cd $BATS_TMPDIR
    rm -rf carthage_${PROJECT_NAME}
    mkdir carthage_${PROJECT_NAME} && cd carthage_${PROJECT_NAME}
    
    if [ -n "${apollo_ios_branch}" ]; then
        echo "# The variable apollo_ios_branch is not empy. Using ${apollo_ios_branch} in Cartfile." >&3
        printf 'github "%s/%s" "%s"' "apollographql" "${PROJECT_NAME}" "${apollo_ios_branch}" > Cartfile
    else
        echo "# The variable apollo_ios_branch empy. Using  0.9.2 in Cartfile." >&3
        printf 'github "%s/%s" ~> 0.9.2' "apollographql" "${PROJECT_NAME}" > Cartfile
    fi

    echo "# ${BATS_TMPDIR}" >&3
}

teardown() {

    tail -n 100 build.log
    cd $BATS_TEST_DIRNAME
    rm -rf carthage_${PROJECT_NAME}
}

@test "Carthage builds ${PROJECT_NAME}" {
    
    if [ -n "${skip_apollo_ios}" ]; then
        skip "the variable skip_apollo_ios is not empy: ${skip_apollo_ios}"
    fi

    run carthage update --no-use-binaries --cache-builds --log-path build.log

    [ "$status" -eq 0 ]

    # Version file
    [ -e "Carthage/Build/.${PROJECT_NAME}.version" ]
    [ -e "Carthage/Build/.SQLite.swift.version" ]
    [ -e "Carthage/Build/.Starscream.version" ]


    export __BUILD_PLATFORM__=Mac
    
    # Mac
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Apollo.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Apollo.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloSQLite.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloSQLite.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloWebSocket.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloWebSocket.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Starscream.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Starscream.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/SQLite.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/SQLite.framework.dSYM" ]

    export __BUILD_PLATFORM__=iOS

    # iOS
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Apollo.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Apollo.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloSQLite.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloSQLite.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloWebSocket.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloWebSocket.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Starscream.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Starscream.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/SQLite.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/SQLite.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/${__BUILD_PLATFORM__}/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 10 ]
    
    export __BUILD_PLATFORM__=tvOS

    # tvOS
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Apollo.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Apollo.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloSQLite.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloSQLite.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloWebSocket.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloWebSocket.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Starscream.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Starscream.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/SQLite.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/SQLite.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/${__BUILD_PLATFORM__}/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 5 ]

    export __BUILD_PLATFORM__=watchOS

    # watchOS
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Apollo.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Apollo.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloSQLite.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloSQLite.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloWebSocket.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/ApolloWebSocket.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Starscream.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/Starscream.framework.dSYM" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/SQLite.framework" ]
    [ -d "Carthage/Build/${__BUILD_PLATFORM__}/SQLite.framework.dSYM" ]

    symbolmapsCount=$(ls -lR Carthage/Build/${__BUILD_PLATFORM__}/*.bcsymbolmap | wc -l)
    [ "$symbolmapsCount" -eq 5 ]
}

