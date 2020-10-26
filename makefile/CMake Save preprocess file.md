## CMake Save preprocess file



在 CMake 中保存预处理后的文件（如 `.i` 或 `.ii` 文件），可通过以下方法实现：

------

### 一、‌**GCC/Clang 编译器选项**‌

通过 `CMAKE_C_FLAGS` 或 `CMAKE_CXX_FLAGS` 添加 `-save-temps=obj` 选项，生成预处理文件到构建目录：

```
cmakeCopy Codeset(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -save-temps=obj")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -save-temps=obj")
```

‌**效果**‌：编译时自动生成 `.i`（C）或 `.ii`（C++）文件，存放于 `CMakeFiles/<target>.dir/` 子目录中‌。

------

### 二、‌**分阶段生成预处理文件**‌

1. ‌**手动调用预处理器**‌
   使用 `make <target>.i` 命令（需确保 Makefile 已生成）：

   ```
   make my_target.i
   ```

   适用于 CMake 生成的 Makefile 项目‌。

2. ‌**直接调用编译器**‌
   通过 `-E` 选项仅执行预处理：

   ```
   gcc -E source.c -o source.i
   ```

   需手动指定输入输出文件‌。

------

### 三、‌**CMake 自定义命令**‌

通过 `add_custom_command` 在构建流程中插入预处理步骤：

```
cmakeCopy Codeadd_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/preprocessed.i
  COMMAND ${CMAKE_C_COMPILER} -E ${CMAKE_CURRENT_SOURCE_DIR}/source.c > ${CMAKE_CURRENT_BINARY_DIR}/preprocessed.i
  DEPENDS source.c
)
```

‌**优势**‌：可精确控制预处理文件的生成路径和命名‌。

------

### 四、‌**调试与验证**‌

- ‌**检查生成路径**‌
  预处理文件默认保存在 `CMakeFiles/<target>.dir/` 或构建目录的 `CMakeFiles/` 子目录中‌。
- ‌**查看内容**‌
  使用文本编辑器或 `cat` 命令确认预处理结果是否包含宏展开和头文件内容‌34。

------

### 五、‌**注意事项**‌

1. ‌**清理中间文件**‌
   `-save-temps` 生成的文件需手动清理，避免占用磁盘空间‌1。
2. ‌**跨平台兼容性**‌
   MSVC 需使用 `/P` 或 `/EP` 选项，需通过 `CMAKE_CXX_FLAGS` 适配‌
