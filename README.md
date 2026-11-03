# DSB-SC Modulation & Coherent Demodulation in MATLAB

Final project for **EHM3131 – Communication 1** at **Yıldız Technical University**.

A MATLAB simulation of a **Double-Sideband Suppressed-Carrier (DSB-SC)** link:
modulation, an AWGN channel at several noise levels, coherent demodulation, and
time/frequency-domain analysis of how noise affects the recovered message.

## What I did

1. **Modulation**: I multiplied a 50 Hz message `m(t)` by a 500 Hz carrier `c(t)` to get `s(t) = m(t)·c(t)`.
2. **Channel**: I added white Gaussian noise (`awgn`) at three SNRs: **15 dB** (good), **10 dB** (moderate), **3 dB** (poor).
3. **Coherent demodulation**: I multiplied the received signal by the carrier, then low-pass filtered it
   (5th-order Butterworth, 100 Hz cutoff, zero-phase `filtfilt`) and corrected the amplitude.
4. **Spectral analysis**: I computed the FFT of the original and recovered signals.
5. **Plots**: I made two figures comparing the original message with the three recovered versions, in the time and frequency domains.

## Parameters

| Parameter | Value |
|---|---|
| Message frequency `fm` / amplitude `Am` | 50 Hz / 1 |
| Carrier frequency `fc` / amplitude `Ac` | 500 Hz / 10 |
| Sampling frequency `fs` | 10 kHz |
| Duration | 0.1 s |
| SNR values | 15, 10, 3 dB |

## How to run

Requires MATLAB with the **Communications Toolbox** (`awgn`) and **Signal Processing Toolbox** (`butter`, `filtfilt`).

```matlab
dsb
```

Change `fm`, `fc`, the SNR values or the filter cutoff at the top of `dsb.m` to experiment.

## Expected result

At 15 dB the recovered message is close to the original. As SNR drops to 3 dB, the recovered
waveform gets visibly noisier and the noise floor rises in the spectrum, while the 50 Hz message
peak stays at the same frequency.
