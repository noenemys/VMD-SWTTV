function result=CEECMSA(x)
y=ceemdan(x,0.005,100,200);


N=length(y(2,:));
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
        Sigma(i)=sigma(i,i);
    end
    L=Sigma./sum(sum(Sigma));
    deta=-L.*log(L);
    pos=deta<0.015;
    P=5;
    for i=1:length(pos)
        if pos(i)
            P=i;
            break;
        end
    end
  
    
    sigma(P+1:end,P+1:end)=0;
    NewA=U*sigma*V';
    result=Cal_back_diagonal(NewA);
    result=result';

end