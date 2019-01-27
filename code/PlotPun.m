function PlotPun(index,Gamma_Range,xTH)
mrk={'-+','-*','->'};
Pb_un_PAM = @(x)qfunc(sqrt(2*10.^(x/10)));
figure;
h = semilogy(xTH,Pb_un_PAM(xTH),'-','LineWidth', 1);
hold on
switch index
    case 6
        load(strcat('c',num2str(index),'_MS_M1.mat'),'Pbit','Gamma_dB');
        h = semilogy(Gamma_dB,Pbit,mrk{1},'Color','r','LineWidth', 1);
        hold on
        load(strcat('c',num2str(index),'_P1_MS_M1.mat'),'Pbit','Gamma_dB');
        h = semilogy(Gamma_dB,Pbit,mrk{2},'Color','g','LineWidth', 1);
        hold on
        load(strcat('c',num2str(index),'_P2_MS_M1.mat'),'Pbit','Gamma_dB');
        h = semilogy(Gamma_dB,Pbit,mrk{3},'Color','m','LineWidth', 1);
        axis([1 Gamma_Range 1e-6 1e0])
        set(0,'defaultTextInterpreter','latex') % to use LaTeX format
        l = legend('Uncoded','MS - Rate $ \frac{5}{6}$ N = 1152','PP1: Rate $ \frac{16}{18}$ N = 1080, K = 960','PP2: Rate $ \frac{20}{21}$ N = 1008, K = 960' );
        set(gca,'FontSize',13);
        title('Different PPs');
    case 7
        load(strcat('c',num2str(index),'_SP_M1.mat'),'Pbit','Gamma_dB');
        h = semilogy(Gamma_dB,Pbit,mrk{1},'Color','r','LineWidth', 1);
        hold on
        load(strcat('c',num2str(index),'_P1_SP_M1.mat'),'Pbit','Gamma_dB');
        h = semilogy(Gamma_dB,Pbit,mrk{2},'Color','g','LineWidth', 1);
        hold on
        load(strcat('c',num2str(index),'_P2_SP_M1.mat'),'Pbit','Gamma_dB');
        h = semilogy(Gamma_dB,Pbit,mrk{3},'Color','m','LineWidth', 1);
        axis([1 Gamma_Range 1e-6 1e0])
        set(0,'defaultTextInterpreter','latex') % to use LaTeX format
        l = legend('Uncoded','SP - Rate $ \frac{5}{6}$ N = 5184','PP1: - Rate $ \frac{16}{18}$ N = 4860, K = 4320','PP2: Rate $ \frac{20}{21}$ N = 4536, K = 4320');
        set(gca,'FontSize',13);
        title('Different PPs');
end
set(l,'Interpreter','latex');
xlabel('SNR $\Gamma$  [dB]')
ylabel('BER $P_{\rm bit}$')

