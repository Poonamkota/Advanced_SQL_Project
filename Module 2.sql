Module 2 Write an SQL query to solve the given problem statements.
 
 Task 1: List all regions along with the number of users assigned to each region.
 
 SELECT wr.region_name, COALESCE(num_users, 0) AS num_users FROM world_regions wr LEFT JOIN ( SELECT un.region_id, COUNT(DISTINCT un.consumer_id) AS num_users FROM user_nodes un GROUP BY un.region_id ) AS region_users ON wr.region_id = region_users.region_id ORDER BY wr.region_name
 
 
 
 Task 2: Find the user who made the largest deposit amount and the transaction type for that deposit.
 
 SELECT ut.consumer_id, ut.transaction_type, ut.transaction_amount FROM user_transaction ut JOIN ( SELECT transaction_type, MAX(transaction_amount) AS max_transaction_amount FROM user_transaction GROUP BY transaction_type ) max_trans ON ut.transaction_type = max_trans.transaction_type AND ut.transaction_amount = max_trans.max_transaction_amount ORDER BY ut.transaction_amount DESC LIMIT 4
 
 Task 3: Calculate the total amount deposited for each user in the "Europe" region.
 
SELECT u.consumer_id, SUM(t.transaction_amount) AS total_deposited_amount
FROM user_nodes u 
JOIN world_regions wr ON u.region_id = wr.region_id
JOIN user_transaction t ON u.consumer_id = t.consumer_id
WHERE wr.region_name = 'Europe' AND t.transaction_type = 'deposit'
GROUP BY u.consumer_id, u.region_id, wr.region_name;

 Task 4: Calculate the total number of transactions made by each user in the "United States" region.
 
 SELECT u.consumer_id, COUNT(t.consumer_id) AS total_transactions FROM user_nodes u JOIN world_regions wr ON u.region_id = wr.region_id JOIN user_transaction t ON u.consumer_id = t.consumer_id WHERE wr.region_name = 'United States' GROUP BY u.consumer_id, u.region_id, wr.region_name
 
 Task 5: Calculate the total number of users who made more than 5 transactions.
 SELECT consumer_id, COUNT(*) AS number_transactions FROM user_transaction GROUP BY consumer_id HAVING COUNT(*) > 5
 
 
 Task 6: Find the regions with the highest number of nodes assigned to them.
 SELECT wr.region_name, COUNT(un.region_id) AS number_of_nodes
FROM world_regions wr
JOIN user_nodes un ON wr.region_id = un.region_id
GROUP BY wr.region_name
ORDER BY number_of_nodes DESC
 
 
 Task 7: Find the user who made the largest deposit amount in the "Australia" region.
 
 select ut.consumer_id,max(ut.transaction_amount) as largest_deposit
from user_nodes as un
inner join world_regions as wr on un.region_id=wr.region_id
inner join user_transaction as ut on un.consumer_id=ut.consumer_id
where ut.transaction_type='deposit' and wr.region_name='Australia'
group by ut.consumer_id
order by largest_deposit desc
limit 1
 
 Task 8: Calculate the total amount deposited by each user in each region.
 
 SELECT un.consumer_id, wr.region_name, SUM(ut.transaction_amount) as total_deposit
FROM user_nodes as un
INNER JOIN world_regions as wr ON un.region_id = wr.region_id
INNER JOIN user_transaction as ut ON un.consumer_id = ut.consumer_id
WHERE ut.transaction_type = 'deposit'
GROUP BY un.consumer_id, wr.region_name
ORDER BY un.consumer_id, wr.region_name
 
 Task 9: Retrieve the total number of transactions for each region
 
 SELECT wr.region_name, COUNT(ut.consumer_id) AS total_transactions
FROM user_nodes u
JOIN user_transaction ut ON u.consumer_id = ut.consumer_id
JOIN world_regions wr ON u.region_id = wr.region_id
GROUP BY wr.region_name
 
 Task 10: Write a query to find the total deposit amount for each region (region_name) in the user_transaction table. Consider only those transactions where the consumer_id is associated with a valid region in the user_nodes table.
 
 SELECT wr.region_name, SUM(ut.transaction_amount) AS total_deposit_amount
FROM user_transaction ut
JOIN user_nodes un ON ut.consumer_id = un.consumer_id
JOIN world_regions wr ON un.region_id = wr.region_id
WHERE ut.transaction_type = 'deposit'
GROUP BY wr.region_name
 
 Task 11: Write a query to find the top 5 consumers who have made the highest total transaction amount (sum of all their deposit transactions) in the user_transaction table.
 
 SELECT ut.consumer_id, SUM(ut.transaction_amount) as total_transaction_amount
FROM user_transaction as ut
WHERE ut.transaction_type = 'deposit'
GROUP BY ut.consumer_id
ORDER BY total_transaction_amount DESC
LIMIT 5
 
 Task 12: How many consumers are allocated to each region?
 
 SELECT wr.region_id, wr.region_name, COUNT(DISTINCT un.consumer_id) as num_of_consumers
FROM world_regions as wr
LEFT JOIN user_nodes as un ON wr.region_id = un.region_id
GROUP BY wr.region_id, wr.region_name
Limit 5
 
 Task 13: What is the unique count and total amount for each transaction type?
 
 SELECT 
    transaction_type,
    COUNT(DISTINCT consumer_id) AS unique_count,
    SUM(transaction_amount) AS total_amount
FROM user_transaction
GROUP BY transaction_type
 
 
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
 
Task 15: How many transactions were made by consumers from each region?
 
SELECT wr.region_name, COUNT(ut.consumer_id) AS transaction_count
FROM user_transaction ut
JOIN user_nodes un ON ut.consumer_id = un.consumer_id
JOIN world_regions wr ON un.region_id = wr.region_id
GROUP BY wr.region_name