% Originated from http://www.mathworks.com/matlabcentral/newsreader/view_thread/15733
%
% Class to generate an icosahedron and get contact normals
%
% Examples:
% ball = SoccerBall;	% create an instance; constructor function will be executed
% ball.drawBall;		% draw an icosahedron
% [cp, cn] = ball.getContactNormal(iv, ratio);	% get contact normal

classdef SoccerBall < handle
	
	properties
		V;	% vertices of each facet of an icosahedron; 20x1 cell; 3x3 matrix in each cell
	end
	
	methods
		
		function obj = SoccerBall()
			% class constructor
			a = 2/(1+sqrt(5));
			obj.V = {
				[0 a -a; a 1 1; -1 0 0]		% vertices [v1x v2x v3x; v1y v2y v3y; v1z v2z v3z] of facet 1
				[0 -a a; a 1 1; 1 0 0]		% vertices of facet 2
				[0 0 -1; a -a 0; 1 1 a]		% and so on...
				[0 1 0; a 0 -a; 1 a 1]
				[0 0 1; a -a 0; -1 -1 -a]
				[0 -1 0; a 0 -a; -1 -a -1]
				[0 a -a; -a -1 -1; 1 0 0]
				[0 -a a; -a -1 -1; -1 0 0]
				[-a -1 -1; 1 0 0; 0 a -a]
				[-a -1 -1; -1 0 0; 0 -a a]
				[a 1 1; 1 0 0; 0 -a a]
				[a 1 1; -1 0 0; 0 a -a]
				[0 -1 -a; a 0 1; 1 a 0]
				[0 a 1; a 1 0; 1 0 a]
				[0 -a -1; a 1 0; -1 0 -a]
				[0 1 a; a 0 1; -1 -a 0]
				[0 -1 -a; -a 0 -1; -1 -a 0]
				[0 a 1; -a -1 0; -1 0 -a]
				[0 -a -1; -a -1 0; 1 0 a]
				[0 1 a; -a 0 -1; 1 a 0]
				};
		end
		
		function drawBall(obj)
			% plot an icosahedron
			for i=1:size(obj.V,1)
				h = patch(obj.V{i}(1,:), obj.V{i}(2,:), obj.V{i}(3,:), 'r');
				set(h,'facealpha',0.1,'edgealpha',0.2);
			end
			hold on; grid on;
			xlabel('x');
			ylabel('y');
			zlabel('z');
			axis equal;
			view([10 20]);
		end
		
		function [cp, cn] = getContactNormal(obj, iv, ratio)
			% Get a contact normal at an interpolated point from three vertices of iv-th facet with respect to ratio
			%
			% iv: index for iv-th facet vertices V{iv}; scalar
			% ratio: interpolation ratio corresponding to each vertex [r1; r2; r3]; 3x1 vector;
			%       sum of r1, r2, r3 should be 1; sum(ratio)=1
			% cp: contact point position [pix; piy; piz]; 3x1 vector
			% cn: inward-pointing direction of contact normal [nix; niy; niz]; 3x1 vector
			
			% check input arguments
			if iv > length(obj.V)
				error('Index iv should be less than or equal to 20, the number of facets of an icosahedron!');
			end
			if abs(sum(ratio)-1) > eps
				warning('The sum of ratio for interpolation is not 1! L1 normalized value will be used...');
				ratio = ratio./sum(ratio);
			end
			
			% contact point position; interpolated from three vertices of iv-th facet with respect to ratio
			cp = obj.V{iv} * ratio;
			
			% inward-pointing contact normal direction; inward-pointing normal vector of iv-th facet
			cn = cross(obj.V{iv}(:,2)-obj.V{iv}(:,1), obj.V{iv}(:,3)-obj.V{iv}(:,2));	% clockwise winding for inward-pointing
		end
		
	end
	
end

% Credits: Sung Kyun Kim (kimsk@cs.cmu.edu),16-741 Mechanics of Manipulation, Fall 2015