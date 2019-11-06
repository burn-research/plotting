function [] = plot_3d_variable_reconstruction(x, y, z_original, z_reconstructed, x_name, y_name, z_name, camera_view, destination)
% This function plots a 3D scatter visualization of a variable reconstruction.
%
% Input:
% ------------
%
% - x
%         a variable on the x-axis.
%
% - y
%         a variable on the y-axis.
%
% - z_original
%         the original variable on the z-axis.
%         (Will be coloured in black.)
%
% - z_reconstructed
%         the reconstruction of the original variable on the z-axis.
%         (Will be coloured in red.)
%
% - x_name
%         label for the variable on the x-axis.
%
% - y_name
%         label for the variable on the y-axis.
%
% - z_name
%         label for the variable on the z-axis.
%
% - camera_view
%         view of the camera on the 3D plot.
%
% - destination
%         is a string specifying the plot saving destination.
%
%         Example: destination = 'PLOTS/'

%% plot_3d_variable_reconstruction
% Checks:
if isempty(destination)
    destination = '';
end

if isempty(x_name)
    x_name = '$x$';
end

if isempty(y_name)
    y_name = '$y$';
end

if isempty(z_name)
    z_name = '$z$';
end

% Plotting parameters:
marker_size_original = 3;
marker_size_reconstructed = 5;
marker_size_legend = 15;
original_c = [0 0 0]./256;
reconstruction_c = [255,111,89]./256;
fontsize_axes = 22;
fontsize_label = 30;
fontsize_legend = 26;
fontsize_ann = 32;
text_size = 26;

figure();
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.8, 0.8]);
scatter3(x, y, z_original, marker_size_original, original_c, 'o', 'filled'), hold on
scatter3(x, y, z_reconstructed, marker_size_reconstructed, reconstruction_c, 'o', 'filled')
set(gca, 'FontSize', fontsize_axes)
xlabel([x_name], 'FontSize', fontsize_label)
ylabel([y_name], 'FontSize', fontsize_label)
zlabel([z_name], 'FontSize', fontsize_label)
grid on
if isempty(camera_view)
    view();
else
    view(camera_view);
end

[l, hobj, hout, mout] = legend({'Original', 'Reconstructed'}, 'Location', 'northwest', 'FontSize', fontsize_legend);

M = findobj(hobj, 'type', 'patch');
set(M, 'MarkerSize', marker_size_legend);

objhl = findobj(hobj, 'type', 'text');
set(objhl, 'FontSize', fontsize_legend);
set(objhl, 'FontName', 'cmr10')
set(objhl, 'interpreter', 'latex')

% Save plot:
filename = [destination, '3d_variable_reconstruction.png'];
saveas(gcf, filename, 'png');
hold off

end
