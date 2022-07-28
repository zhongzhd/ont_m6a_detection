#!/usr/bin/env python

import numpy as np
import math
from sklearn import metrics
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

input=sys.argv[1]
if input!= "ELIGOS_id_label_pred.txt":
  Y,X1=[],[]
  for i in open(input,"r"):
	  ele=i.rstrip().split()
	  Y.append(int(ele[1]))
	  X1.append(float(ele[2]))
else:
  Y,X1=[],[]
  for i in open(input,"r"):
	  ele=i.rstrip().split()
	  Y.append(int(ele[1]))
	  if float(ele[2])==0:
		  X1.append(1000)
	  else:
		  X1.append(-(math.log10(float(ele[2]))))

y=np.array(Y)
x1=np.array(X1)

def return_best_thr0(label,value,out_file):
	pr,rc,thr=metrics.precision_recall_curve(label,value)
	f1=2*pr*rc/(pr+rc)
	fn=open(out_file,"w")
	fn.writelines(["precision","\t","recall","\t","F1_score","\t","thresholds","\n"])
	for i in range(len(pr)-1):
		fn.writelines([str(pr[i]),"\t",str(rc[i]),"\t",str(f1[i]),"\t",str(thr[i]),"\n"])
	fn.writelines([str(pr[-1]),"\t",str(rc[-1]),"\t",str(f1[-1]),"\t",str(1),"\n"])

def return_best_thr1(label,value,out_file):
  pr,rc,thr=metrics.precision_recall_curve(label,value)
  f1=2*pr*rc/(pr+rc)
  fn=open(out_file,"w")
  fn.writelines(["precision","\t","recall","\t","F1_score","\t","thresholds","\n"])
  for i in range(len(pr)-1):
    fn.writelines([str(pr[i]),"\t",str(rc[i]),"\t",str(f1[i]),"\t",str(math.pow(10,-thr[i])),"\n"])
  fn.writelines([str(pr[-1]),"\t",str(rc[-1]),"\t",str(f1[-1]),"\t",str(0),"\n"])

if input!= "ELIGOS_id_label_pred.txt":
  return_best_thr0(y,x1,sys.argv[2])
else:
  return_best_thr1(y,x1,sys.argv[2])
