%% Transformacions morfològiques
% dilatacions amb markers

im = imread('blob3.tif');
figure; imshow(im); title('imatge original');
pause(0.5);

marker = true(size(im));
marker(2:end-1, 2:end-1) = 0;
figure; imshow(marker); title('imatge amb marques');
pause(0.5);


ee = strel('disk', 1);
dil = imdilate(marker,ee);
dilc = dil&im;
figure; imshow(dilc); title('dilatació condicional');
pause(0.5);

for i = 1:50
    dilc = imdilate(dilc,ee) & im;
end

figure; imshow(dilc); title('dilatació condicional xtimes');
pause(0.5);


%% funció equivalent

rec = imreconstruct(marker, im);
figure; imshow(rec); title('reconstrucció');
pause(0.5);

res = im-rec;
figure; imshow(res); title('celules senceres');
pause(0.5);

%% emplenar forats

im = imread('pcbholes.tif');
figure; imshow(im); title('imatge amb forats');
pause(0.5);
im = ~im;

figure; imshow(im); title('imatge complementaria');
pause(0.5);

marker = true(size(im));
marker(2:end-1, 2:end-1) = 0;

rec = imreconstruct(marker, im);

figure; imshow(rec); title('imatge complementaria sense forats');
pause(0.5);

rec = ~rec;

figure; imshow(rec); title('imatge sense forats');
pause(0.5);

forats = rec - (~im);
figure; imshow(forats); title('forats');
pause(0.5);

%% forats que no comencen a les cantonades
% es pot resoldre mitjançant algorismes morfològics pq tenen diferents
% formes i les formes dels elements son constants

im = imread('tools.tif');
figure; imshow(im); title('imatge original');
pause(0.5);

ee = strel('disk', 7);
marker = imerode(im, ee);

figure; imshow(marker); title('markers');
pause(0.5);

rec = imreconstruct(marker, im);
figure; imshow(rec); title('reconstruida');
pause(0.5);

%% lapis i clau anglesa

im = imread('tools.tif');
figure; imshow(im); title('imatge original');
pause(0.5);

ee2 = strel('line', 60, 0);
marker = imerode(im, ee2);
figure; imshow(marker); title('marques llapis i clau');
pause(0.5);

rec = imreconstruct(marker, im);
figure; imshow(rec); title('llapis i clau');
pause(0.5);

%% opening i closing
% opening eliminarà les estructures blanques més petites que l'ee,
% erosionar, dilatar
% closing eliminarà les estructures negres més petites que l'ee, dilatar,
% erosionar

im = imread('blob.tif');
figure; imshow(im); title('imatge original');
pause(0.5);

ee = strel('disk', 5);
ero = imerode(im, ee);
open = imdilate(ero, ee);
% open = imopen(im, ee);

figure; imshow(open); title('opening');
pause(0.5);

ee = strel('disk', 5);
dil = imdilate(im, ee);
close = imerode(dil, ee);
% open = imclose(im, ee);

figure; imshow(close); title('closing');
pause(0.5);


%% roda dentada

im = imread('gear.tif');
figure; imshow(im); title('imatge original');
pause(0.5);

ee = strel('disk', 20);
open = imopen(im, ee);

figure; imshow(open); title('imatge sense dents');
pause(0.5);

dents = im - open;
figure; imshow(dents); title('dents');
pause(0.5);

ee = strel('disk', 20, 0);
open = imopen(im, ee);

figure; imshow(open); title('imatge sense dents ee circular');
pause(0.5);

dents = im - open;
figure; imshow(dents); title('dents ee circular');
pause(0.5);

%% etiquetatge

eti = bwlabel(dents, 8);

figure; imshow(eti, []); title('imatge etiquetada');
colormap colorcube;
pause(0.5);

Dades = regionprops(eti, 'Area');
Arees = [Dades.Area];
