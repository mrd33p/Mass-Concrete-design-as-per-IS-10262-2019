function [w_c,min_cement,max_w_c,min_grade]=wc_ratio(tt2,tt1,tt5,fck_d1,cement,exposure,type1,msa)
%% this is a function to select w/c ratio from fig 1 as per IS 10262

for i=1:4
    x=strcmpi(table2cell(tt2(i,1)),cell(cement));
    if x==1
       j=table2array(tt2(i,3));
        p=tt1(:,j);
        p=p(~isnan(p));
        q=tt1(:,(j+1));
        q=q(~isnan(q));
        xx=fit(p,q,'power2');
        w_c=xx(fck_d1);
    end
end


if strcmpi(type1,"plainconcrete")
    for ii=1:5
        if strcmpi(table2cell(tt5(ii,1)),exposure)
            min_cement=table2cell(tt5(ii,2));
            max_w_c=table2cell(tt5(ii,3));
            min_grade=table2cell(tt5(ii,4));
            if w_c>cell2mat(max_w_c)
                w_c=cell2mat(max_w_c);
            end
        end
    end
elseif strcmpi(type1,"reinforcedconcrete")
    for ii=1:5
        if strcmpi(table2cell(tt5(ii,1)),exposure)
            min_cement=table2cell(tt5(ii,5));
            max_w_c=table2cell(tt5(ii,6));
            min_grade=table2cell(tt5(ii,7));
            if w_c>cell2mat(max_w_c)
                w_c=cell2mat(max_w_c);
            end
        end
    end
end

%% correction for aggregate size IS 456 table 5 & 6
if msa>20
    min_cement=cell2mat(min_cement)-30;
elseif msa<20
    min_cement=cell2mat(min_cement)+40;
end

