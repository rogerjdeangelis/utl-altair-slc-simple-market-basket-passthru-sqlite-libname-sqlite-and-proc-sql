# utl-altair-slc-simple-market-basket-passthru-sqlite-libname-sqlite-and-proc-sql
Altair slc simple market basket passthru sqlite libname sqlite and proc sql
    %let pgm=utl-altair-slc-simple-market-basket-passthru-sqlite-libname-sqlite-and-proc-sql;

    %stop_submission;

    Altair slc simple market basket passthru sqlite libname sqlite and proc sql

    Too long to post on a list, see github
    https://github.com/rogerjdeangelis/utl-altair-slc-simple-market-basket-passthru-sqlite-libname-sqlite-and-proc-sql

    PROBLEM (WHAT OTHER ITEMS ARE PURCHASED WHEN PURCHASING BUTTER)


      PRODUCTS        CUSTOMERS

      butter                545   545, out of 9,835 customers, have butter in their market basket

      also purchased with butter

      whole milk            271   50% half of them also purchased whole milk (271/545)
      other vegetables      197   36% purchased vegetables 197/545
      yogurt                144   26% purchased vegetables 144/545
      rolls/buns            132   24% purchased rolls/buns 132/545

    You can run the sqlite code in any of the 8 languages below.

    CONTENTS

      1 slc proc sql (only sas datasets)
      2 slc libname sqlite
      3 slc passthru sqlite

      Related to Altar Post
      https://community.altair.com/discussion/50697/market-basket-analysis-operators-to-change-data-layout?tab=all 
      
    PREP

    Download Christian Werner ODBC Drive (sqliteodbc_w64)
    Note some browsers will block the download as unsafe mainly because
    the site is http and not https. I have tested the download for malicious software and
    it is ok, however always 'create a restore point' before downloading.

    http://www.ch-werner.de/sqliteodbc/

    Other plcs with the grocery lists
    CSV
    https://www.dropbox.com/s/auqnh93u5f8887j/groceries.csv?dl=0
    XLSX
    https://www.dropbox.com/s/ug97hxkr0wuuvp3/groceries.xlsx?dl=0
    SAS DATASET
    have.sas7bdat
    https://www.dropbox.com/s/0egnm9rz14eqhhs/have.zip?dl=0


    RELATED MARKET BASKET REPOS
    -----------------------------------------------------------------------------------------------------
    https://github.com/rogerjdeangelis/utl-example-of-sequence-analysis-and-market-basket-analysis
    https://github.com/rogerjdeangelis/utl_association_analysis_and_market_basket_analysis
    https://github.com/rogerjdeangelis/utl_market_basket

    DROP DOWN TO 8 LANGUAGES (SAME SWLITE CODE)

    https://github.com/rogerjdeangelis/utl-altair-slc-sqlite-cheat-sheet
    https://github.com/rogerjdeangelis/utl-altair-slc-language1-drop-down-to-open-source-spss-and-execute-postgresql-query
    https://github.com/rogerjdeangelis/utl-altair-slc-language2-drop-down-to-open-source-matlab-and-execute-sqlite-with-extensions
    https://github.com/rogerjdeangelis/utl-altair-slc-language3-proc-r-read-write-csv-files-and-summarize-and-looping-with-sqlite
    https://github.com/rogerjdeangelis/utl-altair-slc-language4-proc-python-read-write-csv-files-and-summarize-and-looping-with-sqlite
    https://github.com/rogerjdeangelis/utl-altair-slc-native-language5-odbc-read-write-text-files-summarize-and-looping-with-sqlite
    https://github.com/rogerjdeangelis/utl-altair-slc-language6-rexcel-read-write-text-files-summarize-and-looping-with-sqlite
    https://github.com/rogerjdeangelis/utl-altair-slc-language7-perl-read-write-text-files-summarize-and-looping-with-sqlite
    https://github.com/rogerjdeangelis/utl-altair-slc-language8-powershell-read-write-text-files-summarize-and-looping-with-sqlite


    /*                   _
    (_)_ __  _ __  _   _| |_
    | | `_ \| `_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    */

    /*--- DOWNLOAD MARKET.SAS7BDAT FROM THIS REPO OR RUN THIS QUERY ---*/

    %utlfkil(d:/sd1/market.sas7bdat);

    filename download "d:/sd1/market.sas7bdat" recfm=n;

    proc http
      url="https://github.com/rogerjdeangelis/utl-altair-slc-simple-market-basket-passthru-sqlite-libname-sqlite-and-proc-sql/raw/main/market.sas7bdat"
      method="GET"
      out=download;
    run;

    /**************************************************************************************************************************/
    /* SD1.MARKET total obs=43,367                                                                                            */
    /*                                                                                                                        */
    /*CUSTOMER  PRODUCTS                                                                                                      */
    /*                                                                                                                        */
    /*     1    citrus fruit                                                                                                  */
    /*     1    semi-finished bread                                                                                           */
    /*     1    margarine                                                                                                     */
    /*     1    ready soups                                                                                                   */
    /*                                                                                                                        */
    /*     2    tropical fruit                                                                                                */
    /*     2    yogurt                                                                                                        */
    /*     2    coffee                                                                                                        */
    /*     3    whole milk                                                                                                    */
    /*                                                                                                                        */
    /*     4    pip fruit                                                                                                     */
    /*     4    yogurt                                                                                                        */
    /*     4    cream cheese                                                                                                  */
    /*     4    meat spreads                                                                                                  */
    /*  ....                                                                                                                  */
    /*  9834    semi-finished bread                                                                                           */
    /*  9834    bottled water                                                                                                 */
    /*  9834    soda                                                                                                          */
    /*  9834    bottled beer                                                                                                  */
    /*                                                                                                                        */
    /*  9835    chicken                                                                                                       */
    /*  9835    tropical fruit                                                                                                */
    /*  9835    other vegetables                                                                                              */
    /*  9835    vinegar                                                                                                       */
    /*  9835    shopping bags                                                                                                 */
    /**************************************************************************************************************************/

    /*                   _     _
    (_)_ __  _ __  _   _| |_  | | ___   __ _
    | | `_ \| `_ \| | | | __| | |/ _ \ / _` |
    | | | | | |_) | |_| | |_  | | (_) | (_| |
    |_|_| |_| .__/ \__,_|\__| |_|\___/ \__, |
            |_|                        |___/
    */

    1                                          Altair SLC       14:46 Wednesday, March 25, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"


    NOTE: AUTOEXEC processing completed

    1         %utlfkil(d:/sd1/market.sas7bdat);
    2
    3         filename download "d:/sd1/market.sas7bdat" recfm=n;
    4
    5         proc http
    6           url="https://github.com/rogerjdeangelis/utl-altair-slc-simple-market-basket-passthru-sqlite-libname-sqlite-and-proc-sql/raw/main/market.sas7bdat"
    7           method="GET"
    8           out=download;
    9         run;
    NOTE: Call to [https://github.com/rogerjdeangelis/utl-altair-slc-simple-market-basket-passthru-sqlite-libname-sqlite-and-proc-sql/raw/main/market.sas7bdat] returned [200:OK]
    NOTE: Procedure http step took :
          real time : 1.784
          cpu time  : 2.937


    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 1.879
          cpu time  : 3.015

    /*                                    _                      _       _                 _
    / |  _ __  _ __ ___   ___   ___  __ _| |  ___  __ _ ___   __| | __ _| |_ __ _ ___  ___| |_ ___
    | | | `_ \| `__/ _ \ / __| / __|/ _` | | / __|/ _` / __| / _` |/ _` | __/ _` / __|/ _ \ __/ __|
    | | | |_) | | | (_) | (__  \__ \ (_| | | \__ \ (_| \__ \| (_| | (_| | || (_| \__ \  __/ |_\__ \
    |_| | .__/|_|  \___/ \___| |___/\__, |_| |___/\__,_|___/ \__,_|\__,_|\__\__,_|___/\___|\__|___/
        |_|                            |_|
    */

    libname sd1 sas7bdat "d:/sd1";
    libname workx "d:/wpswrkx";

    proc contents data=sd1.market;run;

    proc datasets lib=workx kill;
    run;

    proc sql;

      reset outobs=5;

      create
        table workx.top5 as

      select
        products,
        count(*) as customers
      from
        sd1.market
      where id in
        (select
           distinct id
         from
           sd1.market
         where
           trim(products) = 'butter'
        )

      group
          by products
      order
         by customers desc

    ;quit;

    data workx.prob;
     retain butter_cnt;
     set workx.top5;
     if _n_=1 then butter_cnt=customers;
     prob = customers/butter_cnt;
    run;

    proc print data=workx.prob;
    run;quit;

    /**************************************************************************************************************************/
    /*  WORKX.PROB      total obs=5                                                                                           */
    /*                                                                                                                        */
    /* Obs         PRODUCTS        COUNT_IDS     PROB                                                                         */
    /*                                                                                                                        */
    /*  1      butter                 545       1.00000                                                                       */
    /*  2      whole milk             271       0.49725                                                                       */
    /*  3      other vegetables       197       0.36147                                                                       */
    /*  4      yogurt                 144       0.26422                                                                       */
    /*  5      rolls/buns             132       0.24220                                                                       */
    /**************** **********************************************************************************************************/

    /*   _                                         _   _
     ___| | ___   _ __  _ __ ___   ___   ___  __ _| | | | ___   __ _
    / __| |/ __| | `_ \| `__/ _ \ / __| / __|/ _` | | | |/ _ \ / _` |
    \__ \ | (__  | |_) | | | (_) | (__  \__ \ (_| | | | | (_) | (_| |
    |___/_|\___| | .__/|_|  \___/ \___| |___/\__, |_| |_|\___/ \__, |
                 |_|                            |_|            |___/
    */

    1                                          Altair SLC       13:31 Wednesday, March 25, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx

    NOTE: Library slchelp assigned as follows:
          Engine:        WPD
          Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp

    NOTE: Library worksas assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\worksas

    NOTE: Library workwpd assigned as follows:
          Engine:        WPD
          Physical Name: d:\workwpd


    LOG:  13:32:00
    NOTE: 1 record was written to file PRINT

    NOTE: The data step took :
          real time : 0.031
          cpu time  : 0.000


    NOTE: AUTOEXEC processing completed

    1         libname sd1 sas7bdat "d:/sd1";
    NOTE: Library sd1 assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\sd1

    2         libname workx "d:/wpswrkx";
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx


    Altair SLC

    The DATASETS Procedure

             Directory

    Libref           WORKX
    Engine           SAS7BDAT
    Physical Name    d:\wpswrkx

                                  Members

                Member    Member
      Number    Name      Type         File Size      Date Last Modified

    --------------------------------------------------------------------

           1    PROB      DATA            131072      25MAR2026:13:31:19
           2    TOP5      DATA              5120      25MAR2026:13:30:36
    3
    4         proc datasets lib=workx kill;
    5         run;
    NOTE: Deleting WORKX.prob (type=DATA)
    NOTE: Deleting WORKX.top5 (type=DATA)
    NOTE: Procedure datasets step took :
          real time : 0.043
          cpu time  : 0.031


    6
    7         proc sql;
    8
    9           reset outobs=5;
    10
    11          create
    12            table workx.top5 as
    13
    14          select
    15            products,
    16            count(*) as customers
    17          from
    18            sd1.market
    19          where id in
    20            (select
    21               distinct id
    22             from
    23               sd1.market
    24             where
    25               trim(products) = 'butter'
    26            )
    27
    28          group
    29              by products
    30          order
    31             by customers desc
    32
    33        ;quit;
    WARNING: Statement finished early due to OUTOBS=5 limit being reached.
    NOTE: Data set "WORKX.top5" has 5 observation(s) and 2 variable(s)
    NOTE: Procedure sql step took :
          real time : 0.110
          cpu time  : 0.109


    34
    35        data workx.prob;
    36         retain butter_cnt;
    37         set workx.top5;
    38         if _n_=1 then butter_cnt=customers;
    39         prob = customers/butter_cnt;
    40        run;

    NOTE: 5 observations were read from "WORKX.top5"
    NOTE: Data set "WORKX.prob" has 5 observation(s) and 4 variable(s)
    NOTE: The data step took :
          real time : 0.015
          cpu time  : 0.015


    41
    42        proc print data=workx.prob;
    43        run;quit;
    NOTE: 5 observations were read from "WORKX.prob"
    NOTE: Procedure print step took :
          real time : 0.000
          cpu time  : 0.000


    44
    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 0.252
          cpu time  : 0.203


    /*___        _                  _ _ _        _ _ _
    |___ \   ___| | ___   ___  __ _| (_) |_ ___ | (_) |__  _ __   __ _ _ __ ___   ___
      __) | / __| |/ __| / __|/ _` | | | __/ _ \| | | `_ \| `_ \ / _` | `_ ` _ \ / _ \
     / __/  \__ \ | (__  \__ \ (_| | | | ||  __/| | | |_) | | | | (_| | | | | | |  __/
    |_____| |___/_|\___| |___/\__, |_|_|\__\___||_|_|_.__/|_| |_|\__,_|_| |_| |_|\___|
                                 |_|
    */

    proc datasets lib=workx kill;
    run;

    libname sd1 sas7bdat "d:/sd1";
    libname workx "d:/wpswrkx";

    libname sqlite odbc noprompt="driver=sqlite3 odbc driver; database=d:/sqlite/mysqlite.db;LoadExt=d:/dll/sqlean.dll;";

    /*--- DROP MARKET TABLE IN SQLITE DATABASE  ---*/
    proc datasets lib=sqlite;
      delete market;
    run;quit;

    /*--- YOU CAN CREATE A SQLITE MARKET TABLE FROM A SAS DATASET USING PASSTHRU ---*/
    /*--- HOWEVER I SUGEST YOU USE THE SIMPLER LIBNAME ENGINE                    ---*/

    /*--- CREATE SQLITE TABLE FROM SAS DATASET ---*/
    data sqlite.market;
      set sd1.market;
    run;quit;

    proc sql;

      reset outobs=5;

      create
        table workx.top5 as

      select
        products,
        count(*) as customers
      from
        sd1.market
      where id in
        (select
           distinct id
         from
           sqlite.market  /*--- READS SQLITE TABLE ---*/
         where
           trim(products) = 'butter'
        )

      group
          by products
      order
         by customers desc

    ;quit;

    data workx.prob;
     retain butter_cnt;
     set workx.top5;
     if _n_=1 then butter_cnt=customers;
     prob = customers/butter_cnt;
    run;

    proc print data=workx.prob;
    run;quit;

    /**************************************************************************************************************************/
    /*  WORKX.PROB      total obs=5                                                                                           */
    /*                                                                                                                        */
    /* Obs         PRODUCTS        COUNT_IDS     PROB                                                                         */
    /*                                                                                                                        */
    /*  1      butter                 545       1.00000                                                                       */
    /*  2      whole milk             271       0.49725                                                                       */
    /*  3      other vegetables       197       0.36147                                                                       */
    /*  4      yogurt                 144       0.26422                                                                       */
    /*  5      rolls/buns             132       0.24220                                                                       */
    /**************** **********************************************************************************************************/

    1                                          Altair SLC       14:53 Wednesday, March 25, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"

    NOTE: AUTOEXEC processing completed


    Altair SLC

    The DATASETS Procedure

             Directory

    Libref           WORKX
    Engine           SAS7BDAT
    Physical Name    d:\wpswrkx
    1         proc datasets lib=workx kill;
    NOTE: No matching members in directory
    2         run;
    3
    4         libname sd1 sas7bdat "d:/sd1";
    NOTE: Library sd1 assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\sd1

    5         libname workx "d:/wpswrkx";
    NOTE: Library workx assigned as follows:
          Engine:        WPD
          Physical Name: d:\wpswrkx

    6
    7         libname sqlite odbc noprompt=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
    NOTE: Library sqlite assigned as follows:
          Engine:        ODBC
          Physical Name:  (SQLite version 3.43.2)

    NOTE: Procedure datasets step took :
          real time : 0.037
          cpu time  : 0.046



    Altair SLC

    The DATASETS Procedure

          Directory

    Libref         SQLITE
    Engine         ODBC
    Data Source
    8
    9         /*--- DROP MARKET TABLEIN SQLITE DATABASE  ---*/
    10        proc datasets lib=sqlite;
    NOTE: No matching members in directory
    11          delete market;
    12        run;quit;
    NOTE: Deleting "SQLITE.MARKET" (memtype="DATA")
    NOTE: Procedure datasets step took :
          real time : 0.127
          cpu time  : 0.062


    13
    14        /*--- CREATE SQLITE TABLE FROM SAS DATASET ---*/
    15        data sqlite.market;
    16          set sd1.market;
    17        run;

    NOTE: 43367 observations were read from "SD1.market"
    NOTE: Data set "SQLITE.market" has an unknown number of observation(s) and 2 variable(s)
    NOTE: The data step took :
          real time : 4.955
          cpu time  : 2.734


    17      !     quit;
    18
    19        proc sql;
    20
    21          reset outobs=5;
    22
    23          create
    24            table workx.top5 as
    25
    26          select
    27            products,
    28            count(*) as customers
    29          from
    30            sd1.market
    31          where id in
    32            (select
    33               distinct id
    34             from
    35               sqlite.market  /*--- READS SQLITE TABLE ---*/
    36             where
    37               trim(products) = 'butter'
    38            )
    39
    40          group
    41              by products
    42          order
    43             by customers desc
    44
    45        ;quit;
    WARNING: Statement finished early due to OUTOBS=5 limit being reached.
    NOTE: Data set "WORKX.top5" has 5 observation(s) and 2 variable(s)
    NOTE: Procedure sql step took :
          real time : 0.283
          cpu time  : 0.218


    46
    47        data workx.prob;
    48         retain butter_cnt;
    49         set workx.top5;
    50         if _n_=1 then butter_cnt=customers;
    51         prob = customers/butter_cnt;
    52        run;

    NOTE: 5 observations were read from "WORKX.top5"
    NOTE: Data set "WORKX.prob" has 5 observation(s) and 4 variable(s)
    NOTE: The data step took :
          real time : 0.010
          cpu time  : 0.000


    53
    54        proc print data=workx.prob;
    55        run;quit;
    NOTE: 5 observations were read from "WORKX.prob"
    NOTE: Procedure print step took :
          real time : 0.000
          cpu time  : 0.000


    56
    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 5.520
          cpu time  : 3.093

    /*____       _                            _   _                            _ _ _
    |___ /   ___| | ___   _ __   __ _ ___ ___| |_| |__  _ __ _   _   ___  __ _| (_) |_ ___
      |_ \  / __| |/ __| | `_ \ / _` / __/ __| __| `_ \| `__| | | | / __|/ _` | | | __/ _ \
     ___) | \__ \ | (__  | |_) | (_| \__ \__ \ |_| | | | |  | |_| | \__ \ (_| | | | ||  __/
    |____/  |___/_|\___| | .__/ \__,_|___/___/\__|_| |_|_|   \__,_| |___/\__, |_|_|\__\___|
                         |_|                                                |_|
    */

    proc datasets lib=workx kill;
    run;

    libname sd1 sas7bdat "d:/sd1";
    libname workx "d:/wpswrkx";

    libname sqlite odbc noprompt="driver=sqlite3 odbc driver; database=d:/sqlite/mysqlite.db;LoadExt=d:/dll/sqlean.dll;";

    /*--- DROP MARKET TABLE IN SQLITE DATABASE  ---*/
    proc datasets lib=sqlite;
      delete market;
    run;quit;

    /*--- YOU CAN CREATE A SQLITE MARKET TABLE FROM A SAS DATASET USING PASSTHRU ---*/
    /*--- HOWEVER I SUGEST YOU USE THE SIMPLER LIBNAME ENGINE                    ---*/

    /*--- CREATE SQLITE TABLE FROM SAS DATASET ---*/
    data sqlite.market;
      set sd1.market;
    run;quit;


    proc sql;
      connect to odbc
        (noprompt="DRIVER=SQLite3 ODBC Driver;
         Database=d:\sqlite\mysqlite.db;
         LoadExt=d:\dll\sqlean.dll;");

      create table workx.top5 as
      select * from connection to odbc
        (
          select
            products,
            count(*) as customers
          from market
          where id in (
            select distinct id
            from market
            where trim(products) = 'butter'
          )
          group by products
          order by count(*) desc
          limit 5
        );

      disconnect from odbc;
    quit;

    data workx.prob;
     retain butter_cnt;
     set workx.top5;
     if _n_=1 then butter_cnt=customers;
     prob = customers/butter_cnt;
    run;

    proc print data=workx.prob;
    run;quit;

    /**************************************************************************************************************************/
    /*  WORKX.PROB      total obs=5                                                                                           */
    /*                                                                                                                        */
    /* Obs         PRODUCTS        COUNT_IDS     PROB                                                                         */
    /*                                                                                                                        */
    /*  1      butter                 545       1.00000                                                                       */
    /*  2      whole milk             271       0.49725                                                                       */
    /*  3      other vegetables       197       0.36147                                                                       */
    /*  4      yogurt                 144       0.26422                                                                       */
    /*  5      rolls/buns             132       0.24220                                                                       */
    /**************** **********************************************************************************************************/

    /*                   _   _                  _
     _ __   __ _ ___ ___| |_| |__  _ __ _   _  | | ___   __ _
    | `_ \ / _` / __/ __| __| `_ \| `__| | | | | |/ _ \ / _` |
    | |_) | (_| \__ \__ \ |_| | | | |  | |_| | | | (_) | (_| |
    | .__/ \__,_|___/___/\__|_| |_|_|   \__,_| |_|\___/ \__, |
    |_|                                                 |___/
    */

    1                                          Altair SLC       15:01 Wednesday, March 25, 2026

    NOTE: Copyright 2002-2025 World Programming, an Altair Company
    NOTE: Altair SLC 2026 (05.26.01.00.000758)
          Licensed to Roger DeAngelis
    NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

    NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
    NOTE: AUTOEXEC source line
    1       +  ï»¿ods _all_ close;
               ^
    ERROR: Expected a statement keyword : found "?"
    NOTE: Library workx assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\wpswrkx

    NOTE: Library slchelp assigned as follows:
          Engine:        WPD
          Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp

    NOTE: Library worksas assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\worksas

    NOTE: Library workwpd assigned as follows:
          Engine:        WPD
          Physical Name: d:\workwpd


    LOG:  15:01:32
    NOTE: 1 record was written to file PRINT

    NOTE: The data step took :
          real time : 0.029
          cpu time  : 0.015


    NOTE: AUTOEXEC processing completed


    Altair SLC

    The DATASETS Procedure

             Directory

    Libref           WORKX
    Engine           SAS7BDAT
    Physical Name    d:\wpswrkx
    1         proc datasets lib=workx kill;
    NOTE: No matching members in directory
    2         run;
    3
    4         libname sd1 sas7bdat "d:/sd1";
    NOTE: Library sd1 assigned as follows:
          Engine:        SAS7BDAT
          Physical Name: d:\sd1

    5         libname workx "d:/wpswrkx";
    NOTE: Library workx assigned as follows:
          Engine:        WPD
          Physical Name: d:\wpswrkx

    6
    7         libname sqlite odbc noprompt=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
    NOTE: Library sqlite assigned as follows:
          Engine:        ODBC
          Physical Name:  (SQLite version 3.43.2)

    NOTE: Procedure datasets step took :
          real time : 0.038
          cpu time  : 0.031



    Altair SLC

    The DATASETS Procedure

          Directory

    Libref         SQLITE
    Engine         ODBC
    Data Source
    8
    9         /*--- DROP MARKET TABLE IN SQLITE DATABASE  ---*/
    10        proc datasets lib=sqlite;
    NOTE: No matching members in directory
    11          delete market;
    12        run;quit;
    NOTE: Deleting "SQLITE.MARKET" (memtype="DATA")
    NOTE: Procedure datasets step took :
          real time : 0.127
          cpu time  : 0.078


    13
    14        /*--- YOU CAN CREATE A SQLITE MARKET TABLE FROM A SAS DATASET USING PASSTHRU ---*/
    15        /*--- HOWEVER I SUGEST YOU USE THE SIMPLER LIBNAME ENGINE                    ---*/
    16
    17        /*--- CREATE SQLITE TABLE FROM SAS DATASET ---*/
    18        data sqlite.market;
    19          set sd1.market;
    20        run;

    NOTE: 43367 observations were read from "SD1.market"
    NOTE: Data set "SQLITE.market" has an unknown number of observation(s) and 2 variable(s)
    NOTE: The data step took :
          real time : 4.988
          cpu time  : 2.578


    20      !     quit;
    21
    22
    23        proc sql;
    24          connect to odbc
    25            (noprompt=XXXXXXXXXXXXXXXXXXXXXXXXXXXX
    26        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    27        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX);
    NOTE: Connected to DB:  (SQLite version 3.43.2)
    NOTE: Connected to DB:  (SQLite version 3.43.2)
    NOTE: Successfully connected to database ODBC as alias ODBC.
    28
    29          create table workx.top5 as
    30          select * from connection to odbc
    31            (
    32              select
    33                products,
    34                count(*) as customers
    35              from market
    36              where id in (
    37                select distinct id
    38                from market
    39                where trim(products) = 'butter'
    40              )
    41              group by products
    42              order by count(*) desc
    43              limit 5
    44            );
    NOTE: Data set "WORKX.top5" has 5 observation(s) and 2 variable(s)
    45
    46          disconnect from odbc;
    NOTE: Successfully disconnected from database ODBC.
    47        quit;
    NOTE: Procedure sql step took :
          real time : 0.047
          cpu time  : 0.062


    48
    49        data workx.prob;
    50         retain butter_cnt;
    51         set workx.top5;
    52         if _n_=1 then butter_cnt=customers;
    53         prob = customers/butter_cnt;
    54        run;

    NOTE: 5 observations were read from "WORKX.top5"
    NOTE: Data set "WORKX.prob" has 5 observation(s) and 4 variable(s)
    NOTE: The data step took :
          real time : 0.031
          cpu time  : 0.015


    55
    56        proc print data=workx.prob;
    57        run;quit;
    NOTE: 5 observations were read from "WORKX.prob"
    NOTE: Procedure print step took :
          real time : 0.000
          cpu time  : 0.000


    58
    59
    ERROR: Error printed on page 1

    NOTE: Submitted statements took :
          real time : 5.322
          cpu time  : 2.843
    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
