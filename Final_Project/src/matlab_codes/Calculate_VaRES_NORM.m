function [VaR,ES] = Calculate_VaRES_NORM(w,r,alpha)
d = length(w);
T = size(r,2);
rep = 2000;
VaR = zeros(rep,1);
ES = zeros(rep,1);

parfor i=1:rep
    rng(2345+i);
    index = unidrnd(T, [T,1]);
    MC_sample = r(:,index);
    mu_hat = mean(MC_sample,2);
    sigma_hat=cov(MC_sample');
    mu_p = w'*mu_hat;
    sigma_p = sqrt(w'*sigma_hat*w);
    VaR01 = norminv(alpha); % left tail quantile
    ES01=-1/alpha*normpdf(VaR01);
    VaR(i)= mu_p+sigma_p*VaR01;
    ES(i)=mu_p+sigma_p*ES01;
end