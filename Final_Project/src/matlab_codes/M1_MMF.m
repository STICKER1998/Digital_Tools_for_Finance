function param = M1_MMF(x,d,n,w,tol)
%------------Function-------------
% Multivariate Myriad Filter(MMF): Estimate the parameters of MVT 
%------------Input----------------
% x: Dataset (d*n matrix x=[x1,x2,...xn])
% w: Weight
% tol: The tolerance of each axis element
%------------Output---------------
% nu: The degrees of freedom
% mu: mean
% sigma: Covariance matrix
% real_tol: The estimation error of each axis element

% Initialize the parameters
nu=2;
mu=mean(x,2);
sigma=zeros(d,d);
for i=1:n
sigma = sigma+(x(:,i)-mu)*(x(:,i)-mu)';
end
sigma=sigma/n;
delta=zeros(n,1);
gam=zeros(n,1);
done=0;
while ~done
    for i=1:n
        delta(i)=(x(:,i)-mu)'*inv(sigma)*(x(:,i)-mu);
        gam(i)=(nu+d)/(nu+delta(i));
    end
    % Update the Parameters:mu,sigma,nu
    mu0=mu;sigma0=sigma;nu0=nu;

    sigma=zeros(d,d);
    mu=zeros(d,1);
    for i=1:n
        mu = mu+(w(i)*gam(i)*x(:,i))/sum(w.*gam);
    end
    for i=1:n
        sigma = sigma+(w(i)*gam(i)*(x(:,i)-mu)*(x(:,i)-mu)')/sum(w.*gam);
    end

    phi = @(y) psi(y)-log(y);
    F = @(y) abs(phi(y/2)-phi((y+d)/2)+sum(w.*((nu0+d)./(nu0+delta)-log((nu0+d)./(nu0+delta))-1)));
    % We can use fmincon or fzero to solve it
    A=[];b=[];
    lb=1;
    ub=10;
    tolx=1e-9;
    options=optimoptions('fmincon','Display','none','OptimalityTolerance',tolx,'TolX',tolx,'Algorithm','sqp');
    nu = fmincon(F,nu0,A,b,[],[],lb,ub,[],options);
    distance=sqrt(norm(mu-mu0)^2+norm(sigma-sigma0)^2)/sqrt(norm(mu0)^2+norm(sigma0)^2)+...
        sqrt((log(nu)-log(nu0))^2)/abs(log(nu0));
    if distance<tol 
        done=1;
        real_tol=distance;
    end
end
param=[nu;mu;vech(sigma)];
end