% Ruta completa al archivo mfc_paths.scp
scp_file_path = 'C:\Users\root\Desktop\htk-3.2.1\mfc_paths.scp';
%scp_file_path = 'C:\Users\50872852\CEU\2024-2025\Asignaturas\GIBM\TFGs\NataliaPedrosa\experimentacion\mfccs\mfc_paths.scp';


% Leer el archivo mfc_paths.scp
mfc_paths = fileread(scp_file_path); % Leer el contenido del archivo SCP como texto
mfc_paths = strsplit(mfc_paths, newline); % Dividir en líneas

% Ruta de salida para los archivos .scp generados
output_folder = 'C:\Users\root\Desktop\htk-3.2.1'; % Carpeta donde se guardarán los archivos
%output_folder = 'C:\Users\50872852\CEU\2024-2025\Asignaturas\GIBM\TFGs\NataliaPedrosa\experimentacion\mfccs\train'; % Carpeta donde se guardarán los archivos



% Configuración manual de los sujetos y archivos


% 
% %TEST 
% output_files = {
% 
%     'F01_FC01', {'F01', 'FC01'};
%     'F01_FC02', {'F01', 'FC02'};
%     'F01_FC03', {'F01', 'FC03'};
%     'F01_MC01', {'F01', 'MC01'};
%     'F01_MC02', {'F01', 'MC02'};
%     'F01_MC03', {'F01', 'MC03'};
%     'F01_MC04', {'F01', 'MC04'};
%     'F03_FC01', {'F03', 'FC01'};
%     'F03_FC02', {'F03', 'FC02'};
%     'F03_FC03', {'F03', 'FC03'};
%     'F03_MC01', {'F03', 'MC01'};
%     'F03_MC02', {'F03', 'MC02'};
%     'F03_MC03', {'F03', 'MC03'};
%     'F03_MC04', {'F03', 'MC04'};
%     'F04_FC01', {'F04', 'FC01'};
%     'F04_FC02', {'F04', 'FC02'};
%     'F04_FC03', {'F04', 'FC03'};
%     'F04_MC01', {'F04', 'MC01'};
%     'F04_MC02', {'F04', 'MC02'};
%     'F04_MC03', {'F04', 'MC03'};
%     'F04_MC04', {'F04', 'MC04'};
%     'M01_FC01', {'M01', 'FC01'};
%     'M01_FC02', {'M01', 'FC02'};
%     'M01_FC03', {'M01', 'FC03'};
%     'M01_MC01', {'M01', 'MC01'};
%     'M01_MC02', {'M01', 'MC02'};
%     'M01_MC03', {'M01', 'MC03'};
%     'M01_MC04', {'M01', 'MC04'};
%     'M02_FC01', {'M02', 'FC01'};
%     'M02_FC02', {'M02', 'FC02'};
%     'M02_FC03', {'M02', 'FC03'};
%     'M02_MC01', {'M02', 'MC01'};
%     'M02_MC02', {'M02', 'MC02'};
%     'M02_MC03', {'M02', 'MC03'};
%     'M02_MC04', {'M02', 'MC04'};
%     'M03_FC01', {'M03', 'FC01'};
%     'M03_FC02', {'M03', 'FC02'};
%     'M03_FC03', {'M03', 'FC03'};
%     'M03_MC01', {'M03', 'MC01'};
%     'M03_MC02', {'M03', 'MC02'};
%     'M03_MC03', {'M03', 'MC03'};
%     'M03_MC04', {'M03', 'MC04'};
%     'M04_FC01', {'M04', 'FC01'};
%     'M04_FC02', {'M04', 'FC02'};
%     'M04_FC03', {'M04', 'FC03'};
%     'M04_MC01', {'M04', 'MC01'};
%     'M04_MC02', {'M04', 'MC02'};
%     'M04_MC03', {'M04', 'MC03'};
%     'M04_MC04', {'M04', 'MC04'};
%     'M05_FC01', {'M05', 'FC01'};
%     'M05_FC02', {'M05', 'FC02'};
%     'M05_FC03', {'M05', 'FC03'};
%     'M05_MC01', {'M05', 'MC01'};
%     'M05_MC02', {'M05', 'MC02'};
%     'M05_MC03', {'M05', 'MC03'};
%     'M05_MC04', {'M05', 'MC04'};
% };
% 

