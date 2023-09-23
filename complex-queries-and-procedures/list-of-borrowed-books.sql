declare @borrower_id int = 1;

select distinct books.*
from books
join loans on books.book_id = loans.book_id
where borrower_id = @borrower_id;

