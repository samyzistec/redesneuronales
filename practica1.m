close all
clear all
clc

% Entrada [clima, horario, personas, tr�nsito]
E = [0.2, 0.29, 0.2, 0.1]; % Condiciones

% Salida deseada
Yd = [1];

% Tasa de aprendizaje
alpha = 0.02;

% Topolog�a: 4x2x1
n_entrada = 4;
n_oculta = 2;
n_salida = 1;

% Inicializaci�n de pesos (valores aleatorios peque�os)
w1 = rand(n_entrada, n_oculta) - 0.5;  % Pesos de entrada a capa oculta
w2 = rand(n_oculta, n_salida) - 0.5;   % Pesos de capa oculta a salida

% Vector de error
EE = [];

% Monitor de pesos
W1_F = [];
W2_F = [];

% N�mero de �pocas
epocas = 1000;

for k = 1:epocas
    % ---- FORWARD PROPAGATION ----
    % Capa oculta
    net1 = E * w1;         % Producto punto
    y1 = 1 ./ (1 + exp(-net1));  % Funci�n sigmoide
    
    % Capa de salida
    net2 = y1 * w2;
    y2 = 1 ./ (1 + exp(-net2));
    
    % ---- C�lculo del error ----
    e = Yd - y2;
    mse = mean(e.^2);
    
    % ---- BACKPROPAGATION ----
    % Gradiente de la capa de salida
    delta2 = e .* y2 .* (1 - y2);
    
    % Gradiente de la capa oculta
    delta1 = (delta2 * w2') .* y1 .* (1 - y1);
    
    % Actualizaci�n de pesos
    w2 = w2 + alpha * (y1' * delta2);
    w1 = w1 + alpha * (E' * delta1);
    
    % Almacenar error y pesos
    EE = [EE mse];
    W1_F = [W1_F; w1(:)'];
    W2_F = [W2_F; w2(:)'];
    
    % Mostrar la evoluci�n de los pesos cada 100 iteraciones
    if mod(k, 1000) == 0
        figure;
        subplot(1,2,1); imagesc(w1); colorbar; title('Pesos W1');
        subplot(1,2,2); imagesc(w2); colorbar; title('Pesos W2');
        pause(0.1);
    end
    
    % Condici�n de parada (si el error es muy peque�o)
    if mse < 0.001
        break;
    end
end

% ---- Gr�fica del error ----
figure;
plot(EE, 'b', 'LineWidth', 2);
xlabel('�pocas');
ylabel('Error cuadr�tico medio (MSE)');
title('Descenso del error');
grid on;
