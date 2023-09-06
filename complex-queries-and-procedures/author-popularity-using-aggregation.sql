SELECT
    author,
    rank() over (order by count(loans.loan_id) desc) as author_rank
from books
left join loans on books.book_id = loans.book_id
group by author;