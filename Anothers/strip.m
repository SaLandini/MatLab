u = linspace(0,2*pi,1000);
v = linspace(-0.5,0.5,1000);
[u,v] = meshgrid(u,v);

x = (4+v.*cos(u/4)).*cos(u);
y = (4+v.*cos(u/4)).*sin(u);
z = v.*sin(u/4);

figure(1),clf
mesh(x,y,z)
