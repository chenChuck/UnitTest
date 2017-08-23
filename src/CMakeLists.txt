# CMake 最低版本号要求
cmake_minimum_required (VERSION 2.8)
# 项目信息
project (DenaliBD_L)

#添加编译选项
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -Wall -Wextra -pthread")
#设置库文件输出路径
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
#添加Gtest 源文件
aux_source_directory(gtest/src GTEST_LIB_SRCS)
#包含头文件路径
include_directories(gtest/include)
#生成GTEST静态库
add_library (GTEST STATIC ${GTEST_LIB_SRCS})


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage" )

aux_source_directory(. LIB_SRCS)

add_library (UTEST  ${LIB_SRCS})
#添加子目录
add_subdirectory(test)
#开启测试
enable_testing()
#添加测试
add_test(my_unittest ${PROJECT_BINARY_DIR}/bin/unittest_utest)
