set(SOURCES
  main.cpp
  Backend.cpp
)

qt_add_executable(qt_quick_app
  ${SOURCES}
  qml.qrc
)

target_link_libraries(qt_quick_app PRIVATE Qt6::Quick Qt6::QuickControls2)

if (WIN32)
  set_target_properties(qt_quick_app PROPERTIES WIN32_EXECUTABLE TRUE)
endif()
