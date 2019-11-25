function model_wf = learn_CF(x, y, lambda)
% Please implement this function by yourself
%
% Kernel Ridge Regression, calculate alphas (in Fourier domain)
X = fft2(x);
Y = fft2(y);
model_wf = (conj(X).*Y)./(conj(X).*X+lambda);
end