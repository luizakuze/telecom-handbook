# Método da Bisseção 

### Código em aula
```matlab
% função

format long 
%% uma função
f = @(x)sin(x);

%f(1.5);

%% bisseção 
%%% condição de existência de raízes: um valor da função positivo e outro um negativo,
%%% já que as raízes ficam em cima do eixo.

a = 2;
b = 4;

fa = f(a); % (a imagem dos valores a e b que devem ter sinais opostos)
fb = f(b);

[a b x; fa fb fx];

% verifica se tem um número positivo e um negativo (condição da bisseção)
% uma multiplicação de positivo com negativo sempre dá um número negativo
if (fa*fb < 0)
   
   % opções para o loop
   % 1) while (abs(fx) < 0.001) %% procurando o quão próximo está de zero
   % 2) while (abs(a-b) < 0.001) %% diferença dos intervalos está próxima de
   % zero -> opção melhor
   while (abs(a-b) > 0.0001)
       
       x = (a+b)/2
       fx = f(x);
       
       if (fa > 0 && fb < 0 && fx > 0)
           a = x;
       elseif (fa > 0 && fb < 0 && fx < 0)
           b = x;
       elseif (fa < 0 && fb > 0 && fx < 0)
           a = x;
       elseif (fa < 0 && fb > 0 && fx > 0)
           b = x;
       end
       
       % recalculando valores
       fa = f(a);
       fb = f(b);
       fx = f(x);
       
   end  

end

% mostrando novamente na tela
[a b x; fa fb fx]
```
