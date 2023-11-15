exp-02
clc;
clear all;
close all;
time=0:0.01:10;
N=10;
msg=[];
rand=randi([0,1],1,N);
for i=1:N
    if rand(i)==1
        msg=[msg,ones(1,1000)];
    else
        msg=[msg,zeros(1,1000)];
    end
end

prc=[];
d=N^2;
rand2=randi([0,1],1,N);
for i=1:N
    if rand2(i)==0
        prc=[prc,zeros(1,1000)];
    else
        prc=[prc,ones(1,1000)];
    end
end

prc1=[];  rand3=randi([0,1],1,d);
for i=1:d
    if rand3(i)==1
        prc1=[prc1,ones(1,1000)];
    else
        prc1=[prc1,zeros(1,1000)];
    end
end

c=xor(msg,prc);

subplot(3,2,1);
plot(time,msg);
title("Message signal");

subplot(3,2,2);
plot(time,abs(fft(msg)));
title("Message bits freq response");

subplot(3,2,3);
plot(time,prc);
title("Pseudo random code");

subplot(3,2,4);
plot(time,abs(fft(c)));
title("CDMA freq response");

subplot(3,2,5);
plot(time,c);
title("CDMA transmitter code");
