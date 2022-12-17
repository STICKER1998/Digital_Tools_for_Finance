import numpy as np
from scipy import optimize, stats
import math
from scipy.special import psi

def vech(M, ind):
    """
        Realize the switch between a vector/np.array and a symmetric matrix

        Parameters
        ----------
        ind: int
             if ind=1, transfer a vector to a symmetric matrix;
             if ind=0, transfer a symmetric matrix to a vector;

        M: Lists/np.array (ind=1)
            List of feature sizes, i.e.,
                [V[0,0],V[0,1],V[0,2],V[1,1],V[1,2],V[2,2]]
            np.matrix (ind=0)

        Returns
        -------
        V:np.matrix (ind=1)
        v:np.array (ind=0)
    """
    if ind == 1:
        n = int((np.sqrt(8 * len(M) + 1) - 1) / 2)
        V = np.zeros([n, n])
        start_index = 0
        end_index = 0
        for i in range(n):
            start_index = end_index
            end_index = end_index + n - i
            V[i, i:] = M[start_index:end_index]
            for j in range(i):
                V[i, j] = V[j, i]
        return V

    if ind == 0:
        n = np.size(M, 1)
        print(n)
        v = []
        for i in range(n):
            for j in range(i, n):
                v.append(M[i, j])
        return v


def MMF(x, d, n, w, tol):
    """
        Using MMF Method to estimate the parameters of Multivariate-t-distribution

        Parameters
        ----------
        x: np.array
            d * n the sample datas
        n,d: ind
            the dimension/number of sample datas
        w: np.array
            the weight for MMF
        tol: float
            the step tolerance of MMF

        Returns
        -------
        nu: np.array
            the degrees of freedom
        mu: np.array
            d * 1 the location paramter
        sigma: np.matrix
            d * d the covariance matrix
    """
    nu = np.array([2])
    mu = np.matrix(np.mean(x, 1)).T
    sigma = np.matrix(np.zeros([d, d]))
    x = np.matrix(x)
    for i in range(n):
        sigma = sigma + (x[:, i] - mu) * (x[:, i] - mu).T
    sigma = sigma / n

    delta = np.matrix(np.zeros([n, 1]))
    gam = np.matrix(np.zeros([n, 1]))
    done = 0
    while not done:
        for i in range(n):
            delta[i, 0] = ((x[:, i] - mu).T * sigma.I * (x[:, i] - mu))[0, 0]
            gam[i, 0] = (nu + d) / (nu + delta[i])

        mu0 = mu
        sigma0 = sigma
        nu0 = nu
        sigma = np.matrix(np.zeros([d, d]))
        mu = np.matrix(np.zeros([d, 1]))

        for i in range(n):
            mu[:, 0] = mu[:, 0] + (w[i, 0] * gam[i, 0] * x[:, i]) / (w.T * gam)

        for i in range(n):
            sigma = sigma + (w[i, 0] * gam[i, 0]) * ((x[:, i] - mu[:, 0]) * (x[:, i] - mu[:, 0]).T)
        sigma = sigma / (w.T * gam)

        def phi_fun(x):
            return psi(x) - np.log(x)

        def F_fun(x, d, w, nu0, delta, n):
            return np.abs(phi_fun(x / 2) - phi_fun((x + d) / 2) + (w.T * (
                        (nu0 + d) / (nu0 + delta) - np.log((nu0 + d) / (nu0 + delta)) - np.matrix(np.ones([n, 1]))))[
                0, 0])

        cons = ({'type': 'ineq', 'fun': lambda x: x - 1e-5})
        x0 = nu0
        temp = optimize.minimize(F_fun, x0, args=(d, w, nu0, delta, n), method='SLSQP', tol=1e-9, constraints=cons)
        nu = temp.x

        distance = np.sqrt(np.linalg.norm(mu - mu0) ** 2 + np.linalg.norm(sigma - sigma0) ** 2) / np.sqrt(
            np.linalg.norm(mu0) ** 2 + np.linalg.norm(sigma0) ** 2) + np.sqrt((np.log(nu) - np.log(nu0)) ** 2) / np.abs(
            np.log(nu0))

        if distance < tol:
            done = 1
    return nu, mu, sigma


