% DL - entrainement - 2ème version
close all
clc
clear_all_except_COM;
% function m000571

% entrée(s)      : /

% sortie(s)      : /

% commentaire(s) : /

global COM
global CDE
global dossier_SC
warning('off','MATLAB:nearlySingularMatrix')

% ///////////////////////////////// deb /////////////////////////////////
%    opérations réalisées quand on charge un profil (dans m000557)
dossier_SC = 'DS7_CaissonHpCircul_MesProche (Large = -16 dBFS ; Etroit = [-16 -12 -8 -4 0] dBFS  50-150 Hz)'; %///
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\dbfs_50.mnc']       , 'dbfs_50',      '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\dbfs_large.mnc']    , 'dbfs_large',   '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\liste00_dbfs.mnc']  , 'liste00_dbfs', '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\f_large1.mnc']      , 'f_large1',     '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\f_large2.mnc']      , 'f_large2',     '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\f_etroit1.mnc']     , 'f_etroit1',    '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\f_etroit2.mnc']     , 'f_etroit2',    '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\nmax00.mnc']        , 'nmax00',  '-mat');
% ///////////////////////////////// fin /////////////////////////////////


% contrôles initiaux
if isequal(dossier_SC,'')
    waitfor(msgbox('Il faut d''abord créer ou importer un profil','Refusé','error'));
    return
