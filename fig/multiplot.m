clear all;
close all;
clc;

% FILE_NAMES     = {...
%                 'q_04.fig', 'p_04.fig', ...
%                 'q_10.fig', 'p_10.fig', ...
%                 'q_20.fig', 'p_20.fig', ...
%                 'q_30.fig', 'p_30.fig'};
% 
% PLOT_NAMES     = {...
%                 'Q for 0.04 Noise', 'Policy for 0.04 Noise', ...
%                 'Q for 0.10 Noise', 'Policy for 0.10 Noise', ...
%                 'Q for 0.20 Noise', 'Policy for 0.20 Noise', ...
%                 'Q for 0.30 Noise', 'Policy for 0.30 Noise'};

FILE_NAMES     = {...
                'ML/out86.fig', 'QMDP/out78.fig', ...
                'ML/out87.fig', 'QMDP/out79.fig', ...
                'ML/out88.fig', 'QMDP/out80.fig', ...
                'ML/out89.fig', 'QMDP/out81.fig'};

PLOT_NAMES     = {'Maximum Likelihood', 'QMDP'};

ax_vec = zeros(8);
for i=1:8
    h = openfig(FILE_NAMES{i},'reuse','invisible');
    ax_vec(i) = gca;
end

h = figure(9);
for i=1:8
    sub = subplot(4,2,i);
    copyobj(get(ax_vec(i),'children'),sub);
    axis equal;
    axis off;
    try
        title(PLOT_NAMES{i});
    catch
    end
end