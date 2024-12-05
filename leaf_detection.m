load df_fulles.mat;
tmp = df_norm(1,:);
ss = ifft(tmp);

mida = 600;
files = round(real(ss)+mida/2);
cols = round(imag(ss)+mida/2);

aux = logical(zeros(mida));
aux(sub2ind(size(aux), files, cols)) = 1;

figure; imshow(aux); title('erable, etiqueta 2');
pause(0.5);

%% un altre descriptor
tmp = df_norm(20,:);
ss = ifft(tmp);

mida = 600;
files = round(real(ss)+mida/2);
cols = round(imag(ss)+mida/2);

aux = logical(zeros(mida));
aux(sub2ind(size(aux), files, cols)) = 1;
figure; imshow(aux); title('roure, etiqueta 4');
pause(0.5);

%%
tmp = df_norm(end,:);
ss = ifft(tmp);

mida = 600;
files = round(real(ss)+mida/2);
cols = round(imag(ss)+mida/2);

aux = logical(zeros(mida));
aux(sub2ind(size(aux), files, cols)) = 1;
figure; imshow(aux); title('faig, etiqueta 15');
pause(0.5);

%% features

feat_vc = zeros(48,1000+1); % utilitzem les 1000 primeres pq estan duplicades
feat_vc(:,1:end-1) = abs(df_norm(:,1:1000));
feat_vc(:,end) = label_tree(:);

figure, bar(log(feat_vc(1, 1:1000))); title('espectre');
pause(0.5);