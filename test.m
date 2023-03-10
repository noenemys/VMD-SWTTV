clear;close all;clc;
fangzhen2=load('fangzhen2.mat');
fangzhen2=fangzhen2.fangzhen2;
s=fangzhen2(:,2)+fangzhen2(:,3);
s=s(578:1601);%1024个点
t=fangzhen2(:,1);
t=t(578:1601);
fs=1/(t(2)-t(1));
osignal=s*10^11;

SNR=zeros(10,6);
RMSE=zeros(10,6);
Time=zeros(5,11);
snr_t=15;%添加噪声时控制信噪比水平

for i=1:10

testsignal=awgn(osignal,snr_t,'measured');


tic;
vmd_swttv_data=VMD_SWTTV(testsignal,1024,5,20);%VMD-SWTTV方法
%由于我没写收敛条件给了一个迭代次数用以控制收敛，推荐信噪比5db,迭代50次；10db迭代30次；15db迭代20次，20db迭代12次
time_vmd_swttv=toc;

tic;
vmd_wtd_data=vmd_wtd(testsignal);
time_vmd_wtd=toc;

tic;
svd_vmd_data=svd_vmd(testsignal);
time_svd_vmd=toc;

tic;
ceecmsa_data=CEECMSA(testsignal);
time_ceecmsa=toc;

tic;
eemd_sp_data=EEMD_SP(testsignal);
time_eemd_sp=toc;


Tt=[time_vmd_swttv,time_vmd_wtd,time_svd_vmd,time_ceecmsa,time_eemd_sp];
Time(:,i)=Tt';



[SNRvmd_swttv,RMSEvmd_swttv]=estimate(vmd_swttv_data,osignal);
[SNRvmd_wtd,RMSEvmd_wtd]=estimate(vmd_wtd_data,osignal);
[SNRvmd_data,RMSEvmd_data]=estimate(svd_vmd_data,osignal);
[SNRceecmsa,RMSEceecmsa]=estimate(ceecmsa_data,osignal);
[SNReemd_sp,RMSEeemd_sp]=estimate(eemd_sp_data,osignal);
[SNRosignal,RMSEosignal]=estimate(testsignal,osignal);

SNR(i,:)=[SNRvmd_swttv,SNRvmd_wtd,SNRvmd_data,SNRceecmsa,SNReemd_sp,SNRosignal];
RMSE(i,:)=[RMSEvmd_swttv,RMSEvmd_wtd,RMSEvmd_data,RMSEceecmsa,RMSEeemd_sp,RMSEosignal];

end


Time(:,11)=mean(Time(:,1:10),2);
SNRmean=mean(SNR);
RMSEmean=mean(RMSE);
isplot=1;
if isplot
figure(2);
    subplot(5,1,1);
    plot(t,testsignal);hold on;
    plot(t,vmd_swttv_data);hold on;
    ylabel("信号幅值(v)");
    xlabel("时间（s）");
    xlim([2.8,8]*10^-5);
    title("VMD-SWTTV");
    


subplot(5,1,2);
    plot(t,testsignal);hold on;
    plot(t,vmd_wtd_data);hold on;
    ylabel("信号幅值(v)");
    xlabel("时间（s）");
    xlim([2.8,8]*10^-5);
    title("VMD-WTD");

subplot(5,1,3);
    plot(t,testsignal);hold on;
    plot(t,svd_vmd_data);hold on;
    ylabel("信号幅值(v)");
    xlim([2.8,8]*10^-5);
    xlabel("时间（s）");
    title("SVD-VMD");

subplot(5,1,4);
    plot(t,testsignal);hold on;
    plot(t,ceecmsa_data);hold on;
    ylabel("信号幅值(v)");
    xlabel("时间（s）");
    xlim([2.8,8]*10^-5);
    title("JANRR");

subplot(5,1,5);
    plot(t,testsignal);hold on;
    plot(t,eemd_sp_data);hold on;
    legend("含噪信号","降噪信号",'NumColumns',2);
    ylabel("信号幅值(v)");
    xlim([2.8,8]*10^-5);
    xlabel("时间（s）");
    title("EEMD-SP");
end
SNRmean_=SNRmean';
RMSEmean_=RMSEmean';
SNR=SNR';
RMSE=RMSE';
SNR_=[SNR(1:6,:),SNRmean_(1:6)];
RMSE_=[RMSE(1:6,:),RMSEmean_(1:6)];

figure()
subplot(2,1,1);
    plot((1:10),SNR_(1,1:10),"r-*");hold on;
    plot((1:10),SNR_(2,1:10),"m-.^");hold on;
    plot((1:10),SNR_(3,1:10),"k:o");hold on;
    plot((1:10),SNR_(4,1:10),"g--s");hold on;
    plot((1:10),SNR_(5,1:10),"b-d");hold on;

    ylabel("SNR(db)");xlabel("序号")
    title_=strcat("原始信噪比",num2str(snr_t),"db");
    title(title_);
    legend({"VMD-SWTTV","VMD-WTD","SVD-VMD","JANRR","EEMD-SP"},'NumColumns',3);
    DB=num2str(snr_t);
    S_Name=strcat("SNR_",DB,"db");
    R_Name=strcat("RMSE_",DB,"db");
%     save(S_Name,'SNR_');%数据保存
%     save(R_Name,'RMSE_');
