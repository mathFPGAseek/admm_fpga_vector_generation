%---------------------------------------------------------------------
% file name : parse_image_est_vectors.m
% Student: Ray Duran
% Date: 9/24/22
% Class : EECS 999
% University of North Dakota
% Descr: Parse vectors
%---------------------------------------------------------------------
clearvars -except imageest1
%file_path = '../scripts/recon/psf_response_4.txt';

%-------------------
%% Format Text File from Python that generated vectors
%----------------
% Add code for generating table

% parse table
image_est_cell = table2cell(imageest1); % convert from import                                            % header to cell

len = length(image_est_cell);

real_array = {};
%complex_array = {};
tic
for i = 1 : len
  try
    % Indentify Exp and Decimal points to help grab complex nums
    %capture_line = cellstr(psfresponse_cell(i,:)); % easier to deal with str
    capture_line = image_est_cell{i,:}; % easier to deal with str
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

    % Get 2nd real
    %start_pos = dot_array(3);
    %end_pos = e_array(3);
    start_pos = startIndex_dot(2);
    end_pos = startIndex_e(2);
    second_real = capture_line_char(start_pos-2 : end_pos+3);

    % Get 3rd real
    %start_pos = dot_array(3);
    %end_pos = e_array(3);
    start_pos = startIndex_dot(3);
    end_pos = startIndex_e(3);
    third_real = capture_line_char(start_pos-2 : end_pos+3);

    % Get 4th real
    %start_pos = dot_array(3);
    %end_pos = e_array(3);
    start_pos = startIndex_dot(4);
    end_pos = startIndex_e(4);
    fourth_real = capture_line_char(start_pos-2 : end_pos+3);

  catch
    if mod(i,1000)== 0
      disp('Message: Not four real samples \n')
    end
  end  

  % Concatenate Real
  try
    if ~isempty(first_real)
      real_array{end+1} = first_real;
    end

    if ~isempty(second_real)
      real_array{end+1} = second_real;
    end

    if ~isempty(third_real)
      real_array{end+1} = third_real;
    end

    if ~isempty(fourth_real)
      real_array{end+1} = fourth_real;
    end


  catch
    disp('Error: Could not append all reals')
    continue;
  end

  %debug visually
  real_col_array = real_array';
 
  first_real = [];
  second_real = [];
  third_real = [];
  fourth_real = [];


  debug = 1;

  if i == 256
      debug = 1;
  end

end
toc

debug = 1;

