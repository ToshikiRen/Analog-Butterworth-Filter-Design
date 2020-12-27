%% Designing a lowpass filter

% If we set wc to be exactly the frequency of the first sinusoid we'll
% still modify it's value, we have to keep in mind the -3dB 
order = [2, 3, 2, 3];
wc = [2 350 5 0.05]; % cutoff freq's
wc_band = wc * 100;

% Create an input
% Time domain
t = 0: 0.01: 180;
% Frequency vector
w = [1, 10, 100, 200, 300, 400]'; 
arg = w * t;
% Matrix with components on rows
y = sin(arg);
% Adding all the components, result should be a row vector with length(t)
% elements
y = sum(y);

% Checking the filter response

y = y(:);
H = cell(numel(order), 1);
y_out = cell(numel(order),1);
line = factor(numel(order));
col = line(1);
line = prod(line(2:end));

type = {'lowpass', 'highpass', 'stopband', 'passband'};
fig_time_response = figure();
fig_freq_filter_response = figure();

for i = 1:numel(order)
    
    % Design a butterworth filter
    [H{i}, ~] = designButter(order(i), type{i}, wc(i), wc_band(i));
    
    % Subplot setup
    ax = subplot(line, col, i, 'Parent', fig_time_response);
    ax_freq = subplot(line, col, i, 'Parent', fig_freq_filter_response);
    
    
    % Frequency response
    [amp, phase, w] = bode(H{i});
    % Vectorize bode outputs
    amp = amp(:);
    phase = phase(:);
    semilogx(ax_freq, w, 20 * log10(abs(amp)), 'Color', 'm', 'LineWidth', 3)
    grid(ax_freq, 'on');
    xlabel('Frequency');
    ylabel('dB Magnitude');
    
    
    % The response to a sum o sinusoids
    y_out{i} = lsim(H{i}, y, t);
    y_out{i} = y_out{i}(:);
    plot(ax, t, y, 'LineWidth', 0.5, 'Color', 'c');
    hold(ax, 'on');
    plot(ax, t, y_out{i});
    legend(ax, 'Input Signal', 'Filtered Data');
    xlabel(ax, 'Time');
    ylabel(ax, 'Signal Amplitude');


    % Setting up titles
    if checkType(type{i}, [3, 4])
        title(ax, [upper(type{i}(1)) type{i}(2:end)  ' filter of order '....
            num2str(order(i)) ' with wc_{start} = ' num2str(wc(i)) ....
            ' and wc_{stop} = ' num2str(wc_band(i)) ' time response']);
        title(ax_freq, [upper(type{i}(1)) type{i}(2:end)  ' filter of order '....
            num2str(order(i)) ' with wc_{start} = ' num2str(wc(i)) ....
            ' and wc_{stop} = ' num2str(wc_band(i)) ' frequency response']);
    else
         title(ax, [upper(type{i}(1)) type{i}(2:end)  ' filter of order '....
            num2str(order(i)) ' with wc = ' num2str(wc(i)) ' time response']);
         title(ax_freq, [upper(type{i}(1)) type{i}(2:end)  ' filter of order '....
            num2str(order(i)) ' with wc = ' num2str(wc(i)) ' frequency response'] );
    end
    
    
end


