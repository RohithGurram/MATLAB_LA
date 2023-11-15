
exp-04
clc;
clear all;
close all;
sig=2;
x=0:0.01:20;
f=x./(sig.^2).*exp(-x.^2)./(2*sig.^2);
y=sin(2*pi*1500*x);
subplot(3,1,1);
plot(x,y);
title("Rayleigh channel distribution");

for i=1:length(x)
    rxn=y.*f
end
subplot(3,1,2);
plot(x,rxn);
title("Received signal")
