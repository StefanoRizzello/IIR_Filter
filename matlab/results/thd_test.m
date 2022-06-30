clear all;
close all;
clc;

filename1= 'results_9bit.txt';
filename2= 'results_7bit.txt';
filename3= 'results_noopt.txt';
filename4= 'results_opt.txt';
delimiter= '\n';
headerlines = 1;

nb = 9;
A1=importdata(filename1,delimiter,headerlines);
A1.data(1)=0;
y1=A1.data./2^(nb-1);
B1=thd(y1,10e3,9)
figure(1)
thd(y1,10e3,9)

nb = 7;
A2=importdata(filename2,delimiter,headerlines);
A2.data(1)=0;
y2=A2.data./2^(nb-1);
B2=thd(y2,10e3,9)
figure(2)
thd(y2,10e3,9)

nb = 7;
A3=importdata(filename3,delimiter,headerlines);
A3.data(1)=0;
y3=A3.data./2^(nb-1);
B3=thd(y3,10e3,9)
figure(3)
thd(y3,10e3,9)

nb = 7;
A4=importdata(filename4,delimiter,headerlines);
A4.data(1)=0;
y4=A4.data./2^(nb-1);
B4=thd(y4,10e3,9)
figure(4)
thd(y4,10e3,9)