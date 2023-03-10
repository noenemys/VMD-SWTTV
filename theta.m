function result=theta(input,lamda,a)
[m,n]=size(input);
result=zeros(m,n);
for j=1:m
    for i=1:n
        if (abs(input(j,i))<lamda(j))
        else
        y=input(j,i);
        result(j,i)=sign(y)*(abs(y)/2-1/(2*a(j))+sqrt( (abs(y)/2+1/(2*a(j)))^2 -lamda(j)/a(j)));
        end
    end
end
end