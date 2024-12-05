im = imread('n2538.tif');
figure; imshow(im); title('imatge original');
pause(0.5);

ee = strel('disk', 3);
dil = imdilate(im, ee);
ero = imerode(dil, ee);
op = imopen(im, ee);
cl = imclose(im, ee);

figure;
subplot(2,2,1);imshow(dil);title('Dilatació');
subplot(2,2,2);imshow(ero);title('Erosió');
subplot(2,2,3);imshow(op);title('Open');
subplot(2,2,4);imshow(cl);title('Close');


%% Subtracció de soroll salt and pepper

im = imread('gull.tif');
soroll = imnoise(im, 'salt & pepper', 0.2);

ee = strel('disk', 1);
op = imopen(soroll, ee);
cl = imclose(op, ee);

figure;
subplot(1,3,1);imshow(im);title('Original');
subplot(1,3,2);imshow(op);title('Post op');
subplot(1,3,3);imshow(cl);title('Post op-cl');

%% Substracció de linies

im = imread('Birds.tif');

ee = strel('disk', 1);
op = imopen(im, ee);
cl = imclose(op, ee);

figure;
subplot(1,3,1);imshow(im);title('Original');
subplot(1,3,2);imshow(op);title('Post op');
subplot(1,3,3);imshow(cl);title('Post op-cl');

%% Top-hat

im = imread('nshadow.tif');
ee = strel('disk', 5);
th = imtophat(im, ee);
bh = imbothat(~im,ee);

figure;
subplot(1,3,1);imshow(im);title('Original');
subplot(1,3,2);imshow(th);title('Top hat');
subplot(1,3,3);imshow(bh);title('Bop hat');

%% exercici

im = imread('r4x2_256.tif');

ee = strel('rectangle', [60, 6]);
cl = imclose(im, ee);
% bottom-hat
bh = imsubtract(cl, im);
def = imbinarize(bh, 0.2);
res = bwareaopen(def, 5);

figure;
subplot(2,3,1);imshow(im);title('Original');
subplot(2,3,2);imshow(cl);title('Post op-cl');
subplot(2,3,3);imshow(bh, []);title('Bot hat');
subplot(2,3,4);imshow(def);title('Defectes');
subplot(2,3,5);imshow(res);title('Defectes grossos');
subplot(2,3,6);imshow(imfuse(im,res));title('resultat');

%% reconstrucció multinivell (atenuar per binaritzar)

im = imread('arros.tif');

marker = im;
marker(2:end-1, 2:end-1) = 0;
rec = imreconstruct(marker, im);
res = im-rec;

figure;
subplot(1,3,1);imshow(im);title('Original');
subplot(1,3,2);imshow(rec);title('Reconstrucció');
subplot(1,3,3);imshow(res);title('Arros sencers');

%% máxims i mínims locals

im = imread('astablet.tif');

ee = strel('disk', 20, 0);
op = imopen(im, ee);

rm = imregionalmax(op);

figure;
subplot(1,3,1);imshow(im);title('Original');
subplot(1,3,2);imshow(op);title('post open');
subplot(1,3,3);imshow(rm);title('post regionals');


