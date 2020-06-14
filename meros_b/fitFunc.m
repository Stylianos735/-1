function [result] = fitFunc(ratings)
%Η συναρτηση θα περνει ως εισοδο διαφορα διανυσματα τιμων για τις ταινιες 
%που δεν εχει βαθμολογησει ο χρηστης, θα ενωνει τα διανυσματα αυτα με 
%τις ηδη υπαρχουσες βαθμολογιες δημιουργοντας ετσι το διανυσμα του χρηστη.
%Το διανυσμα αυτο θα συγκρινεται υστερα με τα διανσυματα των
%χρηστων-γειτονων και θα υπολογιζεται ο μεσος ορος Pearson της γειτονιας.
%Οσο πιο κοντα στο 1 ειναι ο μεσος ορος, τοσο πιο κοντα βρισκομαστε στη
%λυση.

load ga_data.mat;

user=cat(2,filled_ratings,ratings);

%Replace initial user with vector from population.
bin_dataset(:,1)=user;

%Recalculate Pearson.
Rm_this=corrcoef(bin_dataset);
Rm_this=abs(Rm_this);
Rc_this=Rm_this(:,1);
[~,tmp] = max(Rc_this);
Rc_this(tmp)=[];

%Get the Pearson values for the initial neighbors.
for i=1:length(top_ten)
    tmp=top_ten(i);
    top_ten_val(i)=Rm_this(tmp,1);
end

%Calculate new mean.
%(1-mean formula used to convert problem to minimization for the ga tool to
%handle).
result=(1-(sum(top_ten_val)/length(top_ten_val)));

end

