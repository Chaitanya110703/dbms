CREATE TABLE Book(BookNo INT PRIMARY KEY, BookName VARCHAR(20), DateIssue DATE);
CREATE TABLE AuditB(BookNo INT, BookName VARCHAR(20),DateIssue date);

INSERT INTO Book (BookNo, BookName, DateIssue) values (2,'XXX',TO_DATE('2023-9-25','YYYY-MM-DD'));

Drop TABLE AuditB;

SELECT    *     FROM AuditB;

CREATE OR REPLACE TRIGGER Trig_prog
AFTER
UPDATE OR DELETE ON Book
FOR EACH ROW
DECLARE
I_BookNo INTEGER; 
BEGIN
    IF UPDATING THEN
        INSERT INTO AuditB (BookNo, BookName, DateIssue) VALUES (:old.BookNo,:old.BookName,:old.DateIssue);
    END IF;
    IF DELETING THEN
        INSERT INTO AuditB (BookNo, BookName, DateIssue) VALUES (:old.BookNo,:old.BookName,:old.DateIssue);
    END IF;
END;

DECLARE
BEGIN
UPDATE Book SET BookName = 'xyz' WHERE BookNo = 2;
END;

DECLARE
BEGIN
delete from Book WHERE BookNo = 2;
END;