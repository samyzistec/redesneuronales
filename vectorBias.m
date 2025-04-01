close all;
clear all;
clc;

E = [0.3, 0.1, 0.2, 0.9];
Yd = [1]; 

E = 2 * E - 1;  
Yd = 2 * Yd - 1;

alpha = 0.5;

bias = rand(1);  % Inicializaci�n del bias
w1 = rand(4,5);
w2 = rand(5,1);

EE = [];

for k = 1:100  % Entrenamiento con 100 �pocas

    %   Funci�n de activaci�n con bias separado
    y1 = E * w1 + bias;

    %  ERROR
    e = Yd - y1;
    mse = mean(e.^2);
    EE = [EE, mse];

    %  Actualizaci�n de pesos y bias
    w1 = w1 + alpha * (E' * e);
    bias = bias + alpha * e;

    %Realizar la condici�n de paro
    if mse < 1e-3
        mse
        break;
    end
end

figure;
plot(EE, 'b', 'LineWidth', 1.5);
xlabel('�pocas');
ylabel('MSE');
title('Evoluci�n del error');
gridon;