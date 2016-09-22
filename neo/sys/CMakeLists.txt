cmake_minimum_required ( VERSION 2.8.11 )
project ( sys CXX )

if ( APPLE )
    set ( CMAKE_MACOSX_RPATH OFF )
    set (
        CMAKE_SHARED_LINKER_FLAGS
        "${CMAKE_SHARED_LINKER_FLAGS} -undefined dynamic_lookup"
    )
endif ( APPLE )

include ( FindPkgConfig )
#Do this if user wants to build against system packages
#pkg_search_module ( SDL2 REQUIRED SDL2>=2.0.3 )
#pkg_search_module ( JPEG REQUIRED)
#pkg_search_module ( PNG REQUIRED )
#pkg_search_module ( FREETYPE REQUIRED )
#pkg_search_module ( OPENAL REQUIRED )
#pkg_search_module ( OPENGL REQUIRED )

add_library (
    sys SHARED
    LightweightCompression.cpp
    LightweightCompression.h
    PacketProcessor.cpp
    PacketProcessor.h
    Snapshot.cpp
    Snapshot.h
    SnapshotProcessor.cpp
    SnapshotProcessor.h
    Snapshot_Jobs.cpp
    Snapshot_Jobs.h
    sys_achievements.cpp
    sys_achievements.h
    sys_dedicated_server_search.cpp
    sys_dedicated_server_search.h
    sys_leaderboards.h
    sys_lobby.cpp
    sys_lobby.h
    sys_lobby_backend.h
    sys_lobby_backend_direct.cpp
    sys_lobby_backend_direct.h
    sys_lobby_migrate.cpp
    sys_lobby_snapshot.cpp
    sys_lobby_users.cpp
    sys_local.cpp
    sys_local.h
    sys_localuser.cpp
    sys_localuser.h
    sys_profile.cpp
    sys_profile.h
    sys_public.h
    sys_savegame.cpp
    sys_savegame.h
    sys_session.h
    sys_session_callbacks.cpp
    sys_session_local.cpp
    sys_session_local.h
    sys_session_savegames.cpp
    sys_session_savegames.h
    sys_signin.cpp
    sys_signin.h
    sys_stats.h
    sys_stats_misc.h
    sys_voicechat.cpp
    sys_voicechat.h
)

set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11" )

target_include_directories (
    sys PUBLIC
    ${IDTECH4_INCLUDE_DIRS}
)

#install (
#    TARGETS sys
#    LIBRARY DESTINATION "lib/${CMAKE_PROJECT_NAME}/neo"
#)
