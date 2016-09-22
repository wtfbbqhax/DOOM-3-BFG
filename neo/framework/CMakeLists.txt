cmake_minimum_required ( VERSION 2.8.11 )
project ( framework CXX )

if (APPLE)
    set ( CMAKE_MACOSX_RPATH OFF )
    set (
        CMAKE_SHARED_LINKER_FLAGS
        "${CMAKE_SHARED_LINKER_FLAGS} -undefined dynamic_lookup"
    )
endif (APPLE)

add_library (
    framework SHARED
    BuildVersion.h
    CVarSystem.cpp
    CVarSystem.h
    CmdSystem.cpp
    CmdSystem.h
    Common.cpp
    Common.h
    Common_demos.cpp
    Common_dialog.cpp
    Common_dialog.h
    Common_load.cpp
    Common_local.h
    Common_localize.cpp
    Common_mapconvert.cpp
    Common_menu.cpp
    Common_network.cpp
    Common_printf.cpp
    Compressor.cpp
    Compressor.h
    Console.cpp
    Console.h
    ConsoleHistory.cpp
    ConsoleHistory.h
    DebugGraph.cpp
    DebugGraph.h
    DeclAF.cpp
    DeclAF.h
    DeclEntityDef.cpp
    DeclEntityDef.h
    DeclFX.cpp
    DeclFX.h
    DeclManager.cpp
    DeclManager.h
    DeclPDA.cpp
    DeclPDA.h
    DeclParticle.cpp
    DeclParticle.h
    DeclSkin.cpp
    DeclSkin.h
    DeclTable.cpp
    DeclTable.h
    DemoChecksum.h
    DemoFile.cpp
    DemoFile.h
    EditField.cpp
    EditField.h
    EventLoop.cpp
    EventLoop.h
    File.cpp
    File.h
    FileSystem.cpp
    FileSystem.h
    File_Manifest.cpp
    File_Manifest.h
    File_Resource.cpp
    File_Resource.h
    File_SaveGame.cpp
    File_SaveGame.h
    KeyInput.cpp
    KeyInput.h
    Licensee.h
    PlayerProfile.cpp
    PlayerProfile.h
    Serializer.h
    TokenParser.cpp
    TokenParser.h
    Unzip.h
    UsercmdGen.cpp
    UsercmdGen.h
    Zip.cpp
    Zip.h
    common_frame.cpp
    precompiled.cpp
)

target_link_libraries(framework zlib-1.2.8 minizip)
include_directories(BEFORE "${CMAKE_SOURCE_DIR}/libs/zlib-1.2.8")

set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11" )
