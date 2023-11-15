exp-05
% Parameters
K = 100;       
N = 1000;     
SNRdB = 20;   


ricianChannel = comm.RicianChannel(...
    'SampleRate', 10e2, ...    
    'KFactor', K, ...          
    'PathDelays', [0], ...     
    'AveragePathGains', [0], ... 
    'MaximumDopplerShift', 2, ... 
    'PathGainsOutputPort', true, ... 
    'NormalizePathGains', true);  




%t = (0:1/fs:(N-1)/fs); % Time vector
t=0:0.01:10;
signal = cos(2 * pi* t)'; 

% Apply fading to the transmitted signal
[received_signal, pathGains] = ricianChannel(signal);

% Add AWGN noise to the received signal
SNR = 10^(SNRdB/10); 
noisePower = var(signal) / SNR;
received_signal = received_signal + sqrt(noisePower) * randn(size(received_signal));


figure;
subplot(3,1,1);
plot(t, abs(signal));
title('Transmitted Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, abs(received_signal));
title('Received Signal in Rician Fading Channel with AWGN');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t,(pathGains));
xlabel('Time(s)');
ylabel("Amplitude");
