# Python Dependency External Project
#
# Required symbols are:
#   VIAME_BUILD_PREFIX - where packages are built
#   VIAME_BUILD_INSTALL_PREFIX - directory install target
#   VIAME_PACKAGES_DIR - location of git submodule packages
#   VIAME_ARGS_COMMON -
##

# --------------------- ADD ANY EXTRA PYTHON DEPS HERE -------------------------

set( VIAME_PYTHON_DEPS numpy matplotlib )
set( VIAME_PYTHON_DEP_CMDS "numpy" "matplotlib" )

if( VIAME_ENABLE_CAMTRAWL )
  list( APPEND VIAME_PYTHON_DEPS ubelt )
  list( APPEND VIAME_PYTHON_DEP_CMDS "ubelt" )
endif()

if( VIAME_ENABLE_TENSORFLOW )
  list( APPEND VIAME_PYTHON_DEPS humanfriendly )
  list( APPEND VIAME_PYTHON_DEP_CMDS "humanfriendly" )

  list( APPEND VIAME_PYTHON_DEPS tensorflow )
  if( VIAME_ENABLE_CUDA )
    list( APPEND VIAME_PYTHON_DEP_CMDS "tensorflow-gpu" )
  else()
    list( APPEND VIAME_PYTHON_DEP_CMDS "tensorflow" )
  endif()
endif()