% 
% % % %DEVELOPMENT
% output_files = {
%     'F01_FC01', {'F03', 'M01', 'FC02', 'MC01'};
%     'F01_FC02', {'F04', 'M02', 'FC01', 'MC02'};
%     'F01_FC03', {'F03', 'M03', 'FC02', 'MC03'};
%     'F01_MC01', {'F04', 'M04', 'FC03', 'MC04'};
%     'F01_MC02', {'F03', 'M05', 'FC01', 'MC01'};
%     'F01_MC03', {'F04', 'M01', 'FC03', 'MC02'};
%     'F01_MC04', {'F03', 'M02', 'FC01', 'MC03'};
%     'F03_FC01', {'F01', 'M01', 'FC02', 'MC01'};
%     'F03_FC02', {'F04', 'M02', 'FC01', 'MC02'};
%     'F03_FC03', {'F01', 'M03', 'FC02', 'MC03'};
%     'F03_MC01', {'F04', 'M04', 'FC03', 'MC04'};
%     'F03_MC02', {'F01', 'M05', 'FC01', 'MC01'};
%     'F03_MC03', {'F04', 'M01', 'FC03', 'MC02'};
%     'F03_MC04', {'F01', 'M02', 'FC01', 'MC03'};
%     'F04_FC01', {'F01', 'M01', 'FC02', 'MC01'};
%     'F04_FC02', {'F03', 'M02', 'FC01', 'MC02'};
%     'F04_FC03', {'F01', 'M03', 'FC02', 'MC03'};
%     'F04_MC01', {'F03', 'M04', 'FC03', 'MC04'};
%     'F04_MC02', {'F01', 'M05', 'FC01', 'MC01'};
%     'F04_MC03', {'F03', 'M01', 'FC03', 'MC02'};
%     'F04_MC04', {'F01', 'M02', 'FC01', 'MC03'};
%     'M01_FC01', {'F01', 'M02', 'FC02', 'MC01'};
%     'M01_FC02', {'F03', 'M03', 'FC03', 'MC02'};
%     'M01_FC03', {'F04', 'M04', 'FC01', 'MC03'};
%     'M01_MC01', {'F01', 'M05', 'FC02', 'MC04'};
%     'M01_MC02', {'F03', 'M02', 'FC03', 'MC01'};
%     'M01_MC03', {'F04', 'M03', 'FC01', 'MC02'};
%     'M01_MC04', {'F01', 'M04', 'FC02', 'MC03'};
%     'M02_FC01', {'F01', 'M01', 'FC02', 'MC01'};
%     'M02_FC02', {'F03', 'M03', 'FC03', 'MC02'};
%     'M02_FC03', {'F04', 'M04', 'FC01', 'MC03'};
%     'M02_MC01', {'F01', 'M05', 'FC02', 'MC04'};
%     'M02_MC02', {'F03', 'M01', 'FC03', 'MC01'};
%     'M02_MC03', {'F04', 'M03', 'FC01', 'MC02'};
%     'M02_MC04', {'F01', 'M04', 'FC02', 'MC03'};
%     'M03_FC01', {'F01', 'M01', 'FC02', 'MC01'};
%     'M03_FC02', {'F03', 'M02', 'FC03', 'MC02'};
%     'M03_FC03', {'F04', 'M04', 'FC01', 'MC03'};
%     'M03_MC01', {'F01', 'M05', 'FC02', 'MC04'};
%     'M03_MC02', {'F03', 'M01', 'FC03', 'MC01'};
%     'M03_MC03', {'F04', 'M02', 'FC01', 'MC02'};
%     'M03_MC04', {'F01', 'M04', 'FC02', 'MC03'};
%     'M04_FC01', {'F01', 'M01', 'FC02', 'MC01'};
%     'M04_FC02', {'F03', 'M02', 'FC03', 'MC02'};
%     'M04_FC03', {'F04', 'M03', 'FC01', 'MC03'};
%     'M04_MC01', {'F01', 'M05', 'FC02', 'MC04'};
%     'M04_MC02', {'F03', 'M01', 'FC03', 'MC01'};
%     'M04_MC03', {'F04', 'M02', 'FC01', 'MC02'};
%     'M04_MC04', {'F01', 'M03', 'FC02', 'MC03'};
%     'M05_FC01', {'F01', 'M01', 'FC02', 'MC01'};
%     'M05_FC02', {'F03', 'M02', 'FC03', 'MC02'};
%     'M05_FC03', {'F04', 'M03', 'FC01', 'MC03'};
%     'M05_MC01', {'F01', 'M04', 'FC02', 'MC04'};
%     'M05_MC02', {'F03', 'M01', 'FC03', 'MC01'};
%     'M05_MC03', {'F04', 'M02', 'FC01', 'MC02'};
%     'M05_MC04', {'F01', 'M03', 'FC02', 'MC03'};
%  };


