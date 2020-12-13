close all
%% Fixing n, varying m
close all
%% Show results obtained with sm product
index = [1 2 3 5 7];
mrk={'-o','-+','-*','-<','->'};
xTH= 1:0.01:10;
Pb_un_PAM = @(x)qfunc(sqrt(2*10.^(x/10)));
% Data load
figure;
h = semilogy(xTH,Pb_un_PAM(xTH),'-','LineWidth', 1);
hold on
for i=1:length(index)
    load(strcat(path,'Results\','c',num2str(index(i)),'_SP_M1.mat'),'Pbit','Gamma_dB');
    %plot(Gamma_dB,Pbit);
    h = semilogy(Gamma_dB,Pbit,mrk{i},'LineWidth', 1);
    hold on
end
hold off
axis([1 10 1e-6 1e0])
set(0,'defaultTextInterpreter','latex') % to use LaTeX format
set(gca,'FontSize',13);
title('Sum Product Decoder - Binary');
l = legend('Uncoded','Rate $ \frac{1}{2}$ N = 336',' Rate $ \frac{1}{2}$ N = 1920', 'Rate $ \frac{1}{2}$ N = 8640' , 'Rate $ \frac{2}{3}$ N = 6480','Rate $ \frac{5}{6}$ N = 5184' );
set(l,'Interpreter','latex');
xlabel('SNR $\Gamma$  [dB]')
ylabel('BER $P_{\rm bit}$')
%% Show results obtained with MINSUM
index = [1 2 3 5 6];
mrk={'-o','-+','-*','-<','->'};
xTH= 1:0.01:10;
Pb_un_PAM = @(x)qfunc(sqrt(2*10.^(x/10)));
% Data load
figure;
h = semilogy(xTH,Pb_un_PAM(xTH),'-','LineWidth', 1);
hold on
for i=1:length(index)
    load(strcat(path,'Results\','c',num2str(index(i)),'_MS_M1.mat'),'Pbit','Gamma_dB');
    h = semilogy(Gamma_dB,Pbit,mrk{i},'LineWidth', 1);
    hold on
end
hold off
axis([1 10 1e-6 1e0])
set(0,'defaultTextInterpreter','latex') % to use LaTeX format
set(gca,'FontSize',13);
title('Min Sum Decoder - Binary');
l = legend('Uncoded','Rate $ \frac{1}{2}$ N = 336',' Rate $ \frac{1}{2}$ N = 1920', 'Rate $ \frac{1}{2}$ N = 8640' , 'Rate $ \frac{2}{3}$ N = 6480','Rate $ \frac{5}{6}$ N = 1152' );
set(l,'Interpreter','latex');
xlabel('SNR $\Gamma$  [dB]')
ylabel('BER $P_{\rm bit}$')
%% Comparison between sum prod and min sum
index = [1 2 3 5];
%index = [1 2 3];
Gamma_Range = 10;
mrk1={'-+'};
mrk2 ={'-*'};
for i=1:length(index)
PlotComp(index(i),Gamma_Range,xTH)
end

%% Puncturing
PlotPun(6,Gamma_Range,xTH)
PlotPun(7,Gamma_Range,xTH)