end
e = exist(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\PRERUN\Sweep_indices_max_zero.mnc']);
if e~=2
    waitfor(msgbox('Il faut d''abord avoir prétraité les mesures','Refusé','error'));
    return
end

% chagement de fichier(s) autre que WAV
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\nmax00.mnc']        , 'nmax00',       '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\liste00_dbfs.mnc']  , 'liste00_dbfs', '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\f_etroit1.mnc']     , 'f_etroit1',    '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\f_etroit2.mnc']     , 'f_etroit2',    '-mat');
load(['C:\AP\WORK\MATLAB\MAIN\SC\' dossier_SC '\INFOS\facteur_etal0.mnc'] ,'facteur_etal0','-mat');

% paramètres par défaut

nb_tracks  = 3;    % nb de tracks pour l'entrainement

expo0     = 6;     % affaiblissement de la correction dans le cas des faibles amplitudes (pour éliminer les artefacts aux faibles amplitudes)
%                  % plus cette valeur est élevée, plus l'affaiblissement cible les faibles amplitudes et est sans impact sur les grandes amplitudes
mode_faible = 1;   % type de calcul (1=tens+intégr ; 2=tens+dérivée ; 3=tens+intégr+dérivée)

flag_lis  = 0;     % on/off lissage
flag_lis1 = 0;     % on/off - lissage sur des points
flag_lis2 = 0;     % on/off - lissage p.bande
lis0      = 10;    % nb de pts dans le cas du lissage par pts
flow0     = 400;   % fréq de coupure dans le cas du filtrage p.bas
ordre0    = 4;     % ordre du lissage (2,4 ou 6) dans le cas du lissage p.bas

mode_calcul   = 1;   % mode de calcul : 1 = matrice brute (sans interpol) ; 2 = avec interpol lin ; 3 = avec interpol spline

flag_  = zeros(1,10);
nat_   = ones (1,10);
t_     = zeros(1,10);
kmax_  = ones (1,10);
alpha_ = zeros(1,10);

flag_ (1) = 1;  % validé ?
nat_  (1) = 2;  % nature
t_    (1) = 0;  % instant
kmax_ (1) = 7;  % nb de classes
alpha_(1) = 0; -3;  % param de forme

flag_ (2) = 1;  % validé ?
nat_  (2) = 3;  % nature
t_    (2) = .003;  % instant
kmax_ (2) = 15;  % nb de classes
alpha_(2) = 0; -2;  % param de forme

flag_ (3) = 1;  % validé ?
nat_  (3) = 4;  % nature
t_    (3) = 0;  % instant
kmax_ (3) = 5;  % nb de classes
alpha_(3) = 0; -3;  % param de forme

flag_ (4) = 1;  % validé ?
nat_  (4) = 5;  % nature
t_    (4) = 0;  % instant
kmax_ (4) = 8;  % nb de classes
alpha_(4) = 0; -3;  % param de forme

flag_ (5) = 1;  % validé ?
nat_  (5) = 8;  % nature
t_    (5) = 0;  % instant
kmax_ (5) = 3;  % nb de classes
alpha_(5) = 0; -3;  % param de forme

flag_ (6) = 1;  % validé ?
nat_  (6) = 9;  % nature
t_    (6) = 0;  % instant
kmax_ (6) = 3;  % nb de classes
alpha_(6) = 0; -2;  % param de forme

flag_ (7) = 0;  % validé ?
nat_  (7) = 0;  % nature
t_    (7) = 0;  % instant
kmax_ (7) = 0;  % nb de classes
alpha_(7) = 0;  % param de forme

flag_ (8) = 0;  % validé ?
nat_  (8) = 0;  % nature
t_    (8) = 0;  % instant
kmax_ (8) = 0;  % nb de classes
alpha_(8) = 0;  % param de forme

flag_ (9) = 0;  % validé ?
nat_  (9) = 0;  % nature
t_    (9) = 0;  % instant
kmax_ (9) = 0;  % nb de classes
alpha_(9) = 0;  % param de forme

flag_ (10) = 0;  % validé ?
nat_  (10) = 0;  % nature
t_    (10) = 0;  % instant
kmax_ (10) = 0;  % nb de classes
alpha_(10) = 0;  % param de forme

dt = 1/44100;

HF_DL = figure('Name','Speaker control - DL',...
    'Position',centrage0([12 83 1500 740]),...
    'NumberTitle','off',...
    'Color',COM{53}{1}{4},...
    'MenuBar','none',...
    'WindowStyle','normal',...
    'Resize','off');

HA1 = axes(...
    'Position'     ,[.040 .520 .620 .390],... % position dans la figure en cours (équiv du VIEWPORT)
    'Visible'      ,'on',...                  % si off : axes 'Ox' et 'Oy' invisibles, de même que la couleur de fond (mais les éventuels courbes, textes etc restent visible)
    'MinorGridLineStyle' ,':',...             % type de quadrillage : '-' pour continu ; '--' pour tirets ;  ':' (défaut) pour tirets
    'Color'        , COM{53}{1}{5},...        % couleur de fond
    'NextPlot'     , 'add',...                % 'replace' (défaut) ou 'add' (équiv de 'hold on')
    'XColor'       , [0 0 0],...              % couleur de l'axe 'Ox' (s'il est visible)
    'YColor'       , [0 0 0],...              % couleur de l'axe 'Oy' (s'il est visible)
    'Fontsize'     , 7,...                    %
    'XScale'       , 'linear',...             % échelle 'linear' ou 'log'
    'YScale'       , 'linear'...              % échelle 'linear' ou 'log'
    );
gomzo
xlabel('s')
ylabel('V')
title('Tensions')

hpt_lin   = plot(0,0,'r'); % futur fichier long (hyse lin = point de départ)
hpt       = plot(0,0,'k'); % futur fichier long (target)
hpt_synth = plot(0,0,'g'); % futur fichier long (synthèse)
legend('SANS SC (hyse LIN)','AVEC SC (cible)','Synthèse','Autoupdate','off')

HA2 = axes(...
    'Position'     ,[.040 .130 .620 .330],... % position dans la figure en cours (équiv du VIEWPORT)
    'Visible'      ,'on',...                  % si off : axes 'Ox' et 'Oy' invisibles, de même que la couleur de fond (mais les éventuels courbes, textes etc restent visible)
    'MinorGridLineStyle' ,':',...             % type de quadrillage : '-' pour continu ; '--' pour tirets ;  ':' (défaut) pour tirets
    'Color'        , COM{53}{1}{5},...        % couleur de fond
    'NextPlot'     , 'add',...                % 'replace' (défaut) ou 'add' (équiv de 'hold on')
    'XColor'       , [0 0 0],...              % couleur de l'axe 'Ox' (s'il est visible)
    'YColor'       , [0 0 0],...              % couleur de l'axe 'Oy' (s'il est visible)
    'Fontsize'     , 7,...                    %
    'XScale'       , 'log',...             % échelle 'linear' ou 'log'
    'YScale'       , 'linear'...              % échelle 'linear' ou 'log'
    );
