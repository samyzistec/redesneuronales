close all
clear all
clc
% entrada
%E=[nivel de estudios, expertise en java, dominio del estrés, trabajo en equipo]
E= [0.3, 0.1, 0.2, 0.9] %perfil del entrevistado ya discretizado

% salida
Yd = [1]

%tasa de aprendizaje
alpha = 0.7

%Se declara epsilon
epsilon = 0.001

%topología: 4x5x1

%pesos iniciales, primera capa (conectan de la entrada a la capa oculta)
w1 = rand(4,5)
%pesos iniciales que van de la capa oculta a la capa de salida
w2 = rand (5,1)

%vector de error
EE = [];
%monitor de pesos
W1 = []; W2 = [];

%ciclo de entrenamiento
for k = 1:10000
  k
  %conexión neuronal (*esta es la que podemos mejorar)
  %(*pesos de la primera capa w1)
  y1=[];
  for  i =1:5;
    y = [];
    for k= 1:4;
      y = [y,(w1(k,i)*E(k))];
    endfor
    y1=[y1;sum(y)];
  endfor

  %version simplificada:
  %y1 = w1*E'

  %función sigmoide
  y1 = (1.0/(1+exp(-y1)))';

  %conexion neuronal (*pesos w2)
  y2 = w2'*y1;

  %función sigmoide
  yo = 1.0/(1+exp(-y2));
  
  %error
  e = (yo-Yd).^2;

  %acumular error
  EE = [EE,e];

  %actualiza pesos
  w1 = w1+alpha*(e*E');
  %w1 = w1+alpha*((Yd - yo) .* yo .* (1 - yo));  
  % Error en la salida


  %actualiza pesos
  w2 = w2+alpha*(e*y1);  
  %w2 = w2+alpha*((w2' * delta2) .* y1 .* (1 - y1)); 

  
  
  %en cada iteración guaarda los pesos
  W1 = [W1,w1];

  %en cada iteración guaarda los pesos
  W2 = [W2,w2];


  %condición de paro:
    % Opcion 1 = fijar un número de epocas
    % Opcion 2 = estabilización de pesos (esta opción es INCORRECTA ya que nunca se alcanza)
    % Opcion 3 =  condiciona a un mínimo deseable

    if(e<= 1.4795e-10)
      warndlg('Paro de red, ya aprendió')
      break
    end

end

%muestreo del desenso del gradiente
plot(EE)
xlabel('Epocas')
ylabel('mse')
grid

