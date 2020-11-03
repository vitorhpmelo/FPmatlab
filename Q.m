function [out] = Q(g,b,bsh,bus,NB,k)
bus=table2struct(bus);
out=0;
for l=1:NB
   if(l~=k)  
    out=out-(bus(k).V^2)*(b(k,l)+bsh(k,l));
    aux=(b(k,l)*cos(bus(k).teta-bus(l).teta));
    aux2=(g(k,l)*sin(bus(k).teta-bus(l).teta));
    
    out=out+bus(k).V*bus(l).V*(aux-aux2);
   end   
end   
end
