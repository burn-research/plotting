function [] = plot_color_manifold_with_scalar_variable(X, Y, scalar, scalar_name, destination)
%{
This function colours a 2D manifold with a prescribed colormap.

Inputs: ---

- X

	variable on the x-axis.

- Y

    variable on the y-axis.

- scalar

    vector of the corresponding scalar variable.

- scalar_name

    is a string specifying the name of the scalar variable.

- destination

    plot saving destination.
%}

%% Plotting parameters:
fontsize_axes = 44;
fontsize_label = 54;
fontsize_colorbar = 44;
fontsize_ann = 50;

figure();
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.7, 1]);
scatter(X, Y, 3, scalar, 'filled'); hold on
set(gca, 'FontSize', fontsize_axes);
box on, grid on
xlim([1.05*min(X), 1.05*max(X)]), ylim([1.05*min(Y), 1.05*max(Y)]);
xlabel(['PC-score-1 [-]'], 'FontSize', fontsize_label), ylabel(['PC-score-2 [-]'], 'FontSize', fontsize_label);
colormap(parula);

% Add rectangles:
rec_col = [193,32,15]./256;
%rec_col = [209,17,65]./256;
rec_col = [156,0,0]./256;
rec_col = [180,8,8]./256;
%r = rectangle('Position',[0.18 -0.2 0.25 0.5], 'Curvature', 0.1, 'EdgeColor', rec_col)
r = rectangle('Position',[-0.17 0.6 0.37 0.33], 'Curvature', 0.1, 'EdgeColor', rec_col)
r.LineWidth = 4;
r.LineStyle = '--';
% text(-0.14, 0, {'Oxidizer', 'stream'}, 'FontSize', fontsize_ann, 'Color', rec_col)
text(-0.51, 0.73, {'Reaction', 'zone'}, 'FontSize', fontsize_ann, 'Color', rec_col)

% Colorbar:
cb = colorbar;
cb.FontSize = fontsize_colorbar;
cb.FontName = 'cmr10';

% Save plot:
filename = [destination, scalar_name, '_colored_manifold.eps'];
saveas(gcf, filename, 'epsc');

end
