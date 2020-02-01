# BakeryDatabase

These files were used from: http://users.csc.calpoly.edu/~dekhtyar/365-Winter2015/index.html

The files were preprocessed to remove trailing whitespaces

### Before starting please download the dataset from https://github.umn.edu/sikka008/BakeryDatabase and import using the following instructions: 
1. Start your Postgres Environment with a folder mounted (i.e. `$ docker run -itv /media/sf_csci4707/dbdemo:/dbdemo postgres bash`) where dbdemo is the mounted folder

2. Download the dataset and the SQL files to that mounted folder

3. Simply Run This Script (`\i table_setup.sql`)

4. Import data using the following commands
 
 `\copy customers from 'dbdemo/BAKERY/customers.csv' delimiter ',' csv header;`
 
 `\copy goods from 'dbdemo/BAKERY/goods.csv' delimiter ',' csv header;`
 
 `\copy receipts from 'dbdemo/BAKERY/receipts.csv delimiter ',' csv header;`
 
 `\copy items from 'dbdemo/BAKERY/items.csv delimiter ',' csv header;` 
 
 5. Simply execute the interesting_question.sql script in the current mounted folder (`\i interesting_question.sql`).
