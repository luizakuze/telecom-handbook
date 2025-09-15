% Utilizando Matlab para Análise e Plotagem

vet1 = [1 2 3];
vet2 = vet1 .^ 2; % eleva ao quadrado cada elemento de vet1
plot(vet1, vet2);

% plotando com seno
% x = [-10:10] 
x = [-10:0.1:10];
y = sin(x);
plot(vet1, vet2);

% limite em y do gráfico
ylim([-1.5,1.5]);

% linha horizontal no 0
plot(x, y, [-10,10],[0,0]);

% linha vertical no 0
plot(x, y, [-10,10],[0,0], [0,0], [-1.5, 1.5]);

legend('gráfico seno');

for i=[1:10]
    if (i>5)
        disp(i^2); % print
    else
        disp(-i^2);
    end
end
