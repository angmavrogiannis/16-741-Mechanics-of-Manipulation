% N: the number of contact points; scalar
% M: the number of side facets of a linearized polyhedral friction cone; scalar
% CP: a set of contact point positions [[pix; piy; piz] ...]; 3x(NM) matrix
% CN: a set of inward-pointing directions of contact normals [[nix; niy; niz] ...]; 3x(NM) matrix
% W: a set of normalized contact screws [[cix; ciy; ciz; c0ix; c0iy; c0iz] ...] such that norm([cix; ciy; ciz])=1; 6x(NM) matrix
%
% Examples:
% i;					% index for i-th contact normal
% CPi = CP(1:3, i);		% i-th contact point position
% CNi = CN(1:3, i);		% i-th contact normal direction
% Wi = W(1:6, i);		% normalized screw coordinates of i-th contact normal

function [W] = contactScrew(CP, CN)
% write your code here
    N = size(CP,2);
    for i = 1:N
        % Normalize direction vector
        CNn(:,i) = CN(:,i)/norm(CN(:,i));
        
        % compute cross pdt between CNn and CP
        cpdt = cross(CP(:,i),CNn(:,i));

        % compute contact screws
        W(1:3,i) = CNn(:,i); 
        W(4:6,i) = cpdt;
    end
end

% Credits: Sung Kyun Kim (kimsk@cs.cmu.edu),16-741 Mechanics of Manipulation, Fall 2015