if( VIAME_ENABLE_PYTORCH AND NOT VIAME_ENABLE_PYTORCH-INTERNAL )
  list( APPEND VIAME_PYTHON_DEPS torch )
  list( APPEND VIAME_PYTHON_DEPS torchvision )

  set( ARGS_TORCH )
  set( ARGS_TORCHVISION )

  set( PYTORCH_ARCHIVE https://download.pytorch.org/whl/torch_stable.html )

  if( WIN32 AND VIAME_ENABLE_CUDA )
    set( PYTORCH_VERSION 1.2.0 )
    set( TORCHVISION_VERSION 0.4.0 )

    if( CUDA_VERSION VERSION_GREATER_EQUAL "10.1" )
      set( ARGS_TORCH "==${PYTORCH_VERSION} -f ${PYTORCH_ARCHIVE}" )
      set( ARGS_TORCHVISION "==${PYTORCH_VERSION} -f ${PYTORCH_ARCHIVE}" )
    elseif( CUDA_VERSION VERSION_GREATER_EQUAL "10.0" )
      set( ARGS_TORCH "==${PYTORCH_VERSION}+cu100 -f ${PYTORCH_ARCHIVE}" )
      set( ARGS_TORCHVISION "==${TORCHVISION_VERSION}+cu100 -f ${PYTORCH_ARCHIVE}" )
    elseif( CUDA_VERSION VERSION_EQUAL "9.2" )
      set( ARGS_TORCH "==${PYTORCH_VERSION}+cu92 -f ${PYTORCH_ARCHIVE}" )
      set( ARGS_TORCHVISION "==${TORCHVISION_VERSION}+cu92 -f ${PYTORCH_ARCHIVE}" )
    else()
      message( FATAL_ERROR "With your current build settings you must either:\n"
        " (a) Turn on VIAME_ENABLE_PYTORCH-INTERNAL or\n"
        " (b) Use CUDA 9.2 or 10.0+\n"
        " (c) Disable VIAME_ENABLE_PYTORCH\n" )
    endif()
  elseif( VIAME_ENABLE_CUDA )
    set( PYTORCH_VERSION 1.3.0 )
    set( TORCHVISION_VERSION 0.4.1 )

    if( CUDA_VERSION VERSION_GREATER_EQUAL "10.1" )
      set( ARGS_TORCH "==${PYTORCH_VERSION} -f ${PYTORCH_ARCHIVE}" )
      set( ARGS_TORCHVISION "==${PYTORCH_VERSION} -f ${PYTORCH_ARCHIVE}" )
    elseif( CUDA_VERSION VERSION_GREATER_EQUAL "10.0" )
      set( ARGS_TORCH "==${PYTORCH_VERSION}+cu100 -f ${PYTORCH_ARCHIVE}" )
      set( ARGS_TORCHVISION "==${TORCHVISION_VERSION}+cu100 -f ${PYTORCH_ARCHIVE}" )
    elseif( CUDA_VERSION VERSION_EQUAL "9.2" )
      set( ARGS_TORCH "==${PYTORCH_VERSION}+cu92 -f ${PYTORCH_ARCHIVE}" )
      set( ARGS_TORCHVISION "==${TORCHVISION_VERSION}+cu92 -f ${PYTORCH_ARCHIVE}" )
    else()
      message( FATAL_ERROR "With your current build settings you must either:\n"
        " (a) Turn on VIAME_ENABLE_PYTORCH-INTERNAL or\n"
        " (b) Use CUDA 9.2 or 10.0+\n"
        " (c) Disable VIAME_ENABLE_PYTORCH\n" )
    endif()
  else()
    set( PYTORCH_VERSION 1.3.0 )
    set( TORCHVISION_VERSION 0.4.1 )

    set( ARGS_TORCH "==${PYTORCH_VERSION}+cpu -f ${PYTORCH_ARCHIVE}" )
    set( ARGS_TORCHVISION "==${TORCHVISION_VERSION}+cpu -f ${PYTORCH_ARCHIVE}" )
  endif()

  list( APPEND VIAME_PYTHON_DEP_CMDS "torch${ARGS_TORCH}" )
  list( APPEND VIAME_PYTHON_DEP_CMDS "torchvision${ARGS_TORCHVISION}" )
endif()

if( VIAME_ENABLE_PYTORCH AND VIAME_ENABLE_PYTORCH-MMDET AND NOT WIN32 )
  list( APPEND VIAME_PYTHON_DEPS "pycocotools" )
  list( APPEND VIAME_PYTHON_DEP_CMDS "pycocotools" )
endif()

# ------------------------------------------------------------------------------

set( PYTHON_BASEPATH
  ${VIAME_BUILD_INSTALL_PREFIX}/lib/python${PYTHON_VERSION} )

if( WIN32 )
  set( CUSTOM_PYTHONPATH
    ${PYTHON_BASEPATH}/site-packages;${PYTHON_BASEPATH}/dist-packages )
  set( CUSTOM_PATH
    ${VIAME_BUILD_INSTALL_PREFIX}/bin;$ENV{PATH} )

  string( REPLACE ";" "----" CUSTOM_PYTHONPATH "${CUSTOM_PYTHONPATH}" )
  string( REPLACE ";" "----" CUSTOM_PATH "${CUSTOM_PATH}" )
else()
  set( CUSTOM_PYTHONPATH
    ${PYTHON_BASEPATH}/site-packages:${PYTHON_BASEPATH}/dist-packages )
  set( CUSTOM_PATH
    ${VIAME_BUILD_INSTALL_PREFIX}/bin:$ENV{PATH} )
endif()

set( VIAME_PYTHON_DEPS_DEPS fletch )

if( VIAME_ENABLE_SMQTK )
  set( VIAME_PYTHON_DEPS_DEPS smqtk ${VIAME_PYTHON_DEPS_DEPS} )
endif()

list( LENGTH VIAME_PYTHON_DEPS DEP_COUNT )
math( EXPR DEP_COUNT "${DEP_COUNT} - 1" )

foreach( ID RANGE ${DEP_COUNT} )

  list( GET VIAME_PYTHON_DEPS ${ID} DEP )
  list( GET VIAME_PYTHON_DEP_CMDS ${ID} CMD )

  set( VIAME_PROJECT_LIST ${VIAME_PROJECT_LIST} ${DEP} )

  set( PYTHON_DEP_PIP_CMD pip install --user ${CMD} )
  string( REPLACE " " ";" PYTHON_DEP_PIP_CMD "${PYTHON_DEP_PIP_CMD}" )

  set( PYTHON_DEP_INSTALL
    ${CMAKE_COMMAND} -E env "PYTHONPATH=${CUSTOM_PYTHONPATH}"
                            "PATH=${CUSTOM_PATH}"
                            "PYTHONUSERBASE=${VIAME_BUILD_INSTALL_PREFIX}"
      ${PYTHON_EXECUTABLE} -m ${PYTHON_DEP_PIP_CMD}
    )

  ExternalProject_Add( ${DEP}
    DEPENDS ${VIAME_PYTHON_DEPS_DEPS}
    PREFIX ${VIAME_BUILD_PREFIX}
    SOURCE_DIR ${VIAME_CMAKE_DIR}
    USES_TERMINAL_BUILD 1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${PYTHON_DEP_INSTALL}
    INSTALL_COMMAND ""
    INSTALL_DIR ${VIAME_BUILD_INSTALL_PREFIX}
    LIST_SEPARATOR "----"
    )
endforeach()