gomzo
xlabel('Hz')
ylabel('dB')
hpf_lin   = plot(1,0,'r'); % futur fichier long (hyse lin = point de départ)
hpf       = plot(1,0,'k'); % futur fichier long (target)
hpf_synth = plot(1,0,'g'); % futur fichier long (synthèse)
set(HA2,'XLim',[20 20000]);

% nb de tracks
uic('text', 'Nb de tracks pour l''entrainement = ',    [.030 .940 .110 .020], '', 1, 'on', 'on', '','Fontsize',7);
UI_1 = uic('edit', '',                                 [.135 .940 .030 .025], 'CDE=1;', 1, 'on', 'on', '','Fontsize',7,'HorizontalAlignment','center');
UI_5 = uic('text', 'représentant une durée totale de', [.170 .940 .140 .020], '', 1, 'on', 'on', '','Fontsize',7);

% 9 paramètres
clear UI_101
clear UI_102
clear UI_103
clear UI_104
clear UI_105

% titre des colonnes
uic('text', {'';'Valid'},        [.670 .883 .030 .040], '', 1, 'on', 'on', '','Fontsize',7,'HorizontalAlignment','center');
uic('text', {'';'Nature'},       [.780 .883 .030 .040], '', 1, 'on', 'on', '','Fontsize',7,'HorizontalAlignment','center');
uic('text', {'@ t=';'(ms)'},     [.892 .883 .030 .040], '', 1, 'on', 'on', '','Fontsize',7,'HorizontalAlignment','center');
uic('text', {'Nb de';'classes'}, [.926 .883 .030 .040], '', 1, 'on', 'on', '','Fontsize',7,'HorizontalAlignment','center');
uic('text', {'Param';'de forme'},[.960 .883 .030 .040], '', 1, 'on', 'on', '','Fontsize',7,'HorizontalAlignment','center');

for k=1:10
    UI_101{k} = uic('checkbox', '', [.680 .886-k*.030 .160 .020], 'CDE=101.1;', 0, 'on', 'on', '','Fontsize',7,'ForegroundColor',[0 0 0]);
    txt0={...
        '[A] AMPL ACTU                    TENS';...
        '[B] NB pts depuis DER       MAX  TENS';...
        '[C] AMPL          DER       MAX  TENS';...
        '[D] NB pts depuis AV-DER    MAX  TENS';...
        '[E] AMPL          AV-DER    MAX  TENS';...
        '[F] NB pts depuis AV-AV-DER MAX  TENS';...
        '[G] AMPL          AV-AV-DER MAX  TENS';...
        '';...
        '[H] NB pts depuis DER       ZERO TENS';...
        '[I] NB pts depuis AV-DER    ZERO TENS';...
        '[J] NB pts depuis AV-AV-DER ZERO TENS';...
        '';...
        '[K] AMPL ACTU                    INTEGR ';...
        '[L] NB pts depuis DER       MAX  INTEGR';...
        '[M] AMPL          DER       MAX  INTEGR';...
        '[N] NB pts depuis AV-DER    MAX  INTEGR';...
        '[O] AMPL          AV-DER    MAX  INTEGR';...
        '[P] NB pts depuis AV-AV-DER MAX  INTEGR';...
        '[Q] AMPL          AV-AV-DER MAX  INTEGR';...
        '';...
        '[R] AMPL ACTU                    DERIVEE ';...
        '[S] NB pts depuis DER       MAX  DERIVEE';...
        '[T] AMPL          DER       MAX  DERIVEE';...
        '[U] NB pts depuis AV-DER    MAX  DERIVEE';...
        '[V] AMPL          AV-DER    MAX  DERIVEE';...
        '[W] NB pts depuis AV-AV-DER MAX  DERIVEE';...
        '[X] AMPL          AV-AV-DER MAX  DERIVEE';...
        '';...
        '[ ] AMPL TENS';...
        '[ ] AMPL INTEGR';...
        '[ ] AMPL DERIVEE' ...
        };
    UI_102{k} = uic('popupmenu', txt0, [.697 .890-k*.030 .190 .020], 'CDE=101.1;', 1, 'on', 'on', '','Fontsize',7,'ForegroundColor',[0 0 0],'Fontname','monospaced');
    UI_103{k} = uic('edit', '', [.892 .885-k*.030 .030 .025], 'CDE=101.1;', 0, 'on', 'on', '','Fontsize',7,'ForegroundColor',[0 0 0],'HorizontalAlignment','center');
    UI_104{k} = uic('edit', '', [.926 .885-k*.030 .030 .025], 'CDE=101.1;', 0, 'on', 'on', '','Fontsize',7,'ForegroundColor',[0 0 0],'HorizontalAlignment','center');
    UI_105{k} = uic('edit', '', [.960 .885-k*.030 .030 .025], 'CDE=101.1;', 0, 'on', 'on', '','Fontsize',7,'ForegroundColor',[0 0 0],'HorizontalAlignment','center');
