%% Convolució
kernel = [0, 1, 0; 1, 2, 1; 0, 1, 0]; % kernel senars, han de tenir centre
kernel = kernel/6;

im =ones(256);

im(1:128, 1:128) = 0;
im(129:256, 129:256) = 0;

figure; imshow(im), title('Imatge original'); 

g = convolucio2D(im, kernel);

figure, imshow(g), title('Imatge convolucionada');

function g = convolucio2D(f, k);
    [filas_f, columnas_f] = size(f);
    [filas_k, columnas_k] = size(k);
    
    offset_x = floor(filas_k / 2);
    offset_y = floor(columnas_k / 2);
    
    g = zeros(filas_f, columnas_f);
    
    for i = 1:filas_f
        for j = 1:columnas_f
            suma = 0;
            for kx = 1:filas_k
                for ky = 1:columnas_k
                    x = i - offset_x + kx - 1;
                    y = j - offset_y + ky - 1;
                    if x > 0 && x <= filas_f && y > 0 && y <= columnas_f
                        suma = suma + k(kx, ky) * f(x, y);
                    end
                end
            end
            g(i, j) = suma;
        end
    end
end

%% funció convolució

res=imfilter(im, kernel, "replicate", 'conv');
figure, imshow(res), title('convolució 3x3');

h=ones(31);
h=h/31/31;
res2=imfilter(im,h,"replicate", 'conv');
figure, imshow(res2),title('convolució 31x31');

%% suavitzats

% soroll lineal, filtratge lineal (gauss)
% soroll no lineal, filtratge no lineal (mediana)
kernel_gaussia = fspecial("gaussian",7,2);

im=imread('gull.tif');
figure, imshow(im),title('imatge centrada');

img=imnoise(im, "gaussian");
figure, imshow(img), title('soroll gaussia');
im_suavitzat=imfilter(im,kernel_gaussia, "replicate", 'conv');
figure, imshow(im_suavitzat), title('post kernel gaussia');

im_sp=imnoise(im, 'salt & pepper', 0.2);
figure, imshow(im_sp), title('soroll impulsional');
res_sp=imfilter(im_sp,kernel_gaussia, "replicate", 'conv');
figure, imshow(res_sp), title('filtratge salt & pepper');

resmed=medfilt2(im_sp,[5,5]);
figure, imshow(resmed), title('filtratge mediana');
