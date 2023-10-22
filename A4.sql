INSERT INTO B (RollNo, Name, DateI, NameB, status)
VALUES (18, 'Siddharth', TO_DATE('2023-9-30', 'YYYY-MM-DD'), 'Coders', 'I');

SELECT * FROM Fine;

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE GetAns(
RollNoInput IN NUMBER, BookName IN VARCHAR2
)
IS
    DOI DATE;
    DaysPassed NUMBER;
    FineAmt NUMBER:=0;
BEGIN
    SELECT DateI into DOI FROM b where RollNo=RollNoInput AND NameB = BookName;
    DaysPassed := TRUNC(SYSDATE - DOI);
    
    IF(DaysPassed >= 15 AND DaysPassed <30) then
        FineAmt := DaysPassed * 5;
    ELSIF DaysPassed >= 30 THEN
        FineAmt := DaysPassed * 50;
    END IF;
    
    if FineAmt != 0 then
        INSERT INTO Fine (RollNo,DateI,Amount) VALUES (RollNoInput,TO_DATE(DOI, 'YYYY-MM-DD'),FineAmt);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(FineAmt);
END;

SET SERVEROUTPUT ON;
DECLARE
  RollNo_input INTEGER;
  BookName_input VARCHAR2(20);
BEGIN
    RollNo_input := &RollNo_input;
    BookName_input := '&BookName_input';
  GetAns(RollNo_input,BookName_input);
END;