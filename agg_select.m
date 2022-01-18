function vol_ca=agg_select(tt13,msa,fa_zone,w_c2)
format short

for i=1:4
    if table2array(tt13(i,1))==msa
        ii=i;
    end
end
for j=1:5
    if table2array(tt13(1,j))==fa_zone
        jj=j;
    end
end
vol_ca=table2array(tt13(ii,jj));
%% modification for w/c other than 0.50
if w_c2~=0.50
    mm=(0.50-w_c2)*0.01/0.05;  % 1st para at page 34, F8 of IS 10262
    vol_ca=vol_ca+mm;
end
end


    
    


    