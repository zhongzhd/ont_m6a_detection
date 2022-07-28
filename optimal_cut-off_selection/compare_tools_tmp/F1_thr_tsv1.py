#!/usr/bin/env python

import numpy as np
import math
from sklearn import metrics
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

Y,X1,=[],[]
for i in open(sys.argv[1],"r"):
	ele=i.rstrip().split()
	Y.append(int(ele[1]))
	if float(ele[2])==0:
		X1.append(1000)
	else:
		X1.append(-(math.log10(float(ele[2]))))
	X1.append(1-float(ele[2]))

y=np.array(Y)
x1=np.array(X1)

pr,rc,thr=metrics.precision_recall_curve(y,x1)
f1=2*pr*rc/(pr+rc)
fn=open(sys.argv[2],"w")
fn.writelines(["precision","\t","recall","\t","F1_score","\t","thresholds","\n"])
for i in range(len(pr)-1):
  fn.writelines([str(pr[i]),"\t",str(rc[i]),"\t",str(f1[i]),"\t",str(math.pow(10,-thr[i])),"\n"])
fn.writelines([str(pr[-1]),"\t",str(rc[-1]),"\t",str(f1[-1]),"\t",str(0),"\n"])