def Calculate_RC(w, r, method):
    """
        Calculate the risk contribution for each assets

        Parameters
        ----------
        w: np.array
            d * 1 the weight of portfolios
        r: np.array
            d * n the daily returns of assets
        method: string
            "std": model based on std
            "VaR": model based on VaR
            "ES": model based on ES
        Returns
        -------
        RC: np.array
            d * 1 the risk contribution of assets
    """
    d = len(w)
    w = np.matrix(w)
    RC = []
    if method == 'std':
        sigma = np.matrix(np.cov(r))
        for i in range(d):
            RC.append(w[0, i] * ((w * sigma[i, :].T) / np.sqrt(w * sigma * (w.T)))[0, 0])

    if method == 'VaR':
        n = np.size(r, 1)
        MMF_weight = np.ones([n, 1]) / n
        tol = 1e-6
        [nu_hat, mu_hat, sigma_hat] = MMF(r, d, n, MMF_weight, tol)
        VaR01 = stats.t.ppf(0.05, nu_hat)[0]
        for i in range(d):
            RC.append(-w[0, i] * mu_hat[i, 0] - w[0, i] * ((w * sigma_hat[i, :].T) / np.sqrt(w * sigma_hat * (w.T)))[
                0, 0] * VaR01)

    if method == 'ES':
        n = np.size(r, 1)
        MMF_weight = np.ones([n, 1]) / n
        tol = 1e-6
        [nu_hat, mu_hat, sigma_hat] = MMF(r, d, n, MMF_weight, tol)
        VaR01 = stats.t.ppf(0.05, nu_hat)[0]
        ES01 = -stats.t.pdf(VaR01, nu_hat) / stats.t.cdf(VaR01, nu_hat) * (nu_hat + VaR01 ** 2) / (nu_hat - 1)[0]
        for i in range(d):
            RC.append(-w[0, i] * mu_hat[i, 0] - w[0, i] * ((w * sigma_hat[i, :].T) / np.sqrt(w * sigma_hat * (w.T)))[
                0, 0] * ES01)

    return RC


def Calculate_Loss(w, r, method):
    """
        Calculate the loss function for risk parity model (in order to
        make the risk contribution of each assets equal)

        Parameters
        ----------
        w: np.array
            d * 1 the weight of portfolios
        r: np.array
            d * n the daily returns of assets
        method: string
            "std": model based on std
            "VaR": model based on VaR
            "ES": model based on ES
        Returns
        -------
        Loss: np.array
    """
    RC = Calculate_RC(w, r, method)
    Loss = np.array([0])
    for i in range(len(RC) - 1):
        Loss = Loss + (RC[i + 1] - RC[i])**2
    Loss = Loss + (RC[0] - RC[len(RC) - 1])**2
    return Loss


def Calculate_Weight(r, method):
    """
        Calculate the weight of each assets from the model
        Parameters
        ----------
        r: np.array
            d * n the daily returns of assets
        method: string
            "std": model based on std
            "VaR": model based on VaR
            "ES": model based on ES
        Returns
        -------
         w: np.array
            d * 1 the weight of portfolios
    """
    w0 = np.array([1/3, 1/3, 1/3])
    cons = ({'type': 'eq', 'fun': lambda w: w[0] + w[1] + w[2] - 1})
    w = optimize.minimize(Calculate_Loss, w0, args=(r, method), method='SLSQP', tol=1e-20, constraints=cons,
                          bounds=((1e-3, 1), (1e-3, 1), (1e-3, 1)))
    return w.x


def Calculate_Net_Value(r):
    """
        Calculate the Net Value of portfolios/assets
        Parameters
        ----------
        r: np.array
            d * n the daily returns of assets
        Returns
        -------
         values: np.array
            d * n the net value of portfolios/assets
        """
    T = len(r)
    values = np.ones([T + 1, 1])
    for i in range(1, T + 1):
        values[i] = values[i - 1] * (1 + r[i - 1])
    return values

def Risk_Parity_Model(r, method, month_index):
    """
        Calculate the weight of each assets from the model
        Parameters
        ----------
        r: np.array
            d * n the daily returns of assets
        method: string
            "std": model based on std
            "VaR": model based on VaR
            "ES": model based on ES
        month_index:np.array
            19 * 1 store the index for changing the weight of each assets

        Returns
        -------
         values: np.array
            d * n the net value of portfolios/assets
         w_adjust: np.array
            d * n the weight of each assets for everyday
    """
    frequent = 19
    w = np.ones([3, frequent])
    for i in range(frequent):
        print("Process:",int((i+1)*100/19),"%")
        temp = Calculate_Weight(r[:, month_index[i * 3]:month_index[(i + 1) * 3]], method)
        for j in range(3):
            w[j, i] = temp[j]

    w_adjust = np.zeros([3, month_index[-1] - month_index[3]])
    for i in range(frequent):
        for j in range(month_index[3 + i * 3] - month_index[3], month_index[3 + (i + 1) * 3] - month_index[3]):
            w_adjust[:, j] = w[:, i]
    rp = sum(w_adjust * r[:, month_index[3]:month_index[-1]], 0)
    values = Calculate_Net_Value(rp)
    return w_adjust, values







