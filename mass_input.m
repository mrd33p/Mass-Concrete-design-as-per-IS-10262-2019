%% mass concrete design as per IS 10262
format short
tic
vt={'string','string','string','string','double','double','double','double','double','double','double','double','double','double','double','double','double','double','double','double'};
vn={'cement','exposure','conc_type','agg_type','slump','fly_ash','msa','sg_cement','sg_ash','sg_ca','sg_fa','fa_zone','fck','cement_incrmnt','cement_kg','ash_kg','slump_water','mass_fa','mass_ca','wc_ratio'};
td=zeros(1,14);
td=readtable('L1.xlsx');
trial1=table('size',[1,20],'VariableTypes',vt,'VariableNames',vn);
n=1;
%% Read data for mass_c function
t1=readtable('table_1.xlsx');           %for reading table 1 of IS 10262
t1=table2array(t1);                     %for reading table 2 of IS 10262
t2=readtable('table_2.xlsx');
t2=table2array(t2);
t11=readtable('table_11.xlsx');
t11=table2array(t11);

%% read data for wc_ratio function
tt1=readtable('fig1.xlsx');
tt1=table2array(tt1);           %convert into array if it contains all numrical values
tt2=readtable('cement.xlsx');   % for selection of curve
tt5=readtable('table_5_456.xlsx');   % for IS 456 conditions

%% read data for agg_select
tt13=readtable('table_13.xlsx');

for i=1:1
    di=td(i,:);
    trial1(i,:)=mass_c(di,t1,t2,t11,tt1,tt2,tt5,tt13);
    n=n+1
end
writetable(trial1,'L2.xlsx');
toc
