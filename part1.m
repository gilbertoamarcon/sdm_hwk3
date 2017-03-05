clear all;
close all;
clc;

% File name
FILE_NAME	= 'nav_maze/maze0.txt';
NOISE       = {0.04 0.10 0.20 0.30};
DISCOUNT    = 0.9;
IT          = 100;

% Libraries
addpath(genpath('search_maze'));
addpath(genpath('nav_maze'));
addpath(genpath('maze_helper'));

% Loading maze
maze = load_maze(FILE_NAME);

hist = zeros(IT,2);
for n=1:1

    % Q value function and policy p
    [Q,p] = solve_mdp(maze, NOISE{n}, DISCOUNT, IT);
    a = char(8592+mod(p,4));

    % Plotting final value function
%     draw_maze(maze,1,a);
    draw_maze(maze,1,Q);

    % Navigation
    for i=1:IT
        hist(i,n) = qNavigate(maze, NOISE{n}, DISCOUNT, IT, p);
    end

end

% Plotting results
% dom = -10:0.1:10;
% hold on;
% for n=1:4
%     plot(dom,normpdf(dom,mean(hist(:,n)),std(hist(:,n))));
% end
% grid on;
% legend('Noise: 0.04','Noise: 0.10','Noise: 0.20','Noise: 0.30');
% xlabel('Reward');
% ylabel('Likelihood');