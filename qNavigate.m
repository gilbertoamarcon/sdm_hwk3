% reward = qNavigate(maze, noise, discount, it, policy)
% Moving around the maze following the policy
% Input (maze): maze object
% Input (noise): movement noise (chance of not correctly executing move)
% Input (discount): discount factor
% Input (it): number of iterations
% Input (policy): policy to follow
% Output (reward): net reward
% Written by Gilberto Marcon, 2017

function reward = qNavigate(maze, noise, discount, it, policy)

    % Policy arrows
    a = char(8592+mod(policy,4));
    
    % Start state index
    [cur,~] = get_start(maze);

    % Set initial reward
    reward = 0;

    % Set initial discount
    curDiscount = discount;

    for i=1:it

        % Move in random direction (replace with your MDP policy)
        dir = policy(cur);

        % Try to move in the direction
        cur = move_maze(maze,cur,dir,noise);

        % Receive discounted reward
        reward = reward + get_reward(maze,cur)*curDiscount;

        % Update discount
        curDiscount = curDiscount*discount;

        % Drawing mase
%         draw_maze(maze,cur,a);
%         pause(0.1);

    end
    
end