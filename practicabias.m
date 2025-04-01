close all;  
clear all; 
clc;        


E = [0.2, 0.29, 0.2, 0.1]; 


Yd = [1]; 


alpha = 0.1;  

% Umbral de error de parada (EPSILON)
epsilon = 0.001;  

% Topolog�a de la red neuronal: 4x2x1
n_entrada = 4;   % N�mero de neuronas en la capa de entrada
n_oculta = 2;    % N�mero de neuronas en la capa oculta
n_salida = 1;    % N�mero de neuronas en la capa de salida

% Inicializaci�n de pesos en el rango [-1,1]
w1 = 2 * rand(n_entrada, n_oculta) - 1; % Pesos de entrada a oculta
w2 = 2 * rand(n_oculta, n_salida) - 1;  % Pesos de oculta a salida

% Inicializaci�n de bias
b1 = 2 * rand(1, n_oculta) - 1; % Bias para la capa oculta
b2 = 2 * rand(1, n_salida) - 1; % Bias para la capa de salida

% Inicializaci�n de vectores de error y monitoreo de pesos
EE = [];         % Registro del error en cada �poca
W1_hist = [];    % Historial de pesos de la capa de entrada a oculta
W2_hist = [];    % Historial de pesos de la capa oculta a salida

% N�mero m�ximo de �pocas de entrenamiento
epocas = 100;

%% CICLO DE ENTRENAMIENTO DE LA RED NEURONAL
for k = 1:epocas
    % ---- FORWARD PROPAGATION ----
    % C�lculo de la activaci�n de la capa oculta
    net1 = E * w1 + b1;  
    y1 = 1 ./ (1 + exp(-net1));  % Aplicaci�n de la funci�n sigmoide
    
    % C�lculo de la activaci�n de la capa de salida
    net2 = y1 * w2 + b2;
    y2 = 1 ./ (1 + exp(-net2)); 
    
    % ---- C�LCULO DEL ERROR ----
    e = Yd - y2;  % Diferencia entre la salida deseada y la obtenida
    mse = mean(e.^2);  % C�lculo del error cuadr�tico medio (MSE)
    
    % ---- BACKPROPAGATION ----
    % C�lculo del gradiente de la capa de salida
    delta2 = e .* y2 .* (1 - y2);
    
    % C�lculo del gradiente de la capa oculta
    delta1 = (delta2 * w2') .* y1 .* (1 - y1);
    
    % ---- ELIMINACI�N DE CONEXIONES IRRELEVANTES ----
    umbral = 0.05; % Umbral para eliminar conexiones d�biles
    w1(abs(w1) < umbral) = 0;
    w2(abs(w2) < umbral) = 0;
    
    % ---- ACTUALIZACI�N DE PESOS Y BIAS ----
    w2 = w2 + alpha * (y1' * delta2);
    w1 = w1 + alpha * (E' * delta1);
    b2 = b2 + alpha * delta2;
    b1 = b1 + alpha * delta1;
    
    % ---- REGISTRO DEL ERROR Y PESOS ----
    EE = [EE mse];          % Acumulaci�n del error en cada iteraci�n
    W1_hist = [W1_hist; w1(:)']; % Historial de pesos capa de entrada-oculta
    W2_hist = [W2_hist; w2(:)']; % Historial de pesos capa oculta-salida
    
    % ---- MONITOREO DE PESOS CADA 100 ITERACIONES ----
    if mod(k, 100) == 0
        figure;
        subplot(1,2,1); imagesc(w1); colorbar; title('Pesos W1 (Entrada - Oculta)');
        subplot(1,2,2); imagesc(w2); colorbar; title('Pesos W2 (Oculta - Salida)');
        pause(0.1);
    end
    
    % ---- AJUSTE DIN�MICO DE LA TASA DE APRENDIZAJE ----
    if mse < 0.05
        alpha = 0.05; % Reducir la tasa de aprendizaje si el error baja
    end
    
    % ---- CONDICI�N DE PARO CON EPSILON ----
    if mse < epsilon
        fprintf('Entrenamiento detenido en la �poca %d porque MSE < epsilon (%.6f < %.6f)\n', k, mse, epsilon);
        break; % Detiene el entrenamiento si el error es menor a epsilon
    end
end

%% GRAFICAR EL ERROR DURANTE EL ENTRENAMIENTO
figure;
plot(EE, 'b', 'LineWidth', 2);
xlabel('�pocas');
ylabel('Error cuadr�tico medio (MSE)');
title('Evoluci�n del Error durante el Entrenamiento');
grid on;