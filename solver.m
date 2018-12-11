function [retCPF, retCP, retW, retzmax, retbFC] = solver(ball, N, iterations, mu, M)
	CP = zeros(3,N);
	CN = zeros(3,N);
	
	W = NaN;
	zmax = NaN;
    CPF = NaN;
	bFC = 0;

	for k = 1:iterations
		inds = randsample(20, N);
		for i = 1:N
            c = rand(3, 1);
            c = c/sum(c);
            [CP(:,i), CN(:,i)] = ball.getContactNormal(inds(i), c);
        end
		if mu ~= 0
			[CPF, CNF] = frictionCone(CP, CN, mu, M);
			[W] = contactScrew(CPF, CNF);
		else
			[W] = contactScrew(CP, CN);
		end
        [bFC, zmax] = isForceClosure(W);
        if bFC==1
            break
        end
	end
	retCPF = CPF;
	retCP = CP;
	retW = W;
	retzmax = zmax;
	retbFC = bFC;
end