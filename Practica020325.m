close all;
clear all;
clc;

E = [[0.8, 0.2, 0.4, 0.3],
     [0.7, 0.4, 0.9, 0.6],
     [0.6, 0.3, 0.0, 0.9],
     [0.9, 0.8, 0.8, 0.4]]

Yd = [1, 1, 0, 1]; 

E = 2 * E - 1;  
Yd = 2 * Yd - 1;

alpha = 0.2;

bias = rand(1);  % Inicialización del bias
w1 = rand(4,1);

EE = [];

for k = 1:100  % Entrenamiento con 100 épocas

    mse_total = 0;

    for i = 1:size(E,1)
        Ei = E(i,:);
        Ydi = Yd(i);

        y1 = Ei * w1 + bias;
        e = Ydi - y1;
        mse_total = mse_total + e^2;
        
        disp(['Salida deseada: ', num2str(Ydi)])
        disp(['Salida obtenida: ', num2str(y1)])

        if Ydi ~=y1
            w1 = w1 + alpha * (e * Ei');
            bias = bias + alpha * e;
        else
            disp('iguales...')
        end
    end

    mse = mse_total / size(E,1);
    EE = [EE,mse];

    %Realizar la condición de paro
    if mse < 1e-3
        mse
        break;
    end
end

figure;
plot(EE, 'b', 'LineWidth', 1.5);
xlabel('Épocas');
ylabel('MSE');
title('Evolución del error');
grid on;