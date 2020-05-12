function [] = plot_eigenvector_weights_bar_plot(A, n_mode_sets, n_request_eigvecs, mode_name, annotations, labels, colors, destination, prefix)
% This function plots annotated bar plots from eigenvector weights.
%
% If `n_mode_sets` is larger than 1 it will plot a comaprison of modes from
% more than one mode set. Mode sets should be stacked one below the other
% in a matrix `A`.
%
% For quick plotting of just one set call the function with only A and n_request_eigvecs:
%
% plot_eigenvector_weights_bar_plot(A, 1, n_request_eigvecs, '', {}, {}, {}, '', '')
%
% Input:
% ------------
% - A
%
%     a matrix with eigenvectors.
%     This matrix needs to be composed of vertically stacked sub-matrices
%     (mode sets):
%
%       Eigvec-1     Eigvec-N
%     [                       ] weight 1
%     [                       ] weight 2
%     [                       ]   .
%     [       Mode set 1      ]   .
%     [                       ]   .
%     [                       ]   .
%     [                       ] weight M
%      -----------------------
%     [                       ] weight 1
%                ...
%
%     Each such sub-matrix is associated with one label, marker and color.
%
%     It is assumed that all mode sets have the same dimensions.
%
% - n_mode_sets
%
%     is an integer specifying the number of mode sets stacked into matrix A.
%
% - n_request_eigvecs
%
%     is an integer specifying the number of first eigenvectors requested for
%     plotting.
%
% - mode_name
%
%     is a string specifying the mode name. It will be visible in as the
%     y-axis label and as the plot filename.
%
%     Example: mode_name = 'PC'
%
% - annotations
%
%     is a cell array of strings that annotates bars. It will be visible as
%     the x-axis labels.
%
%     Example: annotations = {'Bar-1', 'Bar-2', 'Bar-3', 'Bar-4'}
%
%     NOTE: If annotations is set to {}, the default annotations will be used.
%
%     DNS1 annotations are:
%
%     annotations = {'$\rm{T}$', '$\rm{H_2}$', '$\rm{O_2}$', '$\rm{O}$',
%     '$\rm{OH}$', '$\rm{H_2O}$', '$\rm{H}$', '$\rm{HO_2}$', '$\rm{H_2O_2}$',
%     '$\rm{CO}$', '$\rm{CO_2}$', '$\rm{HCO}$', '$\rm{N_2}$'};
%
% - labels
%
%     is a cell array of strings that labels the mode sets. It will be
%     visible in the plot legend.
%
%     Example: labels = {'Set-1', 'Set-2'}
%
%     NOTE: If labels is set to {}, no legend will be made.
%
% - colors
%
%     is a matrix of RGB vectors that specify colors for the consecutive
%     mode sets bars.
%
%     Example: colors = [
%                       [0 0 0]
%                       [0.4660 0.6740 0.1880]
%                       [0 0.4470 0.7410]
%                       [0.8500 0.3250 0.0980]]
%
%     NOTE: If colors is set to {}, the default grayscale will be used.
%
% - destination
%
%     is a string specifying the plot saving destination.
%
%     Example: destination = 'PLOTS/'
%
% - prefix
%
%     is a string specifying the prefix that will be added to label the
%     y-axis.
%
%     Example: prefix = ' in cluster 1'

%% Checks:
[n_weights, n_eigvecs] = size(A);

if mod(n_weights, n_mode_sets) ~= 0
    error(['The number of rows in A needs to be divisible by the number of mode sets.']);
end

n_weights = n_weights/n_mode_sets;

if ~exist('destination', 'var') || isempty(destination)
    destination = '';
end

% Create default mode name:
if ~exist('mode_name', 'var') || isempty(mode_name)
    mode_name = 'mode';
end

% Create default annotations:
if ~exist('annotations', 'var') || isempty(annotations)
    annotations = {'$\rm{W_1}$'};
    for i = 2:1:n_weights
        annotations = [annotations, ['$\rm{W_{', num2str(i), '}}$']];
    end
end

% Default prefix is none:
if ~exist('prefix', 'var') || isempty(prefix)
  prefix = '';
end

% Create default grayscale colors:
first_color = 0; last_color = 0.9 - 0.4/n_mode_sets;

if ~exist('colors', 'var') || isempty(colors)
    colors = [];
    for i = 1:1:n_mode_sets
        if i == 1
            colors(i,:) = [first_color first_color first_color];
        elseif i == n_mode_sets
            colors(i,:) = [last_color last_color last_color];
        else
            colors(i,:) = [last_color/(n_mode_sets-1)*(i-1) last_color/(n_mode_sets-1)*(i-1) last_color/(n_mode_sets-1)*(i-1)];
        end
    end
end

%% Plotting parameters:
fontsize_axes = 32;
fontsize_label = 44;
fontsize_legend = 40;
text_size = 44;

%% Bar plot of a single eigenvector:
for i=1:1:n_request_eigvecs

    A_plot = [];

    % Extract single ith eigenvector from each modes set:
    for mode_set = 1:1:n_mode_sets
        A_plot = [A_plot, A(((mode_set-1)*n_weights + 1):(mode_set*n_weights), i)];
    end

    % Bar plots:
    figure(i)
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.8, 1]);
    b = bar(A_plot, 0.8);
    set(gca, 'FontSize', fontsize_axes)
    for int = 1:1:n_mode_sets
        b(int).EdgeColor = colors(int,:);
        b(int).FaceColor = colors(int,:);
    end

    % Annotate bars:
    for int = 1:1:n_weights

        x_pos = int;

        max_weight = max(A_plot(int,:));
        min_weight = min(A_plot(int,:));

        if max_weight > 0.65
            if sign(min_weight) == -1
                y_pos = min_weight - 0.05;
            else
                y_pos = -0.05;
            end
            text(x_pos, y_pos, char(annotations(int)), 'FontSize', text_size, 'Rotation', 90, 'HorizontalAlignment', 'right');
        elseif min_weight < -0.65
            if sign(max_weight) == 1
                y_pos = max_weight + 0.05;
            else
                y_pos = 0.05;
            end
            text(x_pos, y_pos, char(annotations(int)), 'FontSize', text_size, 'Rotation', 90, 'HorizontalAlignment', 'left');
        elseif max_weight >= 0
            y_pos = max_weight + 0.05;
            text(x_pos, y_pos, char(annotations(int)), 'FontSize', text_size, 'Rotation', 90, 'HorizontalAlignment', 'left');
        elseif min_weight < 0
            y_pos = 0.05;
            text(x_pos, y_pos, char(annotations(int)), 'FontSize', text_size, 'Rotation', 90, 'HorizontalAlignment', 'left');
        end
    end

    xticklabels([]); yticks(-1:0.5:1)
    ylabel(['Weights on ', mode_name, '-', num2str(i), prefix, ' [-]'], 'FontSize', fontsize_label);
    ylim([-1 1]), xlim([0 n_weights+1])
    grid 'on'

    if n_mode_sets > 1

        if ~isempty(labels)

            % Create legend from labels:
            l = cell(1, n_mode_sets);

            for int = 1:1:n_mode_sets
                l{int} = char(labels(int));
            end

            legend(b, l, 'Location', 'southeast', 'FontSize', fontsize_legend, 'Orientation', 'horizontal');
        end
    end

    % Save plot:
    filename = [destination, mode_name, '_', num2str(i), '.png'];
    saveas(gcf, filename, 'png');

end
end
