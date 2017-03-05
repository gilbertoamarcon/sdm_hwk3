% [Q,p] = solve_mdp(maze, noise, discount, it)
% Value iteration MDP solving
% Input (maze): maze object
% Input (noise): movement noise (chance of not correctly executing move)
% Input (discount): discount factor
% Input (it): number of iterations
% Output (Q): value function
% Output (p): policy function
% Written by Gilberto Marcon, 2017

function [Q,p] = solve_mdp(maze, noise, discount, it)

    % Libraries
    addpath(genpath('search_maze'));
    addpath(genpath('nav_maze'));
    addpath(genpath('maze_helper'));

    % Getting maze size
    [~,num_nodes] = get_start(maze);

    % Q value function
    Q = zeros(num_nodes,1);

    % Policy function
    p = zeros(num_nodes,1);

    % Value iteration
    for i=1:it

        % For each state s
        for s=1:num_nodes

            % Getting all succesor states s' from s
            % For each action a from s
            n = zeros(4,1);
            for a=1:4

                % Check if this is a valid move
                n(a) = is_move_valid(maze,s,a);

                % If not, stay still
                if(n(a) == -1)
                    n(a) = s;
                end

            end

            % Utility of successor states
            U = Q(n);

            % P(s'|s,a)
            P = (noise/4)*ones(4);
            P = P + (1-noise)*eye(4);

            % max_a P(s'|s,a) * U(s')
            [m, p(s)] = max(P*U);

            % Reward
            R = get_reward(maze,s);

            % Value function iteration
            Q(s) = R + discount*m;

        end

    end

end
