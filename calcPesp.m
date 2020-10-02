j=1;
for i=1:NB
    
    if (DBAR.type(i)==2 |DBAR.type(i)==3)
    Pesp(j)=DBAR.Pesp(i);
    vK(j)=DBAR.bus(i);
    j=j+1;
    end
end

for i=1:NB
    
    if (DBAR.type(i)==3)
    Pesp(j)=DBAR.Qesp(i);
    vK(j)=DBAR.bus(i);
    j=j+1; 
    end
end
clear j;