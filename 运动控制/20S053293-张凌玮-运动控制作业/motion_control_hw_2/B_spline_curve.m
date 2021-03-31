function B_spline_curve(M, N, k, l, X, Y, Z)
% �����������棬X Y Z�������Ƶ�M*N��������꣬k, l�������u���v��Ĵ���
w = 1:100;
y = 1:100;
z = 40*ones(100);
% ------------------------------------------------------------------
a = zeros(360,1);
b = zeros(360,1);
c = zeros(360,1);
n = N - 1;
m = M - 1;
t = 1;
f = 1;
order = 1;

piece_u = 2000;   % u��Ľڵ�ʸ��ϸ��
piece_v = 2000;   %v��ڵ�ʸ��ϸ��
Nik_u = zeros(n+1, 1);  % ��������ʼ��,����(n+1)ά������
Nik_v = zeros(m+1, 1);%��ʼ�������ɣ�m+1��ά������
% u�����ϸ��
NodeVector_u = linspace(0, 1, n+k+2);     % ����B������u��ڵ�ʸ��
u = linspace(k/(n+k+1), (n+1)/(n+k+1), piece_u);    % u��ڵ�ֳ����ɷ�
        
X_M_piece = zeros(M, piece_u);    % ����u���������M * piece
Y_M_piece = zeros(M, piece_u);
Z_M_piece = zeros(M, piece_u);
for i = 1 : M
    for j = 1 : piece_u
        for ii = 0 : 1: n
            Nik_u(ii+1, 1) = BaseFunction(ii, k , u(j), NodeVector_u);
        end
        X_M_piece(i, j) = X(i, :) * Nik_u;
        Y_M_piece(i, j) = Y(i, :) * Nik_u;
        Z_M_piece(i, j) = Z(i, :) * Nik_u;
    end
end

% v�����ϸ��
NodeVector_v = linspace(0, 1, m+l+2);     % ����B������u��ڵ�ʸ��
v = linspace(l/(m+l+1), (m+1)/(m+l+1), piece_v);    % v��ڵ�ֳ����ɷ�
X_MN_piece = zeros(piece_v, piece_u);
Y_MN_piece = zeros(piece_v, piece_u);
Z_MN_piece = zeros(piece_v, piece_u);
for i = 1 : piece_u
    for j = 1 : piece_v
        for ii = 0 : 1 : m
            Nik_v(ii+1, 1) = BaseFunction(ii, l, v(j), NodeVector_v);
        end
    X_MN_piece(j, i) = Nik_v' * X_M_piece(:, i);
    Y_MN_piece(j, i) = Nik_v' * Y_M_piece(:, i);
    Z_MN_piece(j, i) = Nik_v' * Z_M_piece(:, i);
    end
end

%%
%ɸѡ�߽��
for i = 2:piece_u-1
    for j = 2:piece_v-1
        if((Z_MN_piece(i, j)>=40 && Z_MN_piece(i-1, j-1)<40 && Z_MN_piece(i-1, j)<40 && Z_MN_piece(i, j-1)<40) ...
                || (Z_MN_piece(i, j)>=40 && Z_MN_piece(i-1, j+1)<40 && Z_MN_piece(i, j+1)<40  && Z_MN_piece(i-1, j)<40) ...
                ||(Z_MN_piece(i, j)>=40 && Z_MN_piece(i+1, j)<40 && Z_MN_piece(i+1, j-1)<40 && Z_MN_piece(i, j-1)<40) ...
            ||(Z_MN_piece(i, j)>=40 && Z_MN_piece(i+1, j+1)<40 && Z_MN_piece(i+1, j)<40 && Z_MN_piece(i, j+1)<40))
        a(t)= X_MN_piece(i, j);
        b(t)= Y_MN_piece(i, j);
        c(t)= Z_MN_piece(i, j);
        if(X_MN_piece(i, j)<=40 && Y_MN_piece(i, j)>20)
            grade_x(t) = X_MN_piece(i-1, j+1) - X_MN_piece(i, j);
            grade_y(t) = Y_MN_piece(i-1, j+1) - Y_MN_piece(i, j);
            grade_z(t) = Z_MN_piece(i-1,j+1) - Z_MN_piece(i,j);
            if grade_z(t)>0
                grade_z(t) = -grade_z(t);
            end
        end
        if(X_MN_piece(i, j)>40 && Y_MN_piece(i, j)>20)
            grade_x(t) = X_MN_piece(i+1, j+1) - X_MN_piece(i, j);
            grade_y(t) = Y_MN_piece(i+1, j+1) - Y_MN_piece(i, j);
            grade_z(t) = Z_MN_piece(i+1,j+1) - Z_MN_piece(i,j);
             if grade_z(t)>0
                grade_z(t) = -grade_z(t);
            end
        end
        if(X_MN_piece(i, j)<=40 && Y_MN_piece(i, j)<=20)
            grade_x(t) = X_MN_piece(i-1, j-1) - X_MN_piece(i, j);
            grade_y(t) = Y_MN_piece(i-1, j-1) - Y_MN_piece(i, j);
            grade_z(t) = Z_MN_piece(i-1,j-1) - Z_MN_piece(i,j);
             if grade_z(t)>0
                grade_z(t) = -grade_z(t);
            end
        end
        if(X_MN_piece(i, j)>40 && Y_MN_piece(i, j)<=20)
            grade_x(t) = X_MN_piece(i+1, j-1) - X_MN_piece(i, j);
            grade_y(t) = Y_MN_piece(i+1, j-1) - Y_MN_piece(i, j);
            grade_z(t) = Z_MN_piece(i+1,j-1) - Z_MN_piece(i,j);
             if grade_z(t)>0
                grade_z(t) = -grade_z(t);
            end
        end
        t = t + 1;
        end
    end
