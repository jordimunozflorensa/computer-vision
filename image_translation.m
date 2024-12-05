%% Entrega 3: T.2 Processat linial d'imatges I
im=imread('Que_es.png')
figure,imshow(im),title('imatge original')

im2=im+100;
figure,imshow(im2),title('offset')

im3=im*10;
figure,imshow(im3),title('escalar')

im4=255-im3; %im4=imcomplement(im3)
figure,imshow(im4),title('inversa')

%% Histograma pic i pala

%histo=imhist(im);
%figure, plot(histo)

gray = zeros(1, 256);  
[m, n] = size(im);

for i = 1:m
    for j = 1:n
        valor = im(i,j);  
        gray(valor + 1) = gray(valor + 1) + 1;
    end
end

bar(gray);
title('Histograma de la Imatge');
xlabel('Nivel de Gris');
ylabel('Frecuencia');

%% Imatge equalitzada
imeq=histeq(im);
figure,imshow(imeq),title('imatge equalitzada')

%% Transformacions
im=imread('lenna.tif');
figure,imshow(im),title('imatge original')
im2=imresize(im,0.25);
figure,imshow(im2), title('zoom x0.25')
im3=imresize(im, 2);
figure,imshow(im3), title('zoom x2')
im4=imresize(im2, 4);
figure,imshow(im4), title('restaurar imatge original')

im5=imrotate(im,45);
figure,imshow(im5), title('rotacio')

%% Transformacio afi
T=affine2d([1 0 0; 0.5 1 0; 0 0 1]);
im6=imwarp(im,T);
figure,imshow(im6), title('transformacio afi')

%%
im=imread('toycars1.png');
im2=imread('toycars2.png');
subplot(1,2,2),imshow(im)
subplot(1,2,1),imshow(im2)

res=imsubtract(im,im2);
figure,imshow(res)
res2= imabsdiff(im,im2);
figure,imshow(res2),title('diferencia absoluta')
