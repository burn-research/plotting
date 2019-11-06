function [] = plot_eigenvector_weights_bar_plot_as_subplots(A, mode_name, annotations, titles, colors, destination, prefix)
% This function plots annotated bar plots from normalized eigenvector
% weights. Each column from A is a separate subplot.
%
% INPUT PARAMETERS ----------------------------------------------------------
%
% - A
%
%     a matrix with eigenvectors.
%     This matrix needs to be composed of vertically stacked sub-matrices:
%
%       Eigvec-1     Eigvec-M
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
% - mode_name
%
%     is a string specifying the mode name.
%
%     Example: mode_name = 'PC'
%
% - annotations
%
%     is a cell array of strings that annotates bars.
%
%     Example: annotations = {'Bar-1', 'Bar-2', 'Bar-3', 'Bar-4'}
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
% - destination
%
%     is a string specifying the plot saving destination.
%
%     Example: destination = 'PLOTS/'
%
% - prefix
% 
%     is a string specifying the prefix that will be added to label the y-axis.
%     
%     Example: prefix = 'in cluster 1'

%% Checks:
[n_weights, n_eigvecs] = size(A);

if ~exist('destination') || isempty(destination)
    destination = '';
end

%% Plotting parameters:
fontsize_axes = 16;
fontsize_label = 30;
fontsize_legend = 40;
fontsize_title = 18;
text_size = 16;

%% Bar plot of a single eigenvector:
for i=1:1:n_eigvecs

    A_plot = A(:,i);
    
    % Bar plots:
    figure(1)
    %hAxis(i) = subplot(n_eigvecs/2, 2, i)
    subplot('Position', [(mod(i-1,2))/2+0.04 1-(ceil(i/2))/2 + 0.02 1/2.5 1/2.3]);
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.8, 0.9]); 
    b = bar(A_plot, 0.8);
    set(gca, 'FontSize', fontsize_axes)

    b(1).EdgeColor = colors(1,:);
    b(1).FaceColor = colors(1,:);

    % Annotate bars:
    for int = 1:1:n_weights

        x_pos = int;
        limit_weight = 1.1;
        max_weight = max(A_plot(int,:));
        min_weight = min(A_plot(int,:));

        y_pos = max_weight + 0.05;
        y_pos = -0.01;
        text(x_pos, y_pos, char(annotations(int)), 'FontSize', text_size, 'Rotation', 90, 'HorizontalAlignment', 'right');

    end

    xticklabels([]); yticks(0:0.2:1)
    %ylabel(['Weights on ', mode_name, '-', num2str(i), prefix, ' [-]'], 'FontSize', fontsize_label);
    ylim([-0.3 1]), xlim([0 n_weights+1])
    title(titles(i), 'FontSize', fontsize_title);
    grid on

end

% Save plot:
filename = [destination, 'subplot.eps'];
saveas(gcf, filename, 'epsc');

end
