drop function if exists fn_BookBorrowingFrequency;
go
create function fn_BookBorrowingFrequency(@BookID int)
returns int
begin
    return (
        select count(*)
        from loans
        where book_id = @BookID
    );
end;