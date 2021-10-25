#include "Kinetics.h"

extern parameter_robot robot;

double* Forward_Kinetics(double Angle_alpha_beta_gamma[3]){ //radiant 
    using std::pow;
    using std::sqrt;
    static double  trajectories[3]{0};
    double x_a,z_a,x_c,z_c,d_1,a_1,h_1,temp_x_1,temp_z_1,x_b,z_b,d_2,a_2,h_2,temp_x_2,temp_z_2,Y_Foot_default,Z_Foot_temp;
    
    Y_Foot_default = -robot.h;
    x_a = robot.length_OA * std::cos(Angle_alpha_beta_gamma[0]);
    z_a = robot.length_OA * std::sin(Angle_alpha_beta_gamma[0]);
    
    x_c = robot.length_OC * std::cos(Angle_alpha_beta_gamma[1]);
    z_c = robot.length_OC * std::sin(Angle_alpha_beta_gamma[1]);
    
    d_1 = sqrt(pow(x_a - x_c,2) + pow(z_a - z_c,2));
    a_1 = (pow(robot.length_AB,2) - pow(robot.length_BC,2) + sqrt(d_1)) / (2 * d_1);
    h_1 = sqrt(pow(robot.length_AB,2) - pow(a_1,2));
    temp_x_1 = x_a + (a_1 / d_1) * (x_c - x_a);
    temp_z_1 = z_a + (a_1 / d_1)*(z_c - z_a);
    
    x_b = temp_x_1 + (h_1 / d_1) * (z_a - z_c);
    z_b = temp_z_1 - (h_1 / d_1) * (x_a - x_c);
    
    d_2 = robot.length_AB;
    a_2 = (pow(robot.length_AD,2) - pow(robot.length_BD,2) + pow(d_2,2)) / (2 * d_2);
    h_2 = sqrt(pow(robot.length_AD,2) - pow(a_2,2));
    temp_x_2 = x_a - (a_2 / d_2) * (x_a - x_b);
    temp_z_2 = z_a - (a_2 / d_2) * (z_a - z_b);

    trajectories[0] = temp_x_2 + (h_2 / d_2) * (z_a - z_b);
    Z_Foot_temp = temp_z_2 - (h_2 / d_2) * (x_a - x_b);
    
    trajectories[2] = std::sin(Angle_alpha_beta_gamma[2]) * Y_Foot_default + Z_Foot_temp*std::cos(Angle_alpha_beta_gamma[2]);
    trajectories[1] = std::cos(Angle_alpha_beta_gamma[2]) * Y_Foot_default - std::sin(Angle_alpha_beta_gamma[2]) * Z_Foot_temp;
    return trajectories;
}


double* Inverse_Kinetics(double Trajectories_xyz[3])
{
    /*Trajectories[0]: X_Foot
     * Trajectories[1]: Y_Foot
     * Trajectories[2]: Z_Foot
     */
    using std::sqrt;
    using std::pow;
    using std::cos;
    using std::sin;
    using std::atan; //radiant
    static double Angles[3]{0}; //[Angle_Hip,Angle_Knee,Angle_Shoulder]
    
    double distance, length_Hip_Ankle, gamma_1, gamma_2, S, N, Angle_OAKnee, x_a, z_a, x_d, y_d, z_d, d_AD, d_AE, d_BE, x_e_ad, z_e_ad, x_b, z_b, d_OB, d_OE, d_CE, x_e_ob, z_e_ob, x_c, z_c;
    
    distance = sqrt(pow(Trajectories_xyz[1],2) + pow(Trajectories_xyz[2],2));
    length_Hip_Ankle = sqrt(pow(distance,2) - pow(robot.h,2));
    gamma_1 = -atan(robot.h/length_Hip_Ankle) * robot.convert_scale_r_d; //degree
    gamma_2 = -atan(Trajectories_xyz[1] / Trajectories_xyz[2]) * robot.convert_scale_r_d;
    
    Angles[2] = gamma_2 - gamma_1;
    
    // .............................................................solve the knee's angle...................................................................................
    S = sqrt(pow(length_Hip_Ankle,2) + pow(Trajectories_xyz[0],2));
    N = (pow(S,2) - pow(robot.length_OA,2) - pow(robot.length_AD,2)) / (2 * robot.length_OA);
    Angle_OAKnee = std::acos(N / robot.length_AD) * robot.convert_scale_r_d;
    
    Angles[0] = 270 + (atan(Trajectories_xyz[0] / length_Hip_Ankle) + std::acos((robot.length_OA + N) / S)) * robot.convert_scale_r_d;
    x_a = robot.length_OA * cos(Angles[0] * robot.convert_scale_d_r);
    z_a = robot.length_OA * sin(Angles[0] * robot.convert_scale_d_r);
    x_d = Trajectories_xyz[0];
    
    y_d = cos(-Angles[2] * robot.convert_scale_d_r)* Trajectories_xyz[1] - Trajectories_xyz[2] * sin(-Angles[2] * robot.convert_scale_d_r);
    z_d = sin(-Angles[2] * robot.convert_scale_d_r) * Trajectories_xyz[1] + Trajectories_xyz[2] * cos(-Angles[2] * robot.convert_scale_d_r);
    
    d_AD = robot.length_AD;
    d_AE = (pow(robot.length_AB,2) + pow(d_AD,2) - pow(robot.length_BD,2))/( 2 * d_AD);
    d_BE = sqrt(pow(robot.length_AB,2) - pow(d_AE,2));
    
    x_e_ad = x_a - (d_AE / d_AD) * (x_a - x_d);
    z_e_ad = z_a - (d_AE / d_AD) * (z_a - z_d);
    
    x_b = x_e_ad - (d_BE / d_AD) * (z_a - z_d);
    z_b = z_e_ad + (d_BE / d_AD) * (x_a - x_d);
    
    d_OB = sqrt(pow(x_b,2) + pow(z_b,2));
    d_OE = (pow(robot.length_OC,2) + pow(d_OB,2) - pow(robot.length_BC,2)) / (2 * d_OB);
    d_CE = sqrt(pow(robot.length_OC,2) - pow(d_OE,2));
    
    x_e_ob = (d_OE / d_OB) * x_b;
    z_e_ob = (d_OE / d_OB) * z_b;
    x_c = x_e_ob + (d_CE /d_OB) * z_b;
    z_c = z_e_ob - (d_CE / d_OB) * x_b;
    
    Angles[1] = 270 - atan(x_c / z_c) * robot.convert_scale_r_d;
    
    return Angles;
}

