drop function if exists fn_CalculateOverdueFees;
go
create function fn_CalculateOverdueFees(@LoanID int)
returns money
AS
begin
    declare @overdue_days int = (
        select datediff(day, due_date, getdate())
        from loans
        where loans.loan_id = @LoanID
    );

    if @overdue_days is null
    begin
        return 0;
    end;

    declare @overdue_fees money;

    if @overdue_days <= 30
        set @overdue_fees = @overdue_days;
    else
        set @overdue_fees = 30 + (@overdue_days - 30) * 2;

    return @overdue_fees;
end;