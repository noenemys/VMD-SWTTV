function X=NFastTV(Y,lamda,N)
X=Y;
for i=1:N
    X=FastTV(X,lamda);
end
end