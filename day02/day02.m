%% ADVENT OF CODE - DAY 2
% Submarine depth evaluation

clc
clear
format long g

%% Part 1
hor = 0;
dep = 0;

A = readtable('input.txt','Delimiter','space');
D = string(table2array(A(:,1))); % direction
M = table2array(A(:,2)); % magnitude

for i = 1:length(M)
    if D(i)=="forward"
        hor = hor + M(i);
    elseif D(i)=="down"
        dep  = dep + M(i);
    elseif D(i)=="up"
        dep = dep - M(i);
    end
end
disp(dep*hor);

%% Part 2
aim = 0;
dep = 0;
hor = 0;

for i = 1:length(M)
    if D(i)=="forward"
        hor = hor + M(i);
        dep = dep + aim*M(i);
    elseif D(i)=="down"
        aim = aim + M(i);
    elseif D(i)=="up"
        aim = aim - M(i);
    end
end
disp(dep*hor);
