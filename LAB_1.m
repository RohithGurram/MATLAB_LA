exp-01
Tb=1;
N=10;
fc=5;
time=0:0.001:N*Tb;
Tc=0:0.001:Tb;
c=sqrt(2/Tb).*sin(2*pi*fc*Tc);
m=randi([0,1],1,N);
mod=0;
message=0;
for i=1:N
    if m(i)==1
        message=[message,ones(1,1000)];
        mod=[mod,c];
    else
        message=[message,zeros(1,1000)];
        mod=[mod,c];
    end
end

subplot(4,1,1);
plot(time,message);
title("Message signal");

subplot(4,1,2);
plot(Tc,c);
title("Carrier signal");

subplot(4,1,3);
plot(mod);
title("PSK modulated signal");

subplot(4,1,4);
plot(abs(fft(mod)));
title("Freq domain");
