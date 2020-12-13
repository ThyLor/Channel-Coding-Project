choice = 7;
load(strcat('choice',num2str(choice),'.mat'),'Hreal','Hsys','k','n');
% Compute the patterns
[nOR, nOC, nO, cnOR, cnOC] = CalculateNumOnes(Hreal);
[upMatrVC, upMatrCV] = CreateUpdateMatrix(nOR,nOC,nO);
[perMatrVC, perMatrCV] = GetPattern(Hreal,nO,cnOR,cnOC);
save(strcat('data_c',num2str(choice)),'Hreal','Hsys','k','n', 'nOR', 'nOC', 'nO', 'cnOR', 'cnOC' , ...
    'upMatrVC', 'upMatrCV', 'patternVC', 'perMatrVC', 'patternCV', 'perMatrCV');

