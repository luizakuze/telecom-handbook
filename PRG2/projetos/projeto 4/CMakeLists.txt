cmake_minimum_required(VERSION 3.22)
project(thash)

set(CMAKE_CXX_STANDARD 17)

add_executable(thash main.cpp thash.h)

include(FetchContent)
FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG release-1.12.1
)
FetchContent_MakeAvailable(googletest)
include_directories(googletest/include googletest .)
add_executable(runTest  runTest.cpp runTest.cpp)
target_link_libraries(runTest gtest gtest_main)