plot(randn(10,10))
%make a plot with a 10 randon graphics with 10 randon nunbers

get(gca)
%get all values of the corrent axis

get(gca,"YTick")
%get a expecific values of some property

set(gca,"YTick",[-3, 0, pi])
%there, you will set the value of the property

set(gca,'linewidth', 5)
%you change the width of the border

set(gca,'xlim', [3,6])
%you can set the point of the graphic that you want to see

ploth = plot(randn(9,1))

get(ploth)

set(ploth,'linewidth',2,'marker','s','markersize',10,'markerfacecolor','r')

tith = title('Cafés tomados')

set(tith,'String','Coffes that I have drink')

%% Guide
%it's just write:
guide
%to make a new guide