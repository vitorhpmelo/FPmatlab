function [out] = dPV(g,b,bsh,bus,NB,k,l)
out=0;
if(k==l)
   for i=1:NB
       if(k~=i)
       out=out+2*bus(k).V*g(k,i);
       out=out-bus(i).V*(g(k,i)*cos(bus(k).teta-bus(i).teta)+b(k,i)*sin(bus(k).teta-bus(i).teta));
       end
   end
else
    out=-bus(k).V*(g(k,l)*cos(bus(k).teta-bus(l).teta)+b(k,l)*sin(bus(k).teta-bus(l).teta));
end

end

