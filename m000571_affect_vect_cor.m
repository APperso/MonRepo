% affect : correction brute à apporter

% entrée(s) : data_A...J(1:nmax)                  = données extraites
%             liste_bor_A...J(1:nmax)             = bornes
%             mat_er( 1:kmax_A , ... , 1:kmax_J ) = matrice d'erreur (remplie à 100%)

% sortie(s) : vect_cor(1:nmax)                    = correction brute à apporter


% ========================================================================================================================
% partie 1/2 : affect liste_k_A...J(1:nmax) = indices
% ========================================================================================================================


% ------------------------------------------------ répartition en 1 classe ------------------------------------------------

if Kmax==1
    
    % affect : liste_k_A = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        
        liste_k_A(n) = k_A;
    end
    
end

% ------------------------------------------------ répartition en 2 classes ------------------------------------------------

if Kmax==2
    
    % affect : liste_k_A...B = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    liste_k_B = zeros(1,nmax); % entre 1 et kmax_B
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        [k_B,~] = get_classe(data_B(n), liste_bor_B{k_A}) ;
        
        liste_k_A(n) = k_A;
        liste_k_B(n) = k_B;
    end
    
end

% ------------------------------------------------ répartition en 3 classes ------------------------------------------------

if Kmax==3
    
    % affect : liste_k_A...C = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    liste_k_B = zeros(1,nmax); % entre 1 et kmax_B
    liste_k_C = zeros(1,nmax); % entre 1 et kmax_C
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        [k_B,~] = get_classe(data_B(n), liste_bor_B{k_A}) ;
        [k_C,~] = get_classe(data_C(n), liste_bor_C{k_A,k_B}) ;
        
        liste_k_A(n) = k_A;
        liste_k_B(n) = k_B;
        liste_k_C(n) = k_C;
    end
    
end

% ------------------------------------------------ répartition en 4 classes ------------------------------------------------

if Kmax==4
    
    % affect : liste_k_A...D = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    liste_k_B = zeros(1,nmax); % entre 1 et kmax_B
    liste_k_C = zeros(1,nmax); % entre 1 et kmax_C
    liste_k_D = zeros(1,nmax); % entre 1 et kmax_D
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        [k_B,~] = get_classe(data_B(n), liste_bor_B{k_A}) ;
        [k_C,~] = get_classe(data_C(n), liste_bor_C{k_A,k_B}) ;
        [k_D,~] = get_classe(data_D(n), liste_bor_D{k_A,k_B,k_C}) ;
        
        liste_k_A(n) = k_A;
        liste_k_B(n) = k_B;
        liste_k_C(n) = k_C;
        liste_k_D(n) = k_D;
    end
    
end

% ------------------------------------------------ répartition en 5 classes ------------------------------------------------

if Kmax==5
    
    % affect : liste_k_A...E = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    liste_k_B = zeros(1,nmax); % entre 1 et kmax_B
    liste_k_C = zeros(1,nmax); % entre 1 et kmax_C
    liste_k_D = zeros(1,nmax); % entre 1 et kmax_D
    liste_k_E = zeros(1,nmax); % entre 1 et kmax_E
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        [k_B,~] = get_classe(data_B(n), liste_bor_B{k_A}) ;
        [k_C,~] = get_classe(data_C(n), liste_bor_C{k_A,k_B}) ;
        [k_D,~] = get_classe(data_D(n), liste_bor_D{k_A,k_B,k_C}) ;
        [k_E,~] = get_classe(data_E(n), liste_bor_E{k_A,k_B,k_C,k_D}) ;
        
        liste_k_A(n) = k_A;
        liste_k_B(n) = k_B;
        liste_k_C(n) = k_C;
        liste_k_D(n) = k_D;
        liste_k_E(n) = k_E;
    end
    
end

% ------------------------------------------------ répartition en 6 classes ------------------------------------------------

