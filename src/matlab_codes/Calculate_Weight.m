function w = Calculate_Weight(r,type)
Loss = @(w) Calculate_Loss(r,w,type)*1e3;
w0=[1/3,1/3,1/3]';
tolx=1e-9;
options=optimoptions('fmincon','Display','none','OptimalityTolerance',tolx,'TolX',tolx,'Algorithm','sqp');
Aeq=[1,1,1];
beq=1;
lb=[0,0,0];
w=fmincon(Loss,w0,[],[],Aeq,beq,lb,[],[],options);
end