%ENTRENAMIENTO
%output_files = {
    % 'F01_FC01', {'F04', 'FC03', 'M02', 'M03', 'M04', 'M05', 'MC02', 'MC03', 'MC04'};
    % 'F01_FC02', {'F03', 'M01', 'M03', 'M04', 'M05', 'FC03', 'MC01', 'MC03', 'MC04'};
    % 'F01_FC03', {'F04', 'M01', 'M02', 'M04', 'M05', 'FC01', 'MC01', 'MC02', 'MC04'};
    % 'F01_MC01', {'F03', 'M01', 'M02', 'M03', 'M05', 'FC01', 'FC02', 'MC02', 'MC03'};
    % 'F01_MC02', {'F04', 'M01', 'M02', 'M03', 'M04', 'FC02', 'FC03', 'MC03', 'MC04'};
    % 'F01_MC03', {'F03', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC01', 'MC04'};
    % 'F01_MC04', {'F04', 'M01', 'M03', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC02'};
    % 'F03_FC01', {'F04', 'M02', 'M03', 'M04', 'M05', 'FC03', 'MC02', 'MC03', 'MC04'};
    % 'F03_FC02', {'F01', 'FC03', 'M01', 'M03', 'M04', 'M05', 'MC01', 'MC03', 'MC04'};
    % 'F03_FC03', {'F04', 'M01', 'M02', 'M04', 'M05', 'FC01', 'MC01', 'MC02', 'MC04'};
    % 'F03_MC01', {'F01', 'M01', 'M02', 'M03', 'M05', 'FC01', 'FC02', 'MC02', 'MC03'};
    % 'F03_MC02', {'F04', 'M01', 'M02', 'M03', 'M04', 'FC02', 'FC03', 'MC03', 'MC04'};
    % 'F03_MC03', {'F01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC01', 'MC04'};
    % 'F03_MC04', {'F04', 'M01', 'M03', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC02'};
    % 'F04_FC01', {'F03', 'M02', 'M03', 'M04', 'M05', 'FC03', 'MC02', 'MC03', 'MC04'};
    % 'F04_FC02', {'F01', 'M01', 'M03', 'M04', 'M05', 'FC03', 'MC01', 'MC03', 'MC04'};
    % 'F04_FC03', {'F03', 'M01', 'M02', 'M04', 'M05', 'FC01', 'MC01', 'MC02', 'MC04'};
    % 'F04_MC01', {'F01', 'M01', 'M02', 'M03', 'M05', 'FC01', 'FC02', 'MC02', 'MC03'};
    % 'F04_MC02', {'F03', 'M01', 'M02', 'M03', 'M04', 'FC02', 'FC03', 'MC03', 'MC04'};
    % 'F04_MC03', {'F01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC01', 'MC04'};
    % 'F04_MC04', {'F03', 'M01', 'M03', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC02'};
    % 'M01_FC01', {'F03', 'F04', 'M03', 'M04', 'M05', 'FC03', 'MC02', 'MC03', 'MC04'};
    % 'M01_FC02', {'F01', 'F04', 'M02', 'M04', 'M05', 'FC01', 'MC01', 'MC03', 'MC04'};
    % 'M01_FC03', {'F01', 'F03', 'M02', 'M03', 'M05', 'FC02', 'MC01', 'MC02', 'MC04'};
    % 'M01_MC01', {'F03', 'F04', 'M02', 'M03', 'M04', 'FC01', 'FC03', 'MC02', 'MC03'};
    % 'M01_MC02', {'F01', 'F04', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC03', 'MC04'};
    % 'M01_MC03', {'F01', 'F03', 'M02', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC04'};
    % 'M01_MC04', {'F03', 'F04', 'M02', 'M03', 'M05', 'FC01', 'FC03', 'MC01', 'MC02'};
    % 'M02_FC01', {'F03', 'F04', 'M03', 'M04', 'M05', 'FC03', 'MC02', 'MC03', 'MC04'};
    % 'M02_FC02', {'F01', 'F04', 'M01', 'M04', 'M05', 'FC01', 'MC01', 'MC03', 'MC04'};
    % 'M02_FC03', {'F01', 'F03', 'M01', 'M03', 'M05', 'FC02', 'MC01', 'MC02', 'MC04'};
    % 'M02_MC01', {'F03', 'F04', 'M01', 'M03', 'M04', 'FC01', 'FC03', 'MC02', 'MC03'};
    % 'M02_MC02', {'F01', 'F04', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC03', 'MC04'};
    % 'M02_MC03', {'F01', 'F03', 'M01', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC04'};
    % 'M02_MC04', {'F03', 'F04', 'M01', 'M03', 'M05', 'FC01', 'FC03', 'MC01', 'MC02'};
    % 'M03_FC01', {'F03', 'F04', 'M02', 'M04', 'M05', 'FC03', 'MC02', 'MC03', 'MC04'};
    % 'M03_FC02', {'F01', 'F04', 'M01', 'M04', 'M05', 'FC01', 'MC01', 'MC03', 'MC04'};
    % 'M03_FC03', {'F01', 'F03', 'M01', 'M02', 'M05', 'FC02', 'MC01', 'MC02', 'MC04'};
    % 'M03_MC01', {'F03', 'F04', 'M01', 'M02', 'M04', 'FC01', 'FC03', 'MC02', 'MC03'};
    % 'M03_MC02', {'F01', 'F04', 'M02', 'M04', 'M05', 'FC01', 'FC02', 'MC03', 'MC04'};
    % 'M03_MC03', {'F01', 'F03', 'M01', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC04'};
    % 'M03_MC04', {'F03', 'F04', 'M01', 'M02', 'M05', 'FC01', 'FC03', 'MC01', 'MC02'};
    % 'M04_FC01', {'F03', 'F04', 'M02', 'M03', 'M05', 'FC03', 'MC02', 'MC03', 'MC04'};
    % 'M04_FC02', {'F01', 'F04', 'M01', 'M03', 'M05', 'FC01', 'MC01', 'MC03', 'MC04'};
    % 'M04_FC03', {'F01', 'F03', 'M01', 'M02', 'M05', 'FC02', 'MC01', 'MC02', 'MC04'};
    % 'M04_MC01', {'F03', 'F04', 'M01', 'M02', 'M03', 'FC01', 'FC03', 'MC02', 'MC03'};
    % 'M04_MC02', {'F01', 'F04', 'M02', 'M03', 'M05', 'FC01', 'FC02', 'MC03', 'MC04'};
    % 'M04_MC03', {'F01', 'F03', 'M01', 'M03', 'M05', 'FC02', 'FC03', 'MC01', 'MC04'};
    % 'M04_MC04', {'F03', 'F04', 'M01', 'M02', 'M05', 'FC01', 'FC03', 'MC01', 'MC02'};
    % 'M05_FC01', {'F03', 'F04', 'M02', 'M03', 'M04', 'FC03', 'MC02', 'MC03', 'MC04'};
    % 'M05_FC02', {'F01', 'F04', 'M01', 'M03', 'M04', 'FC01', 'MC01', 'MC03', 'MC04'};
    % 'M05_FC03', {'F01', 'F03', 'M01', 'M02', 'M04', 'FC02', 'MC01', 'MC02', 'MC04'};
    % 'M05_MC01', {'F03', 'F04', 'M01', 'M02', 'M03', 'FC01', 'FC03', 'MC02', 'MC03'};
    % 'M05_MC02', {'F01', 'F04', 'M02', 'M03', 'M04', 'FC01', 'FC02', 'MC03', 'MC04'};
    % 'M05_MC03', {'F01', 'F03', 'M01', 'M03', 'M04', 'FC02', 'FC03', 'MC01', 'MC04'};
    % 'M05_MC04', {'F03', 'F04', 'M01', 'M02', 'M04', 'FC01', 'FC03', 'MC01', 'MC02'};
   % };

% 

%ENTRENAMIENTO_DEVELOPMENT
output_files = {
'F01_FC01', {'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'F01_FC02', {'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'F01_FC03', {'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC01', 'MC02', 'MC03', 'MC04'};
'F01_MC01', {'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC02', 'MC03', 'MC04'};
'F01_MC02', {'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC03', 'MC04'};
'F01_MC03', {'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC04'};
'F01_MC04', {'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03'};
'F03_FC01', {'F01', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'F03_FC02', {'F01', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'F03_FC03', {'F01', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC01', 'MC02', 'MC03', 'MC04'};
'F03_MC01', {'F01', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC02', 'MC03', 'MC04'};
'F03_MC02', {'F01', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC03', 'MC04'};
'F03_MC03', {'F01', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC04'};
'F03_MC04', {'F01', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03'};

'F04_FC01', {'F01','F03', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'F04_FC02', {'F01','F03', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'F04_FC03', {'F01','F03', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC01', 'MC02', 'MC03', 'MC04'};
'F04_MC01', {'F01','F03', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC02', 'MC03', 'MC04'};
'F04_MC02', {'F01','F03', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC03', 'MC04'};
'F04_MC03', {'F01','F03', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC04'};
'F04_MC04', {'F01','F03', 'M01', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03'};

'M01_FC01', {'F01','F03', 'F04', 'M02', 'M03', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M01_FC02', {'F01','F03', 'F04', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M01_FC03', {'F01','F03', 'F04', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC01', 'MC02', 'MC03', 'MC04'};
'M01_MC01', {'F01','F03', 'F04', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC02', 'MC03', 'MC04'};
'M01_MC02', {'F01','F03', 'F04', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC03', 'MC04'};
'M01_MC03', {'F01','F03', 'F04', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC04'};
'M01_MC04', {'F01','F03', 'F04', 'M02', 'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03'};

'M02_FC01', {'F01','F03', 'F04', 'M01',  'M03', 'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M02_FC02', {'F01','F03', 'F04', 'M01',  'M03', 'M04', 'M05', 'FC01', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M02_FC03', {'F01','F03', 'F04', 'M01',  'M03', 'M04', 'M05', 'FC01', 'FC02', 'MC01', 'MC02', 'MC03', 'MC04'};
'M02_MC01', {'F01','F03', 'F04', 'M01',  'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC02', 'MC03', 'MC04'};
'M02_MC02', {'F01','F03', 'F04', 'M01',  'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC03', 'MC04'};
'M02_MC03', {'F01','F03', 'F04', 'M01',  'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC04'};
'M02_MC04', {'F01','F03', 'F04', 'M01',  'M03', 'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03'};

'M03_FC01', {'F01','F03', 'F04', 'M01', 'M02',  'M04', 'M05', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M03_FC02', {'F01','F03', 'F04', 'M01', 'M02',  'M04', 'M05', 'FC01', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M03_FC03', {'F01','F03', 'F04', 'M01', 'M02',  'M04', 'M05', 'FC01', 'FC02', 'MC01', 'MC02', 'MC03', 'MC04'};
'M03_MC01', {'F01','F03', 'F04', 'M01', 'M02',  'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC02', 'MC03', 'MC04'};
'M03_MC02', {'F01','F03', 'F04', 'M01', 'M02',  'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC03', 'MC04'};
'M03_MC03', {'F01','F03', 'F04', 'M01', 'M02',  'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC04'};
'M03_MC04', {'F01','F03', 'F04', 'M01', 'M02',  'M04', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03'};

'M04_FC01', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M05', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M04_FC02', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M05', 'FC01', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M04_FC03', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M05', 'FC01', 'FC02', 'MC01', 'MC02', 'MC03', 'MC04'};
'M04_MC01', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M05', 'FC01', 'FC02', 'FC03', 'MC02', 'MC03', 'MC04'};
'M04_MC02', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC03', 'MC04'};
'M04_MC03', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC04'};
'M04_MC04', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M05', 'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03',};

'M05_FC01', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M04',  'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M05_FC02', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M04',  'FC01', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};
'M05_FC03', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M04',  'FC01', 'FC02', 'MC01', 'MC02', 'MC03', 'MC04'};
'M05_MC01', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M04',  'FC01', 'FC02', 'FC03', 'MC02', 'MC03', 'MC04'};
'M05_MC02', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M04',  'FC01', 'FC02', 'FC03', 'MC01', 'MC03', 'MC04'};
'M05_MC03', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M04',  'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC04'};
'M05_MC04', {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M04',  'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03'};

    };
% % 
    % Añade más casos aquí


% Generar archivos .scp
for i = 1:size(output_files, 1)
    % Ruta completa del archivo de salida
   %ENTRENAMIENTO ->
 % output_file_name = fullfile(output_folder, strcat('train_', output_files{i, 1}, '.scp'));

   %DESARROLLO ->  
  % output_file_name = fullfile(output_folder, strcat('develop_', output_files{i, 1}, '.scp'));

    %CONJUNTO ENTRENAMIENTO + DEVELOPMENT
    output_file_name = fullfile(output_folder, strcat('train_develop_', output_files{i, 1}, '.scp'));

   %TEST ->   
  % output_file_name = fullfile(output_folder, strcat('test_', output_files{i, 1}, '.scp'));
    
    % Sujetos a buscar en las rutas
    subjects_to_search = output_files{i, 2};
    
    % Filtrar rutas que contengan los términos de búsqueda
    filtered_paths = {}; % Inicializar como celda
    for j = 1:numel(subjects_to_search)
        search_term = subjects_to_search{j};
        matching_paths = mfc_paths(contains(mfc_paths, search_term)); % Filtrar rutas que contienen el término
        filtered_paths = [filtered_paths; matching_paths(:)]; % Concatenar en formato de celda
    end
    
    % Eliminar duplicados en las rutas filtradas
    filtered_paths = unique(filtered_paths, 'stable'); % Eliminar duplicados y mantener el orden
    
    % Guardar en el archivo .scp
    fid = fopen(output_file_name, 'w');
    if fid == -1
        error('No se pudo abrir el archivo %s para escribir.', output_file_name);
    end
    fprintf(fid, '%s\n', filtered_paths{:});
    fclose(fid);
    
    fprintf('Archivo %s generado con %d rutas.\n', output_file_name, numel(filtered_paths));
end

disp('Todos los archivos .scp han sido generados correctamente.');