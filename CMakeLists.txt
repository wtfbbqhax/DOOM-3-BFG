cmake_minimum_required(VERSION 3.6)
project(DOOM-3-BFG)
option(EXTERNAL_PROJECTS "Fetch and build external project dependencies" ON)

cmake_policy(SET CMP0026 OLD)
cmake_policy(SET CMP0059 OLD)

if (EXTERNAL_PROJECTS)
  include(ExternalProject)
#      ___       _                        _   ____                 
#     |_ _|_ __ | |_ ___ _ __ _ __   __ _| | |  _ \  ___ _ __  ___ 
#      | || | | | ||  __/ |  | | | | (_| | | | |_| |  __/ |_) \__ \
#     |___|_| |_|\__\___|_|  |_| |_|\__,_|_| |____/ \___| .__/|___/
#                                                       |_|        
  set(EXTERNAL_PREFIX "external")
  set(EXTERNAL_NAME "libpng")
  set(EXTERNAL_REPOSITORY "git@github.com:glennrp/libpng.git")
  set(EXTERNAL_TAG "v1.6.25")

  ExternalProject_Add(${EXTERNAL_NAME}
    PREFIX          "${EXTERNAL_PREFIX}"
    GIT_REPOSITORY  ${EXTERNAL_REPOSITORY}
    GIT_TAG         ${EXTERNAL_TAG} 
    CMAKE_ARGS      -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/external
    UPDATE_COMMAND ""
    )

  set(EXTERNAL_NAME "libjpeg-turbo")

  ExternalProject_Add(libjpeg-turbo
    PREFIX "external/src/${EXTERNAL_NAME}"
    SOURCE_DIR ""
    #BINARY_DIR "external/src/${EXTERNAL_NAME}"
    INSTALL_DIR "external"
    GIT_REPOSITORY git@github.com:libjpeg-turbo/libjpeg-turbo.git
    GIT_TAG 1.5.1 
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND pwd && autoreconf -fi && ./configure --prefix=${CMAKE_BINARY_DIR}/external
    BUILD_COMMAND make
    UPDATE_COMMAND ""
  )

else(EXTERNAL_PROJECTS)
#      ____            _                   ____                 
#     / ___| _   _ ___| |_ ___ _ __ ___   |  _ \  ___ _ __  ___ 
#      ___) | |_| \__ \ ||  __/ | | | | | | |_| |  __/ |_) \__ \
#     |____/ \__, |___/\__\___|_| |_| |_| |____/ \___| .__/|___/
#            |___/                                   |_|        
  find_package(PNG REQUIRED)
  find_package(JPEG REQUIRED)

endif(EXTERNAL_PROJECTS)
#    _     _ _____         _     _  _     ____        _ _     _ 
#
#    _     _ _____         _      _  _    ____        _ _     _ 
#   (_) __| |_   _|__  ___| |___ | || |  |  _ ) _   _(_) | __| |
#   | ||(_| | | |/ __/ (__| | \ ||__  _| | )_) | |_| | | | (_| |
#   |_|\__,_| |_|\___|\___|_| |_|   |_|  |____/ \__,_|_|_|\__,_|
#
#    _  __,_   _  ___  ___ _   _    _     ____   __,_ _ _  __,_ 
find_package(ZLIB REQUIRED)

set(EXTERNAL_LIBRARIES
  ${ZLIB_LIBRARIES}
  ${PNG_LIBRARY}
  ${JPEG_LIBRARY}
  )

set(EXTERNAL_INCLUDES
  ${ZLIB_INCLUDE_DIRS}
  ${PNG_INCLUDE_DIRS}
  ${JPEG_INCLUDE_DIRS}
  )

message(STATUS " EXTERNAL_LIBRARIES: ${EXTERNAL_LIBRARIES}")
message(STATUS " EXTERNAL_INCLUDES: ${EXTERNAL_INCLUDES}")

message(STATUS " CMAKE_SYSTEM_PREFIX_PATH: ${CMAKE_SYSTEM_PREFIX_PATH}")
include_directories(${EXTERNAL_INCLUDES})

set(CXX_STANDARD 14)
add_subdirectory(neo)
