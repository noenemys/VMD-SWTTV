function result=SWTTV(y,miu,level)

%初始化
N=length(y);
Wy=swt(y,level,"db4");

% Wy_4=swt(Wy(4,:),1,"db4");
% Wy_3=swt(Wy(3,:),1,"db4");
% Wy_2=swt(Wy(2,:),1,"db4");
% Wy=[Wy(1,:);Wy_2;Wy_3;Wy_4;Wy(level:end,:)];


u=Wy;d=0;
[m,~]=size(Wy);
sigma=zeros(m,1);
sigma_1= median(abs(Wy(1,:)))/0.6745;
for i=1:level
    if i==1
    sigma(i)=sigma_1;
    else
    sigma(i)=2*sigma_1;
    end

end

sigma=sqrt(sigma)*(0.3936+0.1829*log2(N));

yita=0.99;
lamda=2.5*yita.*sigma;
byta=(1-yita)*sqrt(N)*sigma(1)/4;
 a=1./lamda;

% a=max(exp(lamda),1./lamda);
isStop=0;
iter=1;

phi=Wy;
    while (isStop==0)
      
        rho=(Wy+miu*(u-d))/(miu+1);
        phi=theta(rho,lamda/(miu+1),a);
        v=phi+d;

        wtv=iswt(v,"db4");
        ww=swt((NFastTV(wtv,byta/miu,1)-wtv),level,"db4");

        u=v+ww;
        d=d-(u-phi);
        
        iter=iter+1;
        if( iter==50)
            isStop=1;
           
        end
    end
%  phi_2=iswt(phi(2:3,:),"db4");
%  phi_3=iswt(phi(4:5,:),"db4");
%   phi_4=iswt(phi(6:7,:),"db4");
% 
%  phi=[phi(1,:);phi_2;phi_3;phi_4;phi(8:end,:)];
result=iswt(phi,"db4");
result=result';
end