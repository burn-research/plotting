function [] = plot_mean_reconstruction_errors(err_matrix, err_name, ylims, labels, markers, legend_loc, colors, destination)

    [n_subs, n_runs] = size(err_matrix);

    % Checks:
    if ~exist('destination') || isempty(destination)
        destination = '';
    end

    % Create default grayscale colors:
    if ~exist('colors', 'var') || isempty(colors)

        first_color = 0; last_color = 0.9 - 0.4/n_subs;

        colors = [];
        for i = 1:1:n_subs
            if i == 1
                colors(i,:) = [first_color first_color first_color];
            elseif i == n_subs
                colors(i,:) = [last_color last_color last_color];
            else
                colors(i,:) = [last_color/(n_subs-1)*(i-1) last_color/(n_subs-1)*(i-1) last_color/(n_subs-1)*(i-1)];
            end
        end
    end

    % Create default error name:
    if ~exist('err_name', 'var') || isempty(err_name)
        mode_name = 'Error';
    end

    % Plotting parameters:

    x_range = [1:1:n_runs];
    fontsize_axes = 50;
    fontsize_label = 60;
    fontsize_legend = 50;
    marker_size = 300;
    linewidth = 2;

    colors = [
    [216,186,9]
 %   [121,150,88]
    [21,107,92]]./256;
%     [216,139,70]

    % Plot and save:
    for line = 1:1:n_subs

        % Extract single set:
        err_vector = err_matrix(line, :);

        figure(1);
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.8, 1])
        s = scatter(x_range, err_vector, marker_size, colors(line,:), char(markers(line)), 'filled', 'LineWidth', linewidth); hold on

        set(gca, 'FontSize', fontsize_axes); box on; grid on
        ylabel([err_name, ' [-]'], 'FontSize', fontsize_label)
        xlim([0, n_runs+1])
        xticks([1,25, 50])
        ylim(ylims)
        yticks([0:20:100])

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

    for line = 1:1:n_subs

        % Extract single set:
        err_vector = err_matrix(line, :);
        plot(x_range, repmat(mean(err_vector), 1, n_runs), '--', 'color', colors(line,:), 'LineWidth', linewidth)
    end

    filename = [destination, err_name, '.png'];
    saveas(gcf, filename, 'png');
    hold off

end
