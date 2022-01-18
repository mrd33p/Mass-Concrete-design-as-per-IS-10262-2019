function [trial1]=mass_c(x,t1,t2,t11,tt1,tt2,tt5,tt13)
%% code for mix design of concrete as per IS 10262
format short
cement=x{1,1};    
exposure=x{1,2};
type1=x{1,3};
agg_type=x{1,4};                       %shape of aggregates
slump=x{1,5};                          % slump required in mm
fly_ash=x{1,6};                        %fly ash in percent
msa=x{1,7};                            %aggregate size in mm
fa_zone=x{1,8};                         %fine aggegate zone e.g 1 for I, 2 for II, see IS 383
incr_cement_cntnt=x{1,9};              %increase in cemen content, manual requirement
sg_cement=3.15;
sg_ash=2.2;
sg_ca=2.65;
sg_fa=2.64;
                       
fck=20;                                %target grade of concrete e.g. 15 for M15

%% target strength for mix propotioning
for i=1:11
    if t1(i,1)==fck
        x=t1(i,2);
    end
    if t2(i,1)==fck
        sd=t2(i,2);
    end
end

fck_d1=fck+1.65*sd;
fck_d2=fck+x;
fck_d1=max(fck_d1,fck_d2);
    
%% target strength increment as per F3 for wet seiving
incr=msa/14+100/7;          % line equation created for calculation of increment 
fck_d=round(fck_d1*(100+incr)/100);  %only for cube test results and not for selection of water cement ratio.

%% APPROXIMATE AIR CONTENT
for i=1:3
    if t11(i,1)==msa
        ent_air=t11(i,2);
        w_content=t11(i,3);
    end
end

%% SELECTION OF WATER-CEMENT RATIO
[w_c,min_cement,~,~]=wc_ratio(tt2,tt1,tt5,fck_d1,cement,exposure,type1,msa);

%% SELECTION OF WATER CONTENT
if strcmpi(strcat(agg_type,string(msa),'mm'),'rounded40mm')
    w_reduction=20;
elseif strcmpi(strcat(agg_type,string(msa),'mm'),'rounded80mm')
    w_reduction=15;
elseif strcmpi(strcat(agg_type,string(msa),'mm'),'rounded150mm')
    w_reduction=10;
else
    w_reduction=0;
end
reduced_w_content=w_content-w_reduction;

%% water content for slump other than 50mm
if slump~=50
    slump_water=reduced_w_content*(100+(slump-50)*3/25)/100;
else
    slump_water=reduced_w_content;
end

%% CALCULATION OF CEMENT CONTENT
cement_c=round(slump_water/w_c);
if incr_cement_cntnt~=0
    cement_c=round(cement_c*(100+incr_cement_cntnt)/100);
end

w_c2=slump_water/cement_c;

%% fly ash calculation
ash_kg=cement_c*fly_ash/100;
cement_kg=cement_c-ash_kg;
if cement_kg>450                % IS 456 clause 8.2.4.2
    cement_kg=450;
end
if cement_c<min_cement
    cement_c=min_cement;
end

%% PROPORTION OF VOLUME OF COARSE AGGREGATE AND FINE AGGREGETE CONTENT
vol_ca=agg_select(tt13,msa,fa_zone,w_c2);    %function to calulate vol  of ca
vol_fa=1-vol_ca;
%% Mix Calculations
vol_cement=(cement_kg/sg_cement)/1000;
vol_fly_ash=(ash_kg/sg_ash)/1000;
vol_water=(reduced_w_content/1)/1000;
vol_all_agg=((1-ent_air/100)-(vol_cement+vol_fly_ash+vol_water));
mass_ca=vol_all_agg*vol_ca*sg_ca*1000;
mass_fa=vol_all_agg*vol_fa*sg_fa*1000;

%% CHECK ON MORTAR CONTENT F11
m_c=vol_cement+vol_fly_ash+vol_water+vol_fa+ent_air;
%[~,comment0]=mortar(agg_type,msa,m_c);

%disp(comment0)
trial1=table(cement,exposure,type1,agg_type,slump,fly_ash,msa,sg_cement,sg_ash,sg_ca,sg_fa,fa_zone,fck,incr_cement_cntnt,cement_kg,ash_kg,slump_water,mass_fa,mass_ca,w_c2);
end


