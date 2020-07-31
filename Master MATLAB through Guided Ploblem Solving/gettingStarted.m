%% this is a cell
% a simple line of code

4 + 5 % this is a comment

5*2/3 + ... comments
   (9-4)/17^2

%{
   he message of this lecture is that black holes ain’t as black as they’re painted. They aren’t the eternal prisons they were once thought. 
   Things can get out of a black hole both on the outside and possibly to another universe. 
   So, if you feel you are in a black hole, don’t give up;
   there’s a way out.
%}
%% this is another cell even simpler math

u = linspace(0,2*pi,1000);
v = linspace(-0.5,0.5,1000);
[u,v] = meshgrid(u,v);

x = (2+v.*cos(u/2)).*cos(u);
y = (2+v.*cos(u/2)).*sin(u);
z = v.*sin(u/4);

figure(1),clf
mesh(x,y,z)

%% 

%monthly income (post-tax)
income = 2500;

%list expenses
rent = 1200;
untis = 300;
car = 250;
food = 300;
phone = 50;
retirement = .1*income;

% total of expenditures
outflow = rent + untis + car + food + phone + retirement;

%amount left over for nonessential expenses
nonessentitals = income - outflow;

%how much can you spend per day?
perday = nonessentitals / 30;
disp(['I can spend ' num2str(perday) ' extra each day'])

% what if you spend twice as much during the weekend as during th week?
perweek = nonessentitals / (30/7);
inThirds = perweek / 3;
disp([ 'I can spend ' num2str(inThirds*2) ' during the weekend, and ' num2str(inThirds/5) ' each week day']);

