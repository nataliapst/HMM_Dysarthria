@echo off
set dysarthria=F01 F03 F04 M01 M02 M03 M04 M05
set no_dysarthria=FC01 FC02 FC03 MC01 MC02 MC03 MC04

for %%X in (%dysarthria%) do (
    for %%Y in (%no_dysarthria%) do (
        echo Running HResults for %%X with %%Y
        HResults -p -I "C:\Users\root\Desktop\htk-3.2.1\test_%%X_%%Y.mlf" "C:\Users\root\Desktop\htk-3.2.1\clases2.list" "C:\Users\root\Desktop\htk-3.2.1\recout_%%X_%%Y_TEST_corrected.mlf"
    )
)

echo Script finished.
pause
