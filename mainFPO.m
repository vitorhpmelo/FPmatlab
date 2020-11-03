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
while(max(abs(DL))>1e-3&&it2<50)

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

L=(2*g(1,2)*sin(DBAR.teta(1)-DBAR.teta(2)))/(g(1,2)*sin(DBAR.teta(1)-DBAR.teta(2))-b(1,2)*cos(DBAR.teta(1)-DBAR.teta(2)));

DLV1=2*g(1,2)*(DBAR.V(1)-DBAR.V(2)*cos(DBAR.teta(1)-DBAR.teta(2)))...
    +L*DBAR.V(2)*(g(1,2)*cos(DBAR.teta(1)-DBAR.teta(2))+b(1,2)*sin(DBAR.teta(1)-DBAR.teta(2)));
DLV2=2*g(1,2)*(DBAR.V(2)-DBAR.V(1)*cos(DBAR.teta(1)-DBAR.teta(2)));
aux=-2*DBAR.V(2)*g(1,2);
aux=aux+g(1,2)*cos(DBAR.teta(1)-DBAR.teta(2));
aux=aux+b(1,2)*sin(DBAR.teta(1)-DBAR.teta(2));
DLV2=DLV2+L*aux;
DL=[DLV1,DLV2]; 

c=5;

V=[DBAR.V(1),DBAR.V(2)];

flag=0;

while(flag==0)
    V2=V-DL/c;
    if max(V2)>1.1 || min(V2) <0.90
        c=c*2;
    else
        flag=1;  
    end
end

DBAR.V(1)=V2(1)
DBAR.V(2)=V2(2)
it2=it2+1;
end
relprint;
