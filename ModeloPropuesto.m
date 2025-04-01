clear all;
clc;

% ? Parámetros del Modelo
input_size = 4;  % Número de neuronas en la capa de entrada (tamaño del vocabulario)
hidden_size = 8; % Número de neuronas ocultas en la LSTM
output_size = 4; % Tamaño del vocabulario en idioma destino
alpha = 0.2; % Tasa de aprendizaje

% ? Datos de entrada (ejemplo de oración codificada)
E = [0.3, 0.1, 0.2, 0.9];  % Frase en idioma origen (vector de características)
Yd = [1, 0, 0, 0];  % Frase en idioma destino (one-hot vector)

% ? Inicialización de pesos aleatorios (-0.5 a 0.5)
W_i = rand(hidden_size, input_size) - 0.5; % Pesos de entrada
W_h = rand(hidden_size, hidden_size) - 0.5; % Pesos recurrentes (LSTM)
W_o = rand(output_size, hidden_size) - 0.5; % Pesos de salida
b_h = rand(hidden_size, 1) - 0.5; % Bias oculto
b_o = rand(output_size, 1) - 0.5; % Bias de salida

% ? Inicialización de vectores
H_t = zeros(hidden_size, 1);  % Estado oculto inicial
EE = []; % Vector para almacenar error en cada época

num_epocas = 10; % Número de iteraciones de entrenamiento

for k = 1:num_epocas
    % ? Forward Pass: Capa LSTM
    net_h = W_i * E' + W_h * H_t + b_h;  % Suma ponderada + estado anterior
    H_t = 1 ./ (1 + exp(-net_h));  % Función de activación sigmoide (LSTM)

    % ? Salida con Softmax
    net_o = W_o * H_t + b_o;
    y = exp(net_o) ./ sum(exp(net_o)); % Softmax para clasificación
    
    % ? Error Cuadrático
    e = Yd' - y; % Diferencia con la salida deseada
    mse = sum(e.^2); % Error cuadrático medio
    EE = [EE, mse]; % Guardar error
    
    % ? Backpropagation (Actualización de Pesos)
    d_o = e .* y .* (1 - y); % Gradiente de salida
    d_h = (W_o' * d_o) .* H_t .* (1 - H_t); % Gradiente en la capa oculta
    
    % ? Ajuste de pesos
    W_o = W_o + alpha * d_o * H_t';
    b_o = b_o + alpha * d_o;
    W_i = W_i + alpha * d_h * E;
    W_h = W_h + alpha * d_h * H_t';
    b_h = b_h + alpha * d_h;
    
    % ? Visualizar Evolución de Pesos
    figure(1);
    imagesc(W_o);
    colorbar;
    title(['Pesos de Salida en época ', num2str(k)]);
    pause(0.5);
end

% ? Graficar el Error a lo largo de las épocas
figure(2);
plot(EE, '-o');
xlabel('Épocas');
ylabel('Error cuadrático medio (MSE)');
grid on;
title('Evolución del Error');

disp("Pesos finales:");
disp(W_o);
