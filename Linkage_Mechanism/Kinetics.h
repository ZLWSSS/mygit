#ifndef INTRODUCTION_H_
#define INTRODUCTION_H_
#include <iostream>
#include <cmath>

//structure parameters unit:m;
struct parameter_robot{
    double length_OA = 0.3;
    double length_AB = 0.1;
    double length_BD = 0.211477942;
    double length_OC = 0.1;
    double length_BC = 0.3;
    double length_AD = 0.3;
    double Z_hip = 0.5;
    //width of the shoulder
    double h = 0;
    double convert_scale_d_r = M_PI / 180.0;
    double convert_scale_r_d = 180.0 / M_PI;
};

parameter_robot robot;

//solve angle of joints from trajectories
double* Inverse_Kinetics(double Trajectories_xyz[3]); 

//solve trajectories xyz from angle
double* Forward_Kinetics(double Angle_alpha_beta_gamma[3]);

#endif
