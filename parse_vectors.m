%---------------------------------------------------------------------
% file name : parse_vectors.m
% Student: Ray Duran
% Date: 9/13/22
% Class : EECS 999
% University of North Dakota
% Descr: Parse vectors
%---------------------------------------------------------------------
clearvars -except psfresponse4
%file_path = '../scripts/recon/psf_response_4.txt';

%-------------------
%% Format Text File from Python that generated vectors
%----------------
% Add code for generating table

% parse table
psfresponse_cell = table2cell(psfresponse4); % convert from import                                            % header to cell

len = length(psfresponse_cell);

real_array = {};
complex_array = {};
tic
for i = 1 : len
  try
    % Indentify Exp and Decimal points to help grab complex nums
    %capture_line = cellstr(psfresponse_cell(i,:)); % easier to deal with str
    capture_line = psfresponse_cell{i,:}; % easier to deal with str
    expression_e = 'e[+-]';
    startIndex_e = regexp(capture_line,expression_e);
    expression_dot = '[.]';
    startIndex_dot = regexp(capture_line,expression_dot);
    if mod(i,1000) == 0
      message1 = [ 'iter = ', num2str(i)];
      disp(message1);
    end
  catch
      disp('Error: Could not find decimal or Exponent')
      continue;
  end

  try
    % Get parameters for line
    capture_line_char = char(capture_line);
    %dot_array = startIndex_dot{1};
    %e_array = startIndex_e{1};
    %dot_array = startIndex_dot(1);
    %e_array = startIndex_e(1);

    % Get first real
    %start_pos = dot_array(1);
    %end_pos = e_array(1);
    start_pos = startIndex_dot(1);
    end_pos = startIndex_e(1);
    %first_real = capture_line_char(start_pos-2 : end_pos+3);
    first_real = capture_line_char(start_pos-2 : end_pos+3);

    % Get first complex
    %start_pos = dot_array(2);
    %end_pos = e_array(2);
    start_pos = startIndex_dot(2);
    end_pos = startIndex_e(2);
    first_complex = capture_line_char(start_pos-2 : end_pos+4);

    % Get 2nd real
    %start_pos = dot_array(3);
    %end_pos = e_array(3);
    start_pos = startIndex_dot(3);
    end_pos = startIndex_e(3);
    second_real = capture_line_char(start_pos-2 : end_pos+3);

    % Get 2nd complex
    %start_pos = dot_array(4);
    %end_pos = e_array(4);
    start_pos = startIndex_dot(4);
    end_pos = startIndex_e(4);
    second_complex = capture_line_char(start_pos-2 : end_pos+4);
  catch
    if mod(i,1000)== 0
      disp('Message: Only one sample \n')
    end
  end  

  % Concatenate Real and Complex
  try
    if ~isempty(first_real) && ~isempty(first_complex)
      real_array{end+1} = first_real;
      complex_array{end+1} = first_complex;
    end

    if ~isempty(second_real) && ~isempty(second_complex)
      real_array{end+1} = second_real;
      complex_array{end+1} = second_complex;
    end
  catch
    disp('Error: Could not append Two Pairs of Complex numbers')
    continue;
  end

  %debug visually
  real_debug_array = real_array';
  complex_debug_array = complex_array';

  first_real = [];
  first_complex = [];
  second_real = [];
  second_complex = [];

  debug = 1;

  if i == 256
      debug = 1;
  end

end
toc

debug = 1;

