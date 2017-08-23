set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -Wall -Wextra -pthread")
#设置可执行文件输出路径
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
#添加目标
add_executable(unittest_utest 
	test_utest.cc
	)
#目标所需要的库
target_link_libraries(unittest_utest GTEST UTEST)
