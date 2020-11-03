
[n,m]=size(DLIN);
g=zeros(NB,NB);
b=zeros(NB,NB);
bsh=zeros(NB,NB);
clear j;

for i=1:n
    
   g(DLIN.From(i),DLIN.To(i))=real(1/(DLIN.r(i)+j*DLIN.x(i)));
   b(DLIN.From(i),DLIN.To(i))=imag(1/(DLIN.r(i)+j*DLIN.x(i)));
   bsh(DLIN.From(i),DLIN.To(i))=DLIN.bsh(i);
    
end
g=g+g';
b=b+b';
bsh=bsh+bsh';


clear n,m;