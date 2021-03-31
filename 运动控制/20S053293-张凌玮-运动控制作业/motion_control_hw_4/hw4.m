clc
clear 
syms x_center y_center z_center;
p0 = [1 0 0];
p1 = [0 0 1];
p2 = [0 1 0];

%在p1p2p3组成的平面上求圆心点
vector_p0p1 = p0 - p1;
vector_p2p1 = p2 - p1;
vector_p0p2 = p0 - p2;

%法向量
norm_vector = cross(vector_p0p1,vector_p2p1);
norm_vector = norm_vector/norm(norm_vector); %单位化

%求出平面上的圆心
eq1 = norm_vector(1)*(x_center - p0(1)) +   norm_vector(2)*(y_center - p0(2)) + norm_vector(3)*(z_center - p0(3)) == 0;
eq2 = norm_vector(1)*(x_center - p2(1)) +   norm_vector(2)*(y_center - p2(2)) + norm_vector(3)*(z_center - p2(3)) == 0;
eq3 = (x_center - p0(1)) - (z_center - p0(3)) == 0;
eq4 = x_center + y_center + z_center == 1;
eq5 = (y_center - p2(2))-(z_center - p2(3)) ==0;
sol = solve(eq1,eq2,eq3,eq4,eq5,x_center,y_center,z_center);
x_center = sol.x_center;
y_center = sol.y_center;
z_center = sol.z_center;
center = [x_center y_center z_center];
disp('The center of the circle:');
disp(center);

%%
%计算向量夹角
theta_rad = acos(((norm(vector_p0p1))^2 + (norm(vector_p2p1))^2 - (norm(vector_p0p2))^2)/(2*(norm(vector_p0p1))^2*(norm(vector_p0p2))^2));
disp('The range of radian: ');
disp(theta_rad);
theta_degree = 180* (theta_rad/pi);
disp('The range of degree: ');
disp(theta_degree);

%计算基准向量
base_vector_1 = p0 - center
base_vector_2 = p2 - center

%计算半径
radius = norm(base_vector_1);

%计算比例因子k = theta/theta_rad
i = 1;
%计算圆弧
i = 1;
for theta = 0:0.005:theta_rad
    vector_theta = (1 - theta/theta_rad) * base_vector_1 + (theta/theta_rad) * base_vector_2;
    vector_radius = (vector_theta/norm(vector_theta))*radius;
    center_theta(i,:) = center + vector_radius;
    plot3(center_theta(i,1),center_theta(i,2),center_theta(i,3),'r*');
    hold on
    i = i + 1;
end
%表示圆弧轨迹坐标关于theta的表达式
%P = center + radius * ((1 - theta/theta_rad) * base_vector_1 + (theta/theta_rad) * base_vector_2)/norm((theta/theta_rad) * base_vector_1 + (1 - theta/theta_rad) * base_vector_2);

%%
%求方向向量关于theta的表达式
n0 = [0 -1 0];
n1 = [0 -sqrt(2)/2 sqrt(2)/2];
n2 = [0 0 1];

%计算圆弧长度
S = theta_rad * radius;

num = 1;
for theta = 0 : 0.005 : theta_rad
    if theta <= (theta_rad/2)
    N_theta(num,:) = (1 - theta/(theta_rad / 2)) * n0 + theta/(theta_rad/2) * n1;
    N_theta_normal(num,:) = N_theta(num,:)/norm(N_theta(num,:));
    num = num + 1;
    end
    if theta > (theta_rad/2)
    N_theta(num,:) = (1 - (theta - theta_rad/2)/(theta_rad/2)) * n1 + (theta - theta_rad/2) / (theta_rad/2) * n2;
    N_theta_normal(num,:) = N_theta(num,:)/norm(N_theta(num,:));
    num = num + 1;
    end
end

%根据theta表示向量N
%N_1 =  ((1 - theta/(theta_rad / 2)) * n0 + theta/(theta_rad / 2) * n1)/norm((1 - theta/(theta_rad / 2)) * n0 + theta/(theta_rad / 2) * n1)
%N_2 = ((1 - (theta - theta_rad/2)/(theta_rad / 2)) * n1 + (theta - theta_rad/2)/(theta_rad / 2) * n1)/norm((1 - (theta - theta_rad/2)/(theta_rad / 2)) * n0 + (theta - theta_rad/2)/(theta_rad / 2) * n2);
direction_vector = center_theta + N_theta_normal * 0.1; %乘以0.1是为了图好看

%%
%绘图
for i = 1 : 1 : 264
plot3([direction_vector(i,1) center_theta(i,1)],[direction_vector(i,2) center_theta(i,2)],[direction_vector(i,3) center_theta(i,3)],'o-k');
hold on
end

plot3([p0(1) x_center],[p0(2) y_center],[p0(3) z_center],'o-k');
hold on
plot3([p2(1) x_center],[p2(2) y_center],[p2(3) z_center],'o-k');
hold on
plot3([p0(1) p1(1)],[p0(2) p1(2)],[p0(3) p1(3)],'o-k');
hold on
plot3([p1(1) p2(1)],[p1(2) p2(2)],[p1(3) p2(3)],'o-k');
hold on
plot3(x_center,y_center,z_center,'r*');
grid on
xlabel('x');
ylabel('y');
zlabel('z');

%写入文档
fid_1 = fopen('Points of circle.txt','w');
for i = 1 : 1 : 264
fprintf(fid_1,'%f\t%f\t%f\n',center_theta(i,1),center_theta(i,2),center_theta(i,3));
end
fclose(fid_1);

fid_2 = fopen('Direction vector of points.txt','w');
for i = 1 : 1 : 264
    fprintf(fid_2,'%f\t%f\t%f\n',N_theta_normal(i,1),N_theta_normal(i,2),N_theta_normal(i,3));
end
fclose(fid_2);

