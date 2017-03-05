% reward = run_pomdp(maze, noise, discount, it, Q, p, method)
% Simulates POMDP with the selected method
% Input (maze): maze object
% Input (noise): movement noise (chance of not correctly executing move)
% Input (discount): discount factor
% Input (it): number of iterations
% Output (Q): value function
% Output (p): policy function
% Output (method): [1] Maximum likelihood [2] QMDP
% Written by Gilberto Marcon, 2017

function reward = run_pomdp(maze, noise, discount, it, Q, p, method)

    % Libraries
    addpath(genpath('search_maze'));
    addpath(genpath('nav_maze'));
    addpath(genpath('maze_helper'));

    % Getting start
    [cur,num_nodes] = get_start(maze);
    cur = num_nodes;

    % Set initial reward
    reward = 0;

    % Set initial discount
    curDiscount = discount;

    % Initial belief 
    b = ones(num_nodes,1)/num_nodes;

    for i=1:it

        % Getting an observation
        obs = getObservation(maze,cur);

        % Belief update
        if obs == 1
            b = b*0;
            b(cur) = 1;
        else
            b(cur) = 0;
            b = b/sum(b);
        end
        v = b*0;
        for n=1:num_nodes
            for a=1:4
                aux = move_maze(maze,n,a,0);
                v(aux) = v(aux) + b(n)/4;
            end
        end
        b = v;

        % Display maze
        draw_maze(maze,cur,maze.reward,b);
%         pause(0.1);
        filename = sprintf('frames/out%d',i);
        saveas(gcf,filename,'fig');

        % Selecting action
        if method == 1
            % Maximum likelihood action
            dir = mostLikelySearch(cur, b, p);
        else
            % QMDP
            dir = qmdpSearch(cur, b, maze, Q);
        end

        % Attempt to move in action direction
        cur = move_maze(maze,cur,dir,noise);

        % Receive discounted reward if found target
        reward = reward+get_reward(maze,cur)*curDiscount;

        % Update discount
        curDiscount = curDiscount*discount;

        %target moves
        maze = moveTarget(maze);

    end

end
