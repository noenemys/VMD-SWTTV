%A 22db
%B 18db
%C 14db
clear;clc;
A=load("SNR_20db.mat");
A=A.SNR_(:,1:10);
B=load("SNR_15db.mat");
B=B.SNR_(:,1:10);
C=load("SNR_10db.mat");
C=C.SNR_(:,1:10);

c=(1:10);
figure()
subplot(3,1,1);
    plot(c,A(1,:),"r-*");hold on;
     plot(c,A(2,:),"m-.^");hold on;
      plot(c,A(3,:),"k:o");hold on;
       plot(c,A(4,:),"g--s");hold on;
        plot(c,A(5,:),"b-d");hold on;
        ylabel("SNR(db)");xlabel("序号")
      
        title("原始信噪比20db");
          
       
        subplot(3,1,2);
      plot(c,B(1,:),"r-*");hold on;
     plot(c,B(2,:),"m-.^");hold on;
      plot(c,B(3,:),"k:o");hold on;
       plot(c,B(4,:),"g--s");hold on;
        plot(c,B(5,:),"b-d");hold on;
           ylabel("SNR(db)");xlabel("序号")
        title("原始信噪比15db");
             
   
        subplot(3,1,3);
            plot(c,C(1,:),"r-*");hold on;
     plot(c,C(2,:),"m-.^");hold on;
      plot(c,C(3,:),"k:o");hold on;
       plot(c,C(4,:),"g--s");hold on;
        plot(c,C(5,:),"b-d");hold on;
           ylabel("SNR(db)");xlabel("序号")
        title("原始信噪比10db");
             legend({"VMD-SWTTV","VMD-WTD","SVD-VMD","JANRR","EEMD-SP"},'Location','northwest','NumColumns',3);
       