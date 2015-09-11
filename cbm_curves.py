import pandas as pd
import numpy as np
from scipy.optimize import curve_fit

df = pd.read_csv('cabioage.csv')


def beta(data, pred='totage', resp='drybio_bole'):
    pmin = min(data[pred])
    pmax = max(data[pred])
    dmin = min(data[data[pred] == pmin][resp])
    dmax = max(data[data[pred] == pmax][resp])
    return ((dmax-dmin)/(pmax-pmin))/dmax


def fitBert(age, k, m, ap, bt):
    '''
    von Bertalanffy
    '''
    t = np.power(ap, (1-m))-bt*np.exp(-k*age)
    return np.power(age, (1/(1-t)))


def fitCR(age, a, b, k, m):
    return np.power(a*(1-b*np.exp(-k*age)), (1/(1-m)))

p0 = [1, 1, max(df.drybio_bole), beta(df)]



