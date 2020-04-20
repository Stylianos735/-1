%PreProcessing

load u.data

%Input/Target data creation

users=unique(u(:,1));
movies=unique(u(:,2));
input=eye(length(users));
target=zeros([length(movies) length(users)]);
for i=1:length(users)
    for j=1:length(u)
        if u(j,1)==i
            tmp=u(j,2);
            target(tmp,i)=u(j,3);
        end
    end
end

%Centering

sum=0;
jsum=0;
for i=1:size(target,2)
    sum=0;
    jsum=0;
    for j=1:size(target,1)
        if target(j,i)~=0
        sum=sum+target(j,i);
        jsum=jsum+1;
        end
    end
    mean_term=sum/jsum;
    for j=1:length(target)
        if target(j,i)~=0
            target(j,i)=target(j,i)-mean_term;
        end
    end
    clear sum;
    clear jsum;
    clear mean_term
end

%Create normalized output between 0-1
NormRows = sqrt(sum(target.*target,2));
target_norm = bsxfun(@rdivide,abs(target),NormRows);






