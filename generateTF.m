function H = generateTF(order, s_mod)


    s = tf('s');
    H = s/s;
  
    if nargin < 1
        disp('Order was not specified.');
        disp('Returning allpass');
        return;
    elseif isempty(order)
        disp('Order was empty.');
        disp('Returning allpass');
        return;
    end
    
    if nargin < 2 
        disp('Filter basic building block not specified');
        disp('Setting it to s');
        s_mod = s;
    elseif isempty(s_mod)
        disp('Filter basic building block was empty');
        disp('Setting it to s');
        s_mod = s;
    end
    
    if mod(order, 2) == 0
        for i = 1 : order/2
            H = H/(s_mod^2 - 2*s_mod*cos((2*i + order-1)/(2*order) * pi) + 1);
        end
    else
        for i = 1 : (order-1)/2
            H = H/(s_mod^2 - 2*s_mod*cos((2*i + order-1)/(2*order) * pi) + 1);
        end
        H = H/(s_mod+1);
    end

end