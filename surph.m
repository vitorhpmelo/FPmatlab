[V1,V2]=meshgrid(0.8:0.01:1.1);
teta1=0;
teta2=-0.4507;
J=g(1,2)*(V1.^2+V2.^2-2*V1.*V2.*cos(teta1-teta2));
surf(V1,V2,J)
