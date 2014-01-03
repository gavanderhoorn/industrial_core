cmake_minimum_required(VERSION 2.8.3)

project(simple_message)

find_package(catkin REQUIRED COMPONENTS roscpp industrial_msgs)

catkin_package(
    CATKIN_DEPENDS roscpp industrial_msgs
    LIBRARIES ${PROJECT_NAME}
    INCLUDE_DIRS include
    # this also gets installed in this pkg's SHARE_DESTINATION
    CFG_EXTRAS simple_messageExports.cmake
)

include_directories(
    include
    ${catkin_INCLUDE_DIRS}
)

# reuse exported variables for base pkg
include(cmake/simple_messageExports.cmake)

add_definitions(${simple_message_DEFINITIONS})

add_library(${PROJECT_NAME} ${simple_message_SOURCES})
target_link_libraries(${PROJECT_NAME} ${catkin_LIBRARIES})
add_dependencies(${PROJECT_NAME} ${industrial_msgs_EXPORTED_TARGETS})

catkin_add_gtest(${PROJECT_NAME}_utest ${simple_message_UTEST_SOURCES})
set_target_properties(${PROJECT_NAME}_utest PROPERTIES COMPILE_DEFINITIONS "TEST_PORT_BASE=11000")
target_link_libraries(${PROJECT_NAME}_utest ${PROJECT_NAME})

install(
    TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION})

install(
    DIRECTORY include/${PROJECT_NAME}/
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION})
