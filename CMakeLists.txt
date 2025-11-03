cmake_minimum_required(VERSION 3.10)
project(win-ifuse)

add_executable(${PROJECT_NAME} win-ifuse.c)


if(NOT DEFINED PACKAGE_VERSION)
    set(PACKAGE_VERSION "dev")
endif()
target_compile_definitions(${PROJECT_NAME} PRIVATE "PACKAGE_VERSION=\"${PACKAGE_VERSION}\"")

find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBIMOBILEDEVICE REQUIRED libimobiledevice-1.0)
pkg_check_modules(LIBPLIST REQUIRED libplist-2.0)

# for some reason pkg-config doesn't find winfsp, so we manually set the paths here
set(WINFSP_INCLUDE_DIR "C:/Program Files (x86)/WinFsp/inc/fuse")
find_library(WINFSP_LIBRARY NAMES winfsp-x64 PATHS "C:/Program Files (x86)/WinFsp/lib" NO_DEFAULT_PATH)


target_include_directories(${PROJECT_NAME} PRIVATE
    ${LIBIMOBILEDEVICE_INCLUDE_DIRS}
    ${LIBPLIST_INCLUDE_DIRS}
    ${WINFSP_INCLUDE_DIR}
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    ${LIBIMOBILEDEVICE_LIBRARIES}
    ${LIBPLIST_LIBRARIES}
    ${WINFSP_LIBRARY}
)

target_compile_options(${PROJECT_NAME} PRIVATE
    ${LIBIMOBILEDEVICE_CFLAGS_OTHER}
    ${LIBPLIST_CFLAGS_OTHER}
)

find_program(GCC_EXECUTABLE NAMES gcc)
get_filename_component(MSYS2_BIN_PATH ${GCC_EXECUTABLE} DIRECTORY)

if(NOT DEFINED NO_DEPLOY)
add_custom_command(
    TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} 
        -DEXECUTABLE_PATH=$<TARGET_FILE:${PROJECT_NAME}>
        -DMSYS2_BIN_PATH=${MSYS2_BIN_PATH}
        -DCMAKE_CURRENT_BINARY_DIR=$<TARGET_FILE_DIR:${PROJECT_NAME}>
        -P ${CMAKE_SOURCE_DIR}/cmake/deploy.cmake
    COMMENT "Running deployment script to copy dependencies..."
    VERBATIM
)
endif()