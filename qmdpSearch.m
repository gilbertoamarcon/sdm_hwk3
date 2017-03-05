% dir = qmdpSearch(cur, maze, Q, b)
% QMDP action selection
% Input (cur): current robot position
% Input (b): belief state
% Input (maze): maze object
% Input (Q): value function
% Output (dir): action selected
% Written by Gilberto Marcon, 2017

function dir = qmdpSearch(cur, b, maze, Q)
    v = zeros(4,1);
    for a=1:4
        s = move_maze(maze,cur,a,0);
        v(a) = Q(s,:)*b;
    end
    [~,dir] = max(v);
end