
CREATE TABLE OldRRoll(RollNo INTEGER, Name varchar(20));
CREATE TABLE NewRoll(RollNo INTEGER, Name varchar(20));

INSERT INTO NewRoll (RollNo, Name)
VALUES (3,'C');

SELECT * FROM NewRoll;

SET SERVEROUTPUT ON;
DECLARE
  Cursor c1 IS SELECT RollNo,Name FROM OldRRoll;
  CURSOR checkT (StudROll INTEGER, StudName varchar) IS 
  SELECT RollNo,Name FROM NewRoll WHERE RollNo = StudRoll;
  StudName varchar(20);
  StudROll INTEGER;
  TEMP INTEGER:=1;
BEGIN
    OPEN c1;
   
    LOOP
        FETCH c1 INTO StudROll,StudName;
        OPEN checkT(StudROll,StudName);
        FETCH checkT INTO StudROll,StudName;
        IF checkT%NOTFOUND THEN
            INSERT INTO NewRoll (RollNo, Name) VALUES (StudRoll,StudName);
            DBMS_OUTPUT.PUT_LINE('Inserted : '||StudName);
        END IF;
        CLOSE checkT;
        EXIT WHEN c1 %NOTFOUND;
    END LOOP;
    CLOSE c1;
END;