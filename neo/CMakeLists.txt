cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
project(IDTech4 C CXX)

option(USE_MFC_TOOLS "Compile the built-in MFC based tools" OFF)
option(MONOLITH "Embed game logic into main executable" ON)
option(USE_PRECOMPILED_HEADERS "Use precompiled headers during build" OFF)
option(SDL2 "Use SDL2 instead of SDL1.2" ON)
option(OPENAL "Use OpenAL soft instead of XAudio2" OFF)
option(FFMPEG "Use FMPEG to render Bink videos" ON)
option(ONATIVE "Optimize for the host CPU" OFF)
option(WINRT "Build for Windows RT" OFF)
option(WINDOWS10 "Build for Windows 10" OFF)
option(USE_SYSTEM_ZLIB "Use the system zlib instead of the bundled one" OFF)
option(USE_SYSTEM_LIBPNG "Use the system libpng instead of the bundled one" OFF)
option(USE_SYSTEM_LIBJPEG "Use the system libjpeg instead of the bundled one" OFF)
option(USE_SYSTEM_LIBGLEW "Use the system libglew instead of the bundled one" OFF)
set(CPU_TYPE "" CACHE STRING "When set, passes this string as CPU-ID which will be embedded into the binary.")
set(CPU_OPTIMIZATION "-mmmx -msse -msse2" CACHE STRING "Which CPU specific optimitations should be used beside the compiler's default?")
option(USE_INTRINSICS "Compile using intrinsics (e.g mmx, sse, msse2)" ON)
unset(CMAKE_INSTALL_NAME_DIR)
unset(INSTALL_NAME_DIR)

if(UNIX)
    set(OPENAL TRUE)
endif()

if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11")
endif()

if(USE_SYSTEM_LIBGLEW)
    find_package(GLEW)
endif()

if(GLEW_FOUND)
    include_directories(${GLEW_INCLUDE_DIRS})
    set(GLEW_LIBRARY ${GLEW_LIBRARIES})
else()
    include_directories("libs/glew/include")
    set(GLEW_LIBRARY "" )
    add_definitions(-DGLEW_STATIC)
endif()

if(USE_SYSTEM_LIBJPEG)
    find_package(JPEG REQUIRED)
endif()

if (JPEG_FOUND)
    include_directories(${JPEG_INCLUDE_DIRS})
    set(JPEG_LIBRARY ${JPEG_LIBRARIES})
    #add_definitions(-DUSE_NEWER_JPEG) FIXME
endif()

if(USE_SYSTEM_LIBPNG)
    find_package(PNG REQUIRED)
endif()

if(PNG_FOUND)
    set(PNG_LIBRARY ${PNG_LIBRARIES})
endif()

if (USE_SYSTEM_ZLIB)
    find_package(ZLIB REQUIRED)
endif()

if (ZLIB_FOUND)
    set(ZLIB_LIBRARY ${ZLIB_LIBRARIES})
else ()
    include_directories("libs/zlib")
    set(ZLIB_LIBRARY "" )
endif()

add_subdirectory(idlib)

