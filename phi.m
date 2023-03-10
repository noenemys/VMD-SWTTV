clear;clc;
x=(0:0.01:3);
N=length(x);
t=-3:0.01:3;
Nt=length(t);
for i=1:Nt
phi(i)=2/(0.95*sqrt(3))*(atan((1+2*0.95*abs(t(i)))/sqrt(3))-pi/6);
end




for i=1:N
y(i)=x(i) + (4*sign(x(i)))/(3*(((19*abs(x(i)))/10 + 1)^2/3 + 1));

end
subplot(1,2,1)
plot(t,abs(t),'--');hold on;
plot(t,phi);
xlabel('(a)');
title('非凸函数Phi(x)');
legend('|x|','Phi(x)');
subplot(1,2,2)
plot(y,x);hold on;
y2=x;y2(1:100)=0;
plot(x,y2,'--');hold on;
plot(1:0.1:3,0:0.1:2,'.');

title('阈值函数Theta(y),Lamda=1,a=0.95');
xlabel('(b)');
legend('Theta(y)','hard(y)','soft(y)');