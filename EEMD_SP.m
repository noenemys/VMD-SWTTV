function result=EEMD_SP(x)
%x为列向量
[modos ,~]=eemd(x,0.001,30,100);
r=x'-sum(modos);
max_x=max(x);
min_x=min(x);
xi=linspace(min_x,max_x,100);
[m,~]=size(modos);
pdf_x=ksdensity(x,xi);

like=zeros(m,1);
for i=1:m
    pdf_modos(i,:)=ksdensity(modos(i,:),xi);
    like(i)=sum(sum((pdf_x-pdf_modos(i,:)).^2));
    
end
pos=1;
for i=2:m-1
    if like(i)>like(i-1)&&like(i)>like(i+1)
        pos=i;
        break;
    end
end
reemd=sum(modos(pos:end,:))+r;
reemd=[zeros(1,100),reemd,zeros(1,100)];



S_P=stft(reemd);
sp=abs(S_P);
angle_sp=angle(S_P);

 [LL, SS] = RobustPCA(sp);

M_AE=(abs(SS)>abs(LL));
M_AE=M_AE+0;
S_hat=M_AE.*(abs(SS)+abs(LL));
rec_sp=S_hat.*sin(angle_sp)*sqrt(-1)+S_hat.*cos(angle_sp);


result=(real(istft(rec_sp)));
result=result(101:100+length(x));
% figure()
% plot(result);hold on;
% plot(x);

end