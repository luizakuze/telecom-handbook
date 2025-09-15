%% Laboratório de Processamento de sinais
%%
%[m,t] = makecos(20)

%%
% % Vamos fazer um trem de impulso para amostrar nosso sinal
% % (frequência de amostragem de 50 Hz)
% [it1,ts1] = makeimp(50);
% % Agora amostre o sinal original
% ms1 = sampleit1(t,m,ts1);
% % Plote todos os sinais para visualizer o processo de amostragem
% c1 = 'r'; % cor para o primeiro cenário
% smpl_plot(t,m,ts1,it1,ms1,c1);

%%
% Agora faça um segundo trem de impulsos
% % (frequência de amostragem de 30 Hz menor que a taxa de Nyquist)
% [it2,ts2] = makeimp(30);
% % Agora amostre o sinal original com a nova taxa de amostragem
% ms2 = sampleit1(t,m,ts2);
% % Plote todos os sinais para visualizer o processo de amostragem
% c2 = 'g'; % cor para o Segundo cenário
% smpl_plot(t,m,ts2,it2,ms2,c2);

%%

% Agora reconstrua as duas versões amostradas
% mr1 = interpsinc(ms1,ts1,t);
% mr2 = interpsinc(ms2,ts2,t);
% % Plote o sinal original e o sinal reconstruido para comparar
% recon_plot(t,m,ts1,ms1,mr1,c1);
% recon_plot(t,m,ts2,ms2,mr2,c2);
%%

% Agora vamos obter o espectro para examinar o aliasing
% Faça o índice de frequência para plotagem
% f = (-5000/2):(1/2):(5000/2);
% % Use a função do anexo para calcular o espectro
% M = am_spectrum(m);
% MR1 = am_spectrum(mr1);
% MR2 = am_spectrum(mr2);
% % Plote o espectro para comparar
% am_plot(f,M,MR1,MR2,0.02);
%% Tarefas:

% ================================= % Cosseno: 30Hz, Amostragem: 50Hz 
[m,t] = makecos(30); 
[it3,ts3] = makeimp(50); 
ms3 = sampleit1(t,m,ts3); 
c3 = 'r'; smpl_plot(t,m,ts3,it3,ms3,c3); 
mr3 = interpsinc(ms3,ts3,t); 
recon_plot(t,m,ts3,ms3,mr3,c3);
 % ================================= % ================================= % 
Cosseno: 40Hz, Amostragem: 15Hz [m,t] = makecos(40); 
[it4,ts4] = makeimp(15); 
ms4 = sampleit1(t,m,ts4); 
c4 = 'r'; smpl_plot(t,m,ts4,it4,ms4,c4); 
mr4 = interpsinc(ms4,ts4,t); 
recon_plot(t,m,ts4,ms4,mr4,c4);
 % ================================= % ================================= % Cosseno: 30Hz, Amostragem: 50Hz 
[m,t] = makecos(10);
 [it5,ts5] = makeimp(50); 
ms5 = sampleit1(t,m,ts5); 
c5 = 'r'; smpl_plot(t,m,ts5,it5,ms5,c5); 
mr5 = interpsinc(ms5,ts5,t); 
recon_plot(t,m,ts5,ms5,mr5,c5); 
% ================================= % ================================= % Cosseno: 30Hz, Amostragem: 50Hz 
[m,t] = makecos(20); 
[it6,ts6] = makeimp(40);
 ms6 = sampleit1(t,m,ts6); 
c6 = 'r'; 
smpl_plot(t,m,ts6,it6,ms6,c6);
 mr6 = interpsinc(ms6,ts6,t); 
recon_plot(t,m,ts6,ms6,mr6,c6); 
% =================================
