create table books(
    book_id int primary key identity,
    title varchar(255) not null,
    author varchar(255) not null,
    isbn varchar(20) not null unique,
    published_date date not null,
    genre varchar(255) not null,
    shelf_location varchar(10) not null,
    current_status varchar(10) not null check(current_status in ('Available', 'Borrowed'))
);

create table borrowers(
    borrower_id int primary key identity,
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    email varchar(255) not null check(email like '%@%.%'),
    date_of_birth date not null,
    membership_date date not null
);

create table loans(
    loan_id int primary key identity,
    book_id int foreign key references books(book_id),
    borrower_id int foreign key references borrowers(borrower_id),
    date_borrowed date not null,
    due_date date not null,
    date_returned date
);

create table audit_log(
    id int primary key identity,
    book_id int foreign key references books(book_id),
    status_change varchar(10) not null,
    change_date date not null
);
