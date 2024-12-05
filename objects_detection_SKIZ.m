%%
im = imread('blob3.tif');
figure; imshow(im); title('imatge original');
pause(1);

sk = bwskel(im);
figure; imshow(sk); title('esquelet de la imatge');
pause(1);

figure; imshow(imfuse(im,sk)); title('esquelet de la imatge + imatge original');
pause(1);

ee = strel('disk', 1);
ope = imopen(im,ee);
figure; imshow(ope); title('open de la imatge');
pause(1);

clo = imclose(ope,ee);
figure; imshow(clo); title('open-close de la imatge');
pause(1);

sk2 = bwskel(clo);
figure; imshow(sk2); title('esquelet de la imatge filtrada');
pause(1);

%% SKIZ
skiz = bwskel(~im);
figure; imshow(imfuse(im,skiz)); title('SKIZ');
pause(1);

%% exercici

im = imread('pcb1bin.tif');
figure; imshow(im); title('imatge original');
pause(1);

im = ~im;

marker = true(size(im));
marker(2:end-1, 2:end-1) = 0;

rec = imreconstruct(marker, im);
rec = ~rec;

figure; imshow(rec); title('imatge sense forats');
pause(0.5);

forats = rec - (~im);
figure; imshow(forats); title('forats');
pause(0.5);
%% 

ee_rect = strel('rectangle', [10,32]);
mark_rect = imerode(rec, ee_rect);
figure; imshow(mark_rect); title('marques rectangles');
pause(1);

ee = strel('rectangle', [12,34]);
rect_amb_forats = imdilate(mark_rect, ee);
forats_rect = rect_amb_forats&forats;
figure; imshow(forats_rect); title('forats rectangles');
pause(0.5);

rect = rect_amb_forats;

ori_sense_rect = (~rect) - (~rec);
figure; imshow(ori_sense_rect); title('original sense rectangles');
pause(0.5);

%%

ee = strel('disk', 9, 0);
aux = imerode(ori_sense_rect, ee);
figure; imshow(aux); title('aux');
pause(0.5);

e_square = strel('square', 21);
mark_quad = imdilate(aux, e_square);
figure; imshow(mark_quad); title('marques quadrats');
pause(1);

mark_quad = max(mark_quad, 0);

ori_sense_quad = ori_sense_rect - mark_quad;
figure; imshow(ori_sense_quad); title('original sense quad');
pause(0.5);

%%

ee = strel('disk', 8, 0);
aux = imerode(ori_sense_quad, ee);
figure; imshow(aux); title('aux');
pause(0.5);

e_cercles = strel('disk', 10, 0);
mark_cercles = imdilate(aux, e_cercles);
figure; imshow(mark_cercles); title('marques cercles');
pause(1);

mark_cercles = max(mark_cercles, 0);

ori_sense_cerc = ori_sense_quad - mark_cercles;
figure; imshow(ori_sense_cerc); title('original sense cercles');
pause(0.5);

%%
ori_sense_cerc = ori_sense_quad - mark_cercles;
figure; imshow(ori_sense_cerc); title('original sense cercles');
pause(0.5);

ee = strel('square', 5);
aux = imerode(ori_sense_cerc, ee);
figure; imshow(aux); title('aux');
pause(0.5);

e_linies = strel('square', 7);
mark_lines = imdilate(aux, e_linies);
figure; imshow(mark_lines); title('marques linies');
pause(1);

mark_lines = max(mark_lines, 0);

ori_sense_linies = ori_sense_cerc - mark_lines;
figure; imshow(ori_sense_linies); title('original sense linies');
pause(0.5);

%% 
rect = im2double(rect);
mark_quad = im2double(mark_quad);
mark_cercles = im2double(mark_cercles);
mark_lines = im2double(mark_lines);
ori_sense_linies = im2double(ori_sense_linies);

[rows, cols] = size(forats);
combined_image_rgb = zeros(rows, cols, 3);

combined_image_rgb(:, :, 1) = combined_image_rgb(:, :, 1) + 0 * forats; 
combined_image_rgb(:, :, 2) = combined_image_rgb(:, :, 2) + 1 * forats; 
combined_image_rgb(:, :, 3) = combined_image_rgb(:, :, 3) + 0 * forats;  

combined_image_rgb(:, :, 1) = combined_image_rgb(:, :, 1) + 1 * rect;  
combined_image_rgb(:, :, 2) = combined_image_rgb(:, :, 2) + 0 * rect; 
combined_image_rgb(:, :, 3) = combined_image_rgb(:, :, 3) + 0 * rect; 

combined_image_rgb(:, :, 1) = combined_image_rgb(:, :, 1) + 0 * mark_quad;  
combined_image_rgb(:, :, 2) = combined_image_rgb(:, :, 2) + 0 * mark_quad;  
combined_image_rgb(:, :, 3) = combined_image_rgb(:, :, 3) + 1 * mark_quad;  

combined_image_rgb(:, :, 1) = combined_image_rgb(:, :, 1) + 1 * mark_cercles;  
combined_image_rgb(:, :, 2) = combined_image_rgb(:, :, 2) + 0 * mark_cercles;  
combined_image_rgb(:, :, 3) = combined_image_rgb(:, :, 3) + 1 * mark_cercles;  

combined_image_rgb(:, :, 1) = combined_image_rgb(:, :, 1) + 1 * mark_lines;  
combined_image_rgb(:, :, 2) = combined_image_rgb(:, :, 2) + 1 * mark_lines;  
combined_image_rgb(:, :, 3) = combined_image_rgb(:, :, 3) + 0 * mark_lines; 

combined_image_rgb(:, :, 1) = combined_image_rgb(:, :, 1) + ori_sense_linies;  
combined_image_rgb(:, :, 2) = combined_image_rgb(:, :, 2) + ori_sense_linies;  
combined_image_rgb(:, :, 3) = combined_image_rgb(:, :, 3) + ori_sense_linies;  

figure;
imshow(combined_image_rgb);
title('Obra final');
pause(1);
