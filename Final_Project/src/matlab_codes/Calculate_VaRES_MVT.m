function [VaR,ES] = Calculate_VaRES_MVT(w,r,alpha)
d = length(w);
T = size(r,2);
MMF_weight = ones(T,1)/T;
tol = 1e-9;
rep = 2000;
VaR = zeros(rep,1);
ES = zeros(rep,1);

parfor i=1:rep
    rng(2345+i);
    index = unidrnd(T, [T,1]);
    MC_sample = r(:,index);
    param_hat=M1_MMF(MC_sample,d,T,MMF_weight,tol);
    nu_hat=param_hat(1); mu_hat=param_hat(2:4); sigma_hat=vech(param_hat(5:10),1);
    mu_p = w'*mu_hat;
    sigma_p = sqrt(w'*sigma_hat*w);
    VaR01 = tinv(0.05 , nu_hat); % left tail quantile
    ES01=-tpdf(VaR01,nu_hat)/tcdf(VaR01,nu_hat) * (nu_hat+VaR01^2)/(nu_hat-1);
    VaR(i)= mu_p+sigma_p*VaR01;
    ES(i)=mu_p+sigma_p*ES01;
end
