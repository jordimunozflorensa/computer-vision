%% K-means Clustering
im = imread('peppers.png');
figure; imshow(im); title('im original');
pause(0.5);

%% k-means
K = 2;
[files, columnes, chs] = size(im);

% transformem
vect = reshape(double(im), files*columnes, chs);
R = vect(:,1);
G = vect(:,2);
B = vect(:,3);

figure; scatter3(R,G,B,1); xlabel('R'), ylabel('G'), zlabel('B'); title('RGB space');
pause(0.5);

% apliquem kmeans
[cl_idx, cl_ctr] = kmeans(vect,K,'distance','cityblock');

% veiem etiquetes
figure; scatter3(R,G,B,1,cl_idx); xlabel('R'), ylabel('G'), zlabel('B'); title('RGB etiquetat');
pause(0.5);

% veiem centres
figure; scatter3(cl_ctr(:,1),cl_ctr(:,2),cl_ctr(:,3), 50); xlabel('R'), ylabel('G'), zlabel('B'); title('RGB centres');
pause(0.5);

% tornem a la forma original
eti = reshape(cl_idx, files, columnes);
figure; imshow(eti,[]); title('segmentació per kmeans amb escala de grisos');
pause(0.5);

%% mapejem els grisos a colors
rgb = ind2rgb(eti, cl_ctr/255);
figure; imshow(rgb); title('segmentació amb colors');
pause(0.5);

%% espai HSV

im_hsv = rgb2hsv(im);
vect_hs = reshape(im_hsv(:,:,1:2), files*columnes, 2);

figure; scatter(vect_hs(:,1), vect_hs(:,2),1); xlabel('H'), ylabel('S'), title('scatter 2d hsv');
pause(0.5);

[cl_idx2, cl_ctr2] = kmeans(vect_hs,K,'distance','cityblock');
eti2 = reshape(cl_idx2, files, columnes);
figure; imshow(eti2,[]); title('segmentació per kmeans espai HS');
pause(0.5);

%% hsv amb canvi de variables
im_hsv = rgb2hsv(im);
vect_hs = reshape(im_hsv(:,:,1:2), files*columnes, 2);

H = vect_hs(:,1);
S = vect_hs(:,2);

vect_hs(:,1) = S .*sin(2*pi*H);
vect_hs(:,2) = S .*cos(2*pi*H);

figure; scatter(vect_hs(:,1), vect_hs(:,2),1); xlabel('H'), ylabel('S'), title('scatter 2d hsv');
pause(0.5);

[cl_idx2, cl_ctr2] = kmeans(vect_hs,K,'distance','cityblock');
eti2 = reshape(cl_idx2, files, columnes);
figure; imshow(eti2,[]); title('segmentació per kmeans espai HS');
pause(0.5);

%% exercici
im = imread('cafe.tif');
figure; imshow(im); title('segmentació grans café');
pause(0.5);

imbw = imbinarize(im);
figure; imshow(imbw); title('im bw');
pause(0.5);

%%
Td = bwdist(imbw);
figure; imshow(Td, []); title('Transformada de distancia');
pause(0.5);

%%

marques = imextendedmin(-Td, 2);
grad = imimposemin(-Td, marques);

sega = watershed(grad);
figure; imshow(sega == 0); title('watershed');
pause(0.5);

res = imbw;
res(sega == 0) = 1;
figure; imshow(res); title('blobs separats');
pause(0.5);

ee = strel('disk',1);
clo = imclose(res,ee);

figure; imshow(clo); title('imatge separada neta');
pause(0.5);