file(GLOB AAS_INCLUDES aas/*.h)
file(GLOB AAS_SOURCES aas/*.cpp)
add_library(AAS ${AAS_INCLUDES} ${AAS_SOURCES})

file(GLOB_RECURSE CM_INCLUDES cm/*.h)
file(GLOB_RECURSE CM_SOURCES cm/*.cpp)
add_library(CM ${CM_INCLUDES} ${CM_SOURCES})

file(GLOB FRAMEWORK_INCLUDES framework/*.h)
file(GLOB FRAMEWORK_SOURCES framework/*.cpp)

file(GLOB FRAMEWORK_ASYNC_INCLUDES framework/async/*.h)
file(GLOB FRAMEWORK_ASYNC_SOURCES framework/async/*.cpp)

file(GLOB RENDERER_INCLUDES renderer/*.h)
file(GLOB RENDERER_SOURCES renderer/*.cpp)
file(GLOB RENDERER_COLOR_INCLUDES renderer/Color/*.h)
file(GLOB RENDERER_COLOR_SOURCES renderer/Color/*.cpp)
file(GLOB RENDERER_DXT_INCLUDES renderer/DXT/*.h)
file(GLOB RENDERER_DXT_SOURCES renderer/DXT/*.cpp)
file(GLOB RENDERER_JOBS_INCLUDES renderer/jobs/*.h)
file(GLOB RENDERER_JOBS_SOURCES renderer/jobs/*.cpp)
file(GLOB RENDERER_JOBS_DYNAMICSHADOWVOLUME_INCLUDES renderer/jobs/dynamicshadowvolume/*.h)
file(GLOB RENDERER_JOBS_DYNAMICSHADOWVOLUME_SOURCES renderer/jobs/dynamicshadowvolume/*.cpp)
file(GLOB RENDERER_JOBS_PRELIGHTSHADOWVOLUME_INCLUDES renderer/jobs/prelightshadowvolume/*.h)
file(GLOB RENDERER_JOBS_PRELIGHTSHADOWVOLUME_SOURCES renderer/jobs/prelightshadowvolume/*.cpp)
file(GLOB RENDERER_JOBS_STATICSHADOWVOLUME_INCLUDES renderer/jobs/staticshadowvolume/*.h)
file(GLOB RENDERER_JOBS_STATICSHADOWVOLUME_SOURCES renderer/jobs/staticshadowvolume/*.cpp)
file(GLOB RENDERER_OPENGL_INCLUDES renderer/OpenGL/*.h)
file(GLOB RENDERER_OPENGL_SOURCES renderer/OpenGL/*.cpp)
file(GLOB RENDERER_SMAA_INCLUDES renderer/SMAA/*.h)

file(GLOB IRRXML_INCLUDES libs/irrxml/src/*.h)
file(GLOB IRRXML_SOURCES libs/irrxml/src/*.cpp)
add_library(IRRXML ${IRRXML_INCLUDES} ${IRRXML_SOURCES})

file(GLOB MINIZIP_INCLUDES libs/zlib/minizip/*.h)
file(GLOB MINIZIP_SOURCES libs/zlib/minizip/*.c libs/zlib/minizip/*.cpp)

if (NOT GLEW_FOUND)
    set(GLEW_INCLUDES libs/glew/include/GL/glew.h)
    set(GLEW_SOURCES libs/glew/src/glew.c)

    if(WIN32)
        set(GLEW_INCLUDES ${GLEW_INCLUDES} libs/glew/include/GL/wglew.h)
    else(WIN32)
        set(GLEW_INCLUDES ${GLEW_INCLUDES} libs/glew/include/GL/glxew.h)
    endif(WIN32)
else (NOT GLEW_FOUND)
    set(GLEW_INCLUDES "")
    set(GLEW_SOURCES "")
endif (NOT GLEW_FOUND)

set(SOUND_INCLUDES
    sound/snd_local.h
    sound/sound.h
    sound/SoundVoice.h
    sound/WaveFile.h)

set(SOUND_SOURCES
    sound/snd_emitter.cpp
    sound/snd_shader.cpp
    sound/snd_system.cpp
    sound/snd_world.cpp
    sound/SoundVoice.cpp
    sound/WaveFile.cpp)

# FIXME: None of these build alone without decoupling
set(XAUDIO2_INCLUDES
    sound/XAudio2/XA2_SoundHardware.h
    sound/XAudio2/XA2_SoundSample.h
    sound/XAudio2/XA2_SoundVoice.h)

set(XAUDIO2_SOURCES
    sound/XAudio2/XA2_SoundHardware.cpp
    sound/XAudio2/XA2_SoundSample.cpp
    sound/XAudio2/XA2_SoundVoice.cpp)

# FIXME: I rely on external linkage to doomclassic
set(OPENAL_INCLUDES
    sound/OpenAL/AL_SoundHardware.h
    sound/OpenAL/AL_SoundSample.h
    sound/OpenAL/AL_SoundVoice.h)

set(OPENAL_SOURCES
    sound/OpenAL/AL_SoundHardware.cpp
    sound/OpenAL/AL_SoundSample.cpp
    sound/OpenAL/AL_SoundVoice.cpp)

set(STUBAUDIO_INCLUDES
    sound/stub/SoundStub.h)

set(STUBAUDIO_SOURCES
    sound/stub/SoundSample.cpp)

# XXX Header only
file(GLOB RAPIDJSON_INCLUDES libs/rapidjson/include/rapidjson/*.h)

file(GLOB SYS_INCLUDES sys/*.h)
file(GLOB SYS_SOURCES sys/*.cpp)
add_library(SYS ${SYS_INCLUDES} ${SYS_SOURCES})

file(GLOB UI_INCLUDES ui/*.h)
file(GLOB UI_SOURCES ui/*.cpp)
add_library(UI ${UI_INCLUDES} ${UI_SOURCES})

file(GLOB SWF_INCLUDES swf/*.h)
file(GLOB SWF_SOURCES swf/*.cpp)

set(GAMED3XP_INCLUDES
    d3xp/Achievements.h
    d3xp/Actor.h
    d3xp/AF.h
    d3xp/AFEntity.h
    d3xp/AimAssist.h
    d3xp/BrittleFracture.h
    d3xp/Camera.h
    #d3xp/EndLevel.h
    d3xp/Entity.h
    d3xp/Fx.h
    d3xp/Game.h
    d3xp/GameEdit.h
    d3xp/Game_local.h
    d3xp/Grabber.h
    d3xp/IK.h
    d3xp/Item.h
    d3xp/Leaderboards.h
    d3xp/Light.h
    d3xp/Misc.h
    d3xp/Moveable.h
    d3xp/Mover.h
    d3xp/MultiplayerGame.h
    d3xp/Player.h
    d3xp/PlayerIcon.h
    d3xp/PlayerView.h
    d3xp/PredictedValue.h
    d3xp/Projectile.h
    d3xp/Pvs.h
    d3xp/SecurityCamera.h
    d3xp/SmokeParticles.h
    d3xp/Sound.h
    d3xp/Target.h
    d3xp/Trigger.h
    d3xp/Weapon.h
    d3xp/WorldSpawn.h)

set(GAMED3XP_SOURCES
    d3xp/Achievements.cpp
    d3xp/Actor.cpp
    d3xp/AF.cpp
    d3xp/AFEntity.cpp
    d3xp/AimAssist.cpp
    d3xp/BrittleFracture.cpp
    d3xp/Camera.cpp
    #d3xp/EndLevel.cpp
    d3xp/Entity.cpp
    d3xp/Fx.cpp
    d3xp/GameEdit.cpp
    d3xp/Game_local.cpp
    d3xp/Game_network.cpp
    d3xp/Grabber.cpp
    d3xp/IK.cpp
    d3xp/Item.cpp
    d3xp/Leaderboards.cpp
    d3xp/Light.cpp
    d3xp/Misc.cpp
    d3xp/Moveable.cpp
    d3xp/Mover.cpp
    d3xp/MultiplayerGame.cpp
    d3xp/Player.cpp
    d3xp/PlayerIcon.cpp
    d3xp/PlayerView.cpp
    d3xp/precompiled.cpp
    d3xp/Projectile.cpp
    d3xp/Pvs.cpp
    d3xp/SecurityCamera.cpp
    d3xp/SmokeParticles.cpp
    d3xp/Sound.cpp
    d3xp/Target.cpp
    d3xp/Trigger.cpp
    d3xp/Weapon.cpp
    d3xp/WorldSpawn.cpp)

file(GLOB GAMED3XP_AI_INCLUDES d3xp/ai/*.h)
file(GLOB GAMED3XP_AI_SOURCES d3xp/ai/*.cpp)

file(GLOB GAMED3XP_ANIM_INCLUDES d3xp/anim/*.h)
file(GLOB GAMED3XP_ANIM_SOURCES d3xp/anim/*.cpp)

file(GLOB GAMED3XP_GAMESYS_INCLUDES d3xp/gamesys/*.h)
set(GAMED3XP_GAMESYS_SOURCES
    #d3xp/gamesys/Callbacks.cpp
    d3xp/gamesys/Class.cpp
    #d3xp/gamesys/DebugGraph.cpp
    d3xp/gamesys/Event.cpp
    d3xp/gamesys/SaveGame.cpp
    d3xp/gamesys/SysCmds.cpp
    d3xp/gamesys/SysCvar.cpp
    #d3xp/gamesys/TypeInfo.cpp
    )

file(GLOB GAMED3XP_MENUS_INCLUDES d3xp/menus/*.h)
file(GLOB GAMED3XP_MENUS_SOURCES d3xp/menus/*.cpp)

file(GLOB GAMED3XP_PHYSICS_INCLUDES d3xp/physics/*.h)
file(GLOB GAMED3XP_PHYSICS_SOURCES d3xp/physics/*.cpp)

file(GLOB GAMED3XP_SCRIPT_INCLUDES d3xp/script/*.h)
file(GLOB GAMED3XP_SCRIPT_SOURCES d3xp/script/*.cpp)


file(GLOB COMPILER_INCLUDES tools/compilers/*.h)

file(GLOB COMPILER_AAS_INCLUDES tools/compilers/aas/*.h)
file(GLOB COMPILER_AAS_SOURCES tools/compilers/aas/*.cpp)

file(GLOB COMPILER_DMAP_INCLUDES tools/compilers/dmap/*.h)
file(GLOB COMPILER_DMAP_SOURCES tools/compilers/dmap/*.cpp)

add_library(COMPILER_AAS
    ${COMPILER_AAS_INCLUDES}
    ${COMPILER_AAS_SOURCES}
    ${COMPILER_INCLUDES})

add_library(COMPILER_DMAP
    ${COMPILER_DMAP_INCLUDES}
    ${COMPILER_DMAP_SOURCES}
    ${COMPILER_INCLUDES})

file(GLOB COMPILER_RENDERBUMP_INCLUDES tools/compilers/renderbump/*.h)
file(GLOB COMPILER_RENDERBUMP_SOURCES tools/compilers/renderbump/*.cpp)

file(GLOB EDITOR_SCRIPT_INCLUDES tools/script/*.h)
file(GLOB EDITOR_SCRIPT_SOURCES tools/script/*.cpp)

# These are doomclasic files needed above for some stuff
# FIXME: Why?  
#set(DOOMCLASSIC_STUBAUDIO_SOURCES ../doomclassic/doom/i_sound_stub.cpp)
#set(DOOMCLASSIC_OPENAL_SOURCES ../doomclassic/doom/i_sound_openal.cpp)
#set(DOOMCLASSIC_XAUDIO2_SOURCES ../doomclassic/doom/i_sound_win32.cpp)
#
#list(REMOVE_ITEM DOOMCLASSIC_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/../doomclassic/doom/i_sound_stub.cpp)
#list(REMOVE_ITEM DOOMCLASSIC_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/../doomclassic/doom/i_sound_openal.cpp)
#list(REMOVE_ITEM DOOMCLASSIC_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/../doomclassic/doom/i_sound_win32.cpp)

file(GLOB TIMIDITY_INCLUDES libs/timidity/*.h)
file(GLOB TIMIDITY_SOURCES libs/timidity/*.cpp)

file(GLOB_RECURSE WIN32_INCLUDES sys/win32/*.h)
#file(GLOB_RECURSE WIN32_SOURCES sys/win32/*.cpp)

set(WIN32_SOURCES
    sys/win32/win_glimp.cpp
    sys/win32/win_input.cpp
    sys/win32/win_main.cpp
    sys/win32/win_shared.cpp
    sys/win32/win_snd.cpp
    sys/win32/win_syscon.cpp
    sys/win32/win_taskkeyhook.cpp
    sys/win32/win_wndproc.cpp)

if(MSVC)
    list(APPEND WIN32_SOURCES sys/win32/win_cpu.cpp)
endif()

set(WIN32_RESOURCES
    sys/win32/rc/res/doom.ico)

list(APPEND WIN32_RESOURCES sys/win32/rc/doom.rc)

file(GLOB POSIX_INCLUDES sys/posix/*.h)
file(GLOB POSIX_SOURCES sys/posix/*.cpp)

file(GLOB COMMON_INCLUDES sys/common/*.h)
file(GLOB COMMON_SOURCES sys/common/*.cpp)

file(GLOB SDL_INCLUDES sys/sdl/*.h)
file(GLOB SDL_SOURCES sys/sdl/*.cpp)

source_group("aas" FILES ${AAS_INCLUDES})
source_group("aas" FILES ${AAS_SOURCES})

source_group("cm" FILES ${CM_INCLUDES})
source_group("cm" FILES ${CM_SOURCES})

source_group("framework" FILES ${FRAMEWORK_INCLUDES})
source_group("framework" FILES ${FRAMEWORK_SOURCES})

source_group("framework\\async" FILES ${FRAMEWORK_ASYNC_INCLUDES})
source_group("framework\\async" FILES ${FRAMEWORK_ASYNC_SOURCES})

source_group("renderer" FILES ${RENDERER_INCLUDES})
source_group("renderer" FILES ${RENDERER_SOURCES})

source_group("renderer\\Color" FILES ${RENDERER_COLOR_INCLUDES})
source_group("renderer\\Color" FILES ${RENDERER_COLOR_SOURCES})

source_group("renderer\\OpenGL" FILES ${RENDERER_OPENGL_INCLUDES})
source_group("renderer\\OpenGL" FILES ${RENDERER_OPENGL_SOURCES})

source_group("libs\\irrxml" FILES ${IRRXML_INCLUDES})
source_group("libs\\irrxml" FILES ${IRRXML_SOURCES})

source_group("libs\\jpeg-6" FILES ${JPEG_INCLUDES})
source_group("libs\\jpeg-6" FILES ${JPEG_SOURCES})

source_group("libs\\png" FILES ${PNG_INCLUDES})
source_group("libs\\png" FILES ${PNG_SOURCES})

source_group("libs\\zlib" FILES ${ZLIB_INCLUDES})
source_group("libs\\zlib" FILES ${ZLIB_SOURCES})

source_group("libs\\zlib\\minizip" FILES ${MINIZIP_INCLUDES})
source_group("libs\\zlib\\minizip" FILES ${MINIZIP_SOURCES})

source_group("libs\\glew" FILES ${GLEW_INCLUDES})
source_group("libs\\glew" FILES ${GLEW_SOURCES})

source_group("libs\\rapidjson" FILES ${RAPIDJSON_INCLUDES})

source_group("sound" FILES ${SOUND_INCLUDES})
source_group("sound" FILES ${SOUND_SOURCES})

source_group("sound\\XAudio2" FILES ${XAUDIO2_INCLUDES})
source_group("sound\\XAudio2" FILES ${XAUDIO2_SOURCES})

source_group("sound\\OpenAL" FILES ${OPENAL_INCLUDES})
source_group("sound\\OpenAL" FILES ${OPENAL_SOURCES})

source_group("sound\\stub" FILES ${STUBAUDIO_INCLUDES})
source_group("sound\\stub" FILES ${STUBAUDIO_SOURCES})

source_group("libs\\oggvorbis" FILES ${OGGVORBIS_INCLUDES})
source_group("libs\\oggvorbis" FILES ${OGGVORBIS_SOURCES})

source_group("ui" FILES ${UI_INCLUDES})
source_group("ui" FILES ${UI_SOURCES})

source_group("swf" FILES ${SWF_INCLUDES})
source_group("swf" FILES ${SWF_SOURCES})

source_group("sys" FILES ${SYS_INCLUDES})
source_group("sys" FILES ${SYS_SOURCES})

source_group("libs\\timidity" FILES ${TIMIDITY_SOURCES})

# not sure
source_group("game-d3xp" FILES ${GAMED3XP_INCLUDES})
source_group("game-d3xp" FILES ${GAMED3XP_SOURCES})

source_group("game-d3xp\\ai" FILES ${GAMED3XP_AI_INCLUDES})
source_group("game-d3xp\\ai" FILES ${GAMED3XP_AI_SOURCES})

source_group("game-d3xp\\anim" FILES ${GAMED3XP_ANIM_INCLUDES})
source_group("game-d3xp\\anim" FILES ${GAMED3XP_ANIM_SOURCES})

source_group("game-d3xp\\gamesys" FILES ${GAMED3XP_GAMESYS_INCLUDES})
source_group("game-d3xp\\gamesys" FILES ${GAMED3XP_GAMESYS_SOURCES})

source_group("game-d3xp\\menus" FILES ${GAMED3XP_MENUS_INCLUDES})
source_group("game-d3xp\\menus" FILES ${GAMED3XP_MENUS_SOURCES})

source_group("game-d3xp\\physics" FILES ${GAMED3XP_PHYSICS_INCLUDES})
source_group("game-d3xp\\physics" FILES ${GAMED3XP_PHYSICS_SOURCES})

source_group("game-d3xp\\script" FILES ${GAMED3XP_SCRIPT_INCLUDES})
source_group("game-d3xp\\script" FILES ${GAMED3XP_SCRIPT_SOURCES})

# system specific
source_group("sys\\win32" FILES ${WIN32_INCLUDES})
source_group("sys\\win32" FILES ${WIN32_SOURCES})
source_group("sys\\win32\\Resources" FILES ${WIN32_RESOURCES})

source_group("sys\\posix" FILES ${POSIX_INCLUDES})
source_group("sys\\posix" FILES ${POSIX_SOURCES})

source_group("sys\\common" FILES ${COMMON_INCLUDES})
source_group("sys\\common" FILES ${COMMON_SOURCES})

source_group("sys\\sdl" FILES ${SDL_INCLUDES})
source_group("sys\\sdl" FILES ${SDL_SOURCES})

# compilers
source_group("tools\\compilers" FILES ${COMPILER_INCLUDES})

source_group("tools\\compilers\\aas" FILES ${COMPILER_AAS_INCLUDES})
source_group("tools\\compilers\\aas" FILES ${COMPILER_AAS_SOURCES})

source_group("tools\\compilers\\dmap" FILES ${COMPILER_DMAP_INCLUDES})
source_group("tools\\compilers\\dmap" FILES ${COMPILER_DMAP_SOURCES})

include_directories( .  idlib )

if(MSVC)

    # if(MSVC_VERSION EQUAL 1700)
    # set(DirectX_LIBRARIES
    # dinput8
    # dsound
    # dxguid
    # #dxerr
    # Xinput
    # xaudio2.lib
    # )

    # if(NOT OPENAL)
    # list(APPEND DirectX_LIBRARIES xaudio2.lib)
    # endif()

    # else()

    if(WINDOWS10)
        set(DirectX_LIBRARIES
            dinput8
            dsound
            dxguid
            #dxerr
            Xinput
            xaudio2.lib)
    else(WINDOWS10)
        find_package(DirectX REQUIRED)
        include_directories(${DirectX_INCLUDE_DIR})
    endif(WINDOWS10)

    if(OPENAL)
        add_definitions(-DUSE_OPENAL)
        include_directories(${CMAKE_CURRENT_SOURCE_DIR}/libs/openal-soft/include)

        if(CMAKE_CL_64)
            link_directories(${CMAKE_CURRENT_SOURCE_DIR}/libs/openal-soft/lib/win64)
        else()
            link_directories(${CMAKE_CURRENT_SOURCE_DIR}/libs/openal-soft/lib/win32)
        endif()

        list(APPEND IDTECH4_INCLUDES ${OPENAL_INCLUDES})
        list(APPEND IDTECH4_SOURCES ${OPENAL_SOURCES} ${DOOMCLASSIC_OPENAL_SOURCES})
        set(OpenAL_LIBRARIES OpenAL32)

        if(CMAKE_CL_64)
            install(FILES libs/openal-soft/lib/win64/OpenAL64.dll DESTINATION .)
        else()
            install(FILES libs/openal-soft/lib/win32/OpenAL32.dll DESTINATION .)
            install(FILES libs/openal-soft/lib/win32/OpenAL32.pdb DESTINATION .)
        endif()
    else(OPENAL)
        list(APPEND IDTECH4_INCLUDES ${XAUDIO2_INCLUDES})
        list(APPEND IDTECH4_SOURCES ${XAUDIO2_SOURCES} ${DOOMCLASSIC_XAUDIO2_SOURCES})
    endif(OPENAL)

    # FIXME FFMPEG OSX
    list(APPEND IDTECH4_INCLUDES ${SYS_INCLUDES} ${SYS_SOURCES})

    list(REMOVE_DUPLICATES IDTECH4_SOURCES)

    # XXX
    list(APPEND IDTECH4_SOURCES ${WIN32_RESOURCES})
else(MSVC)

    list(APPEND IDTECH4_SOURCES
        ${SYS_INCLUDES} ${SYS_SOURCES})

    find_package(OpenGL REQUIRED)
    include_directories(${OPENGL_INCLUDE_DIRS})

    if(UNIX)
        if(FFMPEG)
            find_package(FFMPEG REQUIRED)
            add_definitions(-DUSE_FFMPEG)

            include_directories(${FFMPEG_INCLUDE_DIR})
            link_directories(${FFMPEG_LIBRARIES_DIRS})
        endif()

        if(SDL2)
            find_package(SDL2 REQUIRED)
            include_directories(${SDL2_INCLUDE_DIR})
            set(SDLx_LIBRARY ${SDL2_LIBRARY})
        else()
            find_package(SDL REQUIRED)
            include_directories(${SDL_INCLUDE_DIR})
            set(SDLx_LIBRARY ${SDL_LIBRARY})
        endif()

        if(APPLE)
            list(REMOVE_ITEM POSIX_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/sys/posix/platform_linux.cpp)
        else()
            list(REMOVE_ITEM POSIX_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/sys/posix/platform_osx.cpp)
        endif()

        list(APPEND IDTECH4_SOURCES
            ${POSIX_INCLUDES} ${POSIX_SOURCES}
            ${SDL_INCLUDES} ${SDL_SOURCES})

        if(OPENAL)
            find_package(OpenAL REQUIRED)
            add_definitions(-DUSE_OPENAL)

            #include_directories(${CMAKE_CURRENT_SOURCE_DIR}/libs/openal-soft/include)
            #if(CMAKE_CL_64)
            #       link_directories(${CMAKE_CURRENT_SOURCE_DIR}/libs/openal-soft/lib/win64)
            #else()
            #       link_directories(${CMAKE_CURRENT_SOURCE_DIR}/libs/openal-soft/lib/win32)
            #endif()

            list(APPEND _INCLUDES ${OPENAL_INCLUDES})
            list(APPEND IDTECH4_SOURCES
                ${OPENAL_SOURCES}
                ${DOOMCLASSIC_OPENAL_SOURCES})
        else()
            list(APPEND IDTECH4_INCLUDES ${STUBAUDIO_INCLUDES})
            list(APPEND IDTECH4_SOURCES
                ${STUBAUDIO_SOURCES}
                ${DOOMCLASSIC_STUBAUDIO_SOURCES})
        endif()

    endif(UNIX)

    list(REMOVE_DUPLICATES IDTECH4_SOURCES)

    GET_DIRECTORY_PROPERTY(_directory_flags COMPILE_DEFINITIONS NEW)
    LIST(APPEND _compiler_FLAGS ${_directory_flags})
    SEPARATE_ARGUMENTS(_compiler_FLAGS)

    if(WIN32)
        set(remove_command "del")
    else()
        set(remove_command "rm")
    endif()

    if (USE_PRECOMPILED_HEADERS)
        # it's ugly enough that the precompiled header binary needs to be in the 
        # source directory (instead of the build directory), so let's at least
        # delete it after build.
        add_custom_target(rm_precomp_header ALL
            COMMAND ${remove_command} "idlib/precompiled.h.gch"
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            COMMENT "remove idlib/precompiled.h.gch"
            )

        # make sure this is run after creating idlib
        add_dependencies(precomp_header_idtech4 idlib)
    endif(USE_PRECOMPILED_HEADERS)

    #add_library(IdTech4 WIN32 ${IDTECH4_SOURCES})

    if (USE_PRECOMPILED_HEADERS)
        # make sure precompiled header is created before executable is compiled
        #add_dependencies(IdTech4 precomp_header_idtech4)

        # make sure precompiled header is deleted after executable is compiled
        add_dependencies(rm_precomp_header IdTech4)
    endif(USE_PRECOMPILED_HEADERS)

endif(MSVC)

if(APPLE)
    set(RT_LIBRARY rt)
endif(APPLE)


# IdLibrary
# SDL1 or SDL2 
list(APPEND FRAMEWORK_LIBS idlib)
list(APPEND FRAMEWORK_LIBS ${SDLx_LIBRARY})

#list(APPEND FRAMEWORK_INCLUDES ${SYS_INCLUDES})
#list(APPEND FRAMEWORK_SOURCES ${SYS_SOURCES})
add_library(system ${SYS_INCLUDES} ${SYS_SOURCES})
list(APPEND FRAMEWORK_LIBS system)

#list(APPEND FRAMEWORK_INCLUDES ${UI_INCLUDES})
#list(APPEND FRAMEWORK_SOURCES ${UI_SOURCES})
add_library(ui ${UI_INCLUDES} ${UI_SOURCES})
list(APPEND FRAMEWORK_LIBS ui)

#list(APPEND FRAMEWORK_INCLUDES ${SWF_INCLUDES})
#list(APPEND FRAMEWORK_SOURCES ${SWF_SOURCES})
add_library(flash ${SWF_INCLUDES} ${SWF_SOURCES})
list(APPEND FRAMEWORK_LIBS flash)

#list(APPEND FRAMEWORK_INCLUDES ${SOUND_INCLUDES})
#list(APPEND FRAMEWORK_SOURCES ${SOUND_SOURCES})

#list(APPEND FRAMEWORK_INCLUDES ${OPENAL_INCLUDES})
#list(APPEND FRAMEWORK_SOURCES ${OPENAL_SOURCES})

#list(APPEND FRAMEWORK_INCLUDES ${XAUDIO2_INCLUDES})
#list(APPEND FRAMEWORK_SOURCES ${XAUDIO2_SOURCES})

#list(APPEND FRAMEWORK_INCLUDES ${STUBAUDIO_INCLUDES})
#list(APPEND FRAMEWORK_SOURCES ${STUBAUDIO_SOURCES})

#add_library(sound
#    ${SOUND_INCLUDES}
#    ${OPENAL_INCLUDES}
#    ${STUBAUDIO_INCLUDES}
#    ${SOUND_SOURCES}
#    ${OPENAL_SOURCES}
#    ${STUBAUDIO_SOURCES})
#list(APPEND FRAMEWORK_LIBS sound)

list(APPEND FRAMEWORK_INCLUDES ${FRAMEWORK_ASYNC_INCLUDES})
list(APPEND FRAMEWORK_SOURCES ${FRAMEWORK_ASYNC_SOURCES})

add_library(ZLIB ${ZLIB_INCLUDES} ${ZLIB_SOURCES})
list(APPEND FRAMEWORK_LIBS ZLIB)

add_library(MINIZIP ${MINIZIP_INCLUDES} ${MINIZIP_SOURCES})
target_link_libraries(MINIZIP ZLIB)
list(APPEND FRAMEWORK_LIBS MINIZIP)

add_library(framework ${FRAMEWORK_INCLUDES} ${FRAMEWORK_SOURCES} ${FRAMEWORK_ASYNC_SOURCES})
target_link_libraries(framework ${FRAMEWORK_LIBS})
#add_library(framework SHARED ${FRAMEWORK_SOURCES} ${FRAMEWORK_ASYNC_SOURCES})
