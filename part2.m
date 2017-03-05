clear all;
close all;
clc;

% File name
FILE_NAME	= 'search_maze/maze1.txt';
NOISE_SET   = {0.00 0.30};
DISCOUNT    = 0.9;
IT          = 100;

% Libraries
addpath(genpath('search_maze'));
addpath(genpath('nav_maze'));
addpath(genpath('maze_helper'));
 
hist = zeros(IT,2*size(NOISE_SET,2),2);
for m=1:2
    for n=1:size(NOISE_SET,2)

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
            [Q(:,s),p(:,s)] = solve_mdp(aux, NOISE_SET{n}, DISCOUNT, IT);
        end

        % Executing solution
        for i=1:IT
            hist(i,n,m) = run_pomdp(maze, NOISE_SET{n}, DISCOUNT, IT, Q, p, m);
        end

    end
end

% Plotting results
dom = -3:0.01:3;
hold on;
for m=1:2
    for n=1:size(NOISE_SET,2)
        plot(dom,normpdf(dom,mean(hist(:,n,m)),std(hist(:,n,m))));
    end
end
grid on;
legend('ML - Noise: 0.00','ML - Noise: 0.30','QMDP - Noise: 0.00','QMDP - Noise: 0.30');
xlabel('Reward');
ylabel('Likelihood');