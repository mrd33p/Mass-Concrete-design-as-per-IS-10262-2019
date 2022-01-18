# Mass-Concrete-design-as-per-IS-10262-2019

STEP 0# Download all contents of this repo and keep in a single folder.

STEP #1 
Fill input data in the L1.xlsx file till column H (columns after that are used for thermal stress calculations, you can leave them as it is they are not used)

STEP #2 What to fill in columns of L1.xlsx file?
column A2: you should enter type of cement to be used in this cell. there are three accepted inputs
for OPC33 cement fill opc33 in cell A2
for OPC43 cement fill opc43 in cell A2
for OPC53 cement fill opc53 in cell A2
for PPC cement fill ppc in cell A2

Enter exposure in column 3. (mild, moderate, severe, very severe, extreme)
Enter aggregate typ in column 4 (rounded,crushed)
Enter the slump required in column 5 (any value between 50 to 150)
Enter fly ash percentage required in column 6 (e.g. 25 for 25%)
Enter size of aggregates to be used in column 7 (only three inputs are allowed, 40,80 and 150)
Enter the zone of sand (e.g. 1 for Zone-I, 2 for Zone-2)
Enter the cement increment if required in column 9 (e.g. 10 for 10% increment)

Dont disturb rest of the values. (they are not used anyway).

STEP #3 

Now just run the mass_input in matlab.

your mix design will be available in L2.xlsx file in the same folder. 

If you face any issue just open new issue, I will try to solve your problem.
