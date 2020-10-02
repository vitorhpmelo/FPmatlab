
j=1;
for i=1:NB
    
    if (DBAR.type(i)==2 | DBAR.type(i)==3)
        DBAR.teta(i)=DBAR.teta(i)+dx(j);
        j=j+1;
    end
end

for i=1:NB 
    if (DBAR.type(i)==3)
        DBAR.V(i)=DBAR.V(i)+dx(j);
        j=j+1;
    end
end

clear j;