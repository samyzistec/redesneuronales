cls
% Mi primer neurona
tic
k=rand(1,2)*(rand(1)-(0.5))
cl=rand(1,2)*(rand(1)-(0.5))
Na=rand(1,2)*(rand(1)-(0.5))

%Entrandas
 E=[1, 0, 1]
%procesamiento
y=sigmoide(sum(sum((E'*k)+(E'*cl)+(E'*Na))))
 
%Activa Luces
if(y>0.5)
    warndlg('Activa luces')
else
    warndlg('No avtivar')
endif
toc