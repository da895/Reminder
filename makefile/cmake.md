# CMake



* [modern cmake from gitlab](https://cliutils.gitlab.io/modern-cmake/)

* [cmake useful variable](https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/Useful-Variables)

| Variable                 | Info                                                         |
| ------------------------ | ------------------------------------------------------------ |
| CMAKE_SOURCE_DIR         | The root source directory                                    |
| CMAKE_CURRENT_SOURCE_DIR | The current source directory if using sub-projects and directories. |
| PROJECT_SOURCE_DIR       | The source directory of the current cmake project.           |
| CMAKE_BINARY_DIR         | The root binary / build directory. This is the directory where you ran the cmake command. |
| CMAKE_CURRENT_BINARY_DIR | The build directory you are currently in.                    |
| PROJECT_BINARY_DIR       | The build directory for the current project.                 |

* [effective_modern_cmake](https://github.com/boostcon/cppnow_presentations_2017)
* [Embracing Modern CMake: How to recognize and use modern CMake interfaces -- Stephen Kelly AT Dublin C++ Meetup](./embracing-modern-cmake.pdf)
* Modern CMake for modular design -- Mathieu Ropert AT CppCon-2017
* More Modern CMake: Working With CMake 3.12 And Later -- Deniz Bahadir AT Meeting C++ 2018
* Compile Dependency

```cmake
target_include_directories (<target> 
<PUBLIC|PRIVATE|INTERFACE> 
[items...])
```

|  |  |
| --------- | ------------------------------------- |
| **PRIVATE** | Needed by me, but **not** my dependers |
| **PUBLIC** | Needed by me **and** my dependers     |
| **INTERFACE** | Needed **not** by me, **but** by my dependers |

* Build Properties

Support <PRIVATE|PUBLIC|INTERFACE> and transtivity

|                                            |                            |
| ------------------------------------------ | -------------------------- |
| **Include Directories**<br />(-I /foo/bar) | target_include_directories |
| **Compile Definitions**<br />(-DSOMEDEF)   | target_compile_definitions |
| **Compile Options**<br />(-fPIC)           | target_compile_options     |
| **Link Libraries**<br />(-l/path/to/lib)   | target_link_libraries      |
| **Sources**                                | target_sources             |

* Avoid unnecessary variables
* Generator Expressions 
  * Basics

|                          |                       |
| ------------------------ | --------------------- |
| `$<1:...>`               | ...                   |
| `$<0:...>`               |                       |
| `$<Config:Debug>`        | 1 (in Debug config)   |
| `$<Config:Debug>`        | 0 (in Debug config)   |
| `$<$<Config:Debug>:...>` | ... (in Debug config) |
| `$<$<Config:Debug>:...>` | (in Debug config)     |

  * Truthiness  conversion

`$<$<BOOL:${WIN32}>:...>` at configure time produces

`$<$<BOOL:1>:...>` or `$<$<BOOL:>:...>` at generate-time!

  * Support for generator expression
	* `target_`  command
	* `file(GENERATE)` command
	* `add_executable/add_library` commands
	* `install` command (partial)
	* `add_custom_target` command (partial)
	* `add_custom_command` command(partial)

There are others, but these are the most important