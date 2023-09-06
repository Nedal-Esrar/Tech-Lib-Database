drop procedure if exists sp_BorrowedBooksReport;
go
create procedure sp_BorrowedBooksReport
    @StartDate date,
    @EndDate date
as
begin
    select
        books.*,
        borrowers.first_name + ' ' + borrowers.last_name as borrower_name,
        loans.date_borrowed
    from books
    join loans on loans.book_id = books.book_id
    join borrowers on loans.borrower_id = borrowers.borrower_id
    where loans.date_borrowed between @StartDate and @EndDate;
end;
