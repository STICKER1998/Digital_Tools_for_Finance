function [w_adjust,value]= Risk_Parity_Model(r,type,month_index)
frequent=19;
w = zeros(3,frequent);
parfor i=1:frequent
    w(:,i)=Calculate_Weight(r(:,month_index((i-1)*3+1):(month_index(i*3+1)-1)),type);
end

w_adjust=[];
for i=1:frequent-1
    w_adjust=[w_adjust,repmat(w(:,i),[1,(month_index((i+1)*3+1)-month_index(i*3+1))])];
end
i=frequent;
w_adjust=[w_adjust,repmat(w(:,i),[1,(month_index((i+1)*3+1)-month_index(i*3+1)+1)])];

% Calculate the Net worth of Portfolio
rp=w_adjust.*r(:,month_index(4):end);
rp=sum(rp,1);
Calculate_Net_Value(rp)
end
