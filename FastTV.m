%输入：需要降噪的实序列Y，实数lamda>0
%输出：TV降噪后的数据
function X=FastTV(Y,lamda)
N=length(Y);
X=Y;
k=1;
k0=k;
kl=k;
kr=k;
vmin=Y(1)-lamda;
vmax=Y(1)+lamda;
umin=lamda;
umax=-lamda;
isterminate=0;
while (isterminate==0)
    
    if k==N
       X(N)=vmin+umin; 
       isterminate=1;
    end
    
    while k<N
        if Y(k+1)+umin<vmin-lamda   %3
            X(k0)=vmin;
            X(kl)=vmin;
            kr=kl+1;
            k=kr;
            k0=kr;
            kl=kr;
          
            vmin=Y(k);
            vmax=Y(k)+2*lamda;
            umin=lamda;
            umax=-lamda;
        elseif Y(k+1)+umax>vmax+lamda %4
             X(k0)=vmax;
             X(kl)=vmax;
             X(kr)=vmax;
              kr=kr+1;
             k=kr;
             k0=kr;
             kl=kr;
            
             vmin=Y(k)-2*lamda;
             vmax=Y(k);
             umin=lamda;
             umax=-lamda;
        else                       %5
            k=k+1;
        
            umin=umin+Y(k)-vmin;
            umax=umax+Y(k)-vmax;
            if (umin>lamda||umin==lamda)
                vmin=vmin+(umin-lamda)/(k-k0+1);
                umin=lamda;
                kl=k;
            end
            if (umax<-lamda||umax==-lamda)
                vmax=vmax+(umax+lamda)/(k-k0+1);
                umax=-lamda;
                kr=k;
            end
        end
    end

     if umin<0
            X(k0)=vmin;
             X(kl)=vmin;
            
             kl=kl+1;
              k0=kl;
             k=k0;
             vmin=Y(k);
             umin=lamda;
             umax=Y(k)+lamda-vmax;
             %tiaozhuan 2
             if k==N
                   X(N)=vmin+umin;
                    isterminate=1;
             end
      elseif umax>0 
               X(k0)=vmax;
             X(kl)=vmax;
             X(kr)=vmax;
         
             k=kr+1;
             k0=kr+1;
             kr=kr+1;
             vmax=Y(k);
             umax=-lamda;
             umin=Y(k)-lamda-vmin;
             %tiaozhuan 2
            if k==N
                   X(N)=vmin+umin;
                    isterminate=1;
            end
      else
            X(k0)=vmin+umin/(k-k0+1);
             X(kl)=X(k0);
              X(kr)=X(k0);
               X(N)=X(k0);
                X(k)=X(k0);
                 isterminate=1;
     end
    
end        
end
