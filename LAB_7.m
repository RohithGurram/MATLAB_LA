exp-07
% clc;
% clear all;
% close all;
% SNR_dB=15;
% SNR=10^(SNR_dB/10);
% channel=[0.8,-0.4,0.2];
% channeldelay=15;
% noisePower=1/(2*SNR);
% fs=1000;
% t=0:1/fs:1;
% f=10;
% tx_symbols=sin(2*pi*f*t);
% rx_signal=filter(channel,1,tx_symbols);
% received_signal=rx_signal+sqrt(noisePower)*randn(size(rx_signal));
% linear =filter(1,channel,received_signal);
% non_linear = abs(received_signal).^2;
% mu=0.01;
% w=zeros(1,channeldelay);
% %output=[];
% for n=channeldelay:length(received_signal)
%     x=received_signal(n:-1:n-channeldelay+1);
%     a=w.*x;
%     e=tx_symbols(n)-a;
%     w=w+2.*mu.*e.*x;
%     output(n)=a;
% end
% 
% subplot(5,1,1);
% plot(tx_symbols);
% title("Transmitted signal");
% 
% subplot(5,1,2);
% plot(t,received_signal);
% title("Received signal");
% 
% subplot(5,1,3);
% plot(t,linear);
% title("Linear equaliser");
% 
% subplot(5,1,4);
% plot(t,non_linear);
% title("Non-linear equaliser");
% 
% subplot(5,1,5);
% plot(t,output);
% title("Adaptive equaliser");

clc;
clear all;
close all;

% Define your input signal and received signal
time = 0.001:0.001:5;
input_signal = sin(2*pi*time); % Replace this with your input signal
received_signal = awgn(input_signal, 20); % Add some noise to simulate a real-world scenario

% Set the length of the adaptive filter (equalizer)
filter_length = 10;

% Initialize the filter coefficients
filter_coefficients = zeros(1, filter_length);

% Set the step size (learning rate) for the LMS algorithm
mu = 0.01;

% Create variables to store the output of the equalizer and the error signal
output_signal = zeros(size(input_signal));
error_signal = zeros(size(input_signal));

% Perform adaptive equalization
for n = filter_length:length(input_signal)
    
    % Extract a portion of the input signal for filtering
    x = input_signal(n-filter_length+1:n);
    
    % Compute the output of the equalizer
    y = filter_coefficients * x';
    
    % Compute the error signal (received - actual output)
    error = received_signal(n) - y;
    
    % Update the filter coefficients using the LMS update rule
    filter_coefficients = filter_coefficients + mu * error * x;
    
    % Store the output and error signals for analysis
    output_signal(n) = y;
    error_signal(n) = error;
end

% Plot the original input signal, received signal, and equalized output
figure;
subplot(3, 1, 1);
plot(time, input_signal);
title('Input Signal');

subplot(3, 1, 2);
plot(time, received_signal);
title('Recieved Signal (Equalizer Input)');

subplot(3, 1, 3);
plot(time, output_signal);
title('Equalized Output');

% Calculate and display the mean squared error
mean_squared_error = mean(error_signal.^2);
disp(['Mean Squared Error: ', num2str(mean_squared_error)]);
