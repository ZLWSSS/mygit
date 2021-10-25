#include<fstream>
#include "Kinetics.h"
#include <vector>

int main(){
    using namespace std;
    ifstream test_data ("/home/lingwei/Desktop/Linkage_Mechanism/Trajectory_data.txt",std::ios::in);
    ofstream outfile;
    ofstream outfile_1;
    outfile.open("/home/lingwei/Desktop/Linkage_Mechanism/angle_data_test.txt",ios::in);
    outfile_1.open("/home/lingwei/Desktop/Linkage_Mechanism/Trajectory_data_test.txt",ios::in);
    
    if(!test_data.is_open())
    {
        std::cout << "Open file failed!, teminate the process\n";
        exit(0);
    }
    
    double angle_Test[3];
    double* Trajectory_data_test;
    
    while(!test_data.eof())
    {
        test_data >> angle_Test[0];
        test_data >> angle_Test[1];
        test_data >> angle_Test[2];
        Trajectory_data_test = Inverse_Kinetics(angle_Test);
        outfile << Trajectory_data_test[0] << "\t" << Trajectory_data_test[1] << "\t" << Trajectory_data_test[2] << "\n";
        outfile_1 << angle_Test[0] << "\t" << angle_Test[1] << "\t" << angle_Test[2] << "\n";
    }
    //matlab eof konghang
    outfile_1.close();
    outfile.close();
    test_data.close();
    return 0;
    
}
