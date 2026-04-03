% base : speaker control

%  principaux modules lancés par "base_SC" :
%
% - m000557    :  créer un profil & les stimuli WAV afférents / charger un profil existant
% - m000558_1  :  mesure - cas n°1 = calibrer (0dBFS)
% - m000558_2  :  mesure - cas n°2 = étalonner (50Hz)
% - m000558_3  :  mesure - cas n°3 = mesurer la FT caract (bande large)
% - m000558_4  :  mesure - cas n°4 = mesurer une réponse test (bande étroite)
% - m000558_5  :  mesure - cas n°5 = enchainer les mesures (bande étroite)
% - m000560    :  contrôle des mesures
% - m000561    :  pré-traitement (prerun)
% - m000562    :  ML - entrainement
% - m000563    :  DL - entrainement - 1ère version
% - m000564    :  écoute
%
%  (en cours)
% - m000571    :  DL - entrainement - 2ème version

close all
clc
clear_all_except_COM

format compact;
format long;
connector.ensureServiceOn;

global COM
global CDE
global dossier_SC; dossier_SC='';

if size(COM,2)==0
    [conf]=m000275(1); % chargement config (on n'a pas le choix de la config)
    % (déconfiguration de Pulse)
    COM{42}{1}='';
end

% raz
close all
clc

% création de la figure
z = get(0,'MonitorPositions');
HF = figure('Name','Speaker Control',...
    'Position',[z(1)+10 z(2)+50 z(3)-20 z(4)-110],...
    'NumberTitle','off',...
    'Color',COM{53}{1}{2},...
    'MenuBar','none',...
    'WindowStyle','normal',...
    'Resize','off');



HM_SC_0      = uimenu(HF,          'label','Général');
HM_SC_0_1    = uimenu(HM_SC_0,     'label',   '1a.  Créer un profil',                           'Callback','CDE=1;');
HM_SC_0_2    = uimenu(HM_SC_0,     'label',   '1b.  Importer un profil existant',               'Callback','CDE=2;');
HM_SC_0_3    = uimenu(HM_SC_0,     'label',   '2.    Calibrer (0dBFS)',                         'Callback','CDE=3;','ForegroundColor',[0 0 .8]);
HM_SC_0_4    = uimenu(HM_SC_0,     'label',   '3.    Etalonner (50Hz)',                         'Callback','CDE=4;','ForegroundColor',[0 0 .8]);
HM_SC_0_5    = uimenu(HM_SC_0,     'label',   '4.    Mesurer la FT caract (bande large)',       'Callback','CDE=5;','ForegroundColor',[.8 0 0]);
HM_SC_0_6    = uimenu(HM_SC_0,     'label',   '5.    Mesurer une réponse test (bande étroite)', 'Callback','CDE=6;','ForegroundColor',[.8 0 0]);
HM_SC_0_7    = uimenu(HM_SC_0,     'label',   '6.    Enchainer les mesures (bande étroite)',    'Callback','CDE=7;','ForegroundColor',[.8 0 0]);
HM_SC_0_8    = uimenu(HM_SC_0,     'label',   '7.    Contrôler les mesures',                    'Callback','CDE=8;');
HM_SC_0_9    = uimenu(HM_SC_0,     'label',   '8.    Pré-traiter les mesures',                  'Callback','CDE=9;','ForegroundColor',[0 .7 0]);
HM_SC_0_10   = uimenu(HM_SC_0,     'label',   '9a.  Entrain. ML',                               'Callback','CDE=10;');
HM_SC_0_11   = uimenu(HM_SC_0,     'label',   '9b.  Entrain. DL',                               'Callback','CDE=11;');
HM_SC_0_12   = uimenu(HM_SC_0,     'label',   '10.  Ecouter',                                 'Callback','CDE=12;','ForegroundColor',[0 0 .8]);

HM_SC_999    = uimenu(HF  ,        'label','Quitter',                                        'Callback','CDE=999;');


CDE = 900; % pour forcer l'init écran

while ishandle(HF)
    
    etat = 0; % 0 = pas encore créé de profil
    
    
    if CDE==1 % créer ou importer un profil
        CDE=0;
        cas=1;
        [dossier_SC_out]=m000557(cas);
        if ~isequal(dossier_SC_out,'') % la création a été jusqu'au bout
            dossier_SC = dossier_SC_out;
            set(HF,'name',['Speaker Control - ' dossier_SC]);
        end
    end
    
    if CDE==2 % importer un profil existant
        CDE=0;
        cas=2;
        [dossier_SC_out]=m000557(cas);
        if ~isequal(dossier_SC_out,'') % la création a été jusqu'au bout
            dossier_SC = dossier_SC_out;
            set(HF,'name',['Speaker Control - ' dossier_SC]);
        end
    end
    
    if CDE==3 % calibrer (0dBFS)
        CDE=0;
        cas=1;
        m000558_1;
    end
    
    if CDE==4 % étalonner (50Hz)
        CDE=0;
        cas=2;
        m000558_2;
    end
    
    if CDE==5 % mesurer la FT caract (large bande)
        CDE=0;
        cas=3;
        m000558_3;
    end
    
    if CDE==6 % mesurer une réponse en bande étroite (test)
        CDE=0;
        cas=4;
        m000558_4;
    end
    
    if CDE==7 % enchainer les mesures en bande étroite
        CDE=0;
        cas=4;
        m000558_5;
    end
    
    if CDE==8 % contrôler les mesures
        CDE=0;
        m000560;
    end
    
    if CDE==9 % pré-traiter les mesures
        CDE=0;
        m000561;
    end
    
    if CDE==10 % entrainement ML
        CDE=0;
        m000562;
    end
    
    if CDE==11 % entrainement DL
        CDE=0;
        m000563;
    end
    
    if CDE==12 % écoute
        CDE=0;
        m000564;
    end
    
    
    
    
    if CDE==999 % quitter
        CDE=0;
        delete(HF);
        return
    end
    
    pause0;
end % de "while"
clear HF;

