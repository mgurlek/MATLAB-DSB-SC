% EHM3131 Communication 1 - Final Project Simulation

%% Step 1: Parameters
fm = 50;                % Message signal frequency (Hz)
Am = 1

fc = 500;               % Carrier frequency (Hz)
Ac = 10

fs = 10000;             % Sampling frequency (Hz)

t = 0:1/fs:0.1;         % Time vector (0 to 0.1 seconds)

%% Step 2: DSB-SC Modulation
m = Am * cos(2*pi*fm*t);     % Baseband message signal m(t)

c =Ac * cos(2*pi*fc*t);     % Carrier signal c(t)

s = m .* c;             % DSB-SC modulated signal s(t)

%% Step 3: Channel
SNR1  = 10;               % Signal-to-Noise Ratio in dB
SNR2 = 15;
SNR3 = 3;
r1 = awgn(s, SNR1, 'measured'); % Adding AWGN to the signal
r2 = awgn(s, SNR2, 'measured'); % Adding AWGN to the signal
r3 = awgn(s, SNR3, 'measured'); % Adding AWGN to the signal


%% Step 3: Channel (AWGN Addition for Multiple SNRs)
% Purpose: Simulate a realistic communication channel with different noise levels.
% Input: Modulated signal (s), SNR values (15, 10, 3 dB).
% Output: Received noisy signals (r1, r2, r3).
SNR1 = 15;               % Good channel conditions
SNR2 = 10;               % Moderate channel conditions
SNR3 = 3;                % Poor channel conditions

r1 = awgn(s, SNR1, 'measured'); % Signal with 15 dB SNR
r2 = awgn(s, SNR2, 'measured'); % Signal with 10 dB SNR
r3 = awgn(s, SNR3, 'measured'); % Signal with 3 dB SNR

%% Step 4: Coherent Demodulation
% Purpose: Recover the original message from the noisy received signals.
% Input: Received signals (r1, r2, r3), Carrier signal (c).
% Output: Recovered message signals (m_rec1, m_rec2, m_rec3).

% Filter Design (Calculated once)
fCutoff = 100;          % Cutoff frequency slightly above fm
[b, a] = butter(5, fCutoff/(fs/2)); % 5th-order Butterworth filter

% Demodulation for SNR1 (15 dB)
v1 = r1 .* c;             
m_rec1 = filtfilt(b, a, v1);
m_rec1 = m_rec1 * (2 / (Ac^2)); % Amplitude correction

% Demodulation for SNR2 (10 dB)
v2 = r2 .* c;             
m_rec2 = filtfilt(b, a, v2);
m_rec2 = m_rec2 * (2 / (Ac^2)); % Amplitude correction

% Demodulation for SNR3 (3 dB)
v3 = r3 .* c;             
m_rec3 = filtfilt(b, a, v3);
m_rec3 = m_rec3 * (2 / (Ac^2)); % Amplitude correction

%% Step 5: Spectral Analysis (FFT)
% Purpose: Compute the frequency-domain spectra for comparison.
N = length(t);
f = (-N/2:N/2-1)*(fs/N); % Frequency vector

% Base signals
M_f = abs(fftshift(fft(m)))/N;
S_f = abs(fftshift(fft(s)))/N;

% FFT for recovered signals
M_rec1_f = abs(fftshift(fft(m_rec1)))/N;
M_rec2_f = abs(fftshift(fft(m_rec2)))/N;
M_rec3_f = abs(fftshift(fft(m_rec3)))/N;

%% Step 6: Plotting Results (Time Domain Noise Impact)
% Purpose: Visualize and compare the impact of different SNR values in time domain.
figure('Name', 'Noise Impact Analysis (Time Domain)', 'NumberTitle', 'off');

subplot(4,1,1);
plot(t, m, 'b', 'LineWidth', 1.5);
title('Original Message Signal m(t)'); xlabel('Time (s)'); ylabel('Amplitude (V)');
grid on;

subplot(4,1,2);
plot(t, m_rec1, 'g', 'LineWidth', 1.2);
title(['Recovered Message (SNR = ', num2str(SNR1), ' dB)']); xlabel('Time (s)'); ylabel('Amplitude (V)');
grid on;

subplot(4,1,3);
plot(t, m_rec2, 'm', 'LineWidth', 1.2);
title(['Recovered Message (SNR = ', num2str(SNR2), ' dB)']); xlabel('Time (s)'); ylabel('Amplitude (V)');
grid on;

subplot(4,1,4);
plot(t, m_rec3, 'r', 'LineWidth', 1.2);
title(['Recovered Message (SNR = ', num2str(SNR3), ' dB)']); xlabel('Time (s)'); ylabel('Amplitude (V)');
grid on;

%% Step 7: Plotting Results (Frequency Domain Noise Impact)
% Purpose: Visualize the spectrum of recovered signals to observe noise floor.
figure('Name', 'Noise Impact Analysis (Frequency Domain)', 'NumberTitle', 'off');

subplot(4,1,1);
plot(f, M_f, 'b', 'LineWidth', 1.5);
title('Spectrum of Original Message Signal'); xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([-150 150]); grid on;

subplot(4,1,2);
plot(f, M_rec1_f, 'g', 'LineWidth', 1.2);
title(['Spectrum of Recovered Message (SNR = ', num2str(SNR1), ' dB)']); xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([-150 150]); grid on;

subplot(4,1,3);
plot(f, M_rec2_f, 'm', 'LineWidth', 1.2);
title(['Spectrum of Recovered Message (SNR = ', num2str(SNR2), ' dB)']); xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([-150 150]); grid on;

subplot(4,1,4);
plot(f, M_rec3_f, 'r', 'LineWidth', 1.2);
title(['Spectrum of Recovered Message (SNR = ', num2str(SNR3), ' dB)']); xlabel('Frequency (Hz)'); ylabel('Magnitude');
xlim([-150 150]); grid on;