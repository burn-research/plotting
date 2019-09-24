function [] = plot_qor_measure_error_bar_plot(qor_name, qor_matrix, n_subs, log_scale, y_limits, y_ticks, labels, markers, colors, legend_loc, destination)
% This function plots error bar graphs for the quality of reconstruction
% (QoR) measure that could for instance be:
%
% R2 - coefficient of determination
% RMSE - root mean squared error
%
% It plots the variable-mean measure with minimum and maximum
% marked as error bars.
%
% Input:
% ------------
%
% - qor_name
% 
%         is a string with the name of the QoR. This will be added to the 
%         filename of the produced plot.
% 
%         Example: qor_name = 'R2'
% 
% - qor_matrix
% 
%         is the combined QoR measure (that could be R2, RMSE, etc).
%         This matrix needs to be composed of vertically stacked sub-matrices:
% 
%           Var-1       Var-M
%         [                   ] 1-mode reconstruction
%         [                   ]
%         [                   ]
%         [      Line-1       ]
%         [                   ]
%         [                   ]
%         [                   ] N-modes reconstruction
%          -------------------
%         [                   ] 1-mode reconstruction
%                 ...
% 
%         Each such sub-matrix is associated with one label, marker and color.
% 
% - n_subs
% 
%         is an integer specifying the number of sub-matrices.
% 
% - log_scale
% 
%         0 if you don't want the Y-axis to be in log-scale.
% 
% - y_limits
% 
%         specify y-axis limits.
% 
%         Note: uses defaults if set to an empty array.
% 
% - y_ticks
% 
%         specify y-axis ticks.
% 
%         Note: uses defaults if set to an empty array.
% 
% - labels
% 
%         is a cell array of strings that labels consecutive sub-matrices.
% 
%         Example: labels = {'Line-1', 'Line-2', 'Line-3', 'Line-4'}
% 
% - markers
% 
%         is a cell array of strings that specifies markers for the consecutive
%         sub-matrices.
% 
%         Example: markers = {'o', '^', 'p', 'd'}
% 
% - colors
% 
%         is a matrix of RGB vectors that specify colors for the consecutive
%         sub-matrices.
% 
%         Example: colors = [
%                       [0 0 0]
%                       [0.4660 0.6740 0.1880]
%                       [0 0.4470 0.7410]
%                       [0.8500 0.3250 0.0980]]
% 
%         Note: uses grayscale if set to an empty array.
% 
% - destination
% 
%         is a string specifying the plot saving destination.
% 
%         Example: destination = 'PLOTS/'

%% plot_qor_measure_error_bar_plot
% Checks:
if ~exist('destination') || isempty(destination)
    destination = '';
end

if isempty(y_limits)
    ylim_flag = 0;
else
    ylim_flag = 1;
end

if isempty(y_ticks)
    yticks_flag = 0;
else
    yticks_flag = 1;
end

% Create default grayscale colors:
first_color = 0; last_color = 0.9 - 0.4/n_subs;

if isempty(colors)
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

% Plotting parameters:
n_modes = size(qor_matrix, 1)/n_subs;
range = 1:1:n_modes;
fontsize_axes = 32;
fontsize_label = 44;
fontsize_legend = 40;
marker_size = 8;
cap_size = 6;
linewidth = 2.5;

% Plot and save:
for line = 1:1:n_subs

    % Extract single sub-matrix:
    sub_matrix = qor_matrix(((line-1)*n_modes + 1):(line*n_modes), :);
    mean_nrmse = mean(sub_matrix, 2);
    max_nrmse = max(sub_matrix, [], 2);
    min_nrmse = min(sub_matrix, [], 2);

    figure(1)
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.8, 1]);
    if log_scale ~= 0
        set(gca,'YScale','log');
    end
    s = errorbar(range + ((-n_subs-1)/2+line)*0.18, mean_nrmse, mean_nrmse - min_nrmse, max_nrmse - mean_nrmse, char(markers(line))); hold on, grid on
    s.Color = colors(line,:);
    s.CapSize = cap_size;
    s.MarkerSize = marker_size;
    s.MarkerFaceColor = colors(line,:);
    s.LineWidth = linewidth;
    set(gca, 'FontSize', fontsize_axes)
    xlabel('Number of modes [-]', 'FontSize', fontsize_label)
    ylabel([qor_name, ' [-]'], 'FontSize', fontsize_label)
    if ylim_flag == 1
        ylim(y_limits)
    end
    xlim([min(range)-1, max(range)+1])
    xticks(range)
    if yticks_flag == 1
        yticks(y_ticks)
    end
    
end

figure(1)
legend(labels, 'Location', legend_loc, 'FontSize', fontsize_legend)
filename = [destination, qor_name, '.eps'];
saveas(gcf, filename, 'epsc');
hold off

end