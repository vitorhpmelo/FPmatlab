
%%entrada de dados %tipo 1 slack, tipo 2 PV tipo 3 PQ
NB=2;
NPV=1;
NPQ=0;
itmax=10;
epi=1e-3;
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



relprint;
