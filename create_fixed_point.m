%---------------------------------------------------------------------
% file name : create_fixed_point.m
% Student: Ray Duran
% Date: 9/13/22
% Class : EECS 999
% University of North Dakota
% Descr: Write parsed vectors to file as a bit string for HDL simulation
%---------------------------------------------------------------------
clearvars -except real_debug_array complex_debug_array psfresponse4
debug = 1;
samples_size = size(real_debug_array,1); % complex and real same size

% Strip out 'j' at end of complex number before formatting
format_complex_debug_array = {};
for j = 1 : samples_size
    temp_cell = complex_debug_array{j};
    format_complex_debug_array{end+1} = [temp_cell(1:end-1)];
    debug = 1;
end
format_complex_debug_array = format_complex_debug_array';
debug = 1;

%-------------------
%% Format file into Matlab
%----------------
tic
fid_real_psf = fopen('real_psf_vectors.txt','wt');
fid_imag_psf = fopen('imag_psf_vectors.txt','wt');

for i = 1 : samples_size
   real_num_cell = str2double(real_debug_array{i});
   fi_real_num = fi( real_num_cell,1,34,16);
   bin_real_num = bin(fi_real_num);
   debug = 1;

  
   imag_num_cell = str2double(format_complex_debug_array{i});
   fi_imag_num = fi( imag_num_cell,1,34,16);
   bin_imag_num = bin(fi_imag_num);
   debug = 1;
   fprintf(fid_real_psf,'%34s \n',bin_real_num);
   fprintf(fid_imag_psf,'%34s \n',bin_imag_num);

end

toc

debug = 1;

