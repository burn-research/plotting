function [] = plot_correlations_imshow(correlations_matrix, annotations, k_list, title_text, destination)


fontsize_axes = 16;
fontsize_label = 24;
fontsize_colorbar = 16;


figure(1);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 0.6])
imagesc(correlations_matrix)
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
% axis('equal')

n_count = max(max(correlations_matrix));
colormap(parula(n_count+1))
cb = colorbar;
cb.FontSize = fontsize_colorbar;
cb.FontName = 'cmr10';

k = n_count+1;
set(cb, 'ticks', (0.5*(k-1)/k):((k-1)/k):(k - 0.5*(k-1)/k), 'ticklabels', [0:1:k])
% set(get(cb,'label'), 'string','$r$ [-]');

% Save plot:
filename = [destination, 'count_imshow.png'];
saveas(gcf, filename, 'png');

end