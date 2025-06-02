# cmake import 3rd part library dll



To import and link a third-party DLL in CMake, follow these steps:

   

- Define the DLL and its import library as an `IMPORTED` library target: 

```cmake
    add_library(MyExternalLib SHARED IMPORTED)
    set_target_properties(MyExternalLib PROPERTIES
        IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/path/to/your/dll/MyExternalLib.dll"
        IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/path/to/your/lib/MyExternalLib.lib"
        INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/path/to/your/headers"
    )
```

- `SHARED`: Indicates it's a shared library (DLL). 
- `IMPORTED`: Tells CMake that this library is already built and located outside the project. 
- `IMPORTED_LOCATION`: Specifies the full path to the `.dll` file. 
- `IMPORTED_IMPLIB`: Specifies the full path to the import `.lib` file (essential for linking on Windows). 
- `INTERFACE_INCLUDE_DIRECTORIES`: Specifies the path to the header files required by the DLL.



- **Link your executable or other library to the imported target:**



```
    target_link_libraries(YourTarget PRIVATE MyExternalLib)
```

- `YourTarget`: Replace with the name of your executable or library that needs to use the DLL.

 

`PRIVATE`: Indicates that `MyExternalLib` is only used internally by `YourTarget` and not exposed to other targets that link to `YourTarget`. Use `PUBLIC` if `MyExternalLib`'s headers or symbols are part of `YourTarget`'s public interface.



- **Ensure the DLL is discoverable at runtime:**

 

- **Place the DLL in the same directory as the executable:** 

  This is the simplest and often preferred method for deployment.

 

Add the DLL's directory to the system's `PATH` environment variable: This is generally less recommended for specific project dependencies as it can lead to conflicts.

 

Use `install(FILES ... DESTINATION ...)` in your `CMakeLists.txt`: If you're installing your project, you can instruct CMake to copy the DLL  to the installation directory alongside your executable.



Example `CMakeLists.txt` snippet:

```cmake
cmake_minimum_required(VERSION 3.10)
project(MyProject CXX)

# Define the imported DLL
add_library(MyExternalLib SHARED IMPORTED)
set_target_properties(MyExternalLib PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/third_party/lib/MyExternalLib.dll"
    IMPORTED_IMPLIB "${CMAKE_CURRENT_SOURCE_DIR}/third_party/lib/MyExternalLib.lib"
    INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/third_party/include"
)

# Add your executable
add_executable(MyApp main.cpp)

# Link your executable to the imported DLL
target_link_libraries(MyApp PRIVATE MyExternalLib)

# (Optional) If you want to install the DLL alongside your executable
install(TARGETS MyApp DESTINATION bin)
install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/third_party/lib/MyExternalLib.d
```