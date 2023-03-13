function result=VMD_SWTTV(x,miu,level)
%x:含噪信号；miu超参数，推荐在N/2~N之间取，一般取N就行，N为信号长度，
%level是小波分解层级，小波函数选定了“db4”，可以自己改
%iterN为迭代次数
level_=2;
while 1
v_d=vmd(x,'NumIMF',level_);
[~,m]=size(v_d);
C=zeros(m,1);
K=C;
Kw=C;
for i=1:m
C(i)=sum(v_d(:,i).*x)/(norm(v_d(:,i))*norm(x));
K(i)=kurtosis(v_d(i,:));
Kw(i)=sign(C(i))*K(i)*abs(C(i));
end
min_kw=min(Kw);
if min_kw<1
    break;
else
    level_=level_+1;
end
end
v_d=vmd(x,'NumIMF',level_);
k_c=diff(Kw);
[~,pos]=max(k_c);
y=sum(v_d(:,pos+1:end),2);
%初始化
N=length(y);
Wy=swt(y,level,"db4");
u=Wy;d=0;
[m,~]=size(Wy);
sigma=zeros(m,1);
for i=1:m
    sigma(i)=thselect(Wy(i,:),'sqtwolog');
end
sig=sqrt(median(abs(Wy(i,:)))/0.675);
yita=0.99;
lamda=sig*yita.*sigma;
byta=(1-yita)*sqrt(N)*sigma(1)/4;
a=1./lamda;

isStop=0;
iter=1;
phi=Wy;
od=x';
nd=x';
    while (isStop==0)
        od=nd;
        rho=(Wy+miu*(u-d))/(miu+1);
        phi=theta(rho,lamda/(miu+1),a);
        v=phi+d;
        wtv=iswt(v,"db4");
        nd=wtv;
        ww=swt((NFastTV(wtv,byta/miu,1)-wtv),level,"db4");
        u=v+ww;
        d=d-(u-phi);
        iter=iter+1;
        
        if( sum(abs(nd-od))<10^-4*N)
            isStop=1;
           
        end
    end
result=iswt(phi,"db4");
result=result';
end