@echo off
rem Generado automáticamente para ejecutar HCompV con todas las combinaciones

rem Habilitar expansión retardada
setlocal EnableDelayedExpansion

rem Sujetos con disartria
set DYSARTHRIA=F01 
REM F03 F04 M01 M02 M03 M04 M05
rem Sujetos sin disartria
set NO_DYSARTHRIA=FC01 FC02 FC03 MC01 MC02 MC03 MC04

rem Directorio base
set BASE_DIR=C:\Users\root\Desktop\htk-3.2.1

for %%X in (%DYSARTHRIA%) do (
    for %%Y in (%NO_DYSARTHRIA%) do (
        rem Crear carpeta de salida train/HMM0 si no existe
        set OUTPUT_DIR=!BASE_DIR!\train_develop_%%X_%%Y\hmm0
        if not exist "!OUTPUT_DIR!" (
            mkdir "!OUTPUT_DIR!"
        )
        echo Ejecutando HCompV para train_%%X_%%Y.scp
        HCompV -f 0.01 -m -S train_develop_%%X_%%Y.scp -M "!OUTPUT_DIR!" proto.txt
    )
)

echo Todos los comandos HCompV se han ejecutado.
pause
