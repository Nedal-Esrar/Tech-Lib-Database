select 
    books.*, 
    borrowers.*
from books
join loans on books.book_id = loans.book_id
join borrowers on borrowers.borrower_id = loans.borrower_id
where date_returned is null and datediff(day, due_date, getdate()) > 30;