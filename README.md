# Qt Quick QML C++ CMake 示例

这是一个最小的 Qt Quick + QML + C++ + CMake 示例项目。

目录结构：
- src/: C++ 源代码与 `CMakeLists.txt`
- qml/: QML 文件
- CMakeLists.txt: 顶层 CMake 配置

构建（Qt6）示例：

```bash
mkdir build
cd build
cmake .. -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x/\
  # 示例: /opt/Qt/6.5.0/gcc_64/lib/cmake
cmake --build . --config Release

# 运行
./qt_quick_app
```

如果你使用 Qt5，需要调整 CMake 文件，或使用 `find_package(Qt5 COMPONENTS Quick REQUIRED)` 并链接 `Qt5::Quick`。

如需我代为构建或切换到 Qt5 风格的 CMake，请告诉我。