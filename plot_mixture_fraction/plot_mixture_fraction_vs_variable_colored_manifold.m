function [] = plot_mixture_fraction_vs_variable_colored_manifold(Z, var, var_color, var_name, y_label_text, legend_text, destination)
%{
This function plots a scatter plot of mixture fraction vs. a variable of choice.
NOTE: It performs random sampling from the mixture fraction pool.

Inputs: ---

- var

      variable data vector.

- Z

      mixture fraction data vector.

- var_color

      variable to color the var(Z) manifold.

- var name

- destination

      plot saving destination.
%}

%% Plotting parameters:
fontsize_axes = 44;
fontsize_label = 54;
fontsize_colorbar = 44;
fontsize_legend = 54;

figure();
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]);
scatter(Z, var, 3, var_color, 'filled'); hold on
set(gca, 'FontSize', fontsize_axes);
box on, grid on
range_x = max(Z)*0.05;
range_y = max(var)*0.05;
xlim([min(Z)-range_x, max(Z)+range_x]), ylim([min(var)-range_y, max(var)+range_y]);
xticks(0:0.2:1)
xlabel(['Mixture fraction [-]'], 'FontSize', fontsize_label), ylabel(y_label_text, 'FontSize', fontsize_label);
dummyh = line(nan, nan, 'Linestyle', 'none', 'Marker', 'none', 'Color', 'none');

[l, hobj, hout, mout] = legend(dummyh, {legend_text}, 'Location', 'northeast', 'FontSize', fontsize_legend);

M = findobj(hobj, 'type', 'patch');
set(M, 'MarkerSize', 25);

objhl = findobj(hobj, 'type', 'text');
set(objhl, 'FontSize', fontsize_legend);
set(objhl, 'FontName', 'cmr10')
set(objhl, 'interpreter', 'latex')

colormap(parula);

% Colorbar:
cb = colorbar;
cb.FontSize = fontsize_colorbar;
cb.FontName = 'cmr10';

% Save plot:
saveas(gcf, destination, 'png');

end
