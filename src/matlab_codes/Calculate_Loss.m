function Loss = Calculate_Loss(r,w,type)
RC = Calculate_RC(r,w,type);
Loss = 0;
for i=1:length(RC)-1
    Loss= Loss+(RC(i+1)-RC(i))^2;
end
Loss = Loss+(RC(1)-RC(length(RC)))^2;
end