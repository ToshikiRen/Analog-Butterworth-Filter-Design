function check = checkType(type, indx)


    if nargin < 1
        check = 0;
        return;
    elseif isempty(type)
        check = 0;
        return;
    end
    if nargin < 2
        indx = [1 2 3 4];
    elseif isempty(indx)
        indx = [1 2 3 4];
    end

    variants = cell(4,1);
    variants{1} = 'lowpass';  % 1
    variants{2} = 'highpass'; % 2
    variants{3} = 'passband'; % 3
    variants{4} = 'stopband'; % 4

    check = 0;
    for i = 1:numel(indx)

        if strcmp(type, variants{indx(i)})
           check = 1;
           return;
        end

    end
 
end