%---------------------------------------------------------------------
% file name : create_fixed_point_image_est.m
% Student: Ray Duran
% Date: 9/13/22
% Class : EECS 999
% University of North Dakota
% Descr: Write parsed vectors to file as a bit string for HDL simulation
%---------------------------------------------------------------------
clearvars -except real_col_array imageest1
debug = 1;
samples_size = size(real_col_array,1); % complex and real same size

debug = 1;

%-------------------
%% Format file into Matlab
%----------------
tic
fid_real_psf = fopen('real_image_est_vectors.txt','wt');

check_for_min_cell_array = [];
abs_check_for_min_cell_array = [];
debug = 1;

% Determine min to set decimal point correctly 
%{
for i = 1 : samples_size
    temp = str2double(real_col_array{i});
    check_for_min_cell_array(i) = temp;
end
abs_check_for_min_cell_array = abs(check_for_min_cell_array);
[M,I]  = min(abs_check_for_min_cell_array);
%}

% Put a check on how many sigfigs we need 
% for this example we need 2.3116e-12
% if we use 31 for decimal we can only get 9.3e-10 
% so the min we cannot get,however there are also
% some numbers with a characteristic of -9
% and for that we would need 5 bits, so
% the most we can devote to frational is 29, which
% makes our min range even less

for i = 1 : samples_size
   real_num_cell = str2double(real_col_array{i});
   fi_real_num = fi( real_num_cell,1,34,29);
   bin_real_num = bin(fi_real_num);
   debug = 1;

   fprintf(fid_real_psf,'%34s \n',bin_real_num);

end

toc

debug = 1;