if Kmax==6
    
    % affect : liste_k_A...F = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    liste_k_B = zeros(1,nmax); % entre 1 et kmax_B
    liste_k_C = zeros(1,nmax); % entre 1 et kmax_C
    liste_k_D = zeros(1,nmax); % entre 1 et kmax_D
    liste_k_E = zeros(1,nmax); % entre 1 et kmax_E
    liste_k_F = zeros(1,nmax); % entre 1 et kmax_F
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        [k_B,~] = get_classe(data_B(n), liste_bor_B{k_A}) ;
        [k_C,~] = get_classe(data_C(n), liste_bor_C{k_A,k_B}) ;
        [k_D,~] = get_classe(data_D(n), liste_bor_D{k_A,k_B,k_C}) ;
        [k_E,~] = get_classe(data_E(n), liste_bor_E{k_A,k_B,k_C,k_D}) ;
        [k_F,~] = get_classe(data_F(n), liste_bor_F{k_A,k_B,k_C,k_D,k_E}) ;
        
        liste_k_A(n) = k_A;
        liste_k_B(n) = k_B;
        liste_k_C(n) = k_C;
        liste_k_D(n) = k_D;
        liste_k_E(n) = k_E;
        liste_k_F(n) = k_F;
    end
    
end

% ------------------------------------------------ répartition en 7 classes ------------------------------------------------

if Kmax==7
    
    % affect : liste_k_A...G = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    liste_k_B = zeros(1,nmax); % entre 1 et kmax_B
    liste_k_C = zeros(1,nmax); % entre 1 et kmax_C
    liste_k_D = zeros(1,nmax); % entre 1 et kmax_D
    liste_k_E = zeros(1,nmax); % entre 1 et kmax_E
    liste_k_F = zeros(1,nmax); % entre 1 et kmax_F
    liste_k_G = zeros(1,nmax); % entre 1 et kmax_G
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        [k_B,~] = get_classe(data_B(n), liste_bor_B{k_A}) ;
        [k_C,~] = get_classe(data_C(n), liste_bor_C{k_A,k_B}) ;
        [k_D,~] = get_classe(data_D(n), liste_bor_D{k_A,k_B,k_C}) ;
        [k_E,~] = get_classe(data_E(n), liste_bor_E{k_A,k_B,k_C,k_D}) ;
        [k_F,~] = get_classe(data_F(n), liste_bor_F{k_A,k_B,k_C,k_D,k_E}) ;
        [k_G,~] = get_classe(data_G(n), liste_bor_G{k_A,k_B,k_C,k_D,k_E,k_F}) ;
        
        liste_k_A(n) = k_A;
        liste_k_B(n) = k_B;
        liste_k_C(n) = k_C;
        liste_k_D(n) = k_D;
        liste_k_E(n) = k_E;
        liste_k_F(n) = k_F;
        liste_k_G(n) = k_G;
    end
    
end

% ------------------------------------------------ répartition en 8 classes ------------------------------------------------

if Kmax==8
    
    % affect : liste_k_A...H = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    liste_k_B = zeros(1,nmax); % entre 1 et kmax_B
    liste_k_C = zeros(1,nmax); % entre 1 et kmax_C
    liste_k_D = zeros(1,nmax); % entre 1 et kmax_D
    liste_k_E = zeros(1,nmax); % entre 1 et kmax_E
    liste_k_F = zeros(1,nmax); % entre 1 et kmax_F
    liste_k_G = zeros(1,nmax); % entre 1 et kmax_G
    liste_k_H = zeros(1,nmax); % entre 1 et kmax_H
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        [k_B,~] = get_classe(data_B(n), liste_bor_B{k_A}) ;
        [k_C,~] = get_classe(data_C(n), liste_bor_C{k_A,k_B}) ;
        [k_D,~] = get_classe(data_D(n), liste_bor_D{k_A,k_B,k_C}) ;
        [k_E,~] = get_classe(data_E(n), liste_bor_E{k_A,k_B,k_C,k_D}) ;
        [k_F,~] = get_classe(data_F(n), liste_bor_F{k_A,k_B,k_C,k_D,k_E}) ;
        [k_G,~] = get_classe(data_G(n), liste_bor_G{k_A,k_B,k_C,k_D,k_E,k_F}) ;
        [k_H,~] = get_classe(data_H(n), liste_bor_H{k_A,k_B,k_C,k_D,k_E,k_F,k_G}) ;
        
        liste_k_A(n) = k_A;
        liste_k_B(n) = k_B;
        liste_k_C(n) = k_C;
        liste_k_D(n) = k_D;
        liste_k_E(n) = k_E;
        liste_k_F(n) = k_F;
        liste_k_G(n) = k_G;
        liste_k_H(n) = k_H;
    end
    
end

% ------------------------------------------------ répartition en 9 classes ------------------------------------------------

