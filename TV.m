%input:Q,alpha_p,gama,miu
%Q为某一尺度观测系数；alpha_p和gama为超参数，miu为分裂增广拉格朗日收缩算法参数
function ew=TV(Q,lamda)
%初始化
Q=Q';
N=length(Q);
ewl=Q;
ewn=Q;
zhu=ones(1,N);
fu=ones(1,N-1);
D1=diag(-zhu);
D2=diag(fu,1);
D3=D1+D2;
D=D3(1:N-1,:);
DDT=D*D';
Dy=D*Q;
%迭代
k=1;
while 1
ewn=Q-D'*(1/lamda*diag(D*ewl)+DDT)^-1*Dy;
if max(abs(ewn-ewl))<0.1||k>200
    ew=ewn';
    break;
else
    ewl=ewn;
    k=k+1;
end
end
end