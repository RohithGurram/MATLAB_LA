exp-03
clc;
clear all;
close all;
pr=[];
d=0:0.1:10;
pl=[];
ht=7.5;
hr=2.5;
pt=10;
gt=0.8;
gr=0.9;
k=pt.*gr.*gt.*(ht^2).*(hr^2);
for i=1:length(d)
    pr(i)=k/d(i)^4;
    pl(i)=10*log(pt/pr(i));
end

subplot(2,1,1);
plot(d,pr);
title("Received power vs Distance");

subplot(2,1,2);
plot(d,pl);
title("Path loss vs Distance");
