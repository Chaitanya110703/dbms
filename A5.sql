CREATE TABLE StudMarks(Name varchar(20),TotalMarks INTEGER);
CREATE TABLE Result(Roll INTEGER, Name varchar(20),Class varchar(10));

INSERT INTO StudMarks (Name, TotalMarks)
VALUES ('Aniket', 850);

SELECT * FROM Result;

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE proc_Grade(
RollInput IN INTEGER, StudName IN VARCHAR2
)
IS
    StudMarks NUMBER;
    StudClass varchar2(10);
BEGIN
    SELECT TotalMarks into StudMarks FROM StudMarks where StudName=Name;
    DBMS_OUTPUT.PUT_LINE(StudMarks);
    IF(StudMarks >= 990 AND StudMarks <= 1500) then
        StudClass := 'Dist';
    ELSIF (StudMarks >= 900 AND StudMarks <= 989) THEN
        StudClass := 'First';
    ELSIF (StudMarks >= 825 AND StudMarks <= 899) THEN
        StudClass := 'Second';
    END IF;
    
    INSERT INTO Result (Roll,Name,Class) VALUES (RollInput,StudName,StudClass);
    
    DBMS_OUTPUT.PUT_LINE(StudClass);
END;

SET SERVEROUTPUT ON;
DECLARE
  RollNo_input INTEGER;
  StudName_input VARCHAR2(20);
BEGIN
    RollNo_input := &RollNo_input;
    StudName_input := '&StudName_input';
    proc_Grade(RollNo_input,StudName_input);
END;