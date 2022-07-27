#!/usr/bin/env python

import sys

fn=open(sys.argv[2],"w")
a=""
b=""
c=""
d=1
e=1
f=""
g=""
h=""
i=""


for line in open(sys.argv[1],"r"):
	ele=line.rstrip().split()
	if(ele[6]==g):
		if(d>float(ele[3])):
			d=float(ele[3])
			e=e+float(ele[4])
		else:
			e=e+float(ele[4])
	else:
		fn.writelines([a,"\t",b,"\t",c,"\t",str(d),"\t",str(e),"\t",f,"\t",g,"\t",h,"\t",i,"\n"])
		a=ele[0]
		b=ele[1]
		c=ele[2]
		d=float(ele[3])
		e=float(ele[4])
		f=ele[5]
		g=ele[6]
		h=ele[7]
		i=ele[8]

fn.writelines([a,"\t",b,"\t",c,"\t",str(d),"\t",str(e),"\t",f,"\t",g,"\t",h,"\t",i,"\n"])
fn.close()
