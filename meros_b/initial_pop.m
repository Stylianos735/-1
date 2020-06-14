%load ga_data.mat;

ratings=bin_dataset(817:end,1);
tmp=length(ratings);
init_pop=zeros(20,tmp);
clear tmp;

for i=1:20
   init_pop(i,:)=ratings; 
end
clear ratings;


