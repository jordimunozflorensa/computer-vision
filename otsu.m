im = imread("arros.tif");
bw1 = im > 100;
bw2 = im > 150;
bw3 = im > 115;

figure;
subplot(2,2,1);imshow(dil);title('Ori');
subplot(2,2,2);imshow(bw1);title('llindar 100');
subplot(2,2,3);imshow(bw2);title('llindar 150');
subplot(2,2,4);imshow(bw3);title('llindar 115');

%% histograma per detectar al threshold

figure; imhist(im); title('histograma imoriginal');
pause(0.5);

%%

th = graythresh(im); % per defecte utilitza Otsu, maximitza variança inter
bw4 = im2bw(im, th);

figure; imshow(bw4); title('llindar Otsu');
pause(0.5);

%% moving averages

imtxt = imread('textsheet.jpg');

h=ones(31);
h=h/31/31;
K = 25;

res2=imfilter(imtxt,h,'conv');

res = imtxt > (res2 - K);

figure, imshow(res),title('moving averages');
pause(0.5);

%% operacions morfologiques

ee = strel('disk', 20);
bg = imopen(im, ee);
figure, mesh(bg),title('fons');
pause(0.5);

res = im-bg;

figure, imshow(res),title('grans');
pause(0.5);

th = graythresh(res); % per defecte utilitza Otsu, maximitza variança inter
final = im2bw(res, th);
figure, imshow(final),title('binaritzada');
pause(0.5);

%% etiquetatje

[eti, num] = bwlabel(final, 4);

figure, imshow(eti, []),title('etiquetada');
pause(0.5);
colormap('colorcube');

Dades = regionprops(eti, 'all');
area50 = Dades(50).Area;
Arees = [Dades.Area];

figure; bar(Arees);
pause(0.5);

max_A = max(Arees);
gros = find(Arees == max_A);

figure; imshow(eti==gros);
pause(0.5);