if Kmax==9
    
    % affect : liste_k_A...I = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    liste_k_B = zeros(1,nmax); % entre 1 et kmax_B
    liste_k_C = zeros(1,nmax); % entre 1 et kmax_C
    liste_k_D = zeros(1,nmax); % entre 1 et kmax_D
    liste_k_E = zeros(1,nmax); % entre 1 et kmax_E
    liste_k_F = zeros(1,nmax); % entre 1 et kmax_F
    liste_k_G = zeros(1,nmax); % entre 1 et kmax_G
    liste_k_H = zeros(1,nmax); % entre 1 et kmax_H
    liste_k_I = zeros(1,nmax); % entre 1 et kmax_I
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        [k_B,~] = get_classe(data_B(n), liste_bor_B{k_A}) ;
        [k_C,~] = get_classe(data_C(n), liste_bor_C{k_A,k_B}) ;
        [k_D,~] = get_classe(data_D(n), liste_bor_D{k_A,k_B,k_C}) ;
        [k_E,~] = get_classe(data_E(n), liste_bor_E{k_A,k_B,k_C,k_D}) ;
        [k_F,~] = get_classe(data_F(n), liste_bor_F{k_A,k_B,k_C,k_D,k_E}) ;
        [k_G,~] = get_classe(data_G(n), liste_bor_G{k_A,k_B,k_C,k_D,k_E,k_F}) ;
        [k_H,~] = get_classe(data_H(n), liste_bor_H{k_A,k_B,k_C,k_D,k_E,k_F,k_G}) ;
        [k_I,~] = get_classe(data_I(n), liste_bor_I{k_A,k_B,k_C,k_D,k_E,k_F,k_G,k_H}) ;
        
        liste_k_A(n) = k_A;
        liste_k_B(n) = k_B;
        liste_k_C(n) = k_C;
        liste_k_D(n) = k_D;
        liste_k_E(n) = k_E;
        liste_k_F(n) = k_F;
        liste_k_G(n) = k_G;
        liste_k_H(n) = k_H;
        liste_k_I(n) = k_I;
    end
    
end

% ------------------------------------------------ répartition en 10 classes ------------------------------------------------

if Kmax==10
    
    % affect : liste_k_A...J = indices
    
    liste_k_A = zeros(1,nmax); % entre 1 et kmax_A
    liste_k_B = zeros(1,nmax); % entre 1 et kmax_B
    liste_k_C = zeros(1,nmax); % entre 1 et kmax_C
    liste_k_D = zeros(1,nmax); % entre 1 et kmax_D
    liste_k_E = zeros(1,nmax); % entre 1 et kmax_E
    liste_k_F = zeros(1,nmax); % entre 1 et kmax_F
    liste_k_G = zeros(1,nmax); % entre 1 et kmax_G
    liste_k_H = zeros(1,nmax); % entre 1 et kmax_H
    liste_k_I = zeros(1,nmax); % entre 1 et kmax_I
    liste_k_J = zeros(1,nmax); % entre 1 et kmax_J
    
    for n=1:nmax
        [k_A,~] = get_classe(data_A(n), liste_bor_A) ;
        [k_B,~] = get_classe(data_B(n), liste_bor_B{k_A}) ;
        [k_C,~] = get_classe(data_C(n), liste_bor_C{k_A,k_B}) ;
        [k_D,~] = get_classe(data_D(n), liste_bor_D{k_A,k_B,k_C}) ;
        [k_E,~] = get_classe(data_E(n), liste_bor_E{k_A,k_B,k_C,k_D}) ;
        [k_F,~] = get_classe(data_F(n), liste_bor_F{k_A,k_B,k_C,k_D,k_E}) ;
        [k_G,~] = get_classe(data_G(n), liste_bor_G{k_A,k_B,k_C,k_D,k_E,k_F}) ;
        [k_H,~] = get_classe(data_H(n), liste_bor_H{k_A,k_B,k_C,k_D,k_E,k_F,k_G}) ;
        [k_I,~] = get_classe(data_I(n), liste_bor_I{k_A,k_B,k_C,k_D,k_E,k_F,k_G,k_H}) ;
        [k_J,~] = get_classe(data_J(n), liste_bor_J{k_A,k_B,k_C,k_D,k_E,k_F,k_G,k_H,k_I}) ;
        
        liste_k_A(n) = k_A;
        liste_k_B(n) = k_B;
        liste_k_C(n) = k_C;
        liste_k_D(n) = k_D;
        liste_k_E(n) = k_E;
        liste_k_F(n) = k_F;
        liste_k_G(n) = k_G;
        liste_k_H(n) = k_H;
        liste_k_I(n) = k_I;
        liste_k_J(n) = k_J;
    end
    
