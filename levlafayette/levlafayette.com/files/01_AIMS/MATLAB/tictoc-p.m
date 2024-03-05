poolobj = parpool;
fprintf('Number of workers: %g\n', poolobj.NumWorkers);

tic
n = 400;
A = 1000;
a = zeros(n);

parfor i = 1:n
    a(i) = max(abs(eig(rand(A))));
end
toc
