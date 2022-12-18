function []=Plot_Weight(w,month_index) 
t = tiledlayout('flow','TileSpacing','compact');
Name ={'CSI-300','CSI-ABI','Gold-ETF'};
for i=1:3
    w_temp=w((i-1)*3+1:3*i,:);
    nexttile
    area([w_temp(1,(month_index(4:end)-month_index(4)+1))',w_temp(2,(month_index(4:end)-month_index(4)+1))',w_temp(3,(month_index(4:end)-month_index(4)+1))'])  
    axis([1,19,0,1])  
    legend('CSI 300','CSI ABI','Gold ETF');  
    set(gca,'XTick', [2,4,6,8,10,12,14,16,18])   
    set(gca,'XTickLabel',{'15-07','16-01','16-09','17-01','17-09','18-01','18-09','19-01','19-09'});  
    xlabel('Allocation Point');    
    ylabel('Weight');      
end
h = legend('SCI-300','SCI-ABI','Gold ETF','fontname','Times New Roman');   
set(h,'Location','northwest','fontsize',12,'color','w','edgecolor','k','textcolor','k');   
h.Layout.Tile = 4;
end  