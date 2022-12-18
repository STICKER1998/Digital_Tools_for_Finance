function [Stat,Name]=Calculate_Statistics(r)  
% Calculate the statistics of r (return of assets)
MEAN=mean(r);  
STD=std(r);  
MID=median(r);  
UP=max(r);  
DOWN=min(r);  
KUR=kurtosis(r);  
SKEW=skewness(r);  
[JB,p]=jbtest(r);
Name=["Mean","Std","Median","Max","Min","Kurtosis","Skewness","J-B Test"];
Stat=[MEAN,STD,MID,UP,DOWN,KUR,SKEW,p];  
end  
