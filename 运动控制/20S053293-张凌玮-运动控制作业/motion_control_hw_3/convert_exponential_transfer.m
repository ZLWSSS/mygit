function matrix_transfer = convert_exponential_transfer(num,theta)


%判断字符串

if num == 1
    exponential_tranfer = [1 0 0 theta;0 1 0 0; 0 0 1 0;0 0 0 1];
end

if num == 2
    exponential_tranfer = [1 0 0 0;0 1 0 theta; 0 0 1 0;0 0 0 1];
end

if num == 3
    exponential_tranfer = [1 0 0 0;0 1 0 0; 0 0 1 theta;0 0 0 1];
end

matrix_transfer = exponential_tranfer;

end