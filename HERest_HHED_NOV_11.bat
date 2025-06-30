@echo off
setlocal enabledelayedexpansion

REM Número de iteraciones principales para añadir gaussianas
set /a num_iterations=40

REM Listas de X y Y
set X_values=F01
REM F03 F04 M01 M02 M03 M04 M05
set Y_values=FC01
rem  FC02 FC03 MC01 MC02 MC03 MC04

REM Archivos necesarios
set class_list=clases2.list
set hed_script=addgaussians.txt

REM Iterar sobre combinaciones de X y Y
for %%X in (%X_values%) do (
    for %%Y in (%Y_values%) do (
        echo --- Procesando combinación %%X y %%Y ---
        
        REM Directorios base y archivos específicos para esta combinación
        set base_dir=C:\Users\root\Desktop\htk-3.2.1\train_%%X_%%Y
        set base_model_dir=!base_dir!\hmm0
        set mlf_file=train_%%X_%%Y.mlf
        set scp_file=train_%%X_%%Y.scp

        REM Crear el directorio base si no existe
        if not exist "!base_dir!" mkdir "!base_dir!"

        REM Iteraciones principales
        for /L %%i in (1,1,%num_iterations%) do (
            echo --- Iteración Principal %%i para %%X y %%Y ---
            
            REM Subiteraciones de HERest dentro de cada iteración principal
            for /L %%j in (1,1,6) do (
                if %%j EQU 1 (
                    REM Primera subiteración usa el modelo base como entrada
                    set in_dir=!base_model_dir!
                ) else (
                    set /a prev_j=%%j-1
                    set in_dir=!base_dir!\hmm!prev_j!_GMM%%i
                )

                set out_dir=!base_dir!\hmm%%j_GMM%%i

                REM Crear el directorio de salida si no existe
                if not exist "!out_dir!" mkdir "!out_dir!"

                REM Ejecutar HERest
            REM    echo Ejecutando HERest para Iteración %%i, Subiteración %%j, %%X y %%Y
                HERest -I !mlf_file! -S !scp_file! -H !in_dir!\macro -H !in_dir!\hmmdefs -M !out_dir! %class_list%
            )

            REM Ejecutar HHEd al final de cada iteración principal
            set in_HHEd_dir=!base_dir!\hmm6_GMM%%i
            set out_HHEd_dir=!base_dir!\hmmHHEd_GMM%%i

            if not exist "!out_HHEd_dir!" mkdir "!out_HHEd_dir!"

            echo Ejecutando HHEd para añadir gaussianas en Iteración %%i, %%X y %%Y
            HHEd -H !in_HHEd_dir!\hmmdefs -H !in_HHEd_dir!\macro -M !out_HHEd_dir! %hed_script% %class_list%

            REM Actualizar el directorio base para la siguiente iteración principal
            set base_model_dir=!out_HHEd_dir!
        )
    )
)

endlocal
echo Proceso completado.
pause
