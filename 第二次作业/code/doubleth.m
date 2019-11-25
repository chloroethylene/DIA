function result = doubleth(image)
[M,N] = size(image);
maxval = max(max(image));
tau1=maxval/15;
tau2=2*tau1;
T1 = image>tau1;
T2 = image>tau2;
result = T2;
iter = 100;     %设置迭代次数，由于算法按行扫描而非按边缘方向扫描，单次运行会有边缘的遗漏
for k=1:iter
    for i=2:M-1
        for j=2:N-1
            if result(i,j)==true
                result(i-1:i+1,j-1:j+1)=result(i-1:i+1,j-1:j+1)|T1(i-1:i+1,j-1:j+1);
            end
        end
    end
end
end