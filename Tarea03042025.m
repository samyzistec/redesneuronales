close all;
clear;
clc;

% Datos de entrada
E = [0.9, 0.8, 0.3, 0.1, 0.5, 0.5, 0.7;
     0.3, 0.5, 0.1, 0.0, 0.7, 0.1, 0.8]';
E = E > 0.5;

Yd = [1, 1, 0, 0, 1, 0, 1]';

% Parámetros
epocas = 1000;
alpha = 0.2;
num_ejecuciones = 100;

errores_todas = zeros(num_ejecuciones, epocas);

% Bucle de 100 ejecuciones
for ejec = 1:num_ejecuciones
    
    % Inicialización aleatoria de pesos
    w1 = rand(4, 2);   % Capa 1
    w2 = rand(4, 4);   % Capa 2
    w3 = rand(1, 4);   % Capa salida

    EG = [];  % Error de cada época

    for ep = 1:epocas
        e = 0;

        for patron = 1:5  % Solo los primeros 5 patrones
            x = E(patron, :)';
            yd = Yd(patron);

            % --- Propagación hacia adelante (Feedforward) ---
            z1 = w1 * x;
            O1 = 1 ./ (1 + exp(-z1));

            z2 = w2 * O1;
            O2 = 1 ./ (1 + exp(-z2));

            z3 = w3 * O2;
            O3 = 1 ./ (1 + exp(-z3));

            Yo = O3;

            % --- Cálculo del error ---
            error_salida = (yd - Yo)^2;
            e = e + error_salida;

            % --- Backpropagation ---
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
                    suma = suma + w2(k, j) * E2(k);
                end
                E1(j) = O1(j) * (1 - O1(j)) * suma;
            end

            % --- Actualización de pesos ---
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

        % Guardar error promedio por época
        EG = [EG, mean(e)];
    end

    % Guardar el error de esta ejecución
    errores_todas(ejec, :) = EG;
end

% --- Gráfica del descenso del gradiente en las 100 ejecuciones ---
figure;
hold on;
for i = 1:num_ejecuciones
    plot(errores_todas(i, :));
end
xlabel('Épocas');
ylabel('Error cuadrático medio (MSE)');
title('100 ejecuciones del descenso del gradiente');
grid on;
