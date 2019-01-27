function PlotComp(index,Gamma_Range,xTH)
mrk1={'-+'};
mrk2 ={'-*'};
Pb_un_PAM = @(x)qfunc(sqrt(2*10.^(x/10)));
figure;
h = semilogy(xTH,Pb_un_PAM(xTH),'-','LineWidth', 1);
hold on
load(strcat('c',num2str(index),'_SP_M1.mat'),'Pbit','Gamma_dB');
h = semilogy(Gamma_dB,Pbit,mrk1{1},'Color','r','LineWidth', 1);
hold on
load(strcat('c',num2str(index),'_MS_M1.mat'),'Pbit','Gamma_dB');
h = semilogy(Gamma_dB,Pbit,mrk2{1},'Color','g','LineWidth', 1);
hold off
axis([1 Gamma_Range 1e-6 1e0])
set(0,'defaultTextInterpreter','latex') % to use LaTeX format
set(gca,'FontSize',13);
title('SumProd VS MinSum - Binary');
switch index
    case 1
        l = legend('Uncoded','SP - Rate $ \frac{1}{2}$, N = 336','MS - Rate $ \frac{1}{2}$, N = 336');

    case 2 
       l = legend('Uncoded','SP - Rate $ \frac{1}{2}$, N = 1920','MS - Rate $ \frac{1}{2}$, N = 1920');
    case 3
       l = legend('Uncoded','SP - Rate $ \frac{1}{2}$, N = 8640','MS - Rate $ \frac{1}{2}$, N = 8640');
    case 5
       l = legend('Uncoded','SP - Rate $\frac{2}{3}$ N = 6480','MS - Rate $\frac{2}{3}$ N = 6480');
    case 5
       l = legend('Uncoded','SP - Rate $ \frac{5}{6}$ N = 1152','MS - Rate $ \frac{5}{6}$ N = 1152');
end
set(l,'Interpreter','latex');
xlabel('SNR $\Gamma$  [dB]')
ylabel('BER $P_{\rm bit}$')

