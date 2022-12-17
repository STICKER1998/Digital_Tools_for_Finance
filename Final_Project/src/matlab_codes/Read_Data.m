function [r,date,month_index]= Read_Data()
% Read the Closing Price and Calculate the day return 
[Price,char]= xlsread("Orginal_Closing_Price.xlsx");
Price=Price';
r=(Price(:,2:end)-Price(:,1:end-1))./Price(:,1:end-1);

% Convert the time variable
char=char(3:end,1);
date=datetime(char);

% Find the indexes for each new months
month_index=ones(61,1);
k=1;
for i=1:length(date)-1
    if month(date(i)) ~= month(date(i+1))
        k=k+1;
        month_index(k)=i+1;
    end
end
month_index(end)=size(r,2);
end