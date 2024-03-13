# CMake编译配置文件
# 声明使用 CMAKE 的最小版本号
cmake_minimum_required(VERSION 3.4.1)

# 配置项目信息
project(NativeTemplateDemo)

# set命令，格式为set(key value)，表示设置key的值为value
# CMAKE_CURRENT_SOURCE_DIR：CMakeList.txt文件所在的目录。
set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

# 设置头文件的搜索目录
include_directories(
    ${NATIVERENDER_ROOT_PATH}
    ${NATIVERENDER_ROOT_PATH}/include
)

# 添加日志库
find_library(
    # Sets the name of the path variable.
    hilog-lib
    # Specifies the name of the NDK library that
    # you want CMake to locate.
    hilog_ndk.z
)

# 添加名为hello的库，库文件名为libhello.so
# add_library：添加本地的cpp文件，多cpp文件使用空格或换行间隔。
add_library(hello SHARED hello.cpp)

# 添加构建需要链接的库
# target_link_libraries：添加需要链接的库，如使用C标准库hypot函数，此处链接libc++.a库文件。
target_link_libraries(hello PUBLIC ${hilog-lib} libace_napi.z.so libc++.a)