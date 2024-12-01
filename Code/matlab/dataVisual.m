clear all;

dataPosition = '../../Data/pseudo/';
filename = 'data';
n = 1;

% data import and creation of variance array
rawData = readmatrix(strcat(dataPosition, filename, int2str(n), '.txt'));

tt = rawData(:, 1);
clock = rawData(:, 2);
data = rawData(:, 3);
s_data = repelem(0.0015, length(data));
%s_vo = repelem(0.0015, length(vo));

sequ = readmatrix("../NumericalSim/python/sequences.txt", "OutputType", "char");
sequ = sequ(:, 2);



%a = [];
a_txt = "";

i_transition = [];
t_transition = [];
c_transition = [];
v_transition = [];

for i = 2:length(tt)
    if(clock(i) > 2 && clock(i-1) < 2)
%        a(end+1) = decodeData(data, i);
        swapVal = decodeData(data, i);
        a_txt = strcat(a_txt, num2str(swapVal) );
        i_transition(end+1) = i;
        t_transition(end+1) = tt(i);
        c_transition(end+1) = clock(i);
        v_transition(end+1) = data(i);
    end
end
a_txt = char(a_txt);

tt = tt(i_transition(1):end);
clock = clock(i_transition(1):end);
data = data(i_transition(1):end);
s_data = s_data(i_transition(1):end);
i_transition = i_transition - i_transition(1) + 1;


t = tiledlayout(2, 2, "TileSpacing","tight", "Padding","tight");

ax1 = nexttile([1 2]);
plot(tt, clock, Color = "#ff0000");
hold on
errorbar(tt, data, s_data, 'o', Color = "#0027bd");
%plot(t_transition, c_transition, 'o', Color = "#00ff00", MarkerSize = 10)
%plot(t_transition, v_transition, 'x', Color = "yellow", MarkerSize = 10)
grid on
grid minor



a_txt
swapSequence = sequ(n);
swapSequence = swapSequence{1}

while(length(a_txt) < 2*length(swapSequence))
    swapSequence = swapSequence(1:end-1);
end

np = KMP( swapSequence, a_txt);
np








sim_vo = encodeData(swapSequence, np, mean(diff(i_transition)), length(c_transition), length(tt));






ax2 = nexttile([1 2]);
plot(tt, sim_vo, Color = "magenta");
ylim([-1, 6]);
grid on
grid minor




legend(ax1, 'Clock', 'Data', 'Clock Transisions', 'Data at Clock Transition', Location= 'ne')
ylabel(ax1, 'Voltage [V]')
xlabel(ax1, 'Time [s]')

legend(ax2, 'Simulated Data', Location= 'ne')
ylabel(ax2, 'Simulated Voltage [V]')
xlabel(ax2, 'Time [s]')

linkaxes([ax1, ax2], 'x');
linkaxes([ax1, ax2], 'y');

hold off
fontsize(14, "points");

title(t, strcat('Measured and Simulated LFSR cycles - n =   ', int2str(n)), 'FontSize', 16);

function y = decodeData(arr, index)
    if(arr(index) > 2)
        y = 1;
    elseif(arr(index) < 0.8)
        y = 0;
    else
        y = -1;
        print('Error');
    end
end

function y = encodeData(seq, indexes, dt, totIndexes, totTime)
    y = zeros(1, totTime);
    i = 1;
    l = 1;
    while(i < totIndexes)
        if(i == indexes(l))
            for j = 1:length(seq)
                for k = 1:dt
%                    (i + (j-1)*dt + k)
                    y((i-1)*dt+(j-1)*dt + k) = str2double(seq(j)) * 5;
                end
            end
            i = i + length(seq);
            l = l + 1;
            if(l > length(indexes))
                l = 1;
            end
        else
            for k = 1:dt
%                k
                y((i-1)*dt + k) = 2;
            end
            i = i + 1;
        end
    end
end