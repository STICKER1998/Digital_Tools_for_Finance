function Index = Calculate_Index(value,month_index)
% Calculate the index of models and assets
R=value(end)^((month_index(end)/5)/length(value))-1;
r=(value(2:end)-value(1:(end-1)))./value(1:(end-1));
sigma=std(r)*sqrt(month_index(end)/5);
Rf=0.03;
sharp=(R-Rf)/sigma;
DD=zeros(1,length(value));
for i=2:length(value)  
    DD(i)=max(max(value(1:i-1))-value(i),0);  
end  
MDD=max(DD);  
Index=[R,sigma,MDD,sharp];
end