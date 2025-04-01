close all
clear all
clc
%ENTRADAS
E=[.2,.29,.2,.1]
%MATRIZ DE PESOS
W=rand(4,5)*(rand (1)-(0.5))
%APRENDIZAJE
Y=sum(sum(W'*E'-2))
%CALCULO DE ERROR
Sd=[1]
E= sqrt(Y-Sd)^2
%GRAFICA ERROR
plot(E)
%CICLO DE ENTRENAMIENTO
Ys=[],Yth=[],Ych=[],Yb=[]
for K=1:10
  Y1=sum(sum(W'*E'))
  Y2=sum(sum(W'*E'-2))
  Ys=[Y1,Y2]
endfor