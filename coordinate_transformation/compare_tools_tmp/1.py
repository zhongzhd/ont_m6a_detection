#!/usr/bin/env python

import sys

fn=open(sys.argv[2],"w")
a=""
b=""
c=""
d=1
e=""
f=""
g=""
h=""
i=""
j=1

for line in open(sys.argv[1],"r"):
	ele=line.rstrip().split()
	if(ele[6]==g):
		d=d+float(ele[3])*float(ele[9])
		j=j+float(ele[9])
	else:
		fn.writelines([a,"\t",b,"\t",c,"\t",str(d/j),"\t",e,"\t",f,"\t",g,"\t",h,"\t",i,"\t",str(j),"\n"])
		a=ele[0]
		b=ele[1]
		c=ele[2]
		d=float(ele[3])*float(ele[9])
		e=ele[4]
		f=ele[5]
		g=ele[6]
		h=ele[7]
		i=ele[8]
		j=float(ele[9])

fn.writelines([a,"\t",b,"\t",c,"\t",str(d/j),"\t",e,"\t",f,"\t",g,"\t",h,"\t",i,"\t",str(j),"\n"])
fn.close()

