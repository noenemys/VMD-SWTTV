function result=mysvd(y,nsigma)
 N=length(y);
 m=floor(N/2);
    n=N+1-m;
    A=zeros(m,n);
    for k=1:m
        for j=1:n
        A(k,j)=y(k+j-1);
        end
    end
    [U,sigma,V]=svd(A);
    sigma(2*nsigma+1:end,2*nsigma+1:end)=0;
    NewA=U*sigma*V';
    result=Cal_back_diagonal(NewA);
    result=result';
end