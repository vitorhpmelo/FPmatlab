clear
clc
%%entrada de dados %tipo 1 slack, tipo 2 PV tipo 3 PQ
NB=2;
NPV=1;
NPQ=0;
itmax=10;
epi=1e-3;
Vlims=1.1;
vlimi=0.9;
%%
importDLIN;
importDBAR;
adados;

nvar=NPV+2*NPQ;
%declarar variáveis
dP=zeros(NPV+2*NPQ,1);
dx=zeros(NPV+2*NPQ,1);
x=zeros(NPV+2*NPQ,1);
Pesp=zeros(NPV+2*NPQ,1);
Pcal=zeros(NPV+2*NPQ,1);
vK=zeros(NPV+2*NPQ,1);

calcPesp;

%processo iterativo
it2=1;
DL=3
while(max(abs(DL))>1e-3&&it2<100)

DBAR.teta(2)=0;
    for it=1:itmax

        calcP;

        %calculo Pesp-Pcal
        dp=Pesp-Pcal;

        conv=max(abs(dp));

        %teste de convergência
        if(conv<epi)
           % print=sprintf('O programa Convergiu em %d itetacoes',it-1);
            %disp(print);
            break  
        end

        %função calcula jacobiana
        calcJ;
        dx=J\dp;

        %atualiza o valor das variáveis
        atualizaval;

end

L=2*g(1,2)*sin(DBAR.teta(1)-DBAR.teta(2))/((g(1,2)*sin(DBAR.teta(1)-DBAR.teta(2)))+(b(1,2)*cos(DBAR.teta(1)-DBAR.teta(2))));

dfdv1=2*g(1,2)*(DBAR.V(1)-DBAR.V(2)*cos(DBAR.teta(1)-DBAR.teta(2)));
dgdv1=DBAR.V(2)*((g(1,2)*cos(DBAR.teta(1)-DBAR.teta(2))-(b(1,2)*sin(DBAR.teta(1)-DBAR.teta(2)))));
dfdv2=2*g(1,2)*(DBAR.V(2)-DBAR.V(1)*cos(DBAR.teta(1)-DBAR.teta(2)));
dgdv2=(-2*g(1,2)*DBAR.V(2))+DBAR.V(1)*((g(1,2)*cos(DBAR.teta(1)-DBAR.teta(2))-(b(1,2)*sin(DBAR.teta(1)-DBAR.teta(2)))));

DLV1=dfdv1+L*dgdv1;
DLV2=dfdv2+L*dgdv2;
DL=[DLV1,DLV2]; 

c=5;

V=[DBAR.V(1),DBAR.V(2)];

flag=0;

V2=V-DL/c;
for i=1:2
    if V2(i)> 1.1
        V2(i)=1.1  
    elseif V2(i)< 0.9
        V2(i)=0.9
    end
end

DBAR.V(1)=V2(1);
DBAR.V(2)=V2(2);
it2=it2+1;
end
relprint;
disp("perdas");
disp(P(g,b,bsh,DBAR,NB,1)+P(g,b,bsh,DBAR,NB,2))