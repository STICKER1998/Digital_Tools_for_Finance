function [] = Plot_Pdf(r)  
T=size(r,2);
w=ones(T,1)/T;
tol=1e-30;

Name ={'Stock','Bond','Gold'};
for i=1:3
    figure(i);
    xmin = min(r(i,:));
    xmax = max(r(i,:));
    x=linspace(xmin,xmax,100);
    y=x; y2=x;
    % Using MMF Method to estimate the parameters of MVT
    param_hat= M1_MMF(r(i,:),1,T,w,tol);
    % Estimated pdf: MVT
    y=tpdf((x-param_hat(2))/sqrt(param_hat(3)),param_hat(1))/sqrt(param_hat(3));
    % Estimated pdf: Normal Distribution;
    y2=normpdf(x,mean(r(i,:)),std(r(i,:)));

    F1=histogram(r(i,:)',x,'Normalization','pdf');
    hold on;  
    F2=plot(x,y,'r','Linewidth',2);  
    hold on;
    F3=plot(x,y2,'b--','Linewidth',2);
    hold on;
    title(Name(i),'fontsize',10,'fontname','Times New Roman');           
    xlabel('x','fontsize',10,'fontname','Times New Roman');    
    ylabel('pdf','fontsize',10,'fontname','Times New Roman');           
    h = legend([F1,F2,F3],'Sample p.d.f','Estimated p.d.f','Norm p.d.f','fontname','Times New Roman');      
    set(h,'fontsize',12,'color','w','edgecolor','k','textcolor','k');   
end
end  

