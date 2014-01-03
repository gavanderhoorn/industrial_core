cmake_minimum_required(VERSION 2.8.3)

project(simple_message_bswap)

find_package(catkin REQUIRED COMPONENTS roscpp industrial_msgs)

# find the simple_message base pkg separately, because it also exports
# the base library, which we don't want to 'catkin-link' to
find_package(simple_message REQUIRED)

catkin_package(
    # do NOT include simple_message, for reasons stated above
    CATKIN_DEPENDS roscpp industrial_msgs
    # we export our own version of the library
    LIBRARIES ${PROJECT_NAME}
    # but reuse the base package include dirs
    INCLUDE_DIRS ${simple_message_INCLUDE_DIRS}
    # TODO: figure out how to export our set of build flags
)

# since we find the simple_message base pkg separately, add it to the 
# include path
include_directories(${simple_message_INCLUDE_DIRS} ${catkin_INCLUDE_DIRS})

# we need base pkg's defines
add_definitions(${simple_message_DEFINITIONS})

# build our version, using the exported sources list
add_library(${PROJECT_NAME} ${simple_message_SOURCES})
set_target_properties(${PROJECT_NAME} PROPERTIES COMPILE_DEFINITIONS "BYTE_SWAPPING")
target_link_libraries(${PROJECT_NAME} ${catkin_LIBRARIES})
add_dependencies(${PROJECT_NAME} ${industrial_msgs_EXPORTED_TARGETS})

catkin_add_gtest(${PROJECT_NAME}_utest ${simple_message_UTEST_SOURCES})
set_target_properties(${PROJECT_NAME}_utest PROPERTIES COMPILE_DEFINITIONS "TEST_PORT_BASE=12000;BYTE_SWAPPING")
target_link_libraries(${PROJECT_NAME}_utest ${PROJECT_NAME})

install(
    TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION})

