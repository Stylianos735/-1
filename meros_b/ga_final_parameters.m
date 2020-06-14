function [x,fval,exitflag,output,population,score] = ga_final_parameters(nvars,PopInitRange_Data,PopulationSize_Data,EliteCount_Data,CrossoverFraction_Data,MigrationFraction_Data,Generations_Data,FitnessLimit_Data,StallGenLimit_Data,TolFun_Data)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = gaoptimset;
%% Modify options setting
options = gaoptimset(options,'PopulationType', 'bitstring');
options = gaoptimset(options,'PopInitRange', PopInitRange_Data);
options = gaoptimset(options,'PopulationSize', PopulationSize_Data);
options = gaoptimset(options,'EliteCount', EliteCount_Data);
options = gaoptimset(options,'CrossoverFraction', CrossoverFraction_Data);
options = gaoptimset(options,'MigrationFraction', MigrationFraction_Data);
options = gaoptimset(options,'Generations', Generations_Data);
options = gaoptimset(options,'FitnessLimit', FitnessLimit_Data);
options = gaoptimset(options,'StallGenLimit', StallGenLimit_Data);
options = gaoptimset(options,'TolFun', TolFun_Data);
options = gaoptimset(options,'SelectionFcn', @selectionroulette);
options = gaoptimset(options,'MutationFcn', {  @mutationuniform [] });
options = gaoptimset(options,'Display', 'off');
options = gaoptimset(options,'PlotFcns', { @gaplotbestf });
[x,fval,exitflag,output,population,score] = ...
ga(@fitFunc,nvars,[],[],[],[],[],[],[],[],options);
