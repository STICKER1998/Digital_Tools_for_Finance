% read data
FILEPATH = "C:\Users\TANGZIFENG\Desktop\dtff-final";
[r,date,month_index] = Read_Data(FILEPATH);

% Plot the figure of assets'return: figure1
Plot_Return(r,month_index);

% Calculate the statistics of r
[Stat_Stock,Name]=Calculate_Statistics(r(1,:));
Stat_Bond=Calculate_Statistics(r(2,:));
Stat_Gold=Calculate_Statistics(r(3,:));
Stat=[Stat_Stock;Stat_Bond;Stat_Gold];

% Plot the Q-Q plot: figure2
Plot_QQ(r)

% Calculate the Parameters for MVT 
d=size(r,1);
n=size(r,2);
weight_MMF=ones(n,1)/n;
tol=1e-6;
param=M1_MMF(r,d,n,weight_MMF,tol);
nu_hat=param(1);
mu_hat=param(2:4);
sigma_hat=vech(param(5:end),1);


% Plot the p.d.f of assets: figure3
Plot_Pdf(r);

% Monte Carlo Methods:Compare the true ES,VaR with the estimated ES,VaR
% based on MVT and Normal Distribution
w=[1/3,1/3,1/3]';
alpha = 0.05;
r_p = w'*r;
VaR = quantile(r_p, alpha);
temp = r_p(r_p<=VaR); 
ES = mean(temp);

[VaR_MVT,ES_MVT] = Calculate_VaRES_MVT(w,r,alpha);
mean(VaR_MVT);mean(ES_MVT);
[VaR_Norm,ES_Norm] = Calculate_VaRES_NORM(w,r,alpha);
mean(VaR_Norm);mean(ES_Norm);
disp=[VaR_MVT-VaR,ES_MVT-ES,VaR_Norm-VaR,ES_Norm-ES];

figure(4);
boxplot(disp,{'VaR(MVT)','ES(MVT)','VaR(Normal)','ES(Normal)'});
hold on;
yline(0,'Color','black','LineStyle','--')
ylabel("Estimate Error");


% Calculate the Net Value, weights and index of Three Portfolio
[w_std,value_std]=Risk_Parity_Model(r,1,month_index);
[w_VaR,value_VaR]=Risk_Parity_Model(r,2,month_index);
[w_ES,value_ES]=Risk_Parity_Model(r,3,month_index);
Index_std=Calculate_Index(value_std,month_index);
Index_VaR=Calculate_Index(value_VaR,month_index);
Index_ES=Calculate_Index(value_ES,month_index);
Index_Stock=Calculate_Index(Calculate_Net_Value(r(1,month_index(4):end)),month_index);
Index_Bond=Calculate_Index(Calculate_Net_Value(r(2,month_index(4):end)),month_index);
Index_Gold=Calculate_Index(Calculate_Net_Value(r(3,month_index(4):end)),month_index);
Index=[Index_std;Index_VaR;Index_ES;Index_Stock;Index_Bond;Index_Gold];
rowname=["Index","std_Model","VaR_Model","ES_Model","CSI_300","CSI_ABI","GOLD_ETF"]';
colname=["Annualized rate of return","Standard Deviation","Maximum Drawdown","Sharp Ratio"];
table_index=[colname;Index];
table_index=[rowname,table_index];
xlswrite(FILEPATH+"\data\result\matlab\Index.xlsx",table_index)
% Export  weights and values
name=["Time","std_Model","VaR_Model","ES_Model"];
xlswrite(FILEPATH+"\data\result\matlab\values.xlsx",[name;string(date(month_index(4):end)),value_std',value_VaR',value_ES']);
xlswrite(FILEPATH+"\data\result\matlab\weight_stock.xlsx",[name;string(date(month_index(4):end)),w_std(1,:)',w_VaR(1,:)',w_ES(1,:)']);
xlswrite(FILEPATH+"\data\result\matlab\weight_bond.xlsx",[name;string(date(month_index(4):end)),w_std(2,:)',w_VaR(2,:)',w_ES(2,:)']);
xlswrite(FILEPATH+"\data\result\matlab\weight_gold.xlsx",[name;string(date(month_index(4):end)),w_std(3,:)',w_VaR(3,:)',w_ES(3,:)']);

w_total=[w_std;w_VaR;w_ES];
% Plot the weights for three models
Plot_Weight(w_total,month_index); 
