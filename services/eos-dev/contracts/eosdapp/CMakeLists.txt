add_executable(esodapp.wasm
   ${CMAKE_CURRENT_SOURCE_DIR}/src/esodapp.cpp
   )

target_compile_options(esodapp.wasm PUBLIC --std=c++17 -fcolor-diagnostics)

target_include_directories(esodapp.wasm
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(esodapp.wasm
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/esodapp.abi" "${CMAKE_CURRENT_BINARY_DIR}" COPYONLY)
