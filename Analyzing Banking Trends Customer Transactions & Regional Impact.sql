
Module 2 Write an SQL query to solve the given problem statements.
 
 Task 1: List all regions along with the number of users assigned to each region.
 
 SELECT wr.region_name, COALESCE(num_users, 0) AS num_users FROM world_regions wr LEFT JOIN ( SELECT un.region_id, COUNT(DISTINCT un.consumer_id) AS num_users FROM user_nodes un GROUP BY un.region_id ) AS region_users ON wr.region_id = region_users.region_id ORDER BY wr.region_name
 
region_name   	num_users	
Africa	88	
Asia	95	
Australia	102	
China	0	
Europe	105	
Russia	0	
United States	110	

 
 Task 2: Find the user who made the largest deposit amount and the transaction type for that deposit.
 
 SELECT ut.consumer_id, ut.transaction_type, ut.transaction_amount FROM user_transaction ut JOIN ( SELECT transaction_type, MAX(transaction_amount) AS max_transaction_amount FROM user_transaction GROUP BY transaction_type ) max_trans ON ut.transaction_type = max_trans.transaction_type AND ut.transaction_amount = max_trans.max_transaction_amount ORDER BY ut.transaction_amount DESC LIMIT 4
 
consumer_id	transaction_type	transaction_amount   	
218	deposit	1000	
219	deposit	1000	

 
 Task 3: Calculate the total amount deposited for each user in the "Europe" region.
 
SELECT u.consumer_id, SUM(t.transaction_amount) AS total_deposited_amount
FROM user_nodes u 
JOIN world_regions wr ON u.region_id = wr.region_id
JOIN user_transaction t ON u.consumer_id = t.consumer_id
WHERE wr.region_name = 'Europe' AND t.transaction_type = 'deposit'
GROUP BY u.consumer_id, u.region_id, wr.region_name;

localhost/b5df44bf/user_nodes/		https://projects.hicounselor.com/zootopia/db_sql.php?db=b5df44bf
 Showing rows 0 - 24 (105 total, Query took 0.0771 seconds.)

SELECT u.consumer_id, SUM(t.transaction_amount) AS total_deposited_amount
FROM user_nodes u 
JOIN world_regions wr ON u.region_id = wr.region_id
JOIN user_transaction t ON u.consumer_id = t.consumer_id
WHERE wr.region_name = 'Europe' AND t.transaction_type = 'deposit'
GROUP BY u.consumer_id, u.region_id, wr.region_name


consumer_id	total_deposited_amount	
402	38962	
378	78892	
383	86900	
30	25272	
410	37158	
17	12090	
480	23650	
374	60764	
206	25322	
339	80674	
50	85878	
366	91168	
454	104830	
199	36454	
443	49896	
317	27104	
122	57860	
36	70980	
334	65384	
205	112574	
475	58498	
500	133034	
234	92950	
420	37664	
430	34584	


 Task 4: Calculate the total number of transactions made by each user in the "United States" region.
 
 SELECT u.consumer_id, COUNT(t.consumer_id) AS total_transactions FROM user_nodes u JOIN world_regions wr ON u.region_id = wr.region_id JOIN user_transaction t ON u.consumer_id = t.consumer_id WHERE wr.region_name = 'United States' GROUP BY u.consumer_id, u.region_id, wr.region_name
 
consumer_id	total_transactions	
188	330	
169	308	
292	330	
63	338	
305	198	
276	330	
100	234	
455	66	
69	572	
265	418	
466	154	
46	338	
142	198	
81	312	
380	352	
387	154	
95	390	
120	374	
287	242	
112	176	
284	484	
217	440	
137	88	
416	418	
375	176	

 
 Task 5: Calculate the total number of users who made more than 5 transactions.
 SELECT consumer_id, COUNT(*) AS number_transactions FROM user_transaction GROUP BY consumer_id HAVING COUNT(*) > 5
 
