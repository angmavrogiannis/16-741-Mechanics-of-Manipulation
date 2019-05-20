% Execution script to test your code for Part 2
%
% FRIC: a flag which is false (or 0) for frictionless contact and true (or 1) for frictional contact; boolean

function part2(FRIC)

% check input arguments
if nargin ~= 1
	FRIC = false;
end


%% Create and draw a soccer ball

% make a class instance
ball = SoccerBall;

% draw an icosahedron
figure;
ball.drawBall;

% % get a single contact normal; but you probably need more
% iv = 20;
% ratio = ones(3,1)./3;
% [cp, cn] = ball.getContactNormal(iv, ratio);


%% Find a force closure grasp
switch (FRIC)	% flag for contact condition
	
	case 0		% frictionless contact
		
		% write your code here
		% write your code here
		% write your code here
		N = 7;
		[~, CP, W, zmax, bFC] = solver(ball, N, 100, 0, NaN);

		% draw contact screws
		drawContactScrew(CP, W);
		
		% print out results
		N
		CP
		W
		zmax
		
	case 1		% frictional contact
		
		% friction coefficient
		mu = 0.3;
		
		% the number of side facets of a linearized polyhedral friction cone
		M = 10;

		% write your code here
		% write your code here
		% write your code here
		N = 3;
		[CPF, CP, WF, zmaxF, bFC] = solver(ball, N, 100, mu, M);
		
		% draw contact screws
		drawContactScrew(CPF, WF, M);
		
		% print out results
		N
		CP
		zmaxF
		
end

% Credits: Sung Kyun Kim (kimsk@cs.cmu.edu),16-741 Mechanics of Manipulation, Fall 2015
