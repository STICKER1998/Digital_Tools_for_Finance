function []= Plot_Return(r,month_index)
% Plot the return of Stock, Bond, Gold from 2015-2019
figure(1);
x=1:month_index(61);
subplot(2,2,1);
plot(x,r(1,:));
axis([0,month_index(61),-inf,inf]);  
xlabel('Year','fontsize',10,'FontName','Times New Roman');    
ylabel('Stock','fontsize',10,'fontname','Times New Roman');
set(gca,'XTick', [month_index(1),month_index(13),month_index(25),month_index(37),month_index(49),month_index(61)])   
set(gca,'XTickLabel',{'2015','2016','2017','2018','2019','2020'});  

subplot(2,2,2);
plot(x,r(2,:));
axis([0,month_index(61),-inf,inf]);  
xlabel('Year','fontsize',10,'fontname','Times New Roman');    
ylabel('Bond','fontsize',10,'fontname','Times New Roman');
set(gca,'XTick', [month_index(1),month_index(13),month_index(25),month_index(37),month_index(49),month_index(61)])   
set(gca,'XTickLabel',{'2015','2016','2017','2018','2019','2020'});  

subplot(2,2,3);
plot(x,r(3,:));
axis([0,month_index(61),-inf,inf]);  
xlabel('Year','fontsize',10,'fontname','Times New Roman');    
ylabel('Gold ETF','fontsize',10,'fontname','Times New Roman');
set(gca,'XTick', [month_index(1),month_index(13),month_index(25),month_index(37),month_index(49),month_index(61)])   
set(gca,'XTickLabel',{'2015','2016','2017','2018','2019','2020'});  

% Plot the Corrlation Matrix of their returns
subplot(2,2,4);
label={'Stock','Bond','Gold'};
h=heatmap(label,label,corr(r'));
end