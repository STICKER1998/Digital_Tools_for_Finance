function []= Plot_QQ(r)
% plot the QQ plot of r
figure(2)
subplot(2,2,1);
qqplot(r(1,:));
xlabel("CSI-300");
ylabel("Probability");
title("Q-Q Plot");
subplot(2,2,2);
qqplot(r(2,:)); 
xlabel("CSI-ABI")
ylabel("Probability");
title("Q-Q Plot");
subplot(2,2,3);
qqplot(r(3,:));  
xlabel("Gold-ETF")
ylabel("Probability");
title("Q-Q Plot");
end