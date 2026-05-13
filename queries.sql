-- 1: Παρουσίασε όλα τα ονόματα των πελατών ταξινομημένα με το
-- ποιος/α οφείλει πιο πολλά στην Choco-K29.

SELECT cust_name,
       curr_balance
FROM   CUSTOMERS
ORDER  BY curr_balance DESC;


-- 2: Ποιοι κωδικοί προϊόντων θα πρέπει να παραγγελθούν άμεσα;


SELECT prod_code,
       description,
       qty_on_hand,
       reorder_level
FROM   PRODUCTS
WHERE  qty_on_hand < reorder_level;



-- 3: Παρουσιάστε τα ονόματα όλων των πελατών που παράγγειλαν
-- 'Almond-Choco' τον Απρίλιο του 2025.

SELECT DISTINCT c.cust_name
FROM   CUSTOMERS     c
JOIN   ORDERS        o  ON o.cust_no   = c.cust_no
JOIN   ORDER_DETAILS od ON od.order_no = o.order_no
JOIN   PRODUCTS      p  ON p.prod_code = od.prod_code
WHERE  p.description LIKE '%Almond-Choco%'
  AND  EXTRACT(YEAR  FROM o.order_date) = 2025
  AND  EXTRACT(MONTH FROM o.order_date) = 4;


-- 4: Παρουσιάστε τον prod_code, order_no, και order_date για
--  όσες παραγγελίες η order_qty είναι μεγαλύτερη από
--  την reorder_qty του αντίστοιχου προϊόντος.

SELECT od.prod_code,
       o.order_no,
       o.order_date
FROM   ORDER_DETAILS od
JOIN   ORDERS        o  ON o.order_no  = od.order_no
JOIN   PRODUCTS      p  ON p.prod_code = od.prod_code
WHERE  od.order_qty > p.reorder_qty;


-- 5: Ποια είναι η αξία και ο αριθμός της καλύτερης παραγγελίας
--  για σοκολάτες τύπου "OrangeChoco"?


SELECT od.order_no,
       SUM(od.order_qty * od.order_price) AS order_value
FROM   ORDER_DETAILS od
JOIN   PRODUCTS      p  ON p.prod_code = od.prod_code
WHERE  p.description LIKE '%OrangeChoco%'
GROUP  BY od.order_no
ORDER  BY order_value DESC
LIMIT  1;



-- 6: Παρουσίασε όλες τις πόλεις για τις οποίες το average
--  redit limit των πελατών είναι πάνω από 9,000€.

SELECT   town,
         ROUND(AVG(cr_limit), 2) AS avg_cr_limit
FROM     CUSTOMERS
GROUP BY town
HAVING   AVG(cr_limit) > 9000
ORDER BY avg_cr_limit DESC;


-- 7: Για κάθε προϊόν (prod_code) βρες τη μικρότερη και τη
-- μεγαλύτερη χρηματικά παραγγελία που έχει γίνει.


SELECT   od.prod_code,
         MIN(od.order_qty * od.order_price) AS min_order_value,
         MAX(od.order_qty * od.order_price) AS max_order_value
FROM     ORDER_DETAILS od
GROUP BY od.prod_code 
ORDER BY od.prod_code;


-- 8: Σε ποιες μέρες τον Ιούνιο 2025 το σύνολο των παραγγελιών
-- που παρελήφθη εκείνη τη μέρα ήταν μεγαλύτερο από 35,000€;

SELECT   o.order_date,
         SUM(od.order_qty * od.order_price) AS daily_total
FROM     ORDERS        o
JOIN     ORDER_DETAILS od ON od.order_no = o.order_no
WHERE    EXTRACT(YEAR  FROM o.order_date) = 2025
  AND    EXTRACT(MONTH FROM o.order_date) = 6
GROUP BY o.order_date
HAVING   SUM(od.order_qty * od.order_price) > 35000
ORDER BY o.order_date;


-- 9: Για κάθε prod_code που παραγγέλθηκε τον Ιανουάριο 2024,
-- παρουσίασε το prod_origin και τον αριθμό των πελατών
-- που παράγγειλαν το εν λόγω προϊόν.

SELECT   od.prod_code,
         p.prod_origin,
         COUNT(DISTINCT o.cust_no) AS num_customers
FROM     ORDER_DETAILS od
JOIN     ORDERS        o  ON o.order_no  = od.order_no
JOIN     PRODUCTS      p  ON p.prod_code = od.prod_code
WHERE    EXTRACT(YEAR  FROM o.order_date) = 2024
  AND    EXTRACT(MONTH FROM o.order_date) = 1
GROUP BY od.prod_code, p.prod_origin
ORDER BY od.prod_code;


-- 10: Ποια προϊόντα κοστίζουν πιο πολύ για να παραγγελθούν;

SELECT prod_code,
       description,
       list_price
FROM   PRODUCTS
WHERE  list_price = (SELECT MAX(list_price) FROM PRODUCTS);


-- 11: Σε ποια ημερομηνία έγινε η πιο μεγάλη παραγγελία;


