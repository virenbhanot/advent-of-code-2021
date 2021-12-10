%% DAY 03: BINARY DIAGNOSTICS
clc
clear

%% PART 1
% SUBMARINE POWER CONSUMPTION
fid = fopen('input.txt');
A = textscan(fid,'%s%s','CollectOutput',1); % Format: A{1}{1,1}(1) to get first element of first string
fclose(fid);

% convert stupid textscan format to sensible string array
n = length(A{:});
B = strings(n,1);
for i = 1:n
	B(i) = A{:}{i,1};
end

[E,G] = getGammaEpsilon(B,1);
fprintf('Epsilon rate: %d\n',bin2dec(E));
fprintf('Gamma rate: %d\n',bin2dec(G));
fprintf('Power consumption: %d\n',bin2dec(E)*bin2dec(G));



%% PART 2
% LIFE SUPPORT RATING
% B = ["00100";"11110";"10110";"10111";"10101";"01111";"00111";"11100";"10000";"11001";"00010";"01010"];
C = B; % copy for the CO2 rating
nums = length(B);
j = 1; % bit counter
while nums>1
	[E,~] = getGammaEpsilon(B,1); % get most and least common bit
	bit = E(j);
	i = 1;
	while i<=length(B)
		if B{i}(j)~=bit
			B(i) = [];
		else
			i = i+1;
		end
	end
	j = j+1;
	nums = length(B);
end

nums = length(C);
j = 1;
while nums>1
	[E,~] = getGammaEpsilon(C,0); % get most commont bit
	bit = E(j);
	i = 1;
	while i<=length(C)
		if C{i}(j)==bit
			C(i) = [];
		else
			i = i+1;
		end
	end
	j = j+1;
	nums = length(C);
end

fprintf('Oxygen rate: %d\n',bin2dec(B));
fprintf('CO2 scrubber rate: %d\n',bin2dec(C));
fprintf('Life support rate: %d\n',bin2dec(B)*bin2dec(C));


%% GAMMA AND EPSILON RATES
function [E,G] = getGammaEpsilon(B)
n = length(B);
s = strlength(B(1));
O = zeros(s,1); % Count ones
Z = zeros(s,1); % Count zeros

% Count ones and zeros
for i = 1:n
    for j = 1:s
        if B{i}(j)=='1' % how to parse a string by character
            O(j) = O(j)+1;
        elseif B{i}(j)=='0'
            Z(j) = Z(j)+1;
        end
    end
end
% Calculate most common ones
for j = 1:s
    if O(j)>=Z(j)
        E(j) = '1'; % Epsilon rate
        G(j) = '0'; % Gamma rate
	elseif O(j)<Z(j)
        E(j) = '0';
        G(j) = '1';
     end
end
end