cmake_minimum_required(VERSION 3.16)
project(qt_quick_app LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Generate QML LSP/QLS ini so tools like qmllint and the QML language server can find imports
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 COMPONENTS Quick QuickControls2 Widgets Qml REQUIRED)

# Fetch QtAwesome (provides Font Awesome icons for Qt)
include(FetchContent)
FetchContent_Declare(
	QtAwesome
	GIT_REPOSITORY https://github.com/gamecreature/QtAwesome.git
	GIT_TAG        main
)
FetchContent_MakeAvailable(QtAwesome)

add_subdirectory(src)
