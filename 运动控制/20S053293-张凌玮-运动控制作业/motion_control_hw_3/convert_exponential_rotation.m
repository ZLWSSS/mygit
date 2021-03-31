function matrix_rotation = convert_exponential_rotation(w,theta,q)

vos = 1- cos(theta);

%计算旋转矩阵R
exponential_rotation = [(w(1)^2)*vos + cos(theta) w(1)*w(2)*vos - w(3)*sin(theta) w(1)*w(2)*vos + w(2)*sin(theta);...
    w(1)*w(2)*vos + w(3)*sin(theta) (w(2)^2)*vos + cos(theta) w(2)*w(3)*vos - w(1)*sin(theta);...
    w(1)*w(3)*vos - w(2)*sin(theta) w(2)*w(3)*vos + w(1)*sin(theta) (w(3)^2)*vos + cos(theta)];

%计算速度
velocity = -cross(w,q);  

%e^(epsilon*theta)
exponential_epsilon = [exponential_rotation (eye(3) - exponential_rotation)*cross(w,velocity)';0,0,0,1];
%exponential_epsilon 取消注释以显示输出

matrix_rotation = exponential_epsilon;
end
