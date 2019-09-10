clc, clear, close all

np_x = 100; np_y = 200;
mesh_x = [];
mesh_y = [];

vec_y = 0.01*(1:1:np_y);

for i = 1:1:np_x
    
    vec_x = 0.01*ones([np_y, 1]).*i;
    mesh_x = [mesh_x; vec_x];
    mesh_y = [mesh_y; vec_y'];
    
end

idx = [ones([np_x*np_y/2,1]); 2*ones([np_x*np_y/2,1])];

destination = 'example_';

plot_clusters_color_map(mesh_y, mesh_x, idx, destination)