% 2015 10 23  Process beampattern data and save to folder

username = getenv('username');
pname = ['C:\Users\',username,'\Dropbox\0_ANALYSIS\bp_processing'];
% fname = 'rousettus_20150819_file_match.xlsx';
fname = 'rousettus_20150825_file_match.xlsx';
% fname = 'rousettus_20150910_file_match.xlsx';
% fname = 'eptesicus_20150911_file_match.xlsx';
trial_to_proc = 19;
chk_indiv_call = 1;
save_dir = ['C:\Users\',username,'\Dropbox\0_ANALYSIS\bp_processing\proc_output'];
if ~exist(save_dir,'dir')
    mkdir(save_dir);
end

for tnum = trial_to_proc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    data.track.fs = 200;   % frame rate [Hz]
    data.param.tempF = 75;  % temperature [deg F]
    data.param.humid = 50;  % humidity (relative in %)
    data.param.extract_call_len = 5;  % [ms]
    data.param.call_short_len = 0.5;  % desired length of extracted call [sec]
    data.param.call_portion_front = 0.2;         % proportion of extracted call before the peak
    data.param.tolernace = 2;
    data.param.tukeywin_proportion = 0.25;  % proportional of tukeywin for call tapering
    data.param.dura_flag = 0;  % 1-use duration marked in the mic detect file (FM bats)
    % 0-use default detection stuff (Rousettus)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    data = bp_proc(data,pname,fname,tnum,chk_indiv_call);
    ff = [data.files.mic_data,'_bp_proc.mat'];
    save(fullfile(save_dir,ff),'-struct','data');
    
    clear data
end

