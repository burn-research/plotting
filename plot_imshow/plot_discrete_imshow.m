function [] = plot_discrete_imshow(discrete_matrix, annotations, k_list, title_text, destination)
% This function plots an imshow of a matrix of discrete values 0, 1, 2, ...
%
% Inputs: ---
%
% - discrete_matrix
%
%       matrix of discrete values. Each row corresponds to an entry
%       in k_list. It should be size (lenght(k_list), number of variables).
%
% - annotations
%
%       cell array of chars representing variable names. Number of entries
%       should correspond to the number of columns in the continuous
%       matrix.
%
% - k_list
%
%       a list numbering rows of continuous matrix. One application might
%       be that k_list is a list containing number of clusters that each
%       row represents.
%
% - title_text
%
%       string containing plot title. If set to false, title will not be plotted.
%
% - destination
%
%       plot saving destination.

fontsize_axes = 16;
fontsize_label = 24;
fontsize_colorbar = 16;

figure(1);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 0.6])
imagesc(discrete_matrix)
set(gca, 'FontSize', fontsize_axes);
xticks(1:1:length(annotations))
xticklabels(annotations)
xtickangle(90)
yticks(1:1:length(k_list))
yticklabels(k_list)
ylabel('k [-]', 'FontSize', fontsize_label)
if title_text ~= false
    title(title_text)
end

n_count = max(max(discrete_matrix));
colormap(parula(n_count+1))
cb = colorbar;
cb.FontSize = fontsize_colorbar;
cb.FontName = 'cmr10';

k = n_count+1;
set(cb, 'ticks', (0.5*(k-1)/k):((k-1)/k):(k - 0.5*(k-1)/k), 'ticklabels', [0:1:k])

% Save plot:
filename = [destination, 'discrete_imshow.png'];
saveas(gcf, filename, 'png');

end