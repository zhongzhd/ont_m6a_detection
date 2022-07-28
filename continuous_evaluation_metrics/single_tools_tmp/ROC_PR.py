#!/usr/bin/env python

import numpy as np
import math
from sklearn import metrics
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

Y,X1,X2,X3,X4,X5,X6=[],[],[],[],[],[],[]
for i in open("id_label_pred.txt","r"):
	ele=i.rstrip().split()
	Y.append(int(ele[1]))
	X1.append(float(ele[2]))
	X2.append(float(ele[3]))
	X3.append(float(ele[4]))
	X4.append(float(ele[5]))
	if float(ele[6])==0:
		X5.append(1000)
	else:
		X5.append(-(math.log10(float(ele[6]))))
	X6.append(float(ele[7]))

y=np.array(Y)
x1=np.array(X1)
x2=np.array(X2)
x3=np.array(X3)
x4=np.array(X4)
x5=np.array(X5)
x6=np.array(X6)

fpr1,tpr1,threshold1=metrics.roc_curve(y,x1)
fpr2,tpr2,threshold2=metrics.roc_curve(y,x2)
fpr3,tpr3,threshold3=metrics.roc_curve(y,x3)
fpr4,tpr4,threshold4=metrics.roc_curve(y,x4)
fpr5,tpr5,threshold5=metrics.roc_curve(y,x5)
fpr6,tpr6,threshold6=metrics.roc_curve(y,x6)

auc1=metrics.auc(fpr1,tpr1)
auc2=metrics.auc(fpr2,tpr2)
auc3=metrics.auc(fpr3,tpr3)
auc4=metrics.auc(fpr4,tpr4)
auc5=metrics.auc(fpr5,tpr5)
auc6=metrics.auc(fpr6,tpr6)

fig = plt.figure(figsize=[6.4,6.4])
ax = fig.add_subplot()
ax.set_title('ROC curve')
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.plot(fpr1,tpr1,color="red",label='Tombo (AUC = %0.2f)' % auc1)
plt.plot(fpr2,tpr2,color="orange",label='MINES (AUC = %0.2f)' % auc2)
plt.plot(fpr3,tpr3,color="yellow",label='Nanom6A (AUC = %0.2f)' % auc3)
plt.plot(fpr4,tpr4,color="green",label='m6Anet (AUC = %0.2f)' % auc4)
plt.plot(fpr5,tpr5,color="blue",label='ELIGOS (AUC = %0.2f)' % auc5)
plt.plot(fpr6,tpr6,color="purple",label='Epinano (AUC = %0.2f)' % auc6)
plt.plot([0, 1], [0, 1], 'k--')
plt.legend(fontsize="small",frameon=False)
plt.savefig("ROC.pdf")

pr1,rc1,threshold1=metrics.precision_recall_curve(y,x1)
pr2,rc2,threshold2=metrics.precision_recall_curve(y,x2)
pr3,rc3,threshold3=metrics.precision_recall_curve(y,x3)
pr4,rc4,threshold4=metrics.precision_recall_curve(y,x4)
pr5,rc5,threshold5=metrics.precision_recall_curve(y,x5)
pr6,rc6,threshold6=metrics.precision_recall_curve(y,x6)

prauc1=metrics.auc(rc1,pr1)
prauc2=metrics.auc(rc2,pr2)
prauc3=metrics.auc(rc3,pr3)
prauc4=metrics.auc(rc4,pr4)
prauc5=metrics.auc(rc5,pr5)
prauc6=metrics.auc(rc6,pr6)

fig = plt.figure(figsize=[6.4,6.4])
ax = fig.add_subplot()
ax.set_title('PR curve')
plt.xlabel('Recall')
plt.ylabel('Precision')
plt.plot(rc1,pr1,color="red",label='Tombo (AUC = %0.2f)' % prauc1)
plt.plot(rc2,pr2,color="orange",label='MINES (AUC = %0.2f)' % prauc2)
plt.plot(rc3,pr3,color="yellow",label='Nanom6A (AUC = %0.2f)' % prauc3)
plt.plot(rc4,pr4,color="green",label='m6Anet (AUC = %0.2f)' % prauc4)
plt.plot(rc5,pr5,color="blue",label='ELIGOS (AUC = %0.2f)' % prauc5)
plt.plot(rc6,pr6,color="purple",label='Epinano (AUC = %0.2f)' % prauc6)
plt.plot([0, 1], [0, 1], 'k--')
plt.legend(fontsize="small",frameon=False)
plt.savefig("PR.pdf")

