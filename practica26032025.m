close all;
clear all;
clc;

%Entrada
E = [0.9, 0.8, 0.3, 0.1, 0.5, 0.5, 0.7;
     0.3, 0.5, 0.1, 0, 0.7, 0.1, 0.8]';

Yd = [1, 1, 0, 0, 1, 0, 1]';

w1 = rand(4, 2);   % C1
w2 = rand(4, 4);   % C2
w3 = rand(1, 4);   % CSalida
alpha = 0.3;       % Tasa de aprendizaje
epocas = 40
;

%Entrenamiento
EG=[];
for ep = 1:epocas
    for patron = 1:size(E,1)
        x = E(patron, :)';
        yd = Yd(patron);

        %Ff
        z1 = w1 * x;
        O1 = 1 ./ (1 + exp(-z1));

        z2 = w2 * O1;
        O2 = 1 ./ (1 + exp(-z2));

        z3 = w3 * O2;
        O3 = 1 ./ (1 + exp(-z3));
        Yo = O3;

        %Bckpp
        Error_salida = (yd - Yo)^2;
        EG=[EG,Error_salida];
        dO3 = Yo * (1 - Yo);
        E3 = Error_salida * dO3;

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
        for i = 1:4
            w3(1, i) = w3(1, i) + alpha * E3 * O2(i);
        end

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
end
%Grafica del descenso del gradiente
plot(EG)