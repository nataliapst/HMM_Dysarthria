@echo off
rem List of dysarthric and non-dysarthric patients
set dysarthric=F01
REM F03 F04 M01 M02 M03 M04 M05
set non_dysarthric=FC01 FC02 FC03 MC01 MC02 MC03 MC04

rem Loop through all combinations of dysarthric and non-dysarthric subjects
for %%X in (%dysarthric%) do (
    for %%Y in (%non_dysarthric%) do (
        echo Running HResults for %%X with %%Y
        for /L %%i in (1,1,40) do (
            HResults -I "C:\Users\root\Desktop\htk-3.2.1\develop_%%X_%%Y.mlf" "C:\Users\root\Desktop\htk-3.2.1\clases2.list" "C:\Users\root\Desktop\htk-3.2.1\recout_%%X_%%Y_%%i_corrected.mlf"
        )
    )
)

echo Script finished.
pause
