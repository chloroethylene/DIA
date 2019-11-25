function labels = gaussian_shaped_labels(sigma, sz)

%evaluate a Gaussian with the peak at the center element
[rs, cs] = ndgrid((1:sz(1)) - floor(sz(1)/2), (1:sz(2)) - floor(sz(2)/2));
labels = exp(-0.5 / sigma^2 * (rs.^2 + cs.^2));

%move the peak to the top-left, with wrap-around
labels = circshift(labels, -floor(sz(1:2) / 2) + 1);

%sanity check: make sure it's really at top-left
assert(labels(1,1) == 1)
