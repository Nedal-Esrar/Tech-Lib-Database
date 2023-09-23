with age_ranges as (
    select 
        borrower_id,
        case when datediff(year, date_of_birth, getdate()) = 0 then '0-10'
        else concat(
            (ceiling(datediff(year, date_of_birth, getdate()) / 10.0) - 1) * 10 + 1, 
            '-', 
            ceiling(datediff(year, date_of_birth, getdate()) / 10.0) * 10)
        end as age_range
    from borrowers
), 
borrowers_count_for_range_genre as (
    select 
        age_range,
        genre,
        count(distinct loans.borrower_id) as borrower_count
    from age_ranges
    join loans on age_ranges.borrower_id = loans.borrower_id
    join books on loans.book_id = books.book_id
    group by age_range, genre
)
select 
    age_range,
    genre
from age_ranges
join loans on age_ranges.borrower_id = loans.borrower_id
join books on loans.book_id = books.book_id
group by age_range, genre
having count(distinct loans.borrower_id) = (
    select max(borrower_count)
    from borrowers_count_for_range_genre
    where borrowers_count_for_range_genre.age_range = age_ranges.age_range
)
order by age_range;