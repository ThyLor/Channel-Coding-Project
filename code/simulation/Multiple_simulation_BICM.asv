% Bit error rate of PAM LDPC codes under AWGN channel
format long 
clc
%% Pick your matrix
choice = 7;
path = 'C:\Users\Lorenzo\Documents\UNI\MAGI\I_sem\CC\FINAL_PROJECT\V_3.0\';
load(strcat(path,'Data\','data_c',num2str(choice),'.mat'));
 Htoy = [1 0 1 1 0 1;
         1 1 1 1 1 0;
         1 1 0 1 1 1;
         ];
%% Modulation and puncturing
puncPat = 2;
M = 4;
matrSym = GetSymbolForAllPer(M);     
%% Sim definitions
switch choice
    case 1
        %Es_N0 = [1.5 2 2.5 2.7 2.9 3 3.1 3.2 3.3 3.4 3.5];
        %For Qpsk
        %Es_N0 = [1.5 2 2.5 2.7 2.9 3 3.2 3.4 3.6 3.7 3.9 4 4.1];
        %M =4
        Es_N0 = [1.5 2 2.5 2.7 2.9 3 3.2 3.4 3.6 3.7 3.9 4 4.1 4.2 4.3];
        %Es_N0 = [1 1.5]
        %Es_N0 = [0.6 0.7 0.8 0.9 1.1]

        %Es_N0 = [3.5 3.9 4.2 4.6];
    case 2
        %Es_N0 = [0 0.5 1 1.25 1.5 1.8 1.9 2 2.1];
        Es_N0 = [1.8 2 2.2 2.4 2.5];
    case 5
        %Es_N0 = [3.3 3.5 3.6 3.7 3.8];
        %Es_N0 = [2 2.5 3];
        Es_N0 = [0 0.5 1];
    case 6 
        %Puncturing 1
        %Es_N0 = [6.5 6.9 7 7.1 7.2 7.3 7.4 7.5 7.6];    
        %Puncturing 2
            %Es_N0 = [9.3 9.4 9.5 9.6];
            %Es_N0 = [8 8.2];
           % Es_N0 = [9.2 9.4 9.5];
           %M=2
        %Es_N0 = [5.5 5.7 5.9 6.1 6.3];    
Es_N0 = [6.5];% 6.7 6.9];
        %Es_N0 = 5.9:0.1:6.6;
        %Es_N0 = 5.7:0.1:6.3;
    case 7
        %Es_N0 = [5.1 5.3 5.5 5.7 5.9 6 6.1];
        %Es_N0 = [ 5.3 5.4 5.5 5.6 5.65 5.7]
        %Es_N0 = [4.9 5.1];
        %Punctured 1
        %Es_N0 = 6.8:0.2:7;
        %Es_N0 = [6.3 6.4 6.5 6.6 6.7]
        %Punctured 2
        %Es_N0 = [7.8 8 8.2 8.3 8.4 8.5];
        %M = 2
        %Es_N0 = [5.5 5.7 5.9 6.1 6.3];
        %M = 4
        %Es_N0 = [6.5 6.7 6.9 7.1 7.3 7.5 7.7 7.9];
        Es_N0 = [10 10.2 10.4];
    otherwise
        disp('other value');
end
%Es_N0 = Eb/N0
%Gamma = 10.^((Es_N0)/10); %Baseband
if(M~=1)
    sigw = sqrt( 1./(Es_N0/(M)));
else
    sigw = sqrt(1./Gamma);
end
% initialize error and packet counters
nerr = zeros(size(Gamma));
nerrS = zeros(size(Gamma));
npack = zeros(size(Gamma));
nerr1 = zeros(size(Gamma));
npack1 = zeros(size(Gamma));
Th_nerr = 1e3;                      %do not simulate if Th_nerr errors are exceeded <--
% Number of iteration;
Nit = 1e4;
% Number of iteration in the minsumalg
mpIt = 80;
%expected precision
prec = 10^(1+log10(1/(k*Nit)));       
%% Start simulation
start = tic;
u = zeros(k,1);
y = zeros(n,1);
s = zeros(n/M,1);
tmp = reshape(y,[M,n/M]);
for it = 1:Nit    
    %Preparing Messages
    %u = randi([0,1],k,1);
    %u = zeros(k,1);
    %y = randi([0,1],n,1);
    %y = EncoderLDPC(Hsys,n,k,u);
    %y = zeros(n,1);
    %yPunc = Puncturing(y)

    if(M == 1)
        s = 2*y -1;
    else
        if(M==2)
            s(:) = -1 - 1*1i;
            %s = ConstMapper2(tmp(1,:),tmp(2,:),n/M);
        else
           tmp = reshape(y,[M,n/M]);
            s(:) = -3 -3*1i;
            %s = ConstMapper4(tmp(1,:),tmp(2,:),tmp(3,:),tmp(4,:),n/M);
        end
    end
    % prepare noise samples (with unit variance)
    w = randn(size(s));
    % Cycle on SNRs
    parfor m = 1:length(Gamma)
        % check number of errors
        if nerr(m)<Th_nerr
            % define noise variance
            % define the received signal COMPLEX GAUSSIAN NOISE
            r = s + (sigw(m)*w + 1i * sigw(m)*w);
            %r = s + (sigw(m))*w;
            %Compute the priorLLRs
            priorLLRs = LLR_BICM(r,matrSym,sigw(m)^2,M);
            %priorLLRs = -2*r ./ sigw(m)^2;
            %priorLLRs = PuncturingLLR(priorLLRs, puncPat, choice);
            % Demodulate
            %u_hat = MinSumDecoder(nOR,nOC,nO,AssignLLRs(priorLLRs,nOC,nO),priorLLRs,upMatrVC,perMatrCV,perMatrVC,mpIt,Hreal);
            u_hat = SumProdDecoder(nOR,nOC,AssignLLRs(priorLLRs,nOC,nO),priorLLRs,upMatrCV,upMatrVC,perMatrCV,perMatrVC,mpIt,Hreal);
            estimate = u_hat(1:k);
            tmp = reshape(u_hat,[M,n/M]);
            if(M == 2)
                symE = ConstMapper2(tmp(1,:),tmp(2,:),n/M);
            else
                if(M==4)
                    symE = ConstMapper4(tmp(1,:),tmp(2,:),tmp(3,:),tmp(4,:),n/M);
                end
            end
            % counting errors
            nerrS(m) = nerrS(m) + sum(symE~=s);
            nerr(m) = nerr(m) + sum(estimate~=u);
            npack(m) = npack(m) + 1;
        end
    end
     % save once in a while
    if (mod(it,1000)==0)
        % display current status
        disp(['#' num2str(it) ', BER = ' num2str(nerr./(npack*k))]);
        %save workspace
        %save(strcat(path,'Results\','simGiust2_c',num2str(choice),'_SP_M',num2str(M),'.mat')); 
    end
    it
end
total_time = toc(start);
fprintf('Total simulation time: %fs\n', total_time);
%% Calculate the statistics
Pbit = nerr./(npack*k);
Ps = nerrS ./(npack*(n/M));
% BER for uncoded packet
Pbit_uc = qfunc(sqrt(2*Gamma));
Ps_QAM = @(x) 4*(1-(1/sqrt(2^M)))*qfunc(sqrt((3/(2^M -1) * (10.^(x/10)))));
Ps_QAM_dB = @(x) 4*(1-(1/sqrt(2^M)))*qfunc(sqrt((3/(2^M -1) * (x))));
Pb_QAM = @(x) Ps_QAM(x)/M;
Pbit_QPSK = 2*qfunc(sqrt(2*Gamma)*sin(pi/4))/2;
%% Show results
figure;
set(0,'defaultTextInterpreter','latex') % to use LaTeX format
set(gca,'FontSize',14);
h = semilogy(Es_N0,Pbit,'r-<',...
    Es_N0,Ps,'g-',...
    Es_N0,Pb_QAM,'b');
axis([min(Es_N0) max(Es_N0) 1e-6 1e0])
set(h,'linewidth',2);
legend('Coded','Uncoded');
xlabel('SNR $\Gamma$  [dB]')
ylabel('BER $P_{\rm bit}$')
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on',...
    'YGrid', 'on', 'XGrid', 'on');