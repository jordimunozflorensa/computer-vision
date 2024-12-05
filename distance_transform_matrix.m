%% Dilatació
% dilatar blancs és el mateix que erosionar negres

ee = [1, 1, 1]; % element estructural

im = false(128);
im(64,:) = 1;   
im(:,64) = 1;   

figure; imshow(im); title('Imatge original');
pause(1);

rows = 128;
columns = 128;

imatge_dialatada = im;

for i = 1:rows
    for j = 1:columns
        if im(i,j) == 1
            for k = -1:1
                if i + k >= 1 && i + k <= rows
                    imatge_dialatada(i + k, j) = 1;
                end
                if j + k >= 1 && j + k <= columns
                    imatge_dialatada(i, j + k) = 1;
                end
            end
        end
    end
end

figure; imshow(imatge_dialatada); title('Imatge dilatada pic i pala');
pause(1);

%% Dilatació amb funció implementada

res2 = imdilate(im,ee');
figure; imshow(res2); title('Imatge dilatada verticalment');
pause(1);

res3 = imdilate(im,ee);
figure; imshow(res3); title('Imatge dilatada horitzontalment');
pause(1);

res4 = imdilate(res3, ee');
figure; imshow(res4); title('Imatge dilatada');
pause(1);

%% Erosió
ee = [1, 1, 1]; % element estructural

im = false(128);
im(61:65,:) = 1;   
im(:,61:65) = 1;   

figure; imshow(im); title('Imatge original');

rows = 128;
columns = 128;

imatge_erosionada = im;

for i = 1:rows
    for j = 1:columns
        if im(i,j) == 0
            for k = -1:1
                if i + k >= 1 && i + k <= rows
                    imatge_erosionada(i + k, j) = 0;
                end
                if j + k >= 1 && j + k <= columns
                    imatge_erosionada(i, j + k) = 0;
                end
            end
        end
    end
end

figure; imshow(imatge_erosionada); title('Imatge erosionada pic i pala');
pause(1);

%% Erosió amb funció implementada

im = imread('blob.tif');
figure; imshow(im); title('Imatge original');
pause(1);

ee = strel('disk', 5);
dil = imdilate(im, ee);
ero =imerode(im, ee);

figure; imshow(dil); title('Imatge dilatada');
pause(1);
figure; imshow(ero); title('Imatge erosionada');
pause(1);

%% experiment

klap = fspecial('laplacian');
im_lap = imfilter(double(im), klap);

figure; imshow(im_lap, []); title('Imatge amb laplacia');
pause(1);

ee = strel('disk',1);
pos = im_lap > 0;
neg = im_lap < 0;

figure; imshow(pos, []); title('positius');
pause(1);

figure; imshow(neg, []); title('negatius');
pause(1);

posdil = imdilate(pos, ee);
contorns = posdil & neg;

figure; imshow(contorns); title('Pasos per zero');
pause(1);

%% 

im = imread('blob3.tif');
figure; imshow(im); title('Imatge original');
pause(1);

dil = imdilate(im,ee);
ero = imerode(im,ee);
figure; imshow(dil); title('dil');
pause(1);
figure; imshow(ero); title('ero');
pause(1);

cext = dil - im;
figure; imshow(cext); title('Contorn extern');
pause(1);

cint = im - ero;
figure; imshow(cint); title('Contorn intern');
pause(1);

%% Laplacià morfològic

fusio = double(cint) - double(cext);
figure; imshow(fusio, []); title('Laplacià morfològic');
pause(1);

%% 

im = imread('touchcell.tif');
figure; imshow(im); title('Imatge original');
pause(1);

tdist = double(im);

ero = imerode(im, ee);
tdist = tdist + ero;

figure; imshow(tdist,[]); title('primera iteració');
pause(1);

ero = imerode(ero, ee);
tdist = tdist + ero;

figure; imshow(tdist,[]); title('segona iteració');
pause(1);

for i = 1:48
    ero = imerode(ero, ee);
    tdist = tdist + ero;
end

figure; imshow(tdist,[]); title('50 iteracions');
pause(1);

td = bwdist(im);
figure; imshow(td,[]); title('Transformacio de distancia inversa');
pause(1);
figure; mesh(td);

td = bwdist(~im);
figure; imshow(td,[]); title('Transformacio de distancia');
pause(1);

figure; mesh(td);