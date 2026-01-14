cmake_minimum_required(VERSION 3.16)
project(qt_quick_app LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Quick QuickControls2 REQUIRED)

add_subdirectory(src)
