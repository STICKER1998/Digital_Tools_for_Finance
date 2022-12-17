function value = Calculate_Net_Value(r)
T=length(r);
value=ones(1,T+1);
for i=2:T+1
    value(i)=value(i-1)*(1+r(i-1));
end
value=value(2:end);
end