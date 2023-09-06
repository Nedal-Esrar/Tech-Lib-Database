with weekly_loan_counts as (
    select
        datename(weekday, date_borrowed) as week_day,
        count(*) as loan_count
    from loans
    group by datename(weekday, date_borrowed)
),
total_loans as (
    select count(*) as total_count
    from loans
)
select top 3
    week_day,
    cast(loan_count as decimal(10, 2)) / (select total_count from total_loans) * 100 as percentage
from weekly_loan_counts
order by loan_count desc;