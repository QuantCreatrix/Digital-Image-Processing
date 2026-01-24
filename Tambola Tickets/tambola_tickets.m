%% Generating Tambola Tickets
% Anubhav Rathore
% Lab Assignment - 2

%% Defaults
close all;
clear all;
clc;

%% Variables and Constants
colCount = zeros(1,9);

%% to avoid all row being zero for a column

while any(colCount == 0)
    tickets = zeros(3,9);
    %% Making active rows
    for row = 1:3
        active_col = randperm(9,5); %Getting random row numbers
        tickets(row, active_col) = 1;
    end
    
    %% Generating Numbers following column-rule
    for col = 1:9
        active_row = find(tickets(:,col) == 1); %Finding row numbers for indexing
        count = length(active_row);
    
        if count > 0
            if col == 1
                low = 1;
                high = 9;
            elseif col == 9
                low = 80;
                high = 90;
            else
                low = (col-1)*10;
                high = (col*10)-1;
            end
        end
    
        nums = sort(randi([low high], 1, count));
        for k = 1:count
            tickets(active_row(k), col) = nums(k);
        end
    end
    
    colCount = sum(tickets ~= 0, 1);
end

%% Displaying tickets
fprintf('\n----- TAMBOLA TICKET -----\n\n');

for r = 1:3
    for c = 1:9
        if tickets(r,c) == 0
            fprintf('[  ]');        
        else
            fprintf('[%2d]', tickets(r,c)); 
        end
    end
    fprintf('\n');
end



