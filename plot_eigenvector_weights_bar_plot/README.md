# Bar plot of eigenvector weights

```matlab
plot_eigenvector_weights_bar_plot(A, n_mode_sets, n_request_eigvecs, mode_name, annotations, labels, colors, destination, prefix)
```

This function plots annotated bar plots from normalized eigenvector weights.

## Example quick plotting

For a quick plotting you can use default `annotations = {}` (DNS1), no `labels = {}` and default grayscale `colors = {}`. Use the function as follows:

```matlab
plot_eigenvector_weights_bar_plot(A, 3, 1, 'mode', {}, {}, {}, '', '')
```

## Example plotting

```matlab
clc, clear all, close all
data_aliases = {'Set 1', 'Set 2'};
variables = {'$\rm{A_1}$', '$\rm{A_2}$', '$\rm{A_3}$', '$\rm{A_4}$', '$\rm{A_5}$'};
colors = [
[0 0 0 ] % black
[0.7 0.7 0.7] % light gray
];
A = [1; 0.7; 0.1; -0.1; 0.4;
    0.9; 0.8; 0.09; -0.09; 0.45];

plot_eigenvector_weights_bar_plot(A, 2, 1, 'mode', variables, data_aliases, colors, 'example', '');
```

![Screenshot](example.png)
