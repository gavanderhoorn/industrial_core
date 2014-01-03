cmake_minimum_required(VERSION 2.8.3)

project(simple_message)

find_package(catkin REQUIRED COMPONENTS roscpp industrial_msgs)

catkin_package(
    # this pkg (and all variants) depend on these catkin pkgs
    CATKIN_DEPENDS roscpp industrial_msgs
    # we export the base library (for use by other pkgs)
    LIBRARIES ${PROJECT_NAME}
    # the base include dir (to be reused by variant pkgs as well)
    INCLUDE_DIRS include
    # TODO: this also gets installed in this pkg's SHARE_DESTINATION, unwanted
    #       and unneeded (unless we also install source)
    CFG_EXTRAS simple_messageExports.cmake
    # TODO: figure out how to export our set of build flags
)

include_directories(
    include
    ${catkin_INCLUDE_DIRS}
)

# reuse exported variables for base pkg
include(cmake/simple_messageExports.cmake)

add_definitions(${simple_message_DEFINITIONS})

# build base version of the library
add_library(${PROJECT_NAME} ${simple_message_SOURCES})
target_link_libraries(${PROJECT_NAME} ${catkin_LIBRARIES})
add_dependencies(${PROJECT_NAME} ${industrial_msgs_EXPORTED_TARGETS})


catkin_add_gtest(${PROJECT_NAME}_utest ${simple_message_UTEST_SOURCES})
set_target_properties(${PROJECT_NAME}_utest PROPERTIES COMPILE_DEFINITIONS "TEST_PORT_BASE=11000")
target_link_libraries(${PROJECT_NAME}_utest ${PROJECT_NAME})

catkin_add_gtest(${PROJECT_NAME}_utest_udp ${simple_message_UTEST_SOURCES})
set_target_properties(${PROJECT_NAME}_utest_udp PROPERTIES COMPILE_DEFINITIONS "TEST_PORT_BASE=15000;UDP_TEST")
target_link_libraries(${PROJECT_NAME}_utest_udp ${PROJECT_NAME})

install(
    TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION})

install(
    DIRECTORY include/${PROJECT_NAME}/
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION})

# TODO: should source also be installed to SHARE dest? This would allow variant
#       packages to be build based on an installed base package.
