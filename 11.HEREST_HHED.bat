@echo off
setlocal enabledelayedexpansion

REM Number of main iterations to add Gaussians
set /a num_iterations=40

REM Lists of X and Y
set X_values=F01
REM F03 F04 M01 M02 M03 M04 M05
set Y_values=FC01
REM FC02 FC03 MC01 MC02 MC03 MC04

REM Required files
set class_list=clases2.list
set hed_script=addgaussians.txt

REM Iterate over all combinations of X and Y
for %%X in (%X_values%) do (
    for %%Y in (%Y_values%) do (
        echo --- Processing combination %%X and %%Y ---
        
        REM Base directories and specific files for this combination
        set base_dir=C:\Users\root\Desktop\htk-3.2.1\train_%%X_%%Y
        set base_model_dir=!base_dir!\hmm0
        set mlf_file=train_%%X_%%Y.mlf
        set scp_file=train_%%X_%%Y.scp

        REM Create base directory if it does not exist
        if not exist "!base_dir!" mkdir "!base_dir!"

        REM Main iterations
        for /L %%i in (1,1,%num_iterations%) do (
            echo --- Main Iteration %%i for %%X and %%Y ---
            
            REM HERest sub-iterations within each main iteration
            for /L %%j in (1,1,6) do (
                if %%j EQU 1 (
                    REM First sub-iteration uses the base model as input
                    set in_dir=!base_model_dir!
                ) else (
                    set /a prev_j=%%j-1
                    set in_dir=!base_dir!\hmm!prev_j!_GMM%%i
                )

                set out_dir=!base_dir!\hmm%%j_GMM%%i

                REM Create output directory if it does not exist
                if not exist "!out_dir!" mkdir "!out_dir!"

                REM Run HERest
                REM echo Running HERest for Iteration %%i, Sub-iteration %%j, %%X and %%Y
                HERest -I !mlf_file! -S !scp_file! -H !in_dir!\macro -H !in_dir!\hmmdefs -M !out_dir! %class_list%
            )

            REM Run HHEd at the end of each main iteration
            set in_HHEd_dir=!base_dir!\hmm6_GMM%%i
            set out_HHEd_dir=!base_dir!\hmmHHEd_GMM%%i

            if not exist "!out_HHEd_dir!" mkdir "!out_HHEd_dir!"

            echo Running HHEd to add Gaussians in Iteration %%i, %%X and %%Y
            HHEd -H !in_HHEd_dir!\hmmdefs -H !in_HHEd_dir!\macro -M !out_HHEd_dir! %hed_script% %class_list%

            REM Update base model directory for the next main iteration
            set base_model_dir=!out_HHEd_dir!
        )
    )
)

endlocal
echo Process completed.
pause
