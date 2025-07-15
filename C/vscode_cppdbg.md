## vscode+cppdbg+Mingw



### 一、基础环境配置

1. ‌**安装 MinGW-w64**‌

   - 推荐下载 `x86_64-posix-seh` 版本（[SourceForge](https://sourceforge.net/projects/mingw-w64/)）并解压至无空格路径（如 `D:\mingw64`）‌
   - 将 `bin` 目录（如 `D:\mingw64\bin`）添加到系统环境变量，终端验证 `gcc -v` 和 `gdb -v`‌

2. ‌**安装 CMake**‌

   - 从官网下载二进制包并配置环境变量（如 `D:\cmake\bin`）‌
   - 验证安装：`cmake --version`‌

3. ‌**VSCode 插件**‌

   - 必装：`C/C++`、`CMake`、`CMake Tools`

   ### 二、CMake 项目配置

   1. ‌**项目结构示例**‌

      ```
      textCopy Codeproject/
      ├── CMakeLists.txt
      ├── src/
      │   ├── main.cpp
      │    └── module.cpp
      ```

   2. ‌**CMakeLists.txt 关键配置**‌

      ```
      cmakeCopy Codecmake_minimum_required(VERSION 3.10)
      project(MyProject)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g")  # 启用调试信
      add_executable(app src/main.cpp src/module.cpp)
      ```

   ### 三、调试配置

   1. ‌**生成构建系统**‌

      - 在项目目录执行：

        ```
        bashCopy Codecmake -B build -G "MinGW Makefiles"
        cmake --build build
        ```

   2. ‌**launch.json 配置**‌

      ```
      jsonCopy Code{
        "version": "0.2.0",
        "configurations": [
          {
            "name": "(gdb) Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/build/app.exe",  # 匹配CMake生成的可执行文
            "miDebuggerPath": "D:/mingw64/bin/gdb.exe",     # 修改为实际路
            "setupCommands": [ ... ]
          }
        ]
      }
      ```

   ### 四、调试流程

   1. ‌**启动调试**‌
      - 按 `F5` 自动构建并启动调试，支持断点、变量监视等功能‌
   2. ‌**常见问题**‌
      - ‌**路径错误**‌：检查 `miDebuggerPath` 和 `program` 路径是否匹配‌
      - ‌**编码问题**‌：在 `tasks.json` 中添加 `chcp 65001` 解决终端乱码‌

   ### 五、多文件项目管理

   - 在 `CMakeLists.txt` 中使用 `add_library` 和 `target_link_libraries` 管理模块‌
   - 通过 `include_directories` 指定头文件路径‌
   - 提示：使用 `CMake: Configure` 命令可快速生成构建配置

### 	

### 	六、[Using GCC with MinGW](https://code.visualstudio.com/docs/cpp/config-mingw)