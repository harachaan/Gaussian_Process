#!/usr/local/bin/python
#
#    plotting two-dimensional Gaussian distribution.
#    $Id: gauss2.py,v 1.3 2018/04/07 14:19:00 daichi Exp $
#
import sys
import putil
import numpy as np
import mpl_toolkits.mplot3d.axes3d as axes3d
from pylab import *

[xmin,xmax] = [-4,4]

def gauss2 (x):
    return exp (lgauss2(x))

def lgauss2 (x):
    D = len(x)
    return - dot(x,x) / 2 - log (2 * pi) * D / 2

def plot_gauss2 (N=25):
    ax = figure().gca (projection='3d')
    xx = np.linspace (xmin, xmax, N)
    X,Y = np.meshgrid (xx,xx)
    Z = np.array ([gauss2([x,y]) for x in xx for y in xx]).reshape (N,N)
    # plot
    putil.simple3d (ax)
    ax.set_aspect (0.6)
    ax.view_init (55,-110)
    ax.tick_params (axis='x',pad=2)
    ax.tick_params (axis='y',pad=2)    
    ax.set_zticks (arange(0,0.2,0.05))
    ax.set_xlabel (r'$x_1$',labelpad=16)
    ax.set_ylabel (r'$x_2$',labelpad=10)
    ax.set_zlabel (r'$N(x)$',labelpad=17)
    ax.w_zaxis.set_pane_color ((1,1,1,1))
    ax.plot_surface (X,Y,Z,cmap='jet',shade=True,
                     linewidth=0.3,edgecolor='black')

def main ():
    plot_gauss2 ()
    if len(sys.argv) > 1:
        tight_layout ()
        savefig (sys.argv[1])
    show ()
    
if __name__ == "__main__":
    main ()