%alpha,beta in(0,1),(0,1]
function result=threshfun(A,Lamda,SH,L,P)
[m,n]=size(A);
if (L>m||L<1)
    return;
else

result=A;
for i=1:L
    for j=1:n
        absAij=abs(A(i,j));
        lamda=Lamda(i);
        if SH~='n'                 
            if(absAij<lamda)
                result(i,j)=0;
            else
                if SH=='s'
                     result(i,j)=sign(A(i,j))*(absAij-lamda);
                end
            end
        else
             lamda=Lamda/log10(i+1);
             if(absAij<lamda)
                result(i,j)=1/P*exp(-1/(i^2))*A(i,j);
%                  result(i,j)=0;
             else

                     result(i,j)=sign(A(i,j))*(absAij-lamda/exp((absAij-lamda)^2));
             end
        end
                    
                    
                    
%                  lamda=Lamda(i)/log10(i+1);
%                 if (absAij<sqrt(2)*lamda)       
%                    result(i,j)=sign(A(i,j))*(absAij-lamda);               
%                 end           
%              result(i,j)=sign(A(i,j))*(absAij-lamda/exp((absAij/lamda-1)^2));
%                result(i,j)=sign(A(i,j))*(absAij-lamda/exp((absAij-lamda)^i));
%              result(i,j)=sign(A(i,j))*(absAij-lamda/exp(30*(absAij-lamda)^2));
    end
end
end


end