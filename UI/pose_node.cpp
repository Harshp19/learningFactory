#include "ros/ros.h"
#include "geometry_msgs/Pose.h"
#include "ros_vars.h"

double posx;
double posy;

void poseCallback(const geometry_msgs::Pose::ConstPtr& msg) {
  posx = msg->position.x;
  posy = msg->position.y;
}

int main(int argc, char **argv) {
  ros::init(argc, argv, "ReadPose");
  ros::NodeHandle n;
  ros::Subscriber sub = n.subscribe("/robot_pose", 1000, poseCallback);
  ros::spin();
  return 0;
}