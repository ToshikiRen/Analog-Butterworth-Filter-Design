function truncatedCellArray = truncateCellArray(cellArray, new_size)
    
    if nargin < 1
        disp('Inputs: cell array and new size');
        return;
    elseif isempty(cellArray)
        disp('Empty input. Nothing to truncate');
        return;
    end
    
    if nargin < 2
        disp('Size was not specified.');
        truncatedCellArray = cellArray;
        return;
    elseif isempty(new_size)
        disp('Empty new size');
        truncatedCellArray = cellArray;
        return;
    end
    
    truncatedCellArray = cell(new_size, 1);
    for i = 1 : new_size
       truncatedCellArray{i} = cellArray{i}; 
    end

end