cmake_minimum_required(VERSION 2.8.3)

project(industrial_robot_client)

find_package(catkin REQUIRED COMPONENTS
    roscpp std_msgs sensor_msgs control_msgs trajectory_msgs simple_message
    actionlib_msgs actionlib urdf industrial_msgs industrial_utils)

find_package(Boost REQUIRED COMPONENTS system thread)

set(SRC_FILES src/joint_relay_handler.cpp
              src/robot_status_relay_handler.cpp
              src/joint_trajectory_downloader.cpp
              src/joint_trajectory_streamer.cpp
              src/joint_trajectory_interface.cpp
              src/robot_state_interface.cpp
              src/utils.cpp)

catkin_package(
    CATKIN_DEPENDS roscpp std_msgs sensor_msgs control_msgs trajectory_msgs
       simple_message actionlib_msgs actionlib urdf industrial_msgs
       industrial_utils
    INCLUDE_DIRS include
    LIBRARIES ${PROJECT_NAME}
)

# this should probably be done using some export mechanism in catkin
add_definitions(${simple_message_DEFINITIONS})

include_directories(
    include
    ${catkin_INCLUDE_DIRS}
)

add_library(${PROJECT_NAME} ${SRC_FILES})
target_link_libraries(
    ${PROJECT_NAME}
    ${simple_message_LIBRARIES})


# this only builds the default binaries
add_executable(
    robot_state
    src/generic_robot_state_node.cpp)
target_link_libraries(
    robot_state
    ${PROJECT_NAME}
    ${catkin_LIBRARIES})

add_executable(
    motion_streaming_interface
    src/generic_joint_streamer_node.cpp)
target_link_libraries(
    motion_streaming_interface
    ${PROJECT_NAME}
    ${catkin_LIBRARIES})

add_executable(
    motion_download_interface
    src/generic_joint_downloader_node.cpp)
target_link_libraries(
    motion_download_interface
    ${PROJECT_NAME}
    ${catkin_LIBRARIES})


add_executable(
    joint_trajectory_action
    src/generic_joint_trajectory_action_node.cpp
    src/joint_trajectory_action.cpp)
target_link_libraries(
    joint_trajectory_action
    ${PROJECT_NAME}
    ${catkin_LIBRARIES})
add_dependencies(
    joint_trajectory_action
    ${PROJECT_NAME}_gencpp)


catkin_add_gtest(${PROJECT_NAME}_utest test/utest.cpp)
target_link_libraries(
    ${PROJECT_NAME}_utest
    ${PROJECT_NAME}
    ${catkin_LIBRARIES})

install(
    TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION})

install(TARGETS
        robot_state
        motion_streaming_interface
        motion_download_interface
        joint_trajectory_action
    RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})

install(
    DIRECTORY include/${PROJECT_NAME}/
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION})

foreach(dir config launch)
   install(DIRECTORY ${dir}/
      DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/${dir})
endforeach()
