% Newton - Para sistemas não lineares
%% matriz inversa: troca Posição da diagonal Principal e troca Sinal da diagonal Secundária! -> inv
%F = @(x)[x(1)^2 + x(2)^2 + x(3)^2 - 9; x(1)^2 + x(2)^2 - x(3)^2 - 1; x(3)-x(2)]
%J = @(x)[2*x(1)   2*x(2)  2*x(3)   ; 2*x(1)  2*x(2)  -2*x(3)     ; 0 -1 +1] %derivada de F

% Um sistema {x² +y² +x² = 0
%            {x²+y²-z²=1
%            {z-y=0

%x1 = [1;1;1]

%    |F1x   F1y   F1z|
% J =|               |
%    |               |


F = @(x)[x(1)+x(2)-1 ; x(1)^2+2*x(2)-2];
J = @(x)[1 1 ; 2*x(1) 2]; 

x1 = [0;0];
x2 = x1 - inv(J(x1))*F(x1);

F(x1);
J(x1);

erro = sum(abs(x2-x1));

while (erro > 0.00001)
    x1 = x2;
    x2 = x1 - inv(J(x1))*F(x1);
    erro = sum(abs(x2-x1));
end    

F(x1)
J(x1)
x1 % x + y = 1, satisfaz o sistema
x2 % x² + 2y = 2
