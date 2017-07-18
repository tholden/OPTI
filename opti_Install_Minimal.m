function opti_Install_Minimal( OptiFolder, fast )
%% Installation File for OPTI

%   Copyright (C) 2016 Jonathan Currie (IPL)

    %Add toolbox path to MATLAB
    fprintf('\n- Adding OPTI Paths to MATLAB Search Path...');
    genp = genpath( OptiFolder );
    genp = regexp(genp,';','split');
    %Folders to exclude from adding to Matlab path
    i = 1;
    rInd{:,:,i} = strfind(genp,'Documentation + Licenses'); i = i + 1;
    rInd{:,:,i} = strfind(genp,'Source'); i = i + 1;
    rInd{:,:,i} = strfind(genp,'CppAD'); i = i + 1;
    rInd{:,:,i} = strfind(genp,'misdp'); i = i + 1;
    rInd{:,:,i} = strfind(genp,'tex'); i = i + 1;
    rInd{:,:,i} = strfind(genp,'.git'); i = i + 1;
    rInd{:,:,i} = strfind(genp,'Crash Files'); i = i + 1;
    rInd{:,:,i} = strfind(genp,'mexopts'); i = i + 1;
    if(~exist([OptiFolder '\Solvers\Source\lib\win32\libclp.lib'],'file'))
        rInd{:,:,i} = strfind(genp,'Development'); i = i + 1;
    end

    ind = NaN(length(rInd{1}),1);
    %Track indices of paths to remove from list
    for i = 1:length(rInd{1})
        for j = 1:size(rInd,3)
            if(any(rInd{j}{i}))
                ind(i) = 1;
            end
        end
    end

    %Remove paths from above and add to matlab path
    genp(ind == 1) = [];
    addpath(genp{:});
    rehash
    fprintf('Done\n\n');

    %Post Install Test if requested
    if ~fast
        opti_Install_Test(1);
    end

    fprintf('\n\nYou now have the following solvers available to use:\n');
    optiSolver;


end
