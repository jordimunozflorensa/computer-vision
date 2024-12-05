im = imread('rabbit.jpg');
figure; imshow(im); title('imatge original');
pause(0.5);

%%
Tl = 0.1;
Th = 0.4;
sigma = 2;

res = edge(im, 'canny', [Tl, Th], sigma);
figure; imshow(res); title('contorns');
pause(0.5);

%%

im = imread('rabbit.jpg');
if size(im, 3) == 3
    im = rgb2gray(im);
end

Tl_values = [0.05, 0.1, 0.15, 0.2];
Th_values = [0.3, 0.4, 0.5, 0.6];
sigma_values = [0.5, 1, 2, 3];

k = 1;
for i = 1:4
    for j = 1:4
        Tl = Tl_values(i);
        Th = Th_values(j);
        sigma = sigma_values(i);

        res = edge(im, 'canny', [Tl, Th], sigma);
        
        figure; imshow(res);
        title(['Tl = ' num2str(Tl) ', Th = ' num2str(Th) ', \sigma = ' num2str(sigma)]);
        
        k = k + 1;
    end
end
