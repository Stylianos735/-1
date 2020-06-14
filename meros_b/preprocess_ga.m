load u.data


%Create dataset of ratings where each row is a movie and each column is a
%user.
users=unique(u(:,1));
movies=unique(u(:,2));
input=eye(length(users));
dataset=zeros([length(movies) length(users)]);
for i=1:length(users)
    for j=1:length(u)
        if u(j,1)==i
            tmp=u(j,2);
            dataset(tmp,i)=u(j,3);
        end
    end
end

%Calculate mean rating for each user.
mean_vals=[];
for i=1:length(users)
    this_col=dataset(:,i);
    tmp=find(this_col);
    k=length(tmp);
    mean_vals=[mean_vals (sum(this_col)/k)];
end
mean_vals=round(mean_vals);

for i=1:length(users)
    for j=1:length(movies)
        if dataset(j,i)==0
            dataset(j,i)=mean_vals(i);
        end
    end
end

%Encode data as bit strings.
bin_dataset=[];
bin_col=[];
for i=1:length(users)
    for j=1:length(movies)
        if dataset(j,i)==1
            bin_col=[bin_col 0 0 0];
        elseif dataset(j,i)==2
            bin_col=[bin_col 0 0 1];
        elseif dataset(j,i)==3
            bin_col=[bin_col 0 1 0];
        elseif dataset(j,i)==4
            bin_col=[bin_col 0 1 1];
        elseif dataset(j,i)==5
            bin_col=[bin_col 1 0 0];
        end
    end
    bin_dataset=[bin_dataset; bin_col];
    clear bin_col;
    bin_col=[];
end
bin_dataset=bin_dataset.';

%Return the coeficients (in Rc) between a random user and the rest of the users.
%Also removes the user's coeficient with theirselves.
curr_user=1; %Select user.
Rm=corrcoef(bin_dataset);
Rm=abs(Rm);
Rc=Rm(:,curr_user);
[~,tmp] = max(Rc);
Rc(tmp)=[];

%Find the top-10 nearest neighbors.
top_ten=[];
top_ten_val=[];
clear tmp;
clear k;
for k=1:10
    [tmp_val,tmp] = max(Rc);
    top_ten=[top_ten tmp];
    top_ten_val=[top_ten_val tmp_val];
    Rc(tmp)=[];
    k=k+1;
    clear tmp;
end

%Extract already filled in ratings for user #1.
filled_ratings=bin_dataset(1:816,curr_user);
filled_ratings=filled_ratings.';

save ga_data bin_dataset filled_ratings top_ten top_ten_val;

