function result=svd_vmd(x)
N=length(x);
 m=floor(N/2);
    n=N+1-m;
    A=zeros(m,n);
    for k=1:m
        for j=1:n
        A(k,j)=x(k+j-1);
        end
    end
    [U,sigma,V]=svd(A);
    Sigma=zeros(m,1);
    
    for i=1:m
        Sigma(i)=sigma(i,i).^2;
    end
      Sve=abs(diff(Sigma)./Sigma(2:end));
      [~,pos]=max(Sve(1:100));
    
    sigma(pos+1:end,pos+1:end)=0;
    NewA=U*sigma*V';
    result=Cal_back_diagonal(NewA);
    result=result';
end