clc;
clear;

syms theta1 theta2 theta3 theta4 theta5 l1 l2 l0;

%%
%检测函数是否写对
% q0 = [0 l1+l2 l0];
% q1 = [0 0 0];
% q2 = [0 l1 0];
% q3 = [0 l1+l2 0];
% g_st0 = [1 0 0 0;0 1 0 l1+l2;0 0 1 l0;0 0 0 1];
% matrix_1 = convert_exponential_rotation([0 0 1],theta1,q1);
% matrix_2 = convert_exponential_rotation([0 0 1],theta2,q2);
% matrix_3 = convert_exponential_rotation([0 0 1],theta3,q3);
% matrix_4 = convert_exponential_transfer(3,theta4);
% gst = matrix_1 * matrix_2 * matrix_3 * matrix_4 * g_st0;
%正确

%%
%读取数据
data = load('Answer of Question_1.txt');
num = size(data);

%初始化
point = zeros(num(1),3);
norm_vector = zeros(num(1),3);
theta_1_final = zeros(num(1),1);
theta_2_final = zeros(num(1),1);
theta_3_final = zeros(num(1),1);
theta_4_final = zeros(num(1),1);
theta_5_final = zeros(num(1),1);
solution = zeros(num(1),5);
o = zeros(1,num(1));

%初始化点
for i = 1 :1:num(1)
    point(i,:) = [data(i,1) data(i,2) data(i,3)];
    norm_vector(i,:) = [data(i,4) data(i,5) data(i,6)];
end

%计算平移矩阵
matrix_transfer_1 = convert_exponential_transfer(1,theta1);
matrix_transfer_2 = convert_exponential_transfer(2,theta2);
matrix_transfer_3 = convert_exponential_transfer(3,theta3);

%计算旋转
w_4 = [0 0 1];
w_5 = [0 sqrt(2)/2 sqrt(2)/2];
matrix_rotation_1 = convert_exponential_rotation(w_4,theta4,[0 0 0]);
matrix_rotation_2 = convert_exponential_rotation(w_5,theta5,[0 0 0]);

%计算g_st0与g_st
g_st0 = [1 0 0 0;...
    0 1 0 0;...
    0 0 1 0;...
    0 0 0 1];

g_st = matrix_transfer_1 * matrix_transfer_2 * matrix_transfer_3 * matrix_rotation_1 * matrix_rotation_2 * g_st0;

%normal vector matrix
normal_vector_matrix= g_st * [0 0 1 0]';
transfer_matrix = g_st * [0 0 0 1]';

disp(g_st);

%使用解方程法验证解析方法第一组数据是否正确
% eq1 = normal_vector_matrix(2,1) - norm_vector(1,2);
% eq2 = normal_vector_matrix(3,1) - norm_vector(1,3);
% [theta4,theta5] = solve(eq1,eq2,theta4,theta5);
% theta4_final = theta4(1);
% double(theta4)
% double(theta5)

%%
%计算theta4与theta5
for i = 1 :num(1)
theta5(i,1) = acos(2 * norm_vector(i,3) - 1);
sol=solve((2^(1/2)*sin(theta4)*sin(theta5(i,1)))/2 - cos(theta4)*(cos(theta5(i,1))/2 - 1/2),theta4);
o(i) = double(sol(1));
end


for i =1 :num(1)
    theta_1_final(i,1) = point(i,1);
    theta_2_final(i,1) = point(i,2);
    theta_3_final(i,1) = point(i,3);
    theta_4_final(i,1) = o(i);
    theta_5_final(i,1) = theta5(i,1);
    solution(i,:) = [theta_1_final(i,1) theta_2_final(i,1) theta_3_final(i,1) theta_4_final(i,1) theta_5_final(i,1)];
end

% disp(solution);

%%
% 写入文件
fid = fopen('Rotation of Axis.txt','w');
for i=1:num(1)
    fprintf(fid,'%f\t%f\t%f\t%f\t%f\n',solution(i,1),solution(i,2),solution(i,3),solution(i,4),solution(i,5));
end
fclose(fid);

