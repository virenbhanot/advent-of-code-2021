%% ADVENT OF CODE
% DAY 1 PUZZLE

clc
clear

%% PART 1
% Count the number of times the depth measurement increases
A = table2array(readtable('input.txt'));
n = length(A);

nInc = 0;

for i = 2:n
	if A(i)>A(i-1)
		nInc = nInc+1;
	end
end
disp(nInc);

%% PART 2
% Three-window sliding measurement

k = 1;
S = zeros(n-2,1);

for i = 1:n-2
	S(k) = S(k) + A(i); % adding depths to get sums of 3
	S(k+1) = S(k+1) + A(i+1);
	S(k+2) = S(k+2) + A(i+2);
	if rem(i,3)==0
		k = k+3; % go to the next 3 sums-of-3 group
	end
end

nInc = 0;
for k = 2:length(S)
	if S(k)>S(k-1)
		nInc = nInc+1;
	end
end
disp(nInc);