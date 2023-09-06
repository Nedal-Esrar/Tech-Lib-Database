select 
    borrowers.borrower_id,
    count(loans.borrower_id) as borrowing_count, 
    rank() over (order by count(loans.borrower_id) desc) as borrower_rank
from borrowers
left join loans on borrowers.borrower_id = loans.borrower_id
group by borrowers.borrower_id;