@echo off
rem Lista de pacientes con disartria y sin disartria
set disartria=F01 
rem F03 F04 M01 M02 M03 M04 M05
set no_disartria=FC01 FC02 FC03 MC01 MC02 MC03 MC04

rem Bucle para todas las combinaciones de disartria y no disartria
for %%X in (%disartria%) do (
    for %%Y in (%no_disartria%) do (
        echo Ejecutando HVite para %%X con %%Y


		rem Bucle de 1 a 40 para iterar en los modelos GMM
        for /L %%Z in (1,1,40) do (
            echo Ejecutando HVite para %%X con %%Y en iteración %%Z

            HVite -H train_%%X_%%Y\hmm6_GMM%%Z\macro -H train_%%X_%%Y\hmm6_GMM%%Z\hmmdefs -S develop_%%X_%%Y.scp -l "*" -i recout_%%X_%%Y_%%Z.mlf -w wdnet1 dict.dict clases2.list
        )
		rem HVite -H "C:\Users\root\Desktop\htk-3.2.1\Train_%%X_%%Y_PROBAR\hmm0_2GMM40\macro" -H "C:\Users\root\Desktop\htk-3.2.1\Train_%%X_%%Y_PROBAR\hmm0_2GMM40\hmmdefs" -S "C:\Users\root\Desktop\htk-3.2.1\development_%%X_%%Y.scp" -l "*" -i "recout_%%X_%%Y.mlf" -w "C:\Users\root\Desktop\htk-3.2.1\wdnet1" "C:\Users\root\Desktop\htk-3.2.1\dict.dict" "C:\Users\root\Desktop\htk-3.2.1\clases2.list"
    )
)

echo Script terminado.
pause
