# 
# Exports shared variables.
# 

set(
    simple_message_DEFINITIONS

    -DROS=1
    -DLINUXSOCKETS=1
)

# TODO: this probably doesn't work if we install source to SHARE dest as well.
#       need to fix path to files then.
set(
    simple_message_SOURCES

    ${CMAKE_CURRENT_LIST_DIR}/../src/byte_array.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/simple_message.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/smpl_msg_connection.cpp

    ${CMAKE_CURRENT_LIST_DIR}/../src/socket/simple_socket.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/socket/udp_socket.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/socket/udp_client.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/socket/udp_server.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/socket/tcp_socket.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/socket/tcp_client.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/socket/tcp_server.cpp

    ${CMAKE_CURRENT_LIST_DIR}/../src/message_handler.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/message_manager.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/ping_handler.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/ping_message.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/joint_data.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/joint_feedback.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/joint_traj_pt.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/joint_traj_pt_full.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/joint_traj.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/robot_status.cpp

    ${CMAKE_CURRENT_LIST_DIR}/../src/messages/joint_message.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/messages/joint_feedback_message.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/messages/joint_traj_pt_message.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/messages/joint_traj_pt_full_message.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../src/messages/robot_status_message.cpp

    ${CMAKE_CURRENT_LIST_DIR}/../src/simple_comms_fault_handler.cpp
)

set(
    simple_message_UTEST_SOURCES

    ${CMAKE_CURRENT_LIST_DIR}/../test/utest.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../test/utest_message.cpp
)
