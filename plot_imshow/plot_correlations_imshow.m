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

cb = colorbar;
cb.FontSize = fontsize_colorbar;
cb.FontName = 'cmr10';

set(cb, 'ticks', [0:0.1:1], 'ticklabels', [0:0.1:1])

% Save plot:
filename = [destination, 'correlations_imshow.png'];
saveas(gcf, filename, 'png');

end