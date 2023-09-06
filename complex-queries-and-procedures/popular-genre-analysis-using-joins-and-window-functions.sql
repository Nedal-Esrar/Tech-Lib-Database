declare @borrow_month int = datepart(month, getdate());

with genre_popularity_rank as (
    select
        datepart(year, loans.date_borrowed) as borrow_year,
        datepart(month, loans.date_borrowed) as borrow_month,
        books.genre,
        count(*) as borrow_count,
        rank() over (
            partition by datepart(year, loans.date_borrowed), datepart(month, loans.date_borrowed) 
            order by count(*) desc) as genre_rank
    from loans
    join books on loans.book_id = books.book_id
    group by datepart(year, loans.date_borrowed),
            datepart(month, loans.date_borrowed),
            books.genre
)
select
    genre,
    borrow_count
from genre_popularity_rank
where genre_rank = 1 and borrow_year = datepart(year, getdate()) and borrow_month = @borrow_month;