function [out] = P(g,b,bsh,bus,NB,k)
out=0;
bus=table2struct(bus);
for l=1:NB
   if(l~=k)  
        out=out+(bus(k).V^2)*g(k,l)-bus(k).V*bus(l).V*(g(k,l)*cos(bus(k).teta-bus(l).teta)+b(k,l)*sin(bus(k).teta-bus(l).teta));
   end   
end   
end