end

%point 
for i = 1: 360
    point(i,:) = [a(i) b(i) c(i) grade_x(i) grade_y(i) grade_z(i)];
end


%making the trajectory
for i = 1:360
    if(point(i,1) <= 40 && point(i,2) <=20)
        point_right_1(order,:) = [point(i,1) point(i,2) point(i,3) point(i,4) point(i,5) point(i,6)];
        order = order + 1;
    end
end

order = 1;

for i = 1:360
    if(point(i,1) > 40 && point(i,2) <=20)
         point_right_2(order,:) = [point(i,1) point(i,2) point(i,3) point(i,4) point(i,5) point(i,6)];
         order = order + 1;
    end
end

order = 1;

for i = 1:360
    if(point(i,1) > 40 && point(i,2) > 20)
         point_3(order,:) = [point(i,1) point(i,2) point(i,3) point(i,4) point(i,5) point(i,6)];
         order = order + 1;
    end
end

order = 1;

for i = 1:360
    if(point(i,1) <= 40 && point(i,2) > 20)
         point_4(order,:) = [point(i,1) point(i,2) point(i,3) point(i,4) point(i,5) point(i,6)];
         order = order + 1;
    end
end

[point_3_size,~]=size(point_3);
[point_4_size,~]=size(point_4);

for i =1: point_3_size
    point_right_3(i,:) = point_3(end-i+1,:);
end

for i =1: point_4_size
    point_right_4(i,:) = point_4(end-i+1,:);
end

%%
%������
%�����
points = [point_right_1;point_right_2;point_right_3;point_right_4];

%�ݶ�
gradient = [points(:,4) points(:,5) points(:,6)];

%�ٶ�
speed(1,:) = [points(1,1)-points(360,1) points(1,2)-points(360,2) 0];
for i = 2:360
    speed(i,:)=[points(i,1)-points(i-1,1) points(i,2)-points(i-1,2) 0];
end

%������
for i =1:360
    normal_vector(i,:)=cross(gradient(i,:),speed(i,:));
end


%b(s)����
for i = 1:360
    b_vector(i,:) = cross(speed(i,:),normal_vector(i,:));
end

%%��λ��
for i = 1:360
    speed_norm(i,:)=speed(i,:)/norm(speed(i,:));
end

for i = 1:360
    gradient_norm(i,:)=gradient(i,:)/norm(gradient(i,:));
end

for i = 1:360
    normal_vector_norm(i,:)=normal_vector(i,:)/norm(normal_vector(i,:));
end

for i = 1:360
    b_vector_norm(i,:)= b_vector(i,:)/norm(b_vector(i,:));
end

%%
%%��������ͼ  ��Ҫ������ȡ��ע�� ����ϸ�ֹ��� ���ܷǳ���ʱ
%  for j = 1 : piece_u
%      for i = 1 : piece_v -1
%         hold on
%         plot3([X_MN_piece(i, j) X_MN_piece(i+1, j)],...
%             [Y_MN_piece(i, j) Y_MN_piece(i+1, j)],...
%             [Z_MN_piece(i, j) Z_MN_piece(i+1, j)], 'b-');
%      end
%  end
% for i = 1 : piece_v
%      for j = 1 : piece_u -1
%          hold on
%          plot3([X_MN_piece(i, j) X_MN_piece(i, j+1)],...
%              [Y_MN_piece(i, j) Y_MN_piece(i, j+1)],...
%              [Z_MN_piece(i, j) Z_MN_piece(i, j+1)], 'b-');
%      end
% end
% hold on
% mesh(w,y,z);
% hold on
% plot3(a,b,c,'o')

%Answer of Question 1
disp([points(:,1) points(:,2) points(:,3) normal_vector_norm]);

%Answer of Question 2
disp([points(:,1) points(:,2) points(:,3) speed_norm normal_vector_norm b_vector_norm]);

%%
% %����ĵ�
% fid_1 = fopen('Answer of Question_1.txt','w');
% for i=1:360
%     fprintf(fid_1,'%f\t%f\t%f\t%f\t%f\t%f\n',points(i,1),points(i,2),points(i,3),normal_vector_norm(i,1),normal_vector_norm(i,2),normal_vector_norm(i,3));
% end
% fclose(fid_1);
% 
% fid_2 = fopen('Answer of Question_2.txt','w');
% for i=1:360
%     fprintf(fid_2,'%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n',points(i,1),points(i,2),points(i,3),speed_norm(i,1),speed_norm(i,2),speed_norm(i,3),...
%         normal_vector_norm(i,1),normal_vector_norm(i,2),normal_vector_norm(i,3),b_vector_norm(i,1),b_vector_norm(i,2),b_vector_norm(i,3));
% end
% fclose(fid_2);
