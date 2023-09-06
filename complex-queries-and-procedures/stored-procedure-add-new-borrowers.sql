drop procedure if exists sp_AddNewBorrower;
go
create procedure sp_AddNewBorrower
    @FirstName varchar(255),
    @LastName varchar(255),
    @Email varchar(255),
    @DateOfBirth date,
    @MembershipDate DATE
as
begin
    if exists (
        select borrower_id 
        from borrowers
        where email = @Email
    )
    begin
        select 'The given email already exists';
    end
    else
    begin
        insert into borrowers
        values (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);

        select borrower_id 
        from borrowers
        where email = @Email;
    end
end;