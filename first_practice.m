%% 1. Genera una matriu A de 10x10 amb valors aleatoris entre 0 i 255 de tipus enter
A = randi([0, 255], 10, 10);
disp('Matriu A:');
disp(A);

%% 2. Obté un vector amb la 4ª fila de A
fila_4 = A(4, :);
disp('4ª fila de A:');
disp(fila_4);

%% 3. Obté un vector amb la 4ª columna de A
columna_4 = A(:, 4);
disp('4ª columna de A:');
disp(columna_4);

%% 4. Obté una matriu on s'hagi suprimit la 4ª columna de A
A_sense_columna_4 = A;
A_sense_columna_4(:, 4) = [];
disp('Matriu sense la 4ª columna de A:');
disp(A_sense_columna_4);

%% 5. Obté un vector amb el valor màxim de cada columna de A
max_per_columna = max(A);
disp('Màxims per columna:');
disp(max_per_columna);

%% 6. Obté el valor màxim de la matriu A
max_A = max(A(:));
disp('Màxims de la matriu A:');
disp(max_A);

%% 7. Obté una matriu amb només les files parells de A
files_parells_A = A(2:2:end, :);
disp('Files parells de A:');
disp(files_parells_A);

%% 8. Obté la fila i columna on es troba el valor mínim de A
[min_A, ind_min_A] = min(A(:));
[fila_min, columna_min] = ind2sub(size(A), ind_min_A);
disp('Posición del mínimo de A:');
disp(['Fila: ', num2str(fila_min), ', Columna: ', num2str(columna_min)]);

%% 9. Genera la matriu B trasposant la matriu A
B = A';
disp('Matriu B (transposada de A):');
disp(B);

%% 10. Obté el producte de les matrius A i B
producte_AB = A * B;
disp('Producte de A i B:');
disp(producte_AB);

%% 11. Obté el producte element a element de A i B
producte_element_a_element = A .* B;
disp('Producte element a element de A i B:');
disp(producte_element_a_element);

%% 12. Genera una matriu booleana on cada element (i,j) valgui 1 si A(i,j) > B(i,j), i 0 en cas contrari
matriu_booleana = A > B;
disp('Matriu booleana (A > B):');
disp(matriu_booleana);

%% 13. Genera un vector amb tots els elements A(i,j) més grans que B(i,j)
elements_A_mes_grans_B = A(A > B);
disp('Elements de A majors que B:');
disp(elements_A_mes_grans_B);

%% 14. Genera una matriu on cada element (i,j) valgui A(i,j) si A(i,j)>B(i,j), i 0 en cas contrari
matriu_condicional = A .* (A > B);
disp('Matriu condicional (A(i,j) si A(i,j) > B(i,j), 0 sino):');
disp(matriu_condicional);
