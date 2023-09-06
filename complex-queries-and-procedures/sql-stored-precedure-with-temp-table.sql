drop procedure if exists sp_BorrowersWithOverdueLoans;
go
create procedure sp_BorrowersWithOverdueLoans as
begin
    select 
        distinct borrowers.borrower_id as borrower_id, 
        first_name + ' ' + last_name as borrower_name,
        email
    into #borrowers_with_overdue_loans
    from borrowers
    join loans on loans.borrower_id = borrowers.borrower_id
    where date_returned is null and due_date < getdate();

    select 
        #borrowers_with_overdue_loans.*, 
        books.book_id, 
        title as book_title,
        due_date
    from #borrowers_with_overdue_loans
    join loans on #borrowers_with_overdue_loans.borrower_id = loans.borrower_id
    join books on loans.book_id = books.book_id
    where date_returned is null and due_date < getdate();

    drop table #borrowers_with_overdue_loans;
end;
