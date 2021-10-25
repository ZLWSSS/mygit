cmake_minimum_required(VERSION 2.8)

project(Linkage_Mechanisms)

set(CMAKE_BUILD_TYPE "Debug")

add_library(linkageIF Kinetics.cpp)
add_library(linkage_shared SHARED Kinetics.cpp)

add_executable(linkage main.cpp)
target_link_libraries(linkage linkage_shared)
