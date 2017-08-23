## CMake 最低版本号要求
#cmake_minimum_required (VERSION 2.8)
# 项目信息
#project (Demo3)
# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_LIB_SRCS)
include_directories(../include)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -Wall -Wextra -pthread")
add_library (MathFunctions  ${DIR_LIB_SRCS})
add_library (gtest STATIC  ${DIR_LIB_SRCS})
#add_subdirectory(../../test _BINARY_DIR)
