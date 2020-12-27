function [H, error] = designButter(order, type, wc, wc_band)
    
    % Define error array
    error = cell(20, 1);
    errorIndex = 1;
    
    % Checking input data
    if nargin < 1
        order = 1;
        wc = 1;
        type = 'lowpass';
        % display('Order set to 1, cutoff frequency set to 1');
        error{errorIndex} =  'No input detected, order and cutoff frequency set to 1';
        errorIndex = errorIndex + 1;
    elseif isempty(order) == 1
        order = 1;
        % display('Order set to 1');
        error{errorIndex} = 'Empty order, order set to 1';
        errorIndex = errorIndex + 1;
    end
    if nargin < 2
        type = 'lowpass';
        error{errorIndex} = 'Type was not set. Deafult type = lowpass';
        errorIndex = errorIndex + 1;
    elseif isempty(type)
        type = 'lowpass';
        error{errorIndex} = 'Type was empty. Deafult type = lowpass';
        errorIndex = errorIndex + 1;
    end
    
    if nargin < 3
        wc = 1;
        % display('Cutoff frequency set to 1');
        error{errorIndex} = 'Cutoff frequency set to 1.';
        errorIndex = errorIndex + 1;
    elseif isempty(wc) == 1
        wc = 1;
        % display('Cutoff frequency set to 1');
        error{errorIndex} = 'Empty cutoff frequency, cutoff set to 1';
        errorIndex = errorIndex + 1;
    end
    
    % Check valid filter type
    if(~checkType(type))
        type = 'lowpass';
        error{errorIndex} = 'Invalid type. Type set to lowpass';
        errorIndex = errorIndex + 1;
    end
    
    % Check if we need the second cutoff frequency
    if(checkType(type, [3, 4]))
        if nargin < 4
            error{errorIndex} = ['Missing second cutoff frequency. ' ....
                'Second cutoff frequency set to 10 * wc'];
            errorIndex = errorIndex + 1;
            wc_band = 10 * wc;
        elseif(isempty(wc_band))
            error{errorIndex} = ['Empty second cutoff frequency. ' ....
                'Second cutoff frequency set to 10 * wc'];
            errorIndex = errorIndex + 1;
            wc_band = 10 * wc;
        end
    end
    
    % Set max-order
    if order > 50
        % display('The order is to high');
        display('Order set to 50');
        error{errorIndex} = 'Order to high. Please use an order <= 50';
        errorIndex = errorIndex + 1;
        order = 50;
    end   
    
    s = tf('s');
    
    switch type
        case 'lowpass'
            s_mod = s/wc;
            H = generateTF(order, s_mod);
        case 'highpass'
            s_mod = wc/s;
            H = generateTF(order, s_mod);
            
        case 'passband'
              s_mod = (s^2 + wc*wc_band)/((wc_band - wc)*s);
              H = generateTF(order, s_mod);
            
        case 'stopband'
            s_mod = ((wc_band - wc)*s)/(s^2 + wc*wc_band);
            H = generateTF(order, s_mod);
            
    end

    if errorIndex == 1
        error{errorIndex} = 'All good';
        errorIndex = errorIndex + 1;
    end
    
    error = truncateCellArray(error, errorIndex - 1);
    H = tf(ss(H, 'min'));
    
end