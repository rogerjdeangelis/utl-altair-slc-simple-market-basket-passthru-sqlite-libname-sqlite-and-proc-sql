/* Market basket analysis: what is also purchased when a customer buys butter?    */
/* Approach 1 from the repo: pure SLC/SAS PROC SQL over a market dataset.          */
/*                                                                                 */
/* The upstream script reads sd1.market from a local sas7bdat library             */
/* (libname sd1 sas7bdat "d:/sd1"). For a self-contained run this bundle builds an */
/* equivalent work.market with the same (id, products) shape from inline sample    */
/* rows; the PROC SQL correlated subquery, GROUP BY / ORDER BY, and the DATA step  */
/* probability calculation are exactly as written upstream. The top-5 output cap is */
/* declared as PROC SQL OUTOBS=5 on the procedure statement.                        */

data work.market;
  length products $27;
  infile datalines dsd dlm='|';
  input id products $;
datalines;
1|butter
1|other vegetables
1|rolls/buns
1|whole milk
2|butter
2|other vegetables
2|rolls/buns
2|whole milk
3|bottled water
3|butter
3|other vegetables
3|whole milk
4|bottled water
4|butter
4|yogurt
5|butter
5|rolls/buns
5|tropical fruit
5|whole milk
5|yogurt
6|butter
6|soda
6|yogurt
7|butter
7|other vegetables
7|rolls/buns
7|whole milk
7|yogurt
8|bottled water
8|butter
8|other vegetables
8|whole milk
9|butter
9|other vegetables
10|butter
10|other vegetables
10|rolls/buns
11|butter
11|other vegetables
11|rolls/buns
12|butter
13|butter
14|butter
14|whole milk
14|yogurt
15|butter
15|yogurt
16|butter
16|rolls/buns
16|tropical fruit
16|whole milk
16|yogurt
17|butter
17|citrus fruit
17|other vegetables
17|whole milk
18|butter
18|other vegetables
18|whole milk
18|yogurt
19|butter
19|soda
20|butter
20|other vegetables
20|whole milk
20|yogurt
21|pastry
21|soda
22|whole milk
23|sausage
23|tropical fruit
24|other vegetables
24|soda
24|yogurt
25|whole milk
25|yogurt
26|bottled water
26|whole milk
27|soda
27|whole milk
28|bottled water
29|other vegetables
30|bottled water
31|bottled water
31|soda
32|tropical fruit
;
run;

proc sql outobs=5;

  create
    table work.top5 as

  select
    products,
    count(*) as customers
  from
    work.market
  where id in
    (select
       distinct id
     from
       work.market
     where
       trim(products) = 'butter'
    )

  group
      by products
  order
     by customers desc

;quit;

data work.prob;
 retain butter_cnt;
 set work.top5;
 if _n_=1 then butter_cnt=customers;
 prob = customers/butter_cnt;
run;

proc print data=work.prob;
run;quit;
