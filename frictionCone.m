% N: the number of contact points; scalar
% CP: a set of contact point positions [[pix; piy; piz] ...]; 3xN matrix
% CN: a set of inward-pointing directions of contact normals [[nix; niy; niz] ...]; 3xN matrix
% mu: the coefficient of (static) friction; scalar
% M: the number of side facets of a linearized polyhedral friction cone; scalar
% CPF: a set of contact point positions of edges of polyhedral friction cones [[pijx; pijy; pijz] ...]; 3x(NM) matrix
% CNF: a set of inward-pointing directions of edges of polyhedral friction cones [[sijx; sijy; sijz] ...]; 3x(NM) matrix
%
% Examples:
% i;							% index for i-th contact normal
% j;							% index for j-th edge of polyhedral friction cone of i-th contact normal
% CPi = CP(1:3, i);				% i-th contact point position
% CNi = CN(1:3, i);				% i-th contact normal direction
% CPFij = CPF(1:3, M*(i-1)+j);	% contact point position of j-th edge of polyhedral friction cone of i-th contact normal
% CNFij = CNF(1:3, M*(i-1)+j);	% contact normal direction of j-th edge of polyhedral friction cone of i-th contact normal

function [CPF, CNF] = frictionCone(CP, CN, mu, M)
    % write your code here
    N = size(CP, 2);
    NM = N*M;

    % compute CPF
    CPF = zeros(3, NM);
    for i = 1:N
        cp = CP(:, i);
        startIdx =  M*(i-1)+1;
        endIdx = M*i;
        CPF(:, startIdx:endIdx) = cp(:, ones(1, M));
    end

    % compute CNF
    CNF = zeros(3, NM);
    for i = 1:N
        Ri = computeRotMat(CN(:, i));
        for j = 1:M
            % eqn (7) in reference # 2
            d(:, j) = [1 ; mu*cos(2*j*pi/M); mu*sin(2*j*pi/M)];

            %normalize dj
            d(:, j) = d(:, j)/norm(d(:, j));

            % eqn (8) in reference # 2
            Sij = Ri * d(:,j);

            % compute CNF
            normcn = norm(CN(:,i));
            CNF(:, M*(i-1) + j) = Sij .* normcn; 
        end
    end
end

% Credits: Sung Kyun Kim (kimsk@cs.cmu.edu),16-741 Mechanics of Manipulation, Fall 2015