function [A_hat ,E_hat ] =rpca(res)

%res，输入图像，输出为低秩A_hat和稀疏E_hat

[row col] = size(res);
if col>row
    res=res';
end

lambda = 1/ sqrt(max(size(res)));

tol = 1e-7;

maxIter = 1000;

% initialize

Y = res;

[u,s,v]=svd(Y);

norm_two=s(1);

norm_inf=max(abs(Y(:)))/lambda;

dual_norm = max(norm_two, norm_inf);

Y = Y / dual_norm;

A_hat = zeros( row, col);

E_hat = zeros( row, col);

mu = 0.01/norm_two; % this one can be tuned

mu_bar = mu * 1e7;

rho = 1.9 ; % this one can be tuned

d_norm=sqrt(sum(res(:).^2));

iter = 0;

total_svd = 0;

converged = 0;%收敛

stopCriterion = 1;

sv = 10;

while ~converged

iter = iter + 1;

temp_T = res - A_hat + (1/mu)*Y;

E_hat=temp_T - lambda/mu;

n1=find(E_hat<0);

E_hat(n1)=0;

tmp=temp_T + lambda/mu;

n1=find(tmp>0);

tmp(n1)=0;

E_hat= E_hat+tmp;

[U1 S1 V1] = svd(res - E_hat + (1/mu)*Y);
U=u;S=s;V=v;
if chsvd(col, sv) == 1

U=U1(:,1:sv);

S=S1(:,1:sv);

V=V1(:,1:sv);

end

diagS = diag(S);

svp = length(find(diagS > 1/mu));

if svp < sv

sv = min(svp + 1, col);

else

sv = min(svp + round(0.05*col), col);

end

% A_hat = U(:, 1:svp) * diag(diagS(1:svp) - 1/mu) * V(:, 1:svp)';

U2=U(:, 1:svp);

S2=diag(diagS(1:svp) - 1/mu);

V2=V(:, 1:svp)';

A_hat=U2*S2*V2;

total_svd = total_svd + 1;

Z = res - A_hat - E_hat;

Y = Y + mu*Z;

mu = min(mu*rho, mu_bar);

%% stop Criterion

stopCriterion = sqrt(sum(Z(:).^2)) / d_norm;

if stopCriterion < tol

converged = 1;

end

if ~converged && iter >= maxIter

disp('Maximum iterations reached') ;

converged = 1 ;

end

end

end

function y=chsvd( n, d)

y=0;

if ((n<=100)&&(d/n<=0.02)) y=1;end

if((n<=200)&&(d/n<=0.06)) y=1; end

if((n<=300)&&(d/n<=0.26)) y=1;end

if((n<=400)&&(d/n<=0.28)) y=1;end

if((n<=500)&&(d/n<=0.34)) y=1;end

if(n>500&&(d/n<=0.38)) y=1;end

end