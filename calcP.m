

j=1;
for i=1:NB
    
    if (DBAR.type(i)==2 | DBAR.type(i)==3)
    Pcal(j)=P(g,b,bsh,DBAR,NB,DBAR.bus(i));
    j=j+1;
    end
end

for i=1:NB
    
    if (DBAR.type(i)==3)
    Pcal(j)=Q(g,b,bsh,DBAR,NB,DBAR.bus(i));
    j=j+1;
    end
end

clear j;