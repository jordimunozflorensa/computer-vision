im = imread('head.png');
im = imresize(im, 0.5);
figure; imshow(im); title('im original');
pause(0.5);

%% calcul de la compacitat

area = sum(im(:));

ero = imerode(im, strel('disk',1));
cont = imsubtract(im,ero);

figure; imshow(cont); title('contorn imatge');
pause(0.5);

perim = sum(cont(:));

C = 4*pi*area/perim/perim;

%% Contorn a píxels
Dades = regionprops(im,'all'); % puc obtenir la convex hull i mes propietats

[fila, col] = find(cont,1);
B = bwtraceboundary(cont, [fila,col], 'E');

%% Fourier
mig = mean(B);

Bc = B - mig;

s = Bc(:,1) + i*Bc(:,2);

z = fft(s);
figure; plot(abs(z)); title('espectre');
pause(0.5);

%%
figure; plot(log(abs(z))); title('espectre escala logaritmica');
pause(0.5);

ss = ifft(z);
files = round(real(ss)+mig(1));
cols = round(imag(ss)+mig(2));

aux = zeros(size(im));
aux(sub2ind(size(aux), files, cols)) = 1;

figure; imshow(aux); title('imatge original recuperada');
pause(0.5);

%%
N = 30;
tmp = z;
tmp(N+1:end-N) = 0;
figure; plot(log(abs(tmp))); title('espectre 30 components');
pause(0.5);

mida = 500;
ss2 = ifft(tmp);
aux = zeros(mida);
files = round(real(ss2)+250);
cols = round(imag(ss2)+250);
aux(sub2ind(size(aux), files, cols)) = 1;

figure; imshow(aux); title('imatge amb 30 descriptors');
pause(0.5);