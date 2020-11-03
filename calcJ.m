
J=zeros(nvar,nvar);
bus=table2struct(DBAR);
for i=1:nvar
    for j=1:nvar
       if i<=(NPV+NPQ)
           if j<=(NPV+NPQ)
           J(i,j)=dPteta(g,b,bsh,bus,NB,vK(i),vK(j));
           else
               J(i,j)=dPV(g,b,bsh,bus,NB,vK(i),vK(j));
           end
       else
           if j<=(NPV+NPQ)
           J(i,j)=dQteta(g,b,bsh,bus,NB,vK(i),vK(j));
           else
            J(i,j)=dQV(g,b,bsh,bus,NB,vK(i),vK(j)); 
           end  
       end
       
       
    end
end