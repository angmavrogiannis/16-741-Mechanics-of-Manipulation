% W: a set of normalized contact screws [[cix; ciy; ciz; c0ix; c0iy; c0iz] ...]; 6x(NM) matrix
% bFC: a flag which is true if the grasp is force closure; boolean
% zmax: the maximum value of the objective function at the optimal point; scalar

function [bFC, zmax] = isForceClosure(W)
    % write your code here
    NM = size(W, 2);

    % compute centroid
    centroid = mean(W, 2);

    % compute coefficient matrix and b
    A = W - centroid;
    b = ones(NM, 1);

    % check for false postives
    if rank(A) ~= 6
        bFC = false;
        zmax = NaN;
    % solve LP
    else
        [~, zmin] = linprog(centroid, A', b);
        zmax = -zmin;
        bFC = zmax < 1;
    end
end

% Credits: Sung Kyun Kim (kimsk@cs.cmu.edu),16-741 Mechanics of Manipulation, Fall 2015