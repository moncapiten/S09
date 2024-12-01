clear all;

dataPosition = '../../Data/';
filename = 'data';
specific = '002';

% data import and creation of variance array
rawData = readmatrix(strcat(dataPosition, filename, specific, '.txt'));

limit1 = 5500;
limit2 = 12500;

tt = rawData(:, 1);
tt = tt(limit1:limit2);
vi = rawData(:, 2);
vi = vi(limit1:limit2);
s_vi = repelem(0.0015, length(vi));
vo = rawData(:, 3);
vo = vo(limit1:limit2);
s_vo = repelem(0.0015, length(vo));

lvi = vi - mean(vi);
lvo = vo - mean(vo);





dt = mean( diff( tt));
fs = 1/dt;

y = fft(lvi);
y = fftshift(y);
f = (0:length(y)/2)*fs/length(y);
y = y(length(y)/2:end);

y2 = fft(lvo);
y2 = fftshift(y2);
f2 = (0:length(y2)/2)*fs/length(y2);
y2 = y2(length(y2)/2:end);





t = tiledlayout(2, 2);

ax1 = nexttile([1, 2]);
%plot(tt, vi, 'o--', Color = "#0027bd");
hold on
%plot(tt, vo, 'x-', Color = "#ff0000");
%plot(tt, lvi, 'o--', Color = "#0027cd");
%plot(tt, lvo, 'x-', Color = "red");
errorbar(tt, vi, s_vi, 'o--', Color = "#0027cd");
errorbar(tt, vo, s_vo, 'x-', Color = "red");
grid on;
grid minor;


ax2 = nexttile([1, 2]);
semilogx(f, abs(y), Color = "#0027cd");
hold on;
%grid on;
%grid minor;


%ax3 = nexttile([1, 1]);
semilogx(f2, abs(y2), Color = "red");
grid on;
grid minor;


title(t, 'Frequency Divider - 1/1.3', 'FontSize', 16, 'FontWeight', 'bold');
legend(ax1, '$ V_{in} $', '$ V_{out} $', Location= 'ne', Interpreter = 'latex')
ylabel(ax1, 'Voltage [V]')
xlabel(ax1, 'Time [s]')
ylabel(ax2, 'Magnitude( zero-averaged) [a.u.]')
xlabel(ax2, 'Frequency [Hz]')
hold off
fontsize(14, "points");


