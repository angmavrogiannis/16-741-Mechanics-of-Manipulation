% n: inward-pointing direction of a contact normal [nx; ny; nz]; 3x1 vector
% R: a rotation matrix with positive x-axis aligned with n; 3x3 matrix
%
% NOTE: As only one direction vector is specified, there is one redundant degree of freedom in the determination of R

function [R] = computeRotMat(n)
    % write your code here
    % define x axis
    xaxis = [1, 0, 0];

    % compute rotation between x axis and normal
    rotation = vrrotvec(xaxis, n);

    % convert to rotation matrix form
    R = axang2rotm(rotation);
end

% Credits: Sung Kyun Kim (kimsk@cs.cmu.edu),16-741 Mechanics of Manipulation, Fall 2015