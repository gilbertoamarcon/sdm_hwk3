% dir = mostLikelySearch(cur, p)
% Maximum likelihood action selection
% Input (cur): current robot position
% Input (b): belief state
% Input (p): MDP policy set
% Output (dir): action selected
% Written by Gilberto Marcon, 2017

function dir = mostLikelySearch(cur, b, p)
    [~,m] = max(b);
    dir = p(cur,m);
end