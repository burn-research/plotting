function [] = plot_parity(original, reconstruction, var_name, var_unit, text_ann, destination)
% This function plots a parity plot between an original variable 
% and its reconstruction.
%
% Inputs: ---
%
% - original
%
%       vector with original variable.
%
% - reconstruction
%
%       vector with reconstruction of the variable.
%
% - var_name
%
%       string containing the variable name.
%
% - var_unit
%
%       string containg the variable unit. Set to '-' if none.
%
% - text_ann
%
%       is a string specifying optional text annotation that will be placed
%       in the top left corner of the parity plot.
%
%       Example: text_ann = {['Dim = 4'], ['Error = 0.1']}
%
% - destination
%
%       plot saving destination.

%% Plotting parameters:
fontsize_axes = 22;
fontsize_label = 30;
fontsize_legend = 26;
fontsize_ann = 32;
text_size = 26;

original_c = [209,17,65]./256;
reconstruction_c = [33,33,33]./256;

%% Parity plot:
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 0.6, 1]);
scatter(original, reconstruction, 3, reconstruction_c, 'filled'), hold on
scatter(original, original, 10, original_c, 'filled')
set(gca, 'FontSize', fontsize_axes)
xlabel(['Observed $\rm{', var_name, '}$ [', var_unit, ']'], 'FontSize', fontsize_label)
ylabel(['Recovered $\rm{', var_name, '}$ [', var_unit, ']'], 'FontSize', fontsize_label)
grid on
box on
xlim([min(min(reconstruction), min(original)), max(max(reconstruction), max(original))])
ylim([min(min(reconstruction), min(original)), max(max(reconstruction), max(original))])

range_length = max(max(reconstruction), max(original)) - min(min(reconstruction), min(original));

if min(min(reconstruction), min(original)) < 0
    x_pos = 0.9*min(min(reconstruction), min(original)); y_pos = 0.85*range_length + min(min(reconstruction), min(original));
else
    x_pos = 0.1*min(min(reconstruction), min(original)); y_pos = 0.85*range_length + min(min(reconstruction), min(original));
end
text(x_pos, y_pos, text_ann, 'FontSize', fontsize_ann)

% Save plot:
filename = [destination, 'pp_variable_', var_name, '.png'];
saveas(gcf, filename, 'png');
hold off

end