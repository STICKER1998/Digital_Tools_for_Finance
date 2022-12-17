function RC = Calculate_RC(r,w,type)
d = length(w);
RC =zeros(d,1);
if type == 'std'
    sigma =cov(r');
    for i=1:d
        RC(i)= w(i)*w'*sigma(i,:)'/sqrt(w'*sigma*w);
    end
end

if type == 'VaR'
    r=-r;
    T=size(r,2);
    MMF_weight=ones(T,1)/T;
    tol=1e-9;
    rep=1;
    param_hat=M1_MMF(r,d,T,MMF_weight,tol);
    nu_hat=param_hat(1); mu_hat=param_hat(2:4);
    sigma_hat=vech(param_hat(5:10),1);
    VaR01 = tinv(0.05 , nu_hat); 
    for i=1:d
        RC(i)=-(w(i)*mu_hat(i)+w(i)*w'*sigma_hat(i,:)'/sqrt(w'*sigma_hat*w)*VaR01);
    end
end

if type == 'ESa'
    T=size(r,2);
    MMF_weight=ones(T,1)/T;
    tol=1e-9;
    rep=1;
    param_hat=M1_MMF(r,d,T,MMF_weight,tol);
    nu_hat=param_hat(1); mu_hat=param_hat(2:4);
    sigma_hat=vech(param_hat(5:10),1);
    VaR01 = tinv(0.05 , nu_hat); 
    ES01=-tpdf(VaR01,nu_hat)/tcdf(VaR01,nu_hat) * (nu_hat+VaR01^2)/(nu_hat-1);
    for i=1:d
    RC(i)=-(w(i)*mu_hat(i)+w(i)*w'*sigma_hat(i,:)'/sqrt(w'*sigma_hat*w)*ES01);
    end
end
end