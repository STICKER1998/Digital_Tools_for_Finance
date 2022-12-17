[r,date,month_index] = Read_Data();

% Plot the daily return of stock, bond and gold ETF and the Correlation
% Matrix (heatmap)
% Plot_Pdf(r)  

% Compare the true ES,VaR with the estimated ES,VaR based on MVT and
% Guassian distribution
% w=[1/3,1/3,1/3]';
% alpha = 0.05;
% r_p = w'*r;
% real_VaR = quantile(r_p, alpha);
% temp = r_p(r_p<=real_VaR); 
% real_ES = mean(temp);

% [VaR,ES] = Calculate_VaRES_MVT(w,r,alpha);
% disp_1=[(VaR-real_VaR),(ES-real_ES)];
% mean(VaR)
% mean(ES)

% figure(1);
% [VaR,ES] = Calculate_VaRES_NORM(w,r,alpha);
% mean(VaR)
% mean(ES)
% disp_2=[VaR-real_VaR,ES-real_ES];
% disp=[disp_1,disp_2];
% boxplot(disp,{'VaR_MVT','ES_MVT','VaR_Norm','ES_Norm'});


% Calculate the Net Value of Three Portfolio
[w_std,value_std]=Risk_Parity_Model(r,'std',month_index);
[w_VaR,value_VaR]=Risk_Parity_Model(r,'VaR',month_index);
[w_ES,value_ES]=Risk_Parity_Model(r,'ESa',month_index);

Interval=1:1162;
plot(Interval,value_1,Interval,value_2,Interval,value_3);
legend({'std','VaR','ES'});

rs=r(1,month_index(4):end);
value_4=Calculate_Net_Value(rs);

