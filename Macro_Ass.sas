/* 

Write a macro to import different type of files. Let’s say 
we have files that are tab      delimited text files as well
 as csv files. (“Sample.csv” and “Scores.txt”) 
(Hint: Define a macro variable for different delimiters.)

*/


%macro file(a,b,c);
proc import datafile="Y:\Advance_SAS\Graded Assignment\Macros\Data set\&a"
out=&b
dbms=&c replace;
run;
%mend file;
%file(a=Sample.csv, b=sample, c=csv);
%file(a=Scores.txt, b=scores, c=tab);
%file(a=HTWT.csv, b=HTWT, c=csv);



/* 
Convert the below SAS codes into macros. 
proc gchart data=HTWT; vbar gender/sumvar=weight; Title 
"Average weight by Gender"; 
      run; 
proc plot data=HTWT; Title "Scatter plot"; plot &height*&weight; 
       run; 
(Hint: Define two different macros.)  */


%macro convert(data, gender,weight);
proc gchart data=&data;
vbar &gender/sumvar=&weight;
title "Average Weight by Gender";
run;
%mend convert;
%convert(HTWT,Gender,Weight);
%macro converttt(data,height,weight);
proc plot data=&data;
plot &height * &weight;
title "Scatter Plot";
run;
%mend convert;
%convert(HTWT,Gender,Weight);



/*
%macro converttt(data,height,weight);
proc plot data=&data;
plot &height * &weight;
title "Scatter Plot";
run;

%mend converttt;
%converttt(HTWT,Height,Weight);
*/




/*
3) 
Import HTWT data set to extract 10 observations starting from 
fifth observation using SAS macros. 
Write a macro to compare two numeric values. 

(Hint: a) Use proc print. b) Use %if %then %do statement.)


*/




%macro obs(a,b);
data obschage;
set HTWT (firstobs=&a obs=&b);
run;
%mend obs;
%obs(a=5,b=16);





%macro numbers(a,b);
%if &a>&b %then %do;
%put &a is greater than &b;
%end;
%else %then %do;
%put &b is equal to or greater than &a;
%end;
%mend numbers;
%numbers (32,54);
 




/*
 
Let’s say you have "Revenue" information for different years 
from 2005 to 2009 with variable revenue. Write SAS macro which
 will apply means and univariate procedure on each year for revenue variable. 
(Hint: Define a macro variable to specify the procedure “name”.)

*/


%macro revenue(name,pname,var);
proc &pname data=&name;
class Year;
vars &var;
run;

%mend revenue;
%revenue(HTWT,means,Height);
%revenue(HTWT,univariate,Height);


/*
 
The data set "Macro definition.txt" has two SAS macros definition,
 import them and apply on HTWT data set. 
(Hint: Use %INCLUDE.)

*/

%include "Y:\Advance_SAS\Graded Assignment\Macros\Data set\Macro definition.txt";
%contents_of(HTWT);
%print_data(HTWT);
run;


/* 
Save the macros permanently defined so far and list all the macros. 
(Hint: Use options mstored sasmstore then run proc catalog.) 


*/



libname perm "Y:\Advance_SAS\Graded Assignment\Macros\Data set\Save_Macro";
options mstored sasmstore=perm;
%macro file(a,b,c)/ store source;
proc import datafile="Y:\Advance_SAS\Graded Assignment\Macros\Data set\&a";
out=&b
dbms=&c replace;
run;
%mend file;

%macro convert(data, gender,weight)/store source;
proc gchart data=&data;
vbar &gender/sumvar=&weight;
title "Average Weight by Gender";
run;

%mend convert;


%macro convertt(data,height,weight) / store source;
proc plot data=&data;
plot &height * &weight;
title "Scatter Plot";
run;

/* %convert(HTWT.Gender,Weight);  */

/* %macro converttt(data,height,weight);
proc plot data=&data;
plot &height * &weight;
title "Scatter Plot";
run;  */


%mend convert;





%macro obs(a,b);
data obschage;
set HTWT1(firstobs=&a obs=&b);
run;
%mend obs;





%macro numbers(x,y) / store soure;
%if &x lt &y %then %do;
%put &y is greater than &x;
%end;
%else %then %do;
%put &x is equal to or greater than &y;
%end;

%mend numbers;
 



%macro revenue(name,pname,var)/ store source;
proc &pname data=&name;
class Year;
vars &var;
run;

%mend revenue;

options mlogic;
proc catalog catalog=;
contents;
run;