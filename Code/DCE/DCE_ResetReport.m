PrepareFN=[WorkingP 'AfterPrepare4D.mat'];
LogFN=[WorkingP 'Log.mat'];
delete(LogFN)
Log.a_00={['\\title{' ReportTitle '}\r\n\\maketitle\r\n']};
save(LogFN,'Log');

AddToLog(WorkingP,'a_01','\\subsection*{Preprocess}');
AddToLog(WorkingP,'z_aaa', '\\newpage\r\n\\subsubsection*{Options}');
for i=fieldnames(Options)'
    AddToLog(WorkingP,['zz_a' i{1}],strrep([i{1} ' = ' num2str(Options.(i{1}))],'_',':'));
end
AddToLog(WorkingP,'zz_b','---------------------');
