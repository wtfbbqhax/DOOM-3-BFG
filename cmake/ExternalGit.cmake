include(ExternalProject)

function(EXTERNAL_GIT _NAME _REPO _TAG) 
    set(EXTERNAL_PREFIX "external")
    set(EXTERNAL_REPOSITORY "${CMAKE_SOURCE_DIR}/${_NAME}")
    set(EXTERNAL_TAG ${_TAG})

    string(TOUPPER ${_NAME} _NAME_UPPER)

    ExternalProject_Add(${_NAME_UPPER}
        PREFIX          "${EXTERNAL_PREFIX}"
        GIT_REPOSITORY  ${EXTERNAL_REPOSITORY}
        GIT_TAG         ${EXTERNAL_TAG}
        CMAKE_ARGS      -DCMAKE_INSTALL_PREFIX=${EXTERNAL_PREFIX}
        UPDATE_COMMAND "")

    find_library(${_NAME}
        PATHS ${EXTERNAL_PREFIX})

    set(${_NAME_UPPER}_INCLUDES ${EXTERNAL_PREFIX}/include)
    set(${_NAME_UPPER}_LIBRARIES ${EXTERNAL_PREFIX}/libs)
endfunction()
