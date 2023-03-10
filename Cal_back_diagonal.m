%计算反对角线上元素和的平均
function result=Cal_back_diagonal(A)
[m,n]=size(A);
N=m+n-1;
result=zeros(1,N);
for i=1:N
    s=0;t=0;
    for k=1:m
        for j=1:n  
            if(k+j==i+1)
                s=s+A(k,j);
                t=t+1;
            end
        end
    end
    result(i)=s/t; 
end
end