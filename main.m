fs = 44100;                   
dt = 1/fs;
t = (0:dt:5-dt)';
order = 100;
passband = [0, 4000]/(fs/2);
stopband = [4500, fs/2]/(fs/2);
sin1 = sin(2*pi*5000*t);
audiowrite('team7-sinetone.wav',sin1,fs);
t2 = 0:dt:5;
chirpSignal = chirp(t2,0,5,8000);
audiowrite('team7-chirp.wav',chirpSignal,fs);
t1 = (0:dt:0.33-dt)';
t2 = (0.33:dt:0.83-dt)';
t3 = (0.83:dt:1.53-dt)';
t4 = (1.53:dt:2.06-dt)';
t5 = (2.06:dt:3.08-dt)';
tone1 = sin(2*pi*1000*t1);
tone2 = sin(2*pi*1100*t2);
tone3 = sin(2*pi*900*t3);
tone4 = sin(2*pi*400*t4);
tone5 = sin(2*pi*600*t5);
main = vertcat(tone1, tone2, tone3, tone4, tone5);
audiowrite('tones.wav',main,fs);
[y, Fs] = audioread('michael.wav');
min_length = min(length(y), length(sin1));
sin1 = sin1(1:min_length, :);
y = y(1:min_length, :);
mergeaudio = sin1 + y;
audiowrite('team7-speechchirp.wav',mergeaudio,fs);
f = [0, passband(2), stopband(1), 1];
a = [1, 1, 0, 0];
h = firls(order, f, a);
y_filtered = filter(h,1,y);
stereo = [y, sin1];
audiowrite('team7-filteredspeechsine.wav', y_filtered, fs);
audiowrite('team7-stereospeechsine.wav',stereo,fs);

% PLOT SINE WAVE (FIG 1)
window = hamming(512);
N_overlap = 256;
N_fft = 1024;
[S,F,T,P] = spectrogram(sin1,window,N_overlap,N_fft,fs,'yaxis');
figure;
surf(T,F,10*log10(P),'EdgeColor','none');
axis tight;
view(0,90);
colormap(jet);
set(gca,'clim',[-80,-20]);
set(gca, 'color', [0 0 0.5137]);
ylim([0 10000]);
xlabel('Time (s)');ylabel('Frequency (Hz)');

% PLOT CHIRP (FIG 2)
window = hamming(512);
N_overlap = 256;
N_fft = 1024;
[S,F,T,P] = spectrogram(chirpSignal,window,N_overlap,N_fft,fs,'yaxis');
figure;
surf(T,F,10*log10(P),'EdgeColor','none');
axis tight;
view(0,90);
colormap(jet);
set(gca,'clim',[-80,-20]);
set(gca, 'color', [0 0 0.5137]);
ylim([0 10000]);
xlabel('Time (s)');ylabel('Frequency (Hz)');

% PLOT CETK (FIG 3)
window = hamming(512);
N_overlap = 256;
N_fft = 1024;
[S,F,T,P] = spectrogram(main,window,N_overlap,N_fft,fs,'yaxis');
figure;
surf(T,F,10*log10(P),'EdgeColor','none');
axis tight;
view(0,90);
colormap(jet);
set(gca,'clim',[-80,-20]);
set(gca, 'color', [0 0 0.5137]);
ylim([0 10000]);
xlabel('Time (s)');ylabel('Frequency (Hz)');

% PLOT AUDIO RECORDING (FIG 4)
window = hamming(512);
N_overlap = 256;
N_fft = 1024;
[S,F,T,P] = spectrogram(y,window,N_overlap,N_fft,fs,'yaxis');
figure;
surf(T,F,10*log10(P),'EdgeColor','none');
axis tight;
view(0,90);
colormap(jet);
set(gca,'clim',[-80,-20]);
set(gca, 'color', [0 0 0.5137]);
ylim([0 10000]);
xlabel('Time (s)');ylabel('Frequency (Hz)');

% PLOT AUDIO RECORDING WITH SINE WAVE (FIG 5)
window = hamming(512);
N_overlap = 256;
N_fft = 1024;
[S,F,T,P] = spectrogram(mergeaudio,window,N_overlap,N_fft,fs,'yaxis');
figure;
surf(T,F,10*log10(P),'EdgeColor','none');
axis tight;
view(0,90);
colormap(jet);
set(gca,'clim',[-80,-20]);
set(gca, 'color', [0 0 0.5137]);
ylim([0 10000]);
xlabel('Time (s)');ylabel('Frequency (Hz)');

% PLOT FILTERED AUDIO RECORDING WITH SINE WAVE (FIG 6)
window = hamming(512);
N_overlap = 256;
N_fft = 1024;
[S,F,T,P] = spectrogram(y_filtered,window,N_overlap,N_fft,fs,'yaxis');
figure;
surf(T,F,10*log10(P),'EdgeColor','none');
axis tight;
view(0,90);
colormap(jet);
set(gca,'clim',[-80,-20]);
set(gca, 'color', [0 0 0.5137]);
ylim([0 10000]);
xlabel('Time (s)');ylabel('Frequency (Hz)');
