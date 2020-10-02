function [out] = dQV(g,b,bsh,bus,NB,k,l)
out=0;
if(k==l)
    %out=-2*bus(k).V*b(k);
   for i=1:NB
       if(k~=i)
       out=out-2*bus(k).V*(b(k,i)+bsh(k,i))+bus(i).V*(b(k,i)*cos(bus(k).teta-bus(i).teta)-g(k,i)*sin(bus(k).teta-bus(i).teta));
       end
   end
else
    out=bus(k).V*(b(k,l)*cos(bus(k).teta-bus(l).teta)-g(k,l)*sin(bus(k).teta-bus(l).teta));
end

end
