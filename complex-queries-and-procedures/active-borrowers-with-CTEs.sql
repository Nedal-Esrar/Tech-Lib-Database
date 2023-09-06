with borrowers_loan_count as (
    select borrower_id, count(*) as loan_count
    from loans
    where date_returned is null
    group by borrower_id
)
select borrowers.*
from borrowers
join borrowers_loan_count
on borrowers.borrower_id = borrowers_loan_count.borrower_id
where loan_count >= 2;