function plotOrbit3(fignum, R, hue)

% Create figure to plot into
hold on;

% Load the basic MATLAB earth topographic data
load('topo.mat','topo','topomap1');

% Clear the axis
cla reset

% Create the earth surface.
RE = 6371;
[x,y,z] = sphere(50);
x = RE*x*0.99;
y = RE*y*0.99;
z = RE*z*0.99;
props.AmbientStrength = 0.1;
props.DiffuseStrength = 1;
props.SpecularColorReflectance = .5;
props.SpecularExponent = 20;
props.SpecularStrength = 1;
props.FaceColor= 'texture';
props.EdgeColor = 'none';
props.FaceLighting = 'phong';
props.Cdata = topo;
load topo
zlimits = [min(topo(:)) max(topo(:))];
demcmap(zlimits);

shading('interp')
surface(x,y,z,props);


% Add lights.
light('position',[-1 0 1]);
light('position',[-1.5 0.5 -0.5], 'color', [.6 .2 .2]);

% Plot the satellite trajectory
hold on
plot3(R(1,:),R(2,:),R(3,:), hue, 'LineWidth', 3);

% Set the view.
axis square off
axis equal

% Make a black sky:
whitebg(fignum,'k');

end