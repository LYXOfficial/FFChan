set(SOURCES
  main.cpp
  Settings.cpp
  Settings.h
  Loader.cpp
  Loader.h
  Translator.cpp
  Translator.h
  Sysfetch.cpp
  Sysfetch.h
  SettingsBridge.cpp
  SettingsBridge.h
  ThemeManager.cpp
  ThemeManager.h
)

qt_add_qml_module(qt_quick_app_qml
  URI FFChan
  VERSION 1.0
  OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/src/FFChan
  QML_FILES
    ../qml/MainWindow.qml
    ../qml/Wizard.qml
)

# On Windows, if the user provided an icon.ico in project root, include a resource
# file so the generated executable has that icon. The rc references ../icon.ico.
if (WIN32)
  if(EXISTS ${CMAKE_SOURCE_DIR}/icon.ico)
    message(STATUS "Found icon.ico; adding Windows resources for executable icon.")
    list(APPEND SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/icon.rc)
  else()
    message(STATUS "No icon.ico found in project root; Windows executable will not have bundled icon.")
  endif()
endif()

qt_add_executable(qt_quick_app
  ${SOURCES}
  qml.qrc
)

target_link_libraries(qt_quick_app PRIVATE Qt6::Quick Qt6::QuickControls2 Qt6::Qml Qt6::Widgets)

# Link QtAwesome if available from FetchContent
if (TARGET QtAwesome)
  target_link_libraries(qt_quick_app PRIVATE QtAwesome)
elseif(TARGET QtAwesome::QtAwesome)
  target_link_libraries(qt_quick_app PRIVATE QtAwesome::QtAwesome)
endif()

find_package(yaml-cpp REQUIRED)
target_link_libraries(qt_quick_app PRIVATE yaml-cpp::yaml-cpp)

if (WIN32)
  set_target_properties(qt_quick_app PROPERTIES WIN32_EXECUTABLE TRUE)
endif()
