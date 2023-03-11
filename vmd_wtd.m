function result=vmd_wtd(x)
level=2;
while 1
v_d=vmd(x,'NumIMF',level);
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
    level=level+1;
end
end
v_d=vmd(x,'NumIMF',level);
k_c=diff(Kw);
[~,pos]=max(k_c);

vmd_data=sum(v_d(:,pos+1:end),2);
result=wden(vmd_data,'minimaxi','h','one',3,'db4');

end