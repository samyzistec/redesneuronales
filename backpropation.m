close all;  
clear all; 
clc;

% definicion para un conjunto de entrenamiento

entre[0.9,0.8,0.3,0.1,0.5,0.5,0.7;
      0.3,0.5,0.1,0,0.7,0.1,0.8]';
      
yd=[1,1,0,0,1,0,1]';

% matriz de conecxiones

w1=rand(2,4)';
w2=rand(4,4)';
w3=rand(4,1)';

% propagacion de señales hacia adelante (feed-forward)
O1 = 1.0/(1+exp(w1*entre(1,:))');
O2 = (1.0/(1+exp(w2*O1)));
O3 = (1.0/(1+exp(w3*O2)));


