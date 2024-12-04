n = [16 32 48 64];
delays = 1e-4 * [3.13 6.31 9.56 12.7];
s_delays = 1e-4 * [0.01 0.03 0.04 0.02];


function y = lin(params, x)
    y = params(1) * x + params(2);
end



p0 = [1 0];
[beta, R, ~, covbeta] = nlinfit(n, delays, @lin, p0);
s_beta = sqrt(diag(covbeta));

%ksq calculation
k = 0;
for i = 1:length(R)
    k = k + R(i)^2/s_delays(i)^2;
end
k = k/(length(R)-2);
k



t = tiledlayout(2, 2, "TileSpacing","tight", "Padding","tight");


ax1 = nexttile([1 2]);
errorbar(n, delays, s_delays, 'o', 'Color', '#0027bd')
hold on
plot(n, lin(beta, n), 'Color', '#ff0000')
nn = [0 70];
plot(nn, lin(beta, nn), 'Color', 'magenta', 'LineStyle', '--')
grid on
grid minor
hold off

% residual plot
ax2 = nexttile([1 2]);
errorbar(n, R, s_delays, 'o', 'Color', '#0027bd')
hold on
plot(n, zeros(length(n)), 'Color', 'black')
grid on
grid minor


dim = [0.05 0.70 0.1 0.1];
annotateString  = strcat('$ k^2_{red} = \, $', sprintf("%.2f", k));
annotation('textbox', dim, 'String', annotateString, 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black', "Interpreter", "latex");

dim = [0.05 0.65 0.1 0.1];
beta = beta * 1e6;
s_beta = s_beta * 1e6;
annotateString  = strcat('$ m = \, $', sprintf("%.2f", beta(1)), '$ \pm $', sprintf("%.2f", s_beta(1)), '$ \mathrm{\mu s} $', sprintf("\n") , '$ q = \, $', sprintf("%.2f", beta(2)), '$ \pm $', sprintf("%.2f", s_beta(2)), '$ \mathrm{\mu s} $');
annotation('textbox', dim, 'String', annotateString, 'FitBoxToText', 'on', 'BackgroundColor', 'white', 'EdgeColor', 'black', "Interpreter", "latex");



ylabel(ax1, '$\Delta_t$ [s]', 'Interpreter', 'latex')
ylabel(ax2, 'Residuals', 'Interpreter', 'latex')
xlabel(ax2, 'n', 'Interpreter', 'latex')
legend(ax1, 'Data', 'Linear Fit', 'Fit Expansion', 'Location', 'northwest')

linkaxes([ax1, ax2], 'x');
xlim(ax1, [0 70])
ylim(ax1, [0 1.1*max(delays)])

fontsize(16, "points");

title(t, 'Delay introduced by the Register', 'Interpreter', 'latex', "FontSize", 18);



