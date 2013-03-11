USE SALES_SAMPLE;

LOAD DATA LOCAL INPATH '/home/hiveuser/hive/sales_sample/sales.tsv' INTO TABLE SALES;
LOAD DATA LOCAL INPATH '/home/hiveuser/hive/sales_sample/sales_detail.tsv' INTO TABLE SALES_DETAIL;
LOAD DATA LOCAL INPATH '/home/hiveuser/hive/sales_sample/itemlist.tsv' INTO TABLE ITEM_MASTER;
LOAD DATA LOCAL INPATH '/home/hiveuser/hive/sales_sample/shoplist.tsv' INTO TABLE SHOP_MASTER;
