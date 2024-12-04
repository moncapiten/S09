clear all;

dataPosition = '../../Data/SR/';
filename = 'data';
n = 16;

% data import and creation of variance array
rawData = readmatrix(strcat(dataPosition, filename, int2str(n), '.txt'));

tt = rawData(:, 1);
clock = rawData(:, 2);
s_clock = repelem(0.0015, length(clock));
data = rawData(:, 3);
s_data = repelem(0.0015, length(data));




i_transition = [];
tc_transition = [];
cc_transition = [];
td_transition = [];
dd_transition = [];

for i = 2:length(tt)
    if( abs(clock(i) - clock(i-1)) > 2)
%    if(clock(i) > 2 && clock(i-1) < 2)
        tc_transition(end+1) = tt(i);
        cc_transition(end+1) = clock(i);
    end
    if( abs(data(i) - data(i-1)) > 2)
%    if(data(i) > 2 && data(i-1) < 2)
        td_transition(end+1) = tt(i);
        dd_transition(end+1) = data(i);
    end
end


t = tiledlayout(2, 2, "TileSpacing","tight", "Padding","tight");

delay_arr = td_transition - tc_transition;

delay = mean(delay_arr);
s_delay = std(delay_arr);

%ax1 = nexttile([1 2]);
errorbar(tt, clock, s_clock, Color = "#ff0000");
hold on
errorbar(tt, data, s_data, 'o', Color = "#0027bd");
plot(tc_transition, cc_transition, 'o', Color = "#00ff00", MarkerSize = 10)
plot(td_transition, dd_transition, 'x', Color = "yellow", MarkerSize = 10)

plot(repelem(tc_transition( int32(length(tc_transition)/2) ), 2), [-1 6], Color = "magenta", LineStyle = "--")
plot(repelem(td_transition( int32(length(tc_transition)/2) ), 2), [-1 6], Color = "magenta", LineStyle = "--")

grid on
grid minor

dim = [0.4 0.76 0.1 0.1];
annotateString  = strcat('$ \Delta_t = \, $', sprintf("%.2e", delay), '$ \pm $', sprintf("%.0e", s_delay), ' s');
annotation('textbox', dim, 'String', annotateString, 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black', "Interpreter", "latex");


legend( 'Clock', 'Data', 'Clock Transitions', 'Data Transition', Location= 'ne')
ylabel( 'Voltage [V]')
xlabel( 'Time [s]')

%legend(ax2, 'Simulated Data', Location= 'ne')
%ylabel(ax2, 'Simulated Voltage [V]')
%xlabel(ax2, 'Time [s]')

%linkaxes([ax1, ax2], 'x');
%linkaxes([ax1, ax2], 'y');

hold off
fontsize(14, "points");

title(t, strcat('Measured and Simulated LFSR cycles - n =   ', int2str(n)), 'FontSize', 16);



