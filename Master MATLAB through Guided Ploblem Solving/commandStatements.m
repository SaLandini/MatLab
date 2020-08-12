%%
%list dimentions
m = 8;

%intialize vartia
hilmat = zeros(m);
checkmat = zeros(m);

% now for loops
for i=1:m
    for j=1:m
        %denominator
        den = i+j-1;
        
        %and invert to find this element
        hilmat(i,j) = 1/den;
        
        %checkboard
        checkmat(i, j) = (-1)^den;
    end
end

%figure
figure(1), clf

subplot(121)
imagesc(hilmat)
axis square, title('Hilbert matrix')
set (gca,'xtick',[],'ytick',[])

subplot(122)
imagesc(checkmat)
axis square, title('Checkboard matrix')
set (gca,'xtick',[],'ytick',[])

%%
i = 0;

while i<5
    i=i+1;
    fprintf('%g ', i)
end
fprintf('\n')

i = 0;

while i<5
    fprintf('%g ', i)
    i=i+1;
end
fprintf('\n')

%%
m = 70;

%init matrix
outmat = zeros(m);
outmat2 = zeros(m);
%loop over rows and columns
for i=1:m
    for j=1:m
        %test wheter row index is less than colunm index
        if i<j
            outmat(i,j) = 1.03^sqrt(i*j);
        else
            outmat2(i,j) = 1.03^m - 1.03^sqrt(i*j);
        end
    end
end

outmat2 = outmat + outmat2

%figure
figure(2), clf

subplot(121)
imagesc(outmat)
axis square, title('Upper-triangular matrix')
set (gca,'xtick',[],'ytick',[],'clim', [0 1.03^m])

subplot(122)
imagesc(outmat2)
axis square, title('Upper-triangular matrix')
set (gca,'xtick',[],'ytick',[],'clim', [0 1.03^m])

%%

thresh = exp(-10);
[currval, startval] = deal(10);

%number of repetitions
nRep = 100;

%decay process
decayvar = nan(nRep, 1000);

for repi=1:nRep
    %reset the current value to original value
    counter = 0;

    %reset counter
    currval = startval;
    
    %stay in loop as long as true
    while currval>thresh
        %init counter
        counter = counter+1;
        
        %decrease target by randon fraction ([0 1])
        currval = currval * rand^(1/2);
        
        %update decay variable
        decayvar(repi, counter+1) =  currval;
    end
end
%plot
figure(3), clf
plot(nanmean(decayvar,1), 'ks-', 'linew',2,'markersize',15,'markerfacecolor','w')
xlabel('Iterations'), ylabel('Value')
title([num2str(counter) 'interations until threshold'])

%%
%"A" is the year
A = 0;

%formula
day1Jan = mod(1 +5*mod(A-1,4) + 4 * mod(A-1,100) + 6*mod(A-1,400), 7);

%match taht the correct string
switch day1Jan
    case 0, day = 'Sunday';
    case 1, day = 'Monday';
    case 2, day = 'Tuesday';
    case 3, day = 'Wednesday';
    case 4, day = 'Thursday';
    case 5, day = 'Friday';
    case 6, day = 'Saturday';
end

%find this year
thisYear = clock;
thisYear = thisYear(1);

if A>thisYear
    fprintf('1 January %g will be a %s\n',A,day);
else
    fprintf('1 January %g was a %s\n',A,day);
end