end

% mode de calcul
uic('text', 'Mode de calcul : ', [.680 .350 .060 .020], '', 1, 'on', 'on', '','Fontsize',7);
txt0={'Sans interpolation';'Avec interpolation linéaire';'Avec interpolation splines'};
UI_402 = uic('popupmenu', txt0,  [.735 .352 .226 .022], 'CDE=402;', 1, 'on', 'off', '','Fontsize',7);

% convergence faibles amplitudes
uic('text', 'Coeff convergence faibles ampl :',  [.680 .310 .130 .020], '', 1, 'on', 'on', '','Fontsize',7);
UI_405 = uic('edit', '',                         [.780 .310 .030 .025], 'CDE=405;', 1, 'on', 'on', '','Fontsize',7,'HorizontalAlignment','center');
uic('text', 'calculé sur',                       [.820 .310 .040 .020], '', 1, 'on', 'on', '','Fontsize',7);
txt0 = {'Tens + intégr';'Tens + dérivée';'Tens + intégr + dérivée'};
UI_406 = uic('popupmenu', txt0,                  [.857 .311 .104 .022], 'CDE=406;', 1, 'on', 'on', '','Fontsize',7);

% lissage
UI_520 = uic('checkbox', 'Lissage', [.680 .269 .050 .022], 'CDE=520;', 1, 'on', 'on', '','Fontsize',7);

% lissage - points
UI_521 = uic('checkbox', '',    [.738 .269 .030 .022], 'CDE=521;', 1, 'on', 'on', '','Fontsize',7);
UI_404 = uic('edit', '',        [.754 .265 .025 .027], 'CDE=404;', 1, 'on', 'on', '','Fontsize',7,'HorizontalAlignment','center');
uic('text', 'pts',              [.780 .265 .020 .022], 'pts', 1, 'on', 'on', '','Fontsize',7);

% lissage - p.bas
UI_522 = uic('checkbox', 'p.bas',    [.806 .269 .030 .022], 'CDE=522;', 1, 'on', 'on', '','Fontsize',7);
UI_407 = uic('edit', '',             [.838 .265 .035 .027], 'CDE=407;', 1, 'on', 'on', '','Fontsize',7,'HorizontalAlignment','center');
uic('text', 'Hz',                    [.874 .265 .020 .022], '', 1, 'on', 'on', '','Fontsize',7);
txt0={'2ème ordre';'4ème ordre';'6ème ordre'};
UI_408 = uic('popupmenu', txt0,      [.890 .270 .071 .022], 'CDE=409;', 1, 'on', 'on', '','Fontsize',7);

UI_400 = uic('text', 'Durée indicative équiv mémoire (matrice) @44.1k  =  ', [.680 .225 .190 .022], '', 1, 'on', 'on', '','Fontsize',7);

UI_401 = uic('text', 'Durée indicative équiv mémoire (bornes) @44.1k  =  ', [.680 .190 .190 .022], '', 1, 'on', 'on', '','Fontsize',7);

% (re-)calculer
UI_600 = uic('pushbutton', '(Re-)calculer',    [.685 .130 .080 .030], 'CDE=600;', 0, 'on', 'off', 'tvG');