consumer_id	number_transactions	
312	18	
376	42	
188	30	
138	30	
373	14	
361	8	
169	28	
402	14	
60	16	
378	26	
383	22	
292	30	
63	26	
499	34	
130	22	
441	42	
53	16	
30	8	
305	18	
136	24	
276	30	
410	20	
152	24	
123	26	
17	6	

 
 Task 6: Find the regions with the highest number of nodes assigned to them.
 SELECT wr.region_name, COUNT(un.region_id) AS number_of_nodes
FROM world_regions wr
JOIN user_nodes un ON wr.region_id = un.region_id
GROUP BY wr.region_name
ORDER BY number_of_nodes DESC
 

region_name	number_of_nodes   	
United States	1254	
Europe	1203	
Australia	1160	
Asia	1081	
Africa	1004	
 
 
 Task 7: Find the user who made the largest deposit amount in the "Australia" region.
 
 select ut.consumer_id,max(ut.transaction_amount) as largest_deposit
from user_nodes as un
inner join world_regions as wr on un.region_id=wr.region_id
inner join user_transaction as ut on un.consumer_id=ut.consumer_id
where ut.transaction_type='deposit' and wr.region_name='Australia'
group by ut.consumer_id
order by largest_deposit desc
limit 1
 

region_name	number_of_nodes   	
United States	1254	
Europe	1203	
Australia	1160	
Asia	1081	
Africa	1004	


 Task 8: Calculate the total amount deposited by each user in each region.
 
 SELECT un.consumer_id, wr.region_name, SUM(ut.transaction_amount) as total_deposit
FROM user_nodes as un
INNER JOIN world_regions as wr ON un.region_id = wr.region_id
INNER JOIN user_transaction as ut ON un.consumer_id = ut.consumer_id
WHERE ut.transaction_type = 'deposit'
GROUP BY un.consumer_id, wr.region_name
ORDER BY un.consumer_id, wr.region_name

localhost/b5df44bf/world_regions/		https://projects.hicounselor.com/zootopia/db_sql.php?db=b5df44bf
 Showing rows 0 - 24 (500 total, Query took 0.2049 seconds.) [consumer_id: 1... - 25...] [region_name: [BLOB - 9 B]... - [BLOB - 6 B]...]

SELECT un.consumer_id, wr.region_name, SUM(ut.transaction_amount) as total_deposit
FROM user_nodes as un
INNER JOIN world_regions as wr ON un.region_id = wr.region_id
INNER JOIN user_transaction as ut ON un.consumer_id = ut.consumer_id
WHERE ut.transaction_type = 'deposit'
GROUP BY un.consumer_id, wr.region_name
ORDER BY un.consumer_id, wr.region_name


consumer_id   	region_name	total_deposit	
1	Australia	16536	
2	Australia	15860	
3	Africa	16562	
4	Africa	22048	
5	Australia	75660	
6	United States	122772	
7	Europe	119288	
8	United States	54834	
9	Asia	82628	
10	Australia	70330	
11	Europe	59150	
12	United States	29744	
13	Europe	84500	
14	United States	41002	
15	United States	28652	
16	Asia	73632	
17	Europe	12090	
18	United States	39312	
19	Europe	23374	
20	Europe	43602	
21	Australia	58448	
22	Asia	138970	
23	United States	30368	
24	Europe	50960	
25	Africa	58474	

 
 Task 9: Retrieve the total number of transactions for each region
 
 SELECT wr.region_name, COUNT(ut.consumer_id) AS total_transactions
FROM user_nodes u
JOIN user_transaction ut ON u.consumer_id = ut.consumer_id
JOIN world_regions wr ON u.region_id = wr.region_id
GROUP BY wr.region_name
 

