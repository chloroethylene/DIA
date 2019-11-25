function result = NMS(G,fai)
[M,N] = size(G);
result = G;
for i=2:M-1
    for j=2:N-1
        if abs(fai(i,j)-0)<=pi/8
            if result(i,j)<result(i-1,j) || result(i,j)<result(i+1,j)
                result(i,j)=0;
            end
        elseif abs(fai(i,j)-pi/4)<=pi/8
            if result(i,j)<result(i+1,j+1) || result(i,j)<result(i-1,j-1)
                result(i,j)=0;
            end
        elseif abs(fai(i,j)+pi/4)<=pi/8
            if result(i,j)<result(i+1,j-1) || result(i,j)<result(i-1,j+1)
                result(i,j)=0;
            end
        else
            if result(i,j)<result(i,j-1) || result(i,j)<result(i,j+1)
                result(i,j)=0;
            end
        end
    end
end
end