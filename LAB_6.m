exp-06
clc;clear all;
% Parameters
SNRdB = 0:1:20; 
nBits = 1e6;    

BER = zeros(size(SNRdB));
PER = zeros(size(SNRdB));
Capacity = zeros(size(SNRdB));
Throughput = zeros(size(SNRdB));

for i = 1:length(SNRdB)
    txBits = randi([0, 1], 1, nBits);
    
    txSymbols = 2 * txBits - 1; 
 
    snr = 10^(SNRdB(i)/10);
    noisePower = 1 / snr;
    noise = sqrt(noisePower) * randn(size(txSymbols));
    rxSymbols = txSymbols + noise;
    
    
    rxBits = rxSymbols > 0; 
    
    
    bitErrors = sum(rxBits ~= txBits);
    packetErrors = sum(rxBits(1:nBits) ~= txBits(1:nBits));
    BER(i) = bitErrors / nBits;
    PER(i) = packetErrors / nBits;
    
    % Calculate channel capacity (Shannon capacity formula)
    Capacity(i) = log2(1 + snr);
    
    % Calculate throughput (bits per second)
    Throughput(i) = nBits / (1 + PER(i));
end

% Plot results
figure;
subplot(2, 2, 1);
plot(SNRdB, BER);
title('Bit Error Rate (BER) vs. SNR');
xlabel('SNR (dB)');
ylabel('BER');

subplot(2, 2, 2);
plot(SNRdB, PER);
title('Packet Error Rate (PER) vs. SNR');
xlabel('SNR (dB)');
ylabel('PER');

subplot(2, 2, 3);
plot(SNRdB, Capacity);
title('Channel Capacity vs. SNR');
xlabel('SNR (dB)');
ylabel('Capacity (bits/symbol)');

subplot(2, 2, 4);
plot(SNRdB, Throughput);
title('Throughput vs. SNR');
xlabel('SNR (dB)');
ylabel('Throughput (bits/second)');
