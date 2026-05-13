CREATE TABLE CUSTOMERS (
    cust_no      INT PRIMARY KEY,
    cust_name    VARCHAR(100) NOT NULL,
    street       VARCHAR(100),
    number       VARCHAR(10),
    town         VARCHAR(50),
    postcode     VARCHAR(10),
    cr_limit     NUMERIC(10,2),
    curr_balance NUMERIC(10,2) DEFAULT 0
);

CREATE TABLE PRODUCTS (
    prod_code     INT PRIMARY KEY,
    description   VARCHAR(100) NOT NULL,
    prod_origin   VARCHAR(5) CHECK (TRIM(prod_origin) IN ('SA','CA','WA','EA','AS')),
    list_price    NUMERIC(10,2) NOT NULL,
    qty_on_hand   NUMERIC(10,2) DEFAULT 0,
    reorder_level NUMERIC(10,2) NOT NULL,
    reorder_qty   NUMERIC(10,2) NOT NULL
);

CREATE TABLE ORDERS (
    order_no   INT PRIMARY KEY,
    order_date DATE NOT NULL,
    cust_no    INT REFERENCES CUSTOMERS(cust_no)
);

CREATE TABLE ORDER_DETAILS (
    order_no    INT REFERENCES ORDERS(order_no),
    prod_code   INT REFERENCES PRODUCTS(prod_code),
    order_qty   NUMERIC(10,2) CHECK (order_qty >= 10),
    order_price NUMERIC(10,2),
    PRIMARY KEY (order_no, prod_code)
);

w