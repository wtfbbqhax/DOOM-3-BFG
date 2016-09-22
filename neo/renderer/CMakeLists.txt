cmake_minimum_required ( VERSION 2.8.11 )
project ( renderer CXX )

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
    renderer SHARED
    BinaryImage.cpp
    BinaryImage.h
    BinaryImageData.h
    BoundsTrack.cpp
    BoundsTrack.h
    BufferObject.cpp
    BufferObject.h
    Cinematic.cpp
    Cinematic.h
    Font.cpp
    Font.h
    Framebuffer.cpp
    Framebuffer.h
    GLMatrix.cpp
    GLMatrix.h
    GLState.h
    GraphicsAPIWrapper.h
    GuiModel.cpp
    GuiModel.h
    Image.h
    ImageManager.cpp
    ImageOpts.h
    Image_files.cpp
    Image_intrinsic.cpp
    Image_load.cpp
    Image_process.cpp
    Image_program.cpp
    Interaction.cpp
    Interaction.h
    Material.cpp
    Material.h
    Model.cpp
    Model.h
    ModelDecal.cpp
    ModelDecal.h
    ModelManager.cpp
    ModelManager.h
    ModelOverlay.cpp
    ModelOverlay.h
    Model_ColladaHelper.h
    Model_ColladaParser.cpp
    Model_ColladaParser.h
    Model_ase.cpp
    Model_ase.h
    Model_beam.cpp
    Model_liquid.cpp
    Model_local.h
    Model_lwo.cpp
    Model_lwo.h
    Model_ma.cpp
    Model_ma.h
    Model_md3.cpp
    Model_md3.h
    Model_md5.cpp
    Model_prt.cpp
    Model_sprite.cpp
    RenderContext.h
    RenderEntity.cpp
    RenderLog.cpp
    RenderLog.h
    RenderProgs.cpp
    RenderProgs.h
    RenderProgs_GLSL.cpp
    RenderProgs_embedded.h
    RenderSystem.cpp
    RenderSystem.h
    RenderSystem_init.cpp
    RenderWorld.cpp
    RenderWorld.h
    RenderWorld_defs.cpp
    RenderWorld_demo.cpp
    RenderWorld_load.cpp
    RenderWorld_local.h
    RenderWorld_portals.cpp
    ResolutionScale.cpp
    ResolutionScale.h
    ScreenRect.cpp
    ScreenRect.h
    VertexCache.cpp
    VertexCache.h
    simplex.h
    tr_backend_draw.cpp
    tr_backend_rendertools.cpp
    tr_frontend_addlights.cpp
    tr_frontend_addmodels.cpp
    tr_frontend_deform.cpp
    tr_frontend_guisurf.cpp
    tr_frontend_main.cpp
    tr_frontend_subview.cpp
    tr_local.h
    tr_trace.cpp
    tr_trisurf.cpp
)

set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11" )

target_include_directories (
    renderer PUBLIC
    ${IDTECH4_INCLUDE_DIRS}
)

#install (
#    TARGETS renderer
#    LIBRARY DESTINATION "lib/${CMAKE_PROJECT_NAME}/neo"
#)
