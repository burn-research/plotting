function [] = plot_value_per_variable(value_name, value_matrix, ylims, annotations, labels, markers, legend_loc, destination)
%{
This function plots value per variable for a given number of sets of
values.

Inputs: ---

- value_name

    is a string with the name of the QoR.

    Example: value_name = 'R2'

- value_matrix

    is the combined QoR measure (that could be R2, RMSE, etc).
    This matrix needs to be composed of horizontally stacked sets:

      Var-1       Var-M
    [                   ] set-1 reconstruction
    [                   ] set-2 reconstruction
    [                   ]     ...
    [                   ] set-N reconstruction

    Each set is associated with one label and marker.

- ylims

    range of limits on the y-axis.

- annotations

    is a cell array containing variable annotations.

- labels

    is a cell array of strings that labels consecutive sub-matrices.

    Example: labels = {'Line-1', 'Line-2', 'Line-3', 'Line-4'}

- markers

    is a cell array of strings that specifies markers for the consecutive
    sub-matrices.

    Example: markers = {'o', '^', 'p', 'd'}

- legend_loc

    is a string specifying legend location.

    Example: legend_loc = 'southwest'

- destination

    is a string specifying the plot saving destination.

    Example: destination = 'PLOTS/'
%}

%% Checks:
if ~exist('destination') || isempty(destination)
    destination = '';
end

%% Plotting parameters:
[n_sets, n_vars] = size(value_matrix);
x_range = [1:1:n_vars];
fontsize_axes = 50;
fontsize_label = 60;
fontsize_legend = 50;
marker_size = 500;
linewidth = 1;

colors = [
[0 0 0]
[203,203,203]]./256;

%% Plot and save:
for line = 1:1:n_sets

    % Extract single set:
    set_matrix = value_matrix(line, :);
    
    figure(1);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.8, 1])
    s = scatter(x_range, set_matrix, marker_size, colors(line,:), char(markers(line)), 'filled', 'LineWidth', linewidth); hold on
    set(gca, 'FontSize', fontsize_axes); box on; grid on
    xticklabels(annotations)
    xtickangle(90)
    ylabel([value_name, ' [-]'], 'FontSize', fontsize_label)
    xticks(x_range)
    xlim([0, n_vars+1])
    ylim(ylims)
    yticks([0:0.2:1])
    
end

figure(1);

[l, hobj, hout, mout] = legend(labels, 'Location', legend_loc, 'FontSize', fontsize_legend, 'orientation', 'horizontal');

M = findobj(hobj, 'type', 'patch');
set(M, 'MarkerSize', 20);
set(M, 'LineWidth', linewidth);

objhl = findobj(hobj, 'type', 'text');
set(objhl, 'FontSize', fontsize_legend);
set(objhl, 'FontName', 'cmr10')
set(objhl, 'interpreter', 'latex')

filename = [destination, value_name, '.png'];
saveas(gcf, filename, 'png');
hold off

end