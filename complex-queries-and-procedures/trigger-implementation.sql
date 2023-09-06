drop trigger if exists audit_logging;
go
create trigger audit_logging
on books
after update
AS
begin
    declare @old_state varchar(255) = (
        select deleted.current_status
        from deleted
    );

    declare @new_state varchar(255) = (
        select inserted.current_status
        from inserted
    );

    if @old_state <> @new_state
    begin
        declare @book_id int = (
            select book_id
            from deleted
        );

        insert into audit_log
        values (@book_id, @new_state, getdate())
    end;
end;