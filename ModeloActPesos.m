close all 
clear all
%Entrada
E=[0.3,0.1,0.2,0.9];%Perfil entrevistado

%Salida
Yd = [1];
%Tasa de aprendizaje
alpha =0.2;

%tasa de aprendizaje
%Pesos iniciales
w= rand(4,2)+2;

%Vector de error
EE=[];
%Vector de pesos
W=[];
%actualiza pesos
w=w+alpha;

%se guardan los pesos para sus analisis


for k=1:10
  %Conexcion neuronal
  y = sum(E*w);
    %Funcion sigmoide
  y = 1/(1+exp(-y));
%Error
  e=(y-Yd).^2;
  %Acomular el error
  EE=[EE,e]
  %ActuaPesos
  w=w+alpha;
  
  %condicion de paro: fijar un numero de epoca, estabilizacion de pesos
  figure:imagesc(w);colorbar
  pause
  W=[W;w];

 end
 
 plot(EE)
 xlabel('Epocas')
 ylabel('mse')
 grid