SELECT o.order_date,
       SUM(od.order_qty * od.order_price) AS total_value
FROM   ORDERS        o
JOIN   ORDER_DETAILS od ON od.order_no = o.order_no
GROUP  BY o.order_no, o.order_date
ORDER  BY total_value DESC
LIMIT  1;


-- 12: Ποια είναι τα ονόματα των πελατών που δεν είχαν καμία
-- παραγγελία τον Φεβρουάριο 2025;


SELECT cust_name
FROM   CUSTOMERS
WHERE  cust_no NOT IN (
    SELECT DISTINCT cust_no
    FROM   ORDERS
    WHERE  cust_no IS NOT NULL
      AND EXTRACT(YEAR  FROM order_date) = 2025
      AND  EXTRACT(MONTH FROM order_date) = 2
)
ORDER BY cust_name;


-- 13: Βρείτε όλα τα ονόματα των πελατών που έχουν κάνει
--      παραγγελίες την 12η Αυγούστου 2025.

SELECT DISTINCT c.cust_name
FROM   CUSTOMERS c
JOIN   ORDERS    o ON o.cust_no = c.cust_no
WHERE  o.order_date = '2025-08-12';


-- 14: Ποιο prod_origin αντιπροσωπεύει το μεγαλύτερο ποσοστό
-- της συνολικής αξίας των διαθέσιμων αποθεμάτων;

SELECT   prod_origin,
         ROUND(
             SUM(qty_on_hand * list_price) * 100.0 /
             (SELECT SUM(qty_on_hand * list_price) FROM PRODUCTS),
         2) AS pct_of_total
FROM     PRODUCTS
GROUP BY prod_origin
ORDER BY pct_of_total DESC
LIMIT    1;


-- 15: Αναφέρετε τον κωδικό προϊόντος και την περιγραφή των
-- προϊόντων που έχουν πωληθεί κάποια στιγμή κάτω από
-- την τιμή καταλόγου (order_price < list_price).

SELECT DISTINCT p.prod_code,
                p.description
FROM   PRODUCTS      p
JOIN   ORDER_DETAILS od ON od.prod_code = p.prod_code
WHERE  od.order_price < p.list_price
ORDER BY p.prod_code;


-- 16: Βρείτε παραγγελίες για τις οποίες δεν υπάρχει
--  αντίστοιχος πελάτης.


SELECT o.order_no,
       o.order_date,
       o.cust_no
FROM   ORDERS    o
LEFT JOIN CUSTOMERS c ON c.cust_no = o.cust_no
WHERE  c.cust_no IS NULL;


-- 17: Παρουσιάστε πελάτες που δεν έχουν ποτέ παραγγείλει.

SELECT c.cust_no,
       c.cust_name
FROM   CUSTOMERS c
LEFT JOIN ORDERS o ON o.cust_no = c.cust_no
WHERE  o.order_no IS NULL
ORDER BY c.cust_no;


-- 18: Βρείτε τον κωδικό και την περιγραφή όλων των προϊόντων
-- που είτε παραγγέλθηκαν τον Απρίλιο 2024 είτε
--  παραγγέλθηκαν τουλάχιστον δύο φορές τον Μάιο 2025.


SELECT p.prod_code,
       p.description
FROM   PRODUCTS p
WHERE  p.prod_code IN (
           --  ΑPRIL 2024
           SELECT od.prod_code
           FROM   ORDER_DETAILS od
           JOIN   ORDERS o ON o.order_no = od.order_no
           WHERE  EXTRACT(YEAR  FROM o.order_date) = 2024
             AND  EXTRACT(MONTH FROM o.order_date) = 4
       )
   OR  p.prod_code IN (
           --  ΜΑΥ 2025
           SELECT od.prod_code
           FROM   ORDER_DETAILS od
           JOIN   ORDERS o ON o.order_no = od.order_no
           WHERE  EXTRACT(YEAR  FROM o.order_date) = 2025
             AND  EXTRACT(MONTH FROM o.order_date) = 5
           GROUP  BY od.prod_code
           HAVING COUNT(*) >= 2
       )
ORDER BY p.prod_code;
      


-- 19: Αναφέρετε τις περιγραφές προϊόντων και τα ονόματα
--      πελατών για όλες τις παραγγελίες από πελάτες στην Ξάνθη.

SELECT p.description,
       c.cust_name,
       o.order_no,
       o.order_date
FROM   CUSTOMERS     c
JOIN   ORDERS        o  ON o.cust_no   = c.cust_no
JOIN   ORDER_DETAILS od ON od.order_no = o.order_no
JOIN   PRODUCTS      p  ON p.prod_code = od.prod_code
WHERE  c.town = 'Ξάνθη'
ORDER BY o.order_date, c.cust_name;


-- 20: Ποιο είναι το μέγιστο ποσό κατά το οποίο ένας πελάτης
-- υπερβαίνει το πιστωτικό του όριο;

SELECT MAX(curr_balance - cr_limit) AS max_over_credit_limit
FROM   CUSTOMERS
WHERE  curr_balance > cr_limit;