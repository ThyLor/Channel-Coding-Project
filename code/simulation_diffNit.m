% Bit error rate of PAM LDPC codes under AWGN channel
format long 
clc
%% Pick your matrix
choice = 5;
path = 'C:\Users\Lorenzo\Documents\UNI\MAGI\I_sem\CC\FINAL_PROJECT\V_3.0\';
load(strcat(path,'Data\','data_c',num2str(choice),'.mat'));
 Htoy = [1 0 1 1 0 1;
         1 1 1 1 1 0;
         1 1 0 1 1 1;
         ];
%% Sim definitions
switch choice
    case 1
        %Gamma_dB = [0 0.5 1 1.5 2 2.3 2.6 2.8 3.0 3.2 3.4 3.6];
        %Nit = [1e3 1e3 1e3 1e3 1e3 1e3 1e4 1e4 5*1e4 1e5 1e5 1e5];
        Gamma_dB = [3.8]
        Nit = 1e5;
    case 2
        Gamma_dB = [0 0.5 1 1.25 1.5 1.8 1.9 2]; %simulate with snr = 2.5
        Nit = [1e3 1e3 1e3 1e3 1e3 1e4 1e4 1e4];
    case 3
        %Gamma_dB = [0 0.5 1 1.2 1.25 1.3 1.35 1.4]; %simulate with snr = 2.5
       % Nit = [ 1e3 1e3 1e3 1e3 1e3 5*1e3 5*1e3 5*1e3];
        Gamma_dB = [1.5 1.65 1.8 1.9];
         Nit = [ 1e3 5*1e3 1e4 1e4];
        %Gamma_dB = [1.3]
        %Nit = [1e3]
    case 4
        Gamma_dB = [2.5 3 3.5]; 
        Nit = [1e3 1e3 1e3];
    case 5
        %Gamma_dB = [3 3.15 3.3 3.35 3.5];
        %Nit = [1e3 1e3 5*1e3 5*1e3 5*1e3];
        Gamma_dB = [3.5 3.6 3.7 3.8 3.9];
        Nit = [1e3 1e3 5*1e3 5*1e3 5*1e3];
        %Gamma_dB = [3.4 3.45];
        %Nit = [5*1e3 5*1e3];
    case 6 
        Gamma_dB = [6.5 6.9 7 7.1 7.2 7.3 7.4 7.5 7.6];               %SNR range in dB
    otherwise
        disp('other value');
end
Gamma = 10.^(Gamma_dB/10);          %SNR
sigw = sqrt(1./Gamma);
% initialize error and packet counters
nerr = zeros(size(Gamma));
npack = zeros(size(Gamma));
nerr1 = zeros(size(Gamma));
npack1 = zeros(size(Gamma));
Th_nerr = 2*1e3;                      %do not simulate if Th_nerr errors are exceeded <--
% Number of iteration;
prIt = 1e4;
% Number of iteration in the minsumalg
mpIt = 80;
%expected precision
prec = 10^(1+log10(1/(k*prIt)));       
%% Modulation and puncturing
puncPat = 1;
M = 2;
%% Start simulation
start = tic;
 % Cycle on SNRs
% for it = 1:1e4
for m = 1:length(Gamma)
    %Preparing Messages
    %u = randi([0,1],k,1);
    u = zeros(k,1);
    %y = EncoderLDPC(Hsys,n,k,u);
    y = zeros(n,1);
    %yPunc = Puncturing(y)    
    s = 2*y -1;
    %tmp = reshape(y,[M,n/M]);
    %s = ConstMapper2(tmp(1,:),tmp(2,:),n/M);
    %s = ConstMapper4(tmp(1,:),tmp(2,:),tmp(3,:),tmp(4,:),n/M);
    % prepare noise samples (with unit variance)
    for it = 1:Nit(m)  
    w = randn(size(s));
    %parfor m = 1:length(Gamma)
        
        % check number of errors
        if nerr(m)<Th_nerr
            % define noise variance
            % define the received signal COMPLEX GAUSSIAN NOISE
            %r = s + (sigw(m)*w + 1i * sigw(m)*w);
            r = s + (sigw(m))*w;
            %Compute the priorLLRs
            %priorLLRs = LLR_BICM(r,sigw(m)^2,M);
            priorLLRs = -2*r ./ sigw(m)^2;
            %priorLLRs = PuncturingLLR(priorLLRs, puncPat);
            % Demodulate
            u_hat = MinSumDecoder(nOR,nOC,nO,AssignLLRs(priorLLRs,nOC,nO),priorLLRs,upMatrVC,perMatrCV,perMatrVC,mpIt,Hreal);
            %u_hat = SumProdDecoder(nOR,nOC,AssignLLRs(priorLLRs,nOC,nO),priorLLRs,upMatrCV,upMatrVC,perMatrCV,perMatrVC,mpIt,Hreal);
            estimate = u_hat(1:k);
            %Puncturing estimate
            %estimate = Puncturing(u_hat);
            %nerr(m) = nerr(m) + sum(estimate~=yPunc);
            % counting errors
            nerr(m) = nerr(m) + sum(estimate~=u);
            npack(m) = npack(m) + 1;
        end
        %it
    end
     % save once in a while
    if (mod(it,1000)==0)
        % display current status
        disp(['#' num2str(it) ', BER = ' num2str(nerr./(npack*k))]);
        %save workspace
        %save(strcat(path,'Results\','sim_c',num2str(choice),'_Nit',num2str(Nit),'_MPIt',num2str(mpIt)))); ,'_PuncPat',num2str(puncPat)));
    end
    it
end
total_time = toc(start);
fprintf('Total simulation time: %fs\n', total_time);
%% Calculate the statistics
Pbit = nerr./(npack*k)
%Pbit1 = nerr1./(npack1*k)
% BER for uncoded packet
Pbit_uc = qfunc(sqrt(2*Gamma));
Pbit_QPSK = 2*qfunc(sqrt(2*Gamma)*sin(pi/4))/2;
%% Show results
figure;
set(0,'defaultTextInterpreter','latex') % to use LaTeX format
set(gca,'FontSize',14);
h = semilogy(Gamma_dB,Pbit,'r-<',...
    Gamma_dB,Pbit_uc,'b');
axis([min(Gamma_dB) max(Gamma_dB) 1e-6 1e0])
set(h,'linewidth',2);
legend('Coded','Uncoded');
xlabel('SNR $\Gamma$  [dB]')
ylabel('BER $P_{\rm bit}$')
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on',...
    'YGrid', 'on', 'XGrid', 'on');