end


% ========================================================================================================================
% partie 2/2 : affect vect_cor(1:nmax) = correction brute à appliquer
% ========================================================================================================================


if Kmax==1 % répartition en 1 classes
    liste =...
        liste_k_A*1;
end

if Kmax==2 % répartition en 2 classes
    liste =...
        liste_k_A*1  +...
        (liste_k_B-1)*kmax_A;
end

if Kmax==3 % répartition en 3 classes
    liste =...
        liste_k_A*1  +...
        (liste_k_B-1)*kmax_A  +...
        (liste_k_C-1)*kmax_A*kmax_B;
end

if Kmax==4 % répartition en 4 classes
    liste =...
        liste_k_A*1  +...
        (liste_k_B-1)*kmax_A  +...
        (liste_k_C-1)*kmax_A*kmax_B +...
        (liste_k_D-1)*kmax_A*kmax_B*kmax_C;
end

if Kmax==5 % répartition en 5 classes
    liste =...
        liste_k_A*1  +...
        (liste_k_B-1)*kmax_A  +...
        (liste_k_C-1)*kmax_A*kmax_B +...
        (liste_k_D-1)*kmax_A*kmax_B*kmax_C +...
        (liste_k_E-1)*kmax_A*kmax_B*kmax_C*kmax_D;
end

if Kmax==6 % répartition en 6 classes
    liste =...
        liste_k_A*1  +...
        (liste_k_B-1)*kmax_A  +...
        (liste_k_C-1)*kmax_A*kmax_B +...
        (liste_k_D-1)*kmax_A*kmax_B*kmax_C +...
        (liste_k_E-1)*kmax_A*kmax_B*kmax_C*kmax_D +...
        (liste_k_F-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E;
end

if Kmax==7 % répartition en 7 classes
    liste =...
        liste_k_A*1  +...
        (liste_k_B-1)*kmax_A  +...
        (liste_k_C-1)*kmax_A*kmax_B +...
        (liste_k_D-1)*kmax_A*kmax_B*kmax_C +...
        (liste_k_E-1)*kmax_A*kmax_B*kmax_C*kmax_D +...
        (liste_k_F-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E +...
        (liste_k_G-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F;
end

if Kmax==8 % répartition en 8 classes
    liste =...
        liste_k_A*1  +...
        (liste_k_B-1)*kmax_A  +...
        (liste_k_C-1)*kmax_A*kmax_B +...
        (liste_k_D-1)*kmax_A*kmax_B*kmax_C +...
        (liste_k_E-1)*kmax_A*kmax_B*kmax_C*kmax_D +...
        (liste_k_F-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E +...
        (liste_k_G-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F +...
        (liste_k_H-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F*kmax_G;
end

if Kmax==9 % répartition en 9 classes
    liste =...
        liste_k_A*1  +...
        (liste_k_B-1)*kmax_A  +...
        (liste_k_C-1)*kmax_A*kmax_B +...
        (liste_k_D-1)*kmax_A*kmax_B*kmax_C +...
        (liste_k_E-1)*kmax_A*kmax_B*kmax_C*kmax_D +...
        (liste_k_F-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E +...
        (liste_k_G-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F +...
        (liste_k_H-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F*kmax_G +...
        (liste_k_I-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F*kmax_G*kmax_H;
end

if Kmax==10 % répartition en 10 classes
    liste =...
        liste_k_A*1  +...
        (liste_k_B-1)*kmax_A  +...
        (liste_k_C-1)*kmax_A*kmax_B +...
        (liste_k_D-1)*kmax_A*kmax_B*kmax_C +...
        (liste_k_E-1)*kmax_A*kmax_B*kmax_C*kmax_D +...
        (liste_k_F-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E +...
        (liste_k_G-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F +...
        (liste_k_H-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F*kmax_G +...
        (liste_k_I-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F*kmax_G*kmax_H +...
        (liste_k_J-1)*kmax_A*kmax_B*kmax_C*kmax_D*kmax_E*kmax_F*kmax_G*kmax_H*kmax_I;
end

vect_cor  = mat_er(liste);

return
