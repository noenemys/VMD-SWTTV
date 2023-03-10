%Data为采样信号，Ndata为估计信号
function [SNR,RMSE]=estimate(Data,Ndata)
N=length(Data);
SNR=10*log10(sum(Data.^2)/sum((Data-Ndata).^2));
RMSE=sqrt(sum((Data-Ndata).^2)/N);
end