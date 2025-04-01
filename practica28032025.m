%Encapsularlo a 100 ejecuciones y probar el eje para encapsular 
close all;

clear all;

clc;
 
% Entrada

E = [0.9, 0.8, 0.3, 0.1, 0.5, 0.5, 0.7;

     0.3, 0.5, 0.1, 0, 0.7, 0.1, 0.8]';
     
     %Discretizacion
E=E>0.5;
 
Yd = [1, 1, 0, 0, 1, 0, 1]';
 
% Inicialización de pesos

w1 = rand(4, 2);   % C1

w2 = rand(4, 4);   % C2

w3 = rand(1, 4);   % Csalida

alpha = 0.2;       % Tasa de aprendizaje

epocas = 1000;     
 
% Entrenamiento

EG = [];  % Almacena el error promedio por época
 
for ep = 1:epocas

    e = 0;  % Acumulador de error para el número de épocas

    for patron = 1:5%(E, 1)

        x = E(patron, :)';

        yd = Yd(patron);
 
        % Feed Forward propagation

        z1 = w1 * x;

        O1 = 1 ./ (1 + exp(-z1));
 
        z2 = w2 * O1;

        O2 = 1 ./ (1 + exp(-z2));
 
        z3 = w3 * O2;

        O3 = 1 ./ (1 + exp(-z3));

        Yo = O3;
 
        % Cálculo del error 

        error_salida = (yd - Yo)^2;

        %aquí esta el ajuste para corregir el descenso (promedio por patrón)

        e= e+error_salida;
 
        % Backpropagation

        dO3 = Yo * (1 - Yo);

        E3 = (yd - Yo) * dO3;
 
        E2 = zeros(4, 1);

        for j = 1:4

            E2(j) = O2(j) * (1 - O2(j)) * (w3(1, j) * E3);

        end
 
        E1 = zeros(4, 1);

        for j = 1:4

            suma = 0;

            for k = 1:4

                suma += w2(k, j) * E2(k);

            end

            E1(j) = O1(j) * (1 - O1(j)) * suma;

        end
 
        %pesos actualizados

        w3 = w3 + alpha * E3 * O2';
 
        for i = 1:4

            for j = 1:4

                w2(i, j) = w2(i, j) + alpha * E2(i) * O1(j);

            end

        end
 
        for i = 1:4

            for j = 1:2

                w1(i, j) = w1(i, j) + alpha * E1(i) * x(j);

            end

        end

    end

    % Guardamos el error promedio de la época

    EG = [EG, mean(e)];

end
 
% Gráfica del descenso del gradiente

figure;

plot(EG);

xlabel('Epocas');

ylabel('MSE');

title('Descenso del Gradiente');

grid on;
 