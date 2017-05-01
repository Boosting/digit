cd(fileparts(mfilename('fullpath')))
if (~exist('../data', 'var'))
    data = load('../data/mnist.mat');
end
if ~exist('../data/mat/train', 'dir')
    mkdir('../data/matt/train')
end
DEBUG = 0;
N = 50000;
num_per_img = 5;
w = (num_per_img + 2) * 28;
h = 28 * 2;
start_x = 28; end_x = w - 28;
stride = floor((end_x - start_x) / (num_per_img - 1));
xs = [start_x:stride:end_x];
if length(xs) > num_per_img
   xs = xs(1:num_per_img); 
end
assert(xs(end) < w);
%% training data
for i = 1:N
    if exist(['../data/mat/train/', num2str(i), '.mat'], 'file')
        disp(['file ''', '../data/mat/train/', num2str(i), '.mat''', ' exists, pass.'])
        continue;
    end
    im = zeros(h, w); lb = 10 * ones(h, w, 'uint8');
    idx = randperm(numel(data.train_label), num_per_img);
    y1 = ones([1,num_per_img]) * 28;
    shiftx = randi([-5,5], [1, num_per_img]);
    shifty = randi([-5,5], [1, num_per_img]);
    x1 = xs + shiftx;
    y1 = y1 + shifty;
    for j = 1:num_per_img
        im(y1(j)-13:y1(j)+14, x1(j)-13:x1(j)+14) = data.train_imgs(:,:,idx(j));
        lb(y1(j)-6:y1(j)+6, x1(j)-6:x1(j)+7) = data.train_label(idx(j));
    end
    im = im + randn(h, w) / 10; im(im < 0) = 0;
    save(['../data/mat/train/', num2str(i), '.mat'], 'im', 'lb');
    if DEBUG
       subplot(1,2,1); imshow(im);
       subplot(1,2,2); imshow(lb==10);
    end
    if mod(i, 100) == 0, disp(['processing ' num2str(i) ' of ' num2str(N) '...']);end
end
%% testing data
if ~exist('../data/mat/test', 'dir')
    mkdir('../data/matt/test')
end
for i=1:num_per_img:size(data.test_imgs, 3)
    if exist(['../data/mat/test/', num2str(i), '.mat'], 'file')
        disp(['file ''', '../data/mat/test/', num2str(i), '.mat''', ' exists, pass.'])
        continue;
    end
    im = zeros(h, w); lb = 10 * ones(h, w, 'uint8');
    idx = i:i+num_per_img;
    y1 = ones([1,num_per_img]) * 28;
    shiftx = randi([-5,5], [1, num_per_img]);
    shifty = randi([-5,5], [1, num_per_img]);
    x1 = xs + shiftx;
    y1 = y1 + shifty;
    for j = 1:num_per_img
        im(y1(j)-13:y1(j)+14, x1(j)-13:x1(j)+14) = data.test_imgs(:,:,idx(j));
        lb(y1(j)-6:y1(j)+6, x1(j)-6:x1(j)+7) = data.test_label(idx(j));
    end
    im = im + randn(h, w) / 10; im(im < 0) = 0;
    save(['../data/mat/test/', num2str(i), '.mat'], 'im', 'lb');
    if DEBUG
       subplot(1,2,1); imshow(im);
       subplot(1,2,2); imshow(lb==10);
    end
    if mod(i, 100) == 0, disp(['processing ' num2str(i) ' of ' num2str(numel(data.test_label)) '...']);end
end