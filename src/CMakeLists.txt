cmake_minimum_required(VERSION 3.20)
project(artificial-intelligence VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_compile_options(-g -O2 -DNDEBUG -Wall -Wextra -Weffc++ -Wconversion -Wsign-conversion -pedantic-errors -Werror -std=c++23)

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS 
    "main.cpp"
    "state_exploration/*.cpp"
)

add_executable(main ${SOURCES})

target_include_directories(main PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/state_exploration
    ${CMAKE_CURRENT_SOURCE_DIR}/state_exploration/examples
)

set_target_properties(main PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}"
)