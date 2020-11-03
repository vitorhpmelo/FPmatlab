%% FLUXO DE POTENCIA OTIMO
clc
clear all
contador = 0;
tol = 10^-3;
P2esp = -0.4;
v(1,1)=1;
v(2,1)=1;
c = 2;
teta(1,1)=0;
teta(2,1)=0;
teta2 = teta(2,1);

r12 = 0.2;
x12 = 1.0;
bsh12 = 0.02*1i;
z12 = 0.2 + 1*1i;
y12 = 1/z12;
Y = [(y12+bsh12) -y12; 
     -y12         (y12+bsh12)];   
G = real(Y);
B = imag(Y);

%% Chutar u para iteracao =0
iteracao = 0;
v(1,1)=1;
v(2,1)=1;
missmatchGRADL = 1;
oldMM = 0;

while missmatchGRADL > tol && iteracao<100
%% Obter x da equaco (3) Resolver o fluxo de carga 
%  Fluxo de Potencia
P2 = (v(2,1)^2)*G(2,2) + v(2,1)*v(1,1)*(G(2,1)*cos(teta(2,1)-teta(1,1))+B(2,1)*sin(teta(2,1)-teta(1,1))); 

deltaP2 = P2esp - P2;
missmatch = abs(deltaP2); 
iteracaoFP = 0;
while missmatch > tol    

JAC = - v(2,1)*v(1,1)*(G(2,1)*sin(teta(2,1)-teta(1,1))-B(2,1)*cos(teta(2,1)-teta(1,1))); 

deltaTeta = JAC\deltaP2;

teta(2,1) = teta(2,1)+ deltaTeta;

P2 = (v(2,1)^2)*G(2,2) + v(2,1)*v(1,1)*(G(2,1)*cos(teta(2,1)-teta(1,1))+B(2,1)*sin(teta(2,1)-teta(1,1))); 

deltaP2 = P2esp - P2;
missmatch = abs(deltaP2); 
iteracaoFP = iteracaoFP + 1;

end

%% Calcular lambda da equacao (1) em (x,u)
lambda = (2*v(1,1)*v(2,1)*G(1,2)*sin(teta(1,1)-teta(2,1))) / (v(1,1)*v(2,1)*(G(1,2)*sin(teta(1,1)-teta(2,1))+B(1,2)*cos(teta(1,1)-teta(2,1))));

%% Calcular o gradiente reduzido 
gradL(1,1) = -1*(   G(1,2)*(2*v(1,1)-2*v(2,1)*cos(teta(1,1)-teta(2,1))) + lambda*(v(2,1)*(G(1,2)*cos(teta(1,1)-teta(2,1))-B(1,2)*sin(teta(1,1)-teta(2,1))))                             );
gradL(2,1) = -1*(   G(1,2)*(2*v(2,1)-2*v(1,1)*cos(teta(1,1)-teta(2,1))) + lambda*(v(1,1)*(G(1,2)*cos(teta(1,1)-teta(2,1))-B(1,2)*sin(teta(1,1)-teta(2,1)))) - 2*G(1,2)*v(2,1)*lambda	);

grad(iteracao+1,1) =gradL(1,1);
grad(iteracao+1,2) =gradL(2,1);
%% Hessiana
H(1,1) = -G(1,2)*2;
H(1,2) = +G(1,2)*2*cos(teta(1,1)-teta(2,1)) - lambda * (  (G(1,2)*cos(teta(1,1)-teta(2,1)) - B(1,2)*sin(teta(1,1)-teta(2,1)))   );
H(2,1) = H(1,2);
H(2,2) = -2*G(1,2) - 2*lambda*G(2,2);

deltaU(1,1) = -  (H(1,1)^-1)*gradL(1,1);
deltaU(2,1) = -  (H(2,2)^-1)*gradL(2,1);

v = v + deltaU;

if v(1,1) > 1.1
    v(1,1) = 1.1;
end
if v(2,1) > 1.1
    v(2,1) = 1.1;
end
if v(1,1) < 0.9
    v(1,1) = 0.9;
end
if v(2,1) < 0.9
    v(2,1) = 0.9;
end

oldMM = missmatchGRADL;
[missmatchGRADL,I] = max(abs(gradL));
if oldMM == missmatchGRADL
    contador = contador + 1;
end

%% Resultado
fprintf('-----FPO-----\n');
fprintf('teta2: %.5f rad = %.5f°\n', teta(2),teta(2)*180/pi );
fprintf('Lambda: %.5f\n', lambda);
fprintf('GRAD_L:%.5f; %.5f\n', gradL(1), gradL(2));
fprintf('Delta_u: %.5f; %.5f\n', deltaU(1), deltaU(2));
fprintf('Iteracao: %d\n', iteracao);
%fprintf('c: %.5f\n', c);
fprintf('V1: %.5f\n', v(1,1));
fprintf('V2: %.5f\n', v(2,1));
fprintf('Perdas: %.5f\n', -G(1,2)*(v(1)^2 + v(2)^2 - 2*v(1)*v(2)*cos(teta(1)-teta(2))));
fprintf('missmatchGRADL: %.5f\n', missmatchGRADL);
if contador == 10
    break;
end
iteracao = iteracao + 1;
end
