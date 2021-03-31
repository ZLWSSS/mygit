%%
%设置题目条件
t0=0;
P0=0;       
P_total = sqrt((100)^2+(20)^2+(200)^2);       %最终位置
v_max = 80.00718524;   %调整后的最大速度 mm/s
a_max=800;   %最大加速度 mm/s^2

t_speed = v_max/a_max;      %加速和减速需要的时间
Pa=0.5*(a_max)*(t_speed^2);  %加速或减速产生的位置量 
t_average = (P_total - 2*Pa)/v_max;%最大速度需要的时间
T = t_average + 2*t_speed;       %到达目标位置所需要的时间

%%
%计算插点
t=t0:0.002:T;
n = size(t);
p_des = zeros(n(1),1);
v_des = zeros(n(1),1);
a_des = zeros(n(1),1);
i = 1;

%判断三种条件
for t = 0:0.002:T
    if t <= t_speed
        p_des(i,1) = 0.5*(a_max)*(t^2);
        v_des(i,1) = a_max * t;
        a_des(i,1) = a_max;
    end
    if t > t_speed && t <= (t_average + t_speed)
        p_des(i,1) = 0.5*(a_max)*(t_speed^2) + (t - t_speed)*v_max;
        v_des(i,1) = v_max;
        a_des(i,1) = 0;
    end
    if t > (t_average + t_speed)
        p_des(i,1) = P_total - 0.5*(a_max)*((T-t)^2);
        v_des(i,1) = a_max*(T - t);
        a_des(i,1) = -a_max;
    end
    i = i + 1;
end

%%
%画图
subplot(3,1,1);
plot(p_des);
legend('位置曲线')
subplot(3,1,2);
plot(v_des)
legend('速度曲线')
subplot(3,1,3);
plot(a_des)
legend('加速度曲线')

%%
%输出文档
fid = fopen('Answer of HW_5.txt','w');
fprintf(fid,'%f\t%f\t%f\t%f\n',1,n(2)-1,T,0.002);
for i=1:n(2)
    fprintf(fid,'%f\t%f\t%f\n',p_des(i,1)*(100/P_total),p_des(i,1)*(20/P_total),...
        p_des(i,1)*(200/P_total));
end
fclose(fid);