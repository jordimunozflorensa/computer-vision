im = imread('rabbit.jpg');
figure; imshow(im); title('im original');
pause(0.5);
%%

ee = strel('disk', 5);
grad = imsubtract(imdilate(im, ee), imerode(im, ee));
figure; imshow(grad, []); title('imatge gradient');
mesh(grad);
pause(0.5);

%%
im_seg = watershed(grad);
figure; imshow(im_seg == 0); title('watershed');
pause(0.5);

%%
min_regional = imregionalmin(grad);
figure; imshow(min_regional, []); title('minims regionals');
pause(0.5);

%% eliminar minims més petits que una profunditat especifica
min_regional = imextendedmin(grad, 5);
figure; imshow(min_regional); title('minims profunditat 5');
pause(0.5);

%% fixar els minims
grad2 = imimposemin(grad, min_regional);
segm2 = watershed(grad2);
figure; imshow(segm2 == 0); title('watershed');
pause(0.5);

%% marques per forma

ee2 = strel('disk', 15);
grad3 = imclose(grad, ee2);
segm3 = watershed(grad3);
figure; imshow(segm3 == 0); title('watershed amb marques per forma');
pause(0.5);

%% 
grad4 = imclose(grad2, ee2);
segm3 = watershed(grad3);
figure; imshow(segm3 == 0); title('watershed amb marques per forma');
pause(0.5);


%% separació d'objectes que es toquen

im = imread('touchcell.tif');
figure; imshow(im); title('im original');
pause(0.5);

Td = bwdist(~im);
figure; imshow(Td, []); title('Transformada de distancia');
pause(0.5);

figure; mesh(Td);
pause(0.5);

% li hem de donar la volta a la transformada de distancia
segm = watershed(-Td);
figure; imshow(segm == 0); title('watershed');
pause(0.5);

res = im;
res(segm == 0) = 0;
figure; imshow(res); title('blobs separats');
pause(0.5);


%% 
im = imread('arros.tif');
ee = strel('disk', 20);
grans = imtophat(im, ee);
figure; imshow(grans); title('iluminacio unirfome');
pause(0.5);

imbw = imbinarize(grans, graythresh(grans));
figure; imshow(imbw); title('im binaritzada');
pause(0.5);

Td = bwdist(~imbw);
figure; imshow(Td, []); title('Transformada de distancia');
pause(0.5);

marques = imextendedmin(-Td, 3);
grad = imimposemin(-Td, marques);

sega = watershed(grad);
figure; imshow(sega == 0); title('watershed');
pause(0.5);

res = imbw;
res(sega == 0) = 0;
figure; imshow(res); title('blobs separats');
pause(0.5);
