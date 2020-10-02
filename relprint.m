
disp('Os valores das variáveis de estado são');
for i=1:NB
   x=sprintf('Barra %d | V= %0.4f | teta = %0.4f',DBAR.bus(i),DBAR.V(i),DBAR.teta(i));  
   disp(x);
end