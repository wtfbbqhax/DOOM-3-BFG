cmake_minimum_required(VERSION 3.6)
project( IDTECH4 C CXX )
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include_directories(libs/glew/include)
add_definitions(-DGLEW_STATIC)

add_subdirectory(libs/zlib-1.2.8)
include_directories(libs/zlib-1.2.8)
include_directories(libs/zlib-1.2.8/minizip)

#add_subdirectory(libs/png-1.6.25)
#include_directories(libs/png-1.6.25)

add_subdirectory(libs/jpeg-9b)
include_directories(libs/jpeg-9b)

set ( CMAKE_C_FLAGS "-std=c11 -Wall" )
set ( CMAKE_CXX_FLAGS "-std=c++11 -Wall" )

include_directories( ${CMAKE_SOURCE_DIR}/idlib )

#add_subdirectory(aas) FIXME
#add_subdirectory(amplitude)
add_subdirectory(cm)
#add_subdirectory(d3xp)
add_subdirectory(framework)
#add_subdirectory(idlib)
#add_subdirectory(libs)
#add_subdirectory(premake)
add_subdirectory(renderer)
#add_subdirectory(sound)
#add_subdirectory(swf)
add_subdirectory(sys)
#add_subdirectory(tools)
#add_subdirectory(ui)


