dataPosition = '../../Data/pseudo/';
filename = 'data';
n = 1;

% data import and creation of variance array
rawData = readmatrix(strcat(dataPosition, filename, int2str(n), '.txt'));

tt = rawData(:, 1);
clock = rawData(:, 2);
data = rawData(:, 3);
%s_vo = repelem(0.0015, length(vo));

sequ = readmatrix("../NumericalSim/python/sequences.txt");
sequ = sequ(:, 2);

plot(tt, data, 'o', Color = "#0027bd");
hold on
plot(tt, clock, Color = "#ff0000");

%a = [];
a_txt = "";

t_transition = [];
c_transition = [];
v_transition = [];

for i = 2:length(tt)
    if(clock(i) > 2 && clock(i-1) < 2)
%        a(end+1) = decodeData(data, i);
        swapVal = decodeData(data, i);
        a_txt = strcat(a_txt, num2str(swapVal) );
        t_transition(end+1) = tt(i);
        c_transition(end+1) = clock(i);
        v_transition(end+1) = data(i);
    end
end
a_txt = char(a_txt);

%a


plot(t_transition, c_transition, 'o', Color = "#00ff00", MarkerSize = 10)
plot(t_transition, v_transition, 'x', Color = "yellow", MarkerSize = 10)




%swapSequence = dec2bin(sequ(n));

a_txt
swapSequence = num2str(sequ(n))

while(length(a_txt) < 2*length(swapSequence))
    swapSequence = swapSequence(1:end-1);
end

np = KMP( swapSequence, a_txt);
np

grid on
grid minor
%title('Amplified photodiode output voltage');
legend('Data', 'Clock', Location= 'ne')
ylabel('Voltage [V]')
xlabel('Time [s]')
hold off
fontsize(14, "points");


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