% mémo
UI_601 = uic('pushbutton', 'Mémoriser l''état actuel',  [.815 .130 .080 .030], 'CDE=601;', 0, 'on', 'off', '','Fontsize',7);
UI_602 = uic('pushbutton', 'Rappeler un état',          [.900 .130 .080 .030], 'CDE=602;', 0, 'on', 'off', '','Fontsize',7);

% messages de résultat
UI_501 = uic('text', 'Rapport d''erreur (erreur actuelle / erreur de départ) = 0', [.470 .464 .190 .022], '', 1, 'on', 'on', '','Fontsize',7);
UI_502 = uic('text', 'Délai additionnel pour lissage = 0 ms', [.470 .920 .190 .022], '', 1, 'on', 'on', '','Fontsize',7);

% message d'avertissement
UI_505 = uic('text', 'Il faudra (re)calculer', [.240 .710 .230 .030], '', 1, 'off', 'on', 'fr','Fontsize',10,'HorizontalAlignment','center');

UI_999 = uic('pushbutton', 'Quitter',  [.900 .020 .080 .050], 'CDE=999;', 0, 'on', 'on', '');

% =================================================================================================================
% initialisation
% =================================================================================================================

m000571_maj_rubr;   % maj rubriques
pause(.2)







% =================================================================================================================
% début de la boucle d'attente
% =================================================================================================================

CDE=600; % pour forcer le calcul

