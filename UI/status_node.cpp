#include <string>
#include "ros/ros.h"
#include "mir_msgs/RobotState.h"
#include "ros_vars.h"

std::string status;

void statusCallback(const mir_msgs::RobotState::ConstPtr& msg) {
  int state = msg->robotState;
  switch(state) {
    case 1:
      status = "Starting";
      break;
    case 2:
      status = "Shutting Down";
      break;
    case 3:
      status = "Ready";
      break;
    case 4:
      status = "Paused";
      break;
    case 5:
      status = "Mission Active";
      break;
    case 6:
      status = "Aborted";
      break;
    case 7:
      status = "Mission Completed";
      break;
    case 8:
      status = "Robot Charging";
      break;
    case 9:
      status = "Robot Docking";
      break;
    case 10:
      status = "E-Stop Active";
      break;
    case 11:
      status = "Manual Controls Engaged";
      break;
    case 12:
      status = "ERROR";
      break;
  }
}

int main(int argc, char **argv) {
  ros::init(argc, argv, "ReadStatus");
  ros::NodeHandle n;
  ros::Subscriber sub = n.subscribe("/robot_state", 1000, statusCallback);
  ros::spin();
  return 0;
}