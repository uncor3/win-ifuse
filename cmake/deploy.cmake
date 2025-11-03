# create dist directory and move the executable there
set(DEST_DIR "${CMAKE_CURRENT_BINARY_DIR}/dist")
file(MAKE_DIRECTORY "${DEST_DIR}")

set(BIN "${CMAKE_CURRENT_BINARY_DIR}/win-ifuse.exe")

# move target executable
file(RENAME "${BIN}" "${DEST_DIR}/win-ifuse.exe")

# required DLLs
set(REQUIRED_DLLS
    "libcrypto-3-x64.dll"
    "libimobiledevice-1.0.dll"
    "libimobiledevice-glue-1.0.dll"
    "libplist-2.0.dll"
    "libssl-3-x64.dll"
    "libusbmuxd-2.0.dll"
    "winfsp-x64.dll"
)

set(DLL_SEARCH_PATHS
    "${MSYS2_BIN_PATH}"
    "C:/Program Files (x86)/WinFsp/bin"
)

foreach(DLL_NAME ${REQUIRED_DLLS})
    set(DLL_FOUND FALSE)
    
    foreach(SEARCH_PATH ${DLL_SEARCH_PATHS})
        set(DLL_PATH "${SEARCH_PATH}/${DLL_NAME}")
        if(EXISTS "${DLL_PATH}")
            message("Copying dependency: ${DLL_NAME} from ${SEARCH_PATH}")
            file(COPY "${DLL_PATH}" DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/dist")
            set(DLL_FOUND TRUE)
            break()
        endif()
    endforeach()
    
    if(NOT DLL_FOUND)
        message(FATAL_ERROR "Required DLL not found: ${DLL_NAME}")
    endif()
endforeach()