while ishandle(HF_DL)
    
    if CDE==1 % saisie : nb_tracks
        CDE=0;
        waitfor(msgbox('à programmer'))
        return
    end
    
    
    if CDE==600 % (re)calculer
        CDE=0;
        
        set(UI_505,'Visible','off'); % message "(re)calculer)"
        set(UI_600,'Enable','off'); % bouton "(re)calculer)"
        set(UI_601,'Enable','off'); % bouton "mémoriser un état"
        set(UI_602,'Enable','off'); % bouton "rappeler un état"
        pause(.1);
        
        h_suivi = waitbar(0,'Calcul en cours...','Name','Phase 1/2 : Entraînement');
        
        
        waitbar(1/5);
        m000571_affect_longs_fichiers; % affect longs fichiers
        % ici on a : x1t_lin_long(1:nmax)        = tensions de départ
        %            deriv_x1t_lin_long(1:nmax)  = sa dérivée
        %            integr_x1t_lin_long(1:nmax) = son intégration
        %            x1t_long(1:nmax)            = tensions cible
        %            indices_longs(1:nmax)       = liste d'indices (par paires) indiquant les débuts et fins de partie utiles

        set(hpt,'XData',((1:5:nmax)-1)*dt,'YData',x1t_long(1:5:nmax))
        set(hpt_lin,'XData',((1:5:nmax)-1)*dt,'YData',x1t_lin_long(1:5:nmax))
        df = 1/nmax/dt;
        x1f_long       = fft(x1t_long);
        x1f_lin_long   = fft(x1t_lin_long);
        set(hpf,'XData',((1:5:nmax)-1)*df,'YData',20*log10(abs(x1f_long(1:5:nmax))));
        set(hpf_lin,'XData',((1:5:nmax)-1)*df,'YData',20*log10(abs(x1f_lin_long(1:5:nmax))));
        
        waitbar(2/5);
        m000571_extract_A_J_apprent; % extraction éléments data_A...J , kmax_A...J, alpha_A...J, cas_A...J - POUR L'APPRENTISSAGE
        % ici on a : liste_indices(1:nmax_learn) = liste des indices constituant les parties utiles concaténées
        %            Kmax                        =  nb de paramètres pris en compte (1 pour "A" ; 2 pour "A,B" ; ... 10 pour "A,B,C,D,E,F,G,H,I,J")
        %            data_A(1:nmax_learn) ... data_J(1:nmax_learn) = données extraites
        %            kmax_A  ... kmax_B          = nb de classes
        %            alpha_A ... alpha_J         = param de forme
        %            cas_A   ... cas_J           = 1 ou 2 selon que la data est monodirectionnelle (nb de pts depuis...) ou bidirectionnelle
        
        % affect : ..._learn(1:nmax_learn) = extraits (parmi les longs fichiers) des parties utiles sur lesquelles va se faire l'apprentissage
        x1t_learn     = x1t_long(liste_indices);
        x1t_lin_learn = x1t_lin_long(liste_indices);
        erreur_learn  = x1t_learn - x1t_lin_learn;
        
        %figure0
        %nmax = size(x1t_long,2);
        %plot( ((1:nmax)-1)*dt,x1t_long,'k' , ((1:nmax)-1)*dt,x1t_lin_long,'r' );
        %legend('x1t\_long = tension cible (avec SC)','x1t\_lin\_long = tension source (sans SC)')
        %title('longs fichiers complets')
        %gomzo;
        
        %figure0
        %plot( ((1:nmax_learn)-1)*dt,x1t_learn,'k' , ((1:nmax_learn)-1)*dt,x1t_lin_learn,'r' , ((1:nmax_learn)-1)*dt,erreur_learn,'b' );
        %legend('x1t\_learn (1:nmax\_learn) = tension cible (avec SC)','x1t\_lin\_lean (1:nmax\_learn) = tension source (sans SC)','erreur\_learn (1:nmax\_learn)')
        %title('extraits sur lesquels va se faire l''apprentissage')
        %gomzo;
        
        
        % ajout d'un très léger bruit aléatoire pour éviter une erreur dans "set_classe" (pivots identiques)
        if Kmax>=1;   data_A = data_A + 1e-7*rand(1,nmax_learn);  end
        if Kmax>=2;   data_B = data_B + 1e-7*rand(1,nmax_learn);  end
        if Kmax>=3;   data_C = data_C + 1e-7*rand(1,nmax_learn);  end
        if Kmax>=4;   data_D = data_D + 1e-7*rand(1,nmax_learn);  end
        if Kmax>=5;   data_E = data_E + 1e-7*rand(1,nmax_learn);  end
        if Kmax>=6;   data_F = data_F + 1e-7*rand(1,nmax_learn);  end
        if Kmax>=7;   data_G = data_G + 1e-7*rand(1,nmax_learn);  end
        if Kmax>=8;   data_H = data_H + 1e-7*rand(1,nmax_learn);  end
        if Kmax>=9;   data_I = data_I + 1e-7*rand(1,nmax_learn);  end
        if Kmax>=10;  data_J = data_J + 1e-7*rand(1,nmax_learn);  end
        
        waitbar(3/5);
        m000571_affect_bor_er_apprent; % affect : bornes & matrice d'erreur
        % ici on a :  liste_bor_A{...}    ...   liste_bor_J{...}  = bornes des classes corresp
        %             mat_er( 1:kmax_A , ... , 1:kmax_J )         = matrice d'erreur (remplie à 100%)
        
        set(h_suivi,'Name','Phase 2/2 : Synthèse');
        waitbar(4/5);
        m000571_extract_A_J_synth; % extraction éléments data_A...J - POUR LA SYNTHESE
        % ici on a : data_A(1:nmax) ... data_J(1:nmax) = données extraites
        
        
        waitbar(5/5);
        m000571_affect_vect_cor     % coeur du calcul - POUR LA SYNTHESE
        % ici on a : vect_cor(1:nmax) = correction brute à apporter        
        
        
        x1t_long_synth = x1t_lin_long + vect_cor;
        
        
        
        % maj graphique synthèse
        set(hpt_synth,'XData',((1:5:nmax)-1)*dt,'YData',x1t_long_synth(1:5:nmax))
        df = 1/nmax/dt;
        x1f_long_synth = fft(x1t_long_synth);
        set(hpf_synth,'XData',((1:5:nmax)-1)*df,'YData',20*log10(abs(x1f_long_synth(1:5:nmax))));
        set(HA2,'XLim',[20 20000]);
        
        delete(h_suivi)
        
        waitfor(msgbox('ok pour l''instant ///'))
        
        
        
        
        
    end % de "if CDE==600 % (re)calculer"
    
    if CDE==999     % quitter
        CDE=0;
        delete(HF_DL); % fermeture de cette figure
    end
    
    pause0;
end % de "while"

return
