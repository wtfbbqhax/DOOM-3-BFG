#idtools########################################################################

file(GLOB COMPILER_INCLUDES tools/compilers/*.h)

file(GLOB COMPILER_AAS_INCLUDES tools/compilers/aas/*.h)
file(GLOB COMPILER_AAS_SOURCES tools/compilers/aas/*.cpp)

file(GLOB COMPILER_DMAP_INCLUDES tools/compilers/dmap/*.h)
file(GLOB COMPILER_DMAP_SOURCES tools/compilers/dmap/*.cpp)

file(GLOB COMPILER_RENDERBUMP_INCLUDES tools/compilers/renderbump/*.h)
file(GLOB COMPILER_RENDERBUMP_SOURCES tools/compilers/renderbump/*.cpp)

file(GLOB COMPILER_ROQVQ_INCLUDES tools/compilers/roqvq/*.h)
file(GLOB COMPILER_ROQVQ_SOURCES tools/compilers/roqvq/*.cpp)

set(TOOLS_INCLUDES tools/edit_public.h)

file(GLOB TOOLS_COMAFX_INCLUDES tools/comafx/*.h)
file(GLOB TOOLS_COMAFX_SOURCES tools/comafx/*.cpp)

set(TOOLS_COMMON_INCLUDES
  tools/common/ColorButton.h
  tools/common/DialogHelpers.h
  tools/common/MaskEdit.h
  tools/common/OpenFileDialog.h
  tools/common/PropertyGrid.h
  tools/common/RegistryOptions.h
  #tools/common/RenderBumpFlatDialog.h
  tools/common/RollupPanel.h
  tools/common/SpinButton.h)

set(TOOLS_COMMON_SOURCES
  tools/common/AlphaPopup.cpp
  tools/common/ColorButton.cpp
  tools/common/MaskEdit.cpp
  tools/common/OpenFileDialog.cpp
  tools/common/PropertyGrid.cpp
  tools/common/RegistryOptions.cpp
  #tools/common/RenderBumpFlatDialog.cpp
  tools/common/RollupPanel.cpp
  tools/common/SpinButton.cpp)

file(GLOB TOOLS_COMMON_PROPTREE_INCLUDES tools/common/PropTree/*.h)
file(GLOB TOOLS_COMMON_PROPTREE_SOURCES tools/common/PropTree/*.cpp)

file(GLOB EDITOR_AF_INCLUDES tools/af/*.h)
file(GLOB EDITOR_AF_SOURCES tools/af/*.cpp)

set(EDITOR_DECL_INCLUDES
  tools/decl/DialogDeclBrowser.h
  tools/decl/DialogDeclEditor.h
  tools/decl/DialogDeclNew.h)

set(EDITOR_DECL_SOURCES
  tools/decl/DialogDeclBrowser.cpp
  tools/decl/DialogDeclEditor.cpp
  tools/decl/DialogDeclNew.cpp)

file(GLOB EDITOR_DEBUGGER_INCLUDES tools/debugger/*.h)
file(GLOB EDITOR_DEBUGGER_SOURCES tools/debugger/*.cpp)

file(GLOB EDITOR_GUIED_INCLUDES tools/guied/*.h)
set(EDITOR_GUIED_SOURCES
  tools/guied/GEApp.cpp
  tools/guied/GECheckInDlg.cpp
  tools/guied/GEDeleteModifier.cpp
  tools/guied/GEHideModifier.cpp
  tools/guied/GEInsertModifier.cpp
  tools/guied/GEItemPropsDlg.cpp
  tools/guied/GEItemScriptsDlg.cpp
  tools/guied/GEKeyValueModifier.cpp
  tools/guied/GEModifier.cpp
  tools/guied/GEModifierGroup.cpp
  tools/guied/GEModifierStack.cpp
  tools/guied/GEMoveModifier.cpp
  tools/guied/GENavigator.cpp
  tools/guied/GEOptions.cpp
  tools/guied/GEOptionsDlg.cpp
  tools/guied/GEProperties.cpp
  tools/guied/GEPropertyPage.cpp
  tools/guied/GESelectionMgr.cpp
  tools/guied/GESizeModifier.cpp
  tools/guied/GEStateModifier.cpp
  tools/guied/GEStatusBar.cpp
  tools/guied/GETransformer.cpp
  tools/guied/GEViewer.cpp
  tools/guied/GEWindowWrapper.cpp
  #tools/guied/GEWindowWrapper_stub.cpp
  tools/guied/GEWorkspace.cpp
  tools/guied/GEWorkspaceFile.cpp
  tools/guied/GEZOrderModifier.cpp
  tools/guied/guied.cpp)

file(GLOB EDITOR_MATERIALEDITOR_INCLUDES tools/materialeditor/*.h)
file(GLOB EDITOR_MATERIALEDITOR_SOURCES tools/materialeditor/*.cpp)

file(GLOB EDITOR_PARTICLE_INCLUDES tools/particle/*.h)
file(GLOB EDITOR_PARTICLE_SOURCES tools/particle/*.cpp)

file(GLOB EDITOR_PDA_INCLUDES tools/pda/*.h)
file(GLOB EDITOR_PDA_SOURCES tools/pda/*.cpp)

file(GLOB EDITOR_RADIANT_INCLUDES tools/radiant/*.h)
file(GLOB EDITOR_RADIANT_SOURCES tools/radiant/*.cpp)

file(GLOB EDITOR_SCRIPT_INCLUDES tools/script/*.h)
file(GLOB EDITOR_SCRIPT_SOURCES tools/script/*.cpp)

file(GLOB EDITOR_SOUND_INCLUDES tools/sound/*.h)
file(GLOB EDITOR_SOUND_SOURCES tools/sound/*.cpp)


source_group("tools\\compilers" FILES ${COMPILER_INCLUDES})

source_group("tools\\compilers\\aas" FILES ${COMPILER_AAS_INCLUDES})
source_group("tools\\compilers\\aas" FILES ${COMPILER_AAS_SOURCES})

source_group("tools\\compilers\\dmap" FILES ${COMPILER_DMAP_INCLUDES})
source_group("tools\\compilers\\dmap" FILES ${COMPILER_DMAP_SOURCES})

source_group("tools\\compilers\\renderbump" FILES ${COMPILER_RENDERBUMP_INCLUDES})
source_group("tools\\compilers\\renderbump" FILES ${COMPILER_RENDERBUMP_SOURCES})

source_group("tools\\compilers\\roqvq" FILES ${COMPILER_ROQVQ_INCLUDES})
source_group("tools\\compilers\\roqvq" FILES ${COMPILER_ROQVQ_SOURCES})

source_group("tools" FILES ${TOOLS_INCLUDES})

source_group("tools\\comafx" FILES ${TOOLS_COMAFX_INCLUDES})
source_group("tools\\comafx" FILES ${TOOLS_COMAFX_SOURCES})

source_group("tools\\common" FILES ${TOOLS_COMMON_INCLUDES})
source_group("tools\\common" FILES ${TOOLS_COMMON_SOURCES})

source_group("tools\\common\\proptree" FILES ${TOOLS_COMMON_PROPTREE_INCLUDES})
source_group("tools\\common\\proptree" FILES ${TOOLS_COMMON_PROPTREE_SOURCES})

source_group("tools\\af" FILES ${EDITOR_AF_INCLUDES})
source_group("tools\\af" FILES ${EDITOR_AF_SOURCES})

source_group("tools\\debugger" FILES ${EDITOR_DEBUGGER_INCLUDES})
source_group("tools\\debugger" FILES ${EDITOR_DEBUGGER_SOURCES})

source_group("tools\\decl" FILES ${EDITOR_DECL_INCLUDES})
source_group("tools\\decl" FILES ${EDITOR_DECL_SOURCES})

source_group("tools\\guied" FILES ${EDITOR_GUIED_INCLUDES})
source_group("tools\\guied" FILES ${EDITOR_GUIED_SOURCES})

source_group("tools\\materialeditor" FILES ${EDITOR_MATERIALEDITOR_INCLUDES})
source_group("tools\\materialeditor" FILES ${EDITOR_MATERIALEDITOR_SOURCES})

source_group("tools\\particle" FILES ${EDITOR_PARTICLE_INCLUDES})
source_group("tools\\particle" FILES ${EDITOR_PARTICLE_SOURCES})

source_group("tools\\pda" FILES ${EDITOR_PDA_INCLUDES})
source_group("tools\\pda" FILES ${EDITOR_PDA_SOURCES})

source_group("tools\\radiant" FILES ${EDITOR_RADIANT_INCLUDES})
source_group("tools\\radiant" FILES ${EDITOR_RADIANT_SOURCES})

source_group("tools\\script" FILES ${EDITOR_SCRIPT_INCLUDES})
source_group("tools\\script" FILES ${EDITOR_SCRIPT_SOURCES})

source_group("tools\\sound" FILES ${EDITOR_SOUND_INCLUDES})
source_group("tools\\sound" FILES ${EDITOR_SOUND_SOURCES})

set(IDTOOLS_INCLUDES
  #${TOOLS_INCLUDES}
  #${TOOLS_COMAFX_INCLUDES}
  #${TOOLS_COMMON_INCLUDES}
  #${TOOLS_COMMON_PROPTREE_INCLUDES}
  #${EDITOR_AF_INCLUDES}
  #${EDITOR_DEBUGGER_INCLUDES}
  #${EDITOR_DECL_INCLUDES}
  #${EDITOR_GUIED_INCLUDES}
  #${EDITOR_MATERIALEDITOR_INCLUDES}
  #${EDITOR_PARTICLE_INCLUDES}
  #${EDITOR_PDA_INCLUDES}
  #${EDITOR_RADIANT_INCLUDES}
  #${EDITOR_SCRIPT_INCLUDES}
  #${EDITOR_SOUND_INCLUDES}
  ${COMPILER_INCLUDES}
  ${COMPILER_AAS_INCLUDES} ${COMPILER_AAS_SOURCES}
  ${COMPILER_DMAP_INCLUDES} ${COMPILER_DMAP_SOURCES}
  #${COMPILER_RENDERBUMP_INCLUDES} ${COMPILER_RENDERBUMP_SOURCES}
  #${COMPILER_ROQVQ_INCLUDES} ${COMPILER_ROQVQ_SOURCES}
  )

set(IDTOOLS_SOURCES
  #${TOOLS_COMAFX_SOURCES}
  #${TOOLS_COMMON_SOURCES}
  #${TOOLS_COMMON_PROPTREE_SOURCES}
  #${EDITOR_AF_SOURCES}
  #${EDITOR_DEBUGGER_SOURCES}
  #${EDITOR_DECL_SOURCES}
  #${EDITOR_GUIED_SOURCES}
  #${EDITOR_MATERIALEDITOR_SOURCES}
  #${EDITOR_PARTICLE_SOURCES}
  #${EDITOR_PDA_SOURCES}
  #${EDITOR_RADIANT_SOURCES}
  #${EDITOR_SCRIPT_SOURCES}
  #${EDITOR_SOUND_SOURCES}
  ${COMPILER_AAS_SOURCES}
  ${COMPILER_DMAP_SOURCES}
  #${COMPILER_RENDERBUMP_SOURCES}
  #${COMPILER_ROQVQ_SOURCES}
  )