region_name	total_transactions	
Africa	22098	
United States	29454	
Asia	26004	
Europe	28736	
Australia	27280	

 
 Task 10: Write a query to find the total deposit amount for each region (region_name) in the user_transaction table. Consider only those transactions where the consumer_id is associated with a valid region in the user_nodes table.
 
 SELECT wr.region_name, SUM(ut.transaction_amount) AS total_deposit_amount
FROM user_transaction ut
JOIN user_nodes un ON ut.consumer_id = un.consumer_id
JOIN world_regions wr ON un.region_id = wr.region_id
WHERE ut.transaction_type = 'deposit'
GROUP BY wr.region_name


region_name	total_deposit_amount	
Africa	5223710	
United States	6719442	
Asia	6038592	
Europe	6914730	
Australia	5985626	

 
 Task 11: Write a query to find the top 5 consumers who have made the highest total transaction amount (sum of all their deposit transactions) in the user_transaction table.
 
 SELECT ut.consumer_id, SUM(ut.transaction_amount) as total_transaction_amount
FROM user_transaction as ut
WHERE ut.transaction_type = 'deposit'
GROUP BY ut.consumer_id
ORDER BY total_transaction_amount DESC
LIMIT 5
 
localhost/b5df44bf/user_transaction/		https://projects.hicounselor.com/zootopia/db_sql.php?db=b5df44bf
 Showing rows 0 -  4 (5 total, Query took 0.0256 seconds.)

SELECT ut.consumer_id, SUM(ut.transaction_amount) as total_transaction_amount
FROM user_transaction as ut
WHERE ut.transaction_type = 'deposit'
GROUP BY ut.consumer_id
ORDER BY total_transaction_amount DESC
LIMIT 5


consumer_id	total_transaction_amount   	
197	16194	
281	15316	
376	14574	
416	14572	
203	13912	
 
 
 Task 12: How many consumers are allocated to each region?
 
 SELECT wr.region_id, wr.region_name, COUNT(DISTINCT un.consumer_id) as num_of_consumers
FROM world_regions as wr
LEFT JOIN user_nodes as un ON wr.region_id = un.region_id
GROUP BY wr.region_id, wr.region_name
Limit 5


region_id	region_name	num_of_consumers	
1	United States	110	
2	Europe	105	
3	Australia	102	
4	Asia	95	
5	Africa	88	

 
 Task 13: What is the unique count and total amount for each transaction type?
 
 SELECT 
    transaction_type,
    COUNT(DISTINCT consumer_id) AS unique_count,
    SUM(transaction_amount) AS total_amount
FROM user_transaction
GROUP BY transaction_type
 

transaction_type	unique_count	total_amount	
deposit	500	2718336	
purchase	448	1613074	
withdrawal	439	1586006	

 
 Task 14: What are the average deposit counts and amounts for each transaction type ('deposit') across all customers, grouped by transaction type?
 
 WITH deposit_counts AS (
    SELECT
        ut.consumer_id,
        COUNT(*) AS deposit_count,
        sum(ut.transaction_amount) AS avg_deposit_amount
    FROM
        user_transaction AS ut
    WHERE
        ut.transaction_type = 'deposit'
    GROUP BY
        ut.consumer_id
)

SELECT
    'deposit' AS transaction_type,
    ROUND(AVG(deposit_count)) AS avg_deposit_count,
    ROUND(AVG(avg_deposit_amount)) AS avg_deposit_amount
    
FROM
    deposit_counts
	
	
transaction_type avg_deposit_count avg_deposit_amount
deposit	11	5437	

 
Task 15: How many transactions were made by consumers from each region?
 
SELECT wr.region_name, COUNT(ut.consumer_id) AS transaction_count
FROM user_transaction ut
JOIN user_nodes un ON ut.consumer_id = un.consumer_id
JOIN world_regions wr ON un.region_id = wr.region_id
GROUP BY wr.region_name


region_name	transaction_count	
Africa	22098	
United States	29454	
Asia	26004	
Europe	28736	
Australia	27280	
