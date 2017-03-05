clear all;
close all;
clc;

% File name
FILE_NAME	= 'search_maze/maze1.txt';
NOISE_SET   = {0.00 0.30};
NOISE       = 2;
DISCOUNT    = 0.9;
IT          = 100;

% Libraries
addpath(genpath('search_maze'));
addpath(genpath('nav_maze'));
addpath(genpath('maze_helper'));
 
% Loading maze
maze = load_maze(FILE_NAME);
[~,num_nodes] = get_start(maze);

% MDP solution
% Policy and Q for every possible target location
aux = maze;
Q = zeros(num_nodes,num_nodes);
p = zeros(num_nodes,num_nodes);
for s=1:num_nodes
    aux.reward = 0*aux.reward;
    aux.reward(s) = 1;
    [Q(:,s),p(:,s)] = solve_mdp(aux, NOISE_SET{NOISE}, DISCOUNT, IT);
end

% Executing solution
run_pomdp(maze, NOISE_SET{NOISE}, DISCOUNT, IT, Q, p, 2);
