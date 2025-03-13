-- Create Database
CREATE DATABASE OnlineBookstore;
use OnlineBooksstore;

select * from books;
select * from customers;
select * from orders;

-- 1) Retrieve all books in the "Fiction" genre:
select * from books where Genre = 'Fiction';


-- 2) Find books published after the year 1950:
select * from books where Published_Year > 1950;

-- 3) List all customers from the Canada:
select * from customers where Country = 'Canada';

-- 4) Show orders placed in November 2023:
select * from orders where month(order_date) = 11 and year(order_date) = 2023;

SELECT * FROM Orders WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(Stock) as Total_Stock from books;

-- 6) Find the details of the most expensive book:
select * from books
order by Price desc
limit 1;
select max(price) from books;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select c.Name, o.Quantity from customers c
join orders o on c.Customer_ID = o.Customer_ID 
where o.Quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where Total_Amount > 20;

-- 9) List all genres available in the Books table:
select distinct(Genre) from books;

-- 10) Find the book with the lowest stock:
select * from books 
order by Stock limit 1;

-- 11) Calculate the total revenue generated from all orders:
select round(sum(Total_Amount),2) As Total_Revenue from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select b.Genre,sum(o.Quantity) AS Total_Books_sold from books b
join orders o
on b.Book_ID = o.Book_ID
group by b.Genre;


-- 2) Find the average price of books in the "Fantasy" genre:
select avg(Price) As Average_Price from books where Genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:
select o.Customer_ID,c.Name,count(*) as Order_Count from orders o
join customers c
on c.Customer_ID = o.Customer_ID
group by o.Customer_ID,Name
having count(*) > 1;

-- 4) Find the most frequently ordered book:
select o.Book_ID,b.Title,count(*) AS ORDER_COUNT from orders o
join books b
on o.Book_ID = b.Book_ID
group by o.Book_ID, b.Title
order by count(*) desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books where Genre = 'Fantasy'
order by Price desc limit 3;


-- 6) Retrieve the total quantity of books sold by each author:
select b.Author,sum(o.Quantity) as Total_Books_Sold from books b 
join orders o 
on b.Book_ID = o.Book_ID
group by b.Author;


-- 7) List the cities where customers who spent over $30 are located:
	select distinct c.City,o.Total_Amount from orders o
    join customers c
    on o.Customer_ID = c.Customer_ID
    where Total_Amount > 30;

-- 8) Find the customer who spent the most on orders:
select c.Name,c.Customer_ID,sum(o.Total_Amount) AS Total_Amount from customers c
join orders o 
on c.Customer_ID = o.Customer_ID
group by c.Customer_ID,c.Name
order by Total_Amount desc limit 1;


-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT 
    b.book_id, 
    b.title, 
    b.stock, 
    COALESCE(SUM(o.quantity), 0) AS Order_quantity,  
    b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id;
