create index ix_borrowers_email on borrowers(email);
create index ix_loans_book_id on loans(book_id);
create index ix_loans_borrower_id on loans(borrower_id);
create index ix_loans_date_borrowed on loans(date_borrowed);
create index ix_loans_due_date on loans(due_date);
