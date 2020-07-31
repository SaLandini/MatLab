
%%

% a row vector using square brackets
vectR = [ 1 2 3 4 3 2 1 0 -999];

% a column vector using semincolons
vectC = [ 2; 4; 2; 1; 0 ];

% a column vector by transposing a row vector
vect = [ 1 2 3 4 3 2 1 0]'; %#ok<NASGU>
vect = transpose([1 2 3 4 5 6 7]);

% a 2x3 matrix
matr1 = [1 2 3; 3 2 1];

matr2 = [1 3; 3 1];

% transpose a 3x2
matr = [1 2; 3 3; 2 1];

% make a row of vector of ones
onesvect = [1 1 1 1 1 1];
onesvector = ones(1, 102);

%column vector of .25
vect3 = [.25; .25; .25];
vect4 = ones(8,1)*.25;
vect5 = zeros(8,1)+.25;

% matrix of randon numbers
matr = randn(12,21);

%%

wholetext = 'Hello my friend, Mikes like purple';

%separete into a cell array based on spaces
wordsep = regexp(wholetext,' ', 'split')

%remove any words if have exactly 4 chracters
numchars = cellfun(@length, wordsep)
word2keep = numchars ~= 4;
wordsep2 = wordsep(word2keep)

% replace 'Mike' and 'Purple' for another names
targname = 'Mikes'
targscolor = 'purple'

namestart = strfind(wholetext, targname)
colorstart = strfind(wholetext, targscolor)

newtex = [ wholetext(1:namestart-1) 'Ricardo' ... next line
    wholetext(namestart+length(targname):colorstart - 1) 'Roxo He4rt'];

%% 

% generate some random numbers and characters
N = 20; %20 number/chracter pairs
numbers = randn(N,1);
tmptext = char(50 + randi(70, N, 1));

%clear the screen
clc

%html code for header
disp('<html>')
disp('<body>')
disp('<table>')

%loop over elements and print
for ri=1:N
    disp([' <tr><td>' num2str(numbers(ri)) '</td><td>' tmptext(ri) '</td><td>'])
end

%close html
fprintf('</table>\n</body>\n</html>\n');

%%

pi;
format long
numdig = 200;

result = round(pi*10^numdig)/10^numdig;

disp(['Pi to ' num2str(numdig) ' significant digits is ' num2str(result)])

%%

%get information about all file/folders
everything = dir;

% name of alll folders
foldernames = {everything([everything.isdir]).name};

%filename length
file_names = cellfun(@length, foldernames)

%use selective query to extract filenames with *vatiab*
somethings = dir('*variab*')