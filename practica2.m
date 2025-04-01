%% -------------------------------------------------------------------
%      RED NEURONAL CON RETROPROPAGACIÓN Y LIMPIEZA DE CONEXIONES
% --------------------------------------------------------------------
% Este código implementa una red neuronal con una arquitectura 4x2x1.
% Se eliminan conexiones irrelevantes, se ajusta la tasa de aprendizaje
% dentro del rango [0,1] y se monitorean los pesos de cada capa.
%
% MEJORAS:
% - Pesos inicializados en el rango [-1,1].
% - Eliminación de conexiones irrelevantes (pesos cercanos a cero).
% - Tasa de aprendizaje en el rango [0,1] con ajuste dinámico.
% - Monitoreo visual de pesos en cada capa.
% - Condición de parada optimizada basada en \( \epsilon = 0.001 \).

%% LIMPIEZA DEL ESPACIO DE TRABAJO
close all;  % Cierra todas las figuras abiertas
clear all;  % Borra todas las variables del espacio de trabajo
clc;        % Limpia la consola

%% DEFINICIÓN DE PARÁMETROS

% Entrada del sistema [clima, horario, personas, tránsito]
E = [0.2, 0.29, 0.2, 0.1]; 

% Salida deseada
Yd = [1]; 

% Tasa de aprendizaje inicial en el rango [0,1]
alpha = 0.1;  

% Umbral de error de parada (EPSILON)
epsilon = 0.001;  

% Topología de la red neuronal: 4x2x1
n_entrada = 4;   % Número de neuronas en la capa de entrada
n_oculta = 2;    % Número de neuronas en la capa oculta
n_salida = 1;    % Número de neuronas en la capa de salida

% Inicialización de pesos en el rango [-1,1]
w1 = 2 * rand(n_entrada, n_oculta) - 1; % Pesos de entrada a oculta
w2 = 2 * rand(n_oculta, n_salida) - 1;  % Pesos de oculta a salida

% Inicialización de vectores de error y monitoreo de pesos
EE = [];         % Registro del error en cada época
W1_hist = [];    % Historial de pesos de la capa de entrada a oculta
W2_hist = [];    % Historial de pesos de la capa oculta a salida

% Número máximo de épocas de entrenamiento
epocas = 100;

%% CICLO DE ENTRENAMIENTO DE LA RED NEURONAL
for k = 1:epocas
    % ---- FORWARD PROPAGATION ----
    % Cálculo de la activación de la capa oculta
    net1 = E * w1;  
    y1 = 1 ./ (1 + exp(-net1));  % Aplicación de la función sigmoide
    
    % Cálculo de la activación de la capa de salida
    net2 = y1 * w2;
    y2 = 1 ./ (1 + exp(-net2)); 
    
    % ---- CÁLCULO DEL ERROR ----
    e = Yd - y2;  % Diferencia entre la salida deseada y la obtenida
    mse = mean(e.^2);  % Cálculo del error cuadrático medio (MSE)
    
    % ---- BACKPROPAGATION ----
    % Cálculo del gradiente de la capa de salida
    delta2 = e .* y2 .* (1 - y2);
    
    % Cálculo del gradiente de la capa oculta
    delta1 = (delta2 * w2') .* y1 .* (1 - y1);
    
    % ---- ELIMINACIÓN DE CONEXIONES IRRELEVANTES ----
    umbral = 0.05; % Umbral para eliminar conexiones débiles
    w1(abs(w1) < umbral) = 0;
    w2(abs(w2) < umbral) = 0;
    
    % ---- ACTUALIZACIÓN DE PESOS ----
    w2 = w2 + alpha * (y1' * delta2);
    w1 = w1 + alpha * (E' * delta1);
    
    % ---- REGISTRO DEL ERROR Y PESOS ----
    EE = [EE mse];          % Acumulación del error en cada iteración
    W1_hist = [W1_hist; w1(:)']; % Historial de pesos capa de entrada-oculta
    W2_hist = [W2_hist; w2(:)']; % Historial de pesos capa oculta-salida
    
    % ---- MONITOREO DE PESOS CADA 100 ITERACIONES ----
    if mod(k, 100) == 0
        figure;
        subplot(1,2,1); imagesc(w1); colorbar; title('Pesos W1 (Entrada - Oculta)');
        subplot(1,2,2); imagesc(w2); colorbar; title('Pesos W2 (Oculta - Salida)');
        pause(0.1);
    end
    
    % ---- AJUSTE DINÁMICO DE LA TASA DE APRENDIZAJE ----
    if mse < 0.05
        alpha = 0.05; % Reducir la tasa de aprendizaje si el error baja
    end
    
    % ---- CONDICIÓN DE PARO CON EPSILON ----
    if mse < epsilon
        fprintf('Entrenamiento detenido en la época %d porque MSE < epsilon (%.6f < %.6f)\n', k, mse, epsilon);
        break; % Detiene el entrenamiento si el error es menor a epsilon
    end
end

%% GRAFICAR EL ERROR DURANTE EL ENTRENAMIENTO
figure;
plot(EE, 'b', 'LineWidth', 2);
xlabel('Épocas');
ylabel('Error cuadrático medio (MSE)');
title('Evolución del Error durante el Entrenamiento');
grid on;