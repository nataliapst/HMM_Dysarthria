@echo off
setlocal enabledelayedexpansion

REM List of patients with dysarthria and without dysarthria
set dysarthria=M04
set no_dysarthria=FC01 FC02 FC03 MC01 MC02 MC03 MC04

REM Common directories
set base_dir=C:\Users\root\Desktop\htk-3.2.1
set net_file=%base_dir%\wdnet1
set dict_file=%base_dir%\dict.dict
set class_list=%base_dir%\clases2.list

REM Loop through all combinations
for %%X in (%dysarthria%) do (
    REM Assign number of Gaussians depending on the dysarthric patient
    
    if "%%X"=="M04" (set gmm_num=5)

    for %%Y in (%no_dysarthria%) do (
        echo === Running HVite for %%X with %%Y using GMM!gmm_num! ===

        set model_dir=%base_dir%\train_develop_%%X_%%Y\hmm6_GMM!gmm_num!
        set test_scp=%base_dir%\test_%%X_%%Y.scp
        set output_mlf=recout_%%X_%%Y_TEST.mlf

        HVite -H !model_dir!\macro -H !model_dir!\hmmdefs -S !test_scp! -l "*" -i !output_mlf! -w !net_file! !dict_file! !class_list!
    )
)

endlocal
echo HVite script finished.
pause
