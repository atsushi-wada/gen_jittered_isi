function out = gen_jittered_isi(a,b,td,nt,nr)
% GEN_JITTERED_ISI  Generate jittered ISI sequences.
%   OUT = GEN_JITTERED_ISI(A,B,TD,NT,NR) generates jittered ISI seuqneces
%   for NR runs, each consisting of NT trials. A and B specify the
%   minimum and maximum duration of each ISI, respectively. TD specifies 
%   the total duration of ISIs within each run.
%
%   Example:
%     min-max ISI                : 1-8 sec
%     total ISI duration per run : 64 sec
%     number of trials per run   : 32
%     number of runs             : 120
%
%     out = gen_jittered_isi(1,8,64,32,120)

% Check the number of input arguments
narginchk(5,5);

% Calculate the degree-of-freedom
df = td / nt;

% Generate random samples from a χ distribution
X = chi2rnd(df,[1,nt*1000]);

% Round X into integers
X = round(X);

% Limit X within [a,b]
X = X(X>=a & X<=b);

% Draw a histogram
hist(X,a:b);

% Generate ISI sequences
out = zeros(nr,nt);
for r = 1:nr
    while sum(out(r,:)) ~= td
        ind = randi(length(X),[1,nt]);
        out(r,:) = X(ind);
    end
end
