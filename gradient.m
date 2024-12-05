%% 1- crear la imatge
im = fspecial('gaussian', 257, 50);
im_double = double(im);
figure, mesh(im_double), title('imatge sintetica');
colormap jet; colorbar;
pause(1);

%% 2- gradient vertical y el horizontal, calcular el mòdul i direcció del gradient
Sy = fspecial('sobel');
Gy = imfilter(double(im), Sy,'conv');
figure; var = axes;
imshow(Gy,[]);title(var,'Sobel y');

pause(1);

Gx = imfilter(double(im), Sy','conv');
figure; var = axes;
imshow(Gx,[]);title(var,'Sobel x');
pause(1);

dir = atan2(Gy,Gx);
figure;imshow(dir, []);title('direcció del gradient');
colormap hsv; colorbar;

%% 3- representar el modul del gradient
mod = sqrt(Gx.^2+Gy.^2);
figure,imshow(mod, []),title('modul del gradient');
colormap jet; colorbar;
pause(1);

% el gradient més elevat el trobem en les zones en -sigma i +sigma que es
% quan tenim un canvi de creixement mes accelerat

%% 4- calcular histograma de la imatge d'orientacions del gradient

im_escalada = dir - min(dir(:));
im_escalada = im_escalada ./ max(im_escalada(:)) * 360;

num_bins = 360;
histo = histcounts(im_escalada, num_bins, 'BinLimits', [0, 360]);

figure; bar(0:359, histo);
xlabel('Orientació del Gradient (graus)'); ylabel('Freq');
title('Histograma orientacions gradient');

% l'histograma no és uniforme, veiem que es repeteix un patró cíclicament
% amb pics regulars perque los patrons de la imagen tenen una forma
% simétrica y periódica. Per això els gradients es distribueixen de manera
% unfiorme en certes direccions.
