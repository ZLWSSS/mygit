function Control_point_curve(M, N, X, Y, Z)
% �����ɿ��ƶ�������ɵ�M*N����X Y Z��M*N��ʽ�ľ���

for i = 1 : M
    for j = 1 : N - 1
        hold on
        plot3([X(i, j) X(i, j+1)], [Y(i, j) Y(i, j+1)], [Z(i, j) Z(i, j+1)], 'o-k');
    end
end
for j = 1 : N
    for i = 1 : M-1
        plot3([X(i, j) X(i+1, j)], [Y(i, j) Y(i+1, j)], [Z(i, j) Z(i+1, j)], 'o-k');
    end
end
%Ϊ��չʾ��
%for i = 1: M
 %   for j = 1 : N
  %      hold on
   %     plot3(X(i,j), Y(i,j) ,Z(i,j),'o-k');
    %end
%end %Ҳ����չ��ͬ��Ч�� ����û����
xlabel('X');
ylabel('Y');
zlabel('Z');
view(100, -100);