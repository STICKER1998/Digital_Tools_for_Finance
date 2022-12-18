function w = Calculate_Weight(r,type)
% Calculate the weights for three assets
Loss = @(x) Calculate_Loss(r,x,type)*1e3;
w0=[1/3,1/3,1/3]';
tolx=1e-9;
Aeq=[1,1,1];
beq=1;
lb=[0,0,0];
options=optimoptions('fmincon','Display','none','OptimalityTolerance',tolx,'TolX',tolx);
w =fmincon(Loss,w0,[],[],Aeq,beq,lb,[],[],options);
end