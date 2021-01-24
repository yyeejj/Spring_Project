
-- 코드 생성 함수
CREATE OR REPLACE FUNCTION F_CODE
( 
V_CODE IN VARCHAR2,
V_SEQ  IN NUMBER
)
RETURN VARCHAR2
IS
    V_RESULT VARCHAR2(15);
    V_DEFAULT VARCHAR2(15) := '000000';
    V_CHARSEQ VARCHAR2(15) := TO_CHAR(V_SEQ);
BEGIN
    V_RESULT := V_CODE 
            || SUBSTR(V_DEFAULT, 1, LENGTH(V_DEFAULT) - LENGTH(V_CHARSEQ)) 
            || V_CHARSEQ;
    
    RETURN V_RESULT;
END;


--  ############################################################## 윤상
-- ○ HOST 마일리지 구하는 함수
CREATE OR REPLACE FUNCTION F_HOST_BALANCE
( V_HOST_CODE   IN    MEMBER.MEMBER_CODE%TYPE)

RETURN NUMBER

IS
    V_BALANCE NUMBER(20);
BEGIN

SELECT (SELECT NVL(SUM(AMOUNT), 0)
         FROM CAL_HISTORY
         WHERE HOST_CODE = V_HOST_CODE)
        -
        (SELECT NVL(SUM(HOST_EXCHANGE_AMOUNT), 0)
         FROM HOST_EXCHANGE_HISTORY
         WHERE HOST_CODE = V_HOST_CODE)
AS BALANCE INTO V_BALANCE
FROM DUAL;
RETURN V_BALANCE;
END;  

-- ○ USER 마일리지 구하는 함수
CREATE OR REPLACE FUNCTION F_USER_BALANCE
( V_MEMBER_CODE   IN    MEMBER.MEMBER_CODE%TYPE)

RETURN NUMBER

IS
    V_BALANCE NUMBER(20);
BEGIN
    SELECT 
    (
        SELECT NVL(SUM(LR.LOAD_AMOUNT), 0)
        FROM LOAD_PROC LP
        JOIN LOAD_REG LR
        ON LP.LOAD_REG_CODE = LR.LOAD_REG_CODE
        WHERE LP.LOAD_TYPE_CODE='LT000001' AND LR.MEMBER_CODE= V_MEMBER_CODE
    )
    -
    (
        SELECT NVL(SUM(P.PACKAGE_PRICE), 0)
        FROM BOOK_PAY_LIST BP
        JOIN BOOK_LIST B
        ON BP.BOOK_CODE = B.BOOK_CODE
        JOIN APPLY_PACKAGE AP
        ON B.APPLY_PACKAGE_CODE = AP.APPLY_PACKAGE_CODE
        JOIN PACKAGE P 
        ON AP.PACKAGE_CODE = P.PACKAGE_CODE
        WHERE B.MEMBER_CODE= V_MEMBER_CODE
    )
    +
    (
        SELECT NVL(SUM(P.PACKAGE_PRICE), 0)
        FROM HOST_CANCEL_LIST HC
        JOIN BOOK_REFUND_LIST BR
        ON HC.BOOK_CODE = BR.BOOK_CODE
            JOIN BOOK_LIST B
            ON BR.BOOK_CODE = B.BOOK_CODE
                JOIN APPLY_PACKAGE AP
                ON B.APPLY_PACKAGE_CODE = AP.APPLY_PACKAGE_CODE
                    JOIN PACKAGE P
                    ON AP.PACKAGE_CODE = P.PACKAGE_CODE
                    WHERE B.MEMBER_CODE = V_MEMBER_CODE
    )
    +
    (
        SELECT NVL(SUM
        (CASE WHEN (TO_DATE(AP.APPLY_DATE, 'YYYY-MM-DD') - TO_DATE(MC.MEMBER_CANCEL_DATE, 'YYYY-MM-DD')) < 7 
              THEN TRUNC(P.PACKAGE_PRICE * 0.5, -1) 
              ELSE TRUNC(P.PACKAGE_PRICE * 1, -1)
              END), 0)
        FROM MEMBER_CANCEL_LIST MC
        JOIN BOOK_REFUND_LIST BR
        ON MC.BOOK_CODE = BR.BOOK_CODE
            JOIN BOOK_LIST B
            ON BR.BOOK_CODE = B.BOOK_CODE
                JOIN APPLY_PACKAGE AP
                ON B.APPLY_PACKAGE_CODE = AP.APPLY_PACKAGE_CODE
                    JOIN PACKAGE P
                    ON AP.PACKAGE_CODE = P.PACKAGE_CODE
                    WHERE B.MEMBER_CODE = V_MEMBER_CODE
    )
    -
    (
        SELECT NVL(SUM(MEMBER_EXCHANGE_AMOUNT), 0)
        FROM MEMBER_EXCHANGE_LIST
        WHERE MEMBER_CODE = V_MEMBER_CODE
    ) 
    AS BALANCE INTO V_BALANCE
    FROM DUAL;
    RETURN V_BALANCE;
END;    
