-- 승범 

--######################################### 1. SIGNUP
--○ 확인용
DESC HOST;
SELECT * FROM HOST_PROFILE;

DESC MEMBER;
SELECT * FROM MEMBER_PROFILE;

--○ HOST 중복검사
SELECT COUNT(*) AS COUNT
FROM HOST_PROFILE
WHERE HOST_EMAIL='good1@test.com';
--> 한줄
SELECT COUNT(*) AS COUNT FROM HOST_PROFILE WHERE HOST_EMAIL=?
;
SELECT COUNT(*) AS COUNT
FROM HOST_PROFILE
WHERE HOST_NICKNAME='퉁퉁볼';
--> 한줄
SELECT COUNT(*) AS COUNT FROM HOST_PROFILE WHERE HOST_NICKNAME=?
;

--○ MEMBER 중복검사
SELECT COUNT(*) AS COUNT
FROM MEMBER_PROFILE
WHERE MEMBER_EMAIL='test1@test.com';
--> 한줄
SELECT COUNT(*) AS COUNT FROM MEMBER_PROFILE WHERE MEMBER_EMAIL=?
;
SELECT COUNT(*) AS COUNT
FROM MEMBER_PROFILE
WHERE MEMBER_NICKNAME='탱탱볼';
--> 한줄
SELECT COUNT(*) AS COUNT FROM MEMBER_PROFILE WHERE MEMBER_NICKNAME=?
;

--○ HOST 회원가입
-- 회원코드 등록
SELECT H_SEQ.NEXTVAL
FROM DUAL;

INSERT INTO HOST(HOST_CODE, HOST_SIGN_UP_DATE)
VALUES(F_CODE('H', H_SEQ.NEXTVAL), SYSDATE);
--> 한줄
INSERT INTO HOST(HOST_CODE, HOST_SIGN_UP_DATE) VALUES(F_CODE('H', H_SEQ.NEXTVAL), SYSDATE)
;
-- 프로필정보 등록
INSERT INTO HOST_PROFILE(HOST_EMAIL, HOST_CODE
                       , HOST_PW, HOST_NICKNAME
                       , HOST_NAME, HOST_TEL)
VALUES('이메일', F_CODE('H', H_SEQ.CURRVAL), '비번'
      , '닉네임', '이름', '연락처');
--> 한줄
INSERT INTO HOST_PROFILE(HOST_EMAIL, HOST_CODE, HOST_PW, HOST_NICKNAME, HOST_NAME, HOST_TEL) VALUES(?, F_CODE('H', H_SEQ.CURRVAL), ?, ?, ?, ?)
;

-- 프로시저 호출
EXEC CREATE_HOST_ACCOUNT('sb4411@gmail.com', 'JAVA006$', '테스트홍다', '퐁퐁풍', '010-4444-4444');


--○ MEMBER 회원가입
-- 회원코드 등록
SELECT M_SEQ.NEXTVAL
FROM DUAL;

INSERT INTO MEMBER(MEMBER_CODE, MEMBER_SIGN_UP_DATE)
VALUES(F_CODE('M', M_SEQ.NEXTVAL), SYSDATE);
--> 한줄
INSERT INTO MEMBER(MEMBER_CODE, MEMBER_SIGN_UP_DATE) VALUES(F_CODE('M', M_SEQ.NEXTVAL), SYSDATE)
;
-- 프로필정보 등록
INSERT INTO MEMBER_PROFILE(MEMBER_EMAIL, MEMBER_CODE
                         , MEMBER_PW, MEMBER_NICKNAME
                         , MEMBER_NAME, MEMBER_TEL)
VALUES('이메일', F_CODE('M', M_SEQ.CURRVAL), '비번'
      , '닉네임', '이름', '연락처');
--> 한줄
INSERT INTO MEMBER_PROFILE(MEMBER_EMAIL, MEMBER_CODE, MEMBER_PW, MEMBER_NICKNAME, MEMBER_NAME, MEMBER_TEL) VALUES(?, F_CODE('M', M_SEQ.CURRVAL), ?, ?, ?, ?)
;

-- 프로시저 호출
EXEC CREATE_MEMBER_ACCOUNT('sb9229@gmail.com', 'JAVA0006$', '테3트다', '홍1훙', '010-9949-9999');

SELECT *
FROM MEMBER_PROFILE;

--######################################### 2. LOGIN

--○ MEMBER 로그인 검사
SELECT MEMBER_CODE
FROM MEMBER_PROFILE
WHERE MEMBER_EMAIL = 'test1@test.com'
  AND MEMBER_PW = 'test12345@';

--○ HOST 로그인 검사
SELECT HOST_CODE
FROM HOST_PROFILE
WHERE HOST_EMAIL = 'good1@test.com'
  AND HOST_PW = 'test12345@';

--○ MEMBER 패스워드 검사
SELECT COUNT(*) AS COUNT
FROM MEMBER_PROFILE
WHERE MEMBER_CODE = 'M000001'
  AND MEMBER_PW = 'test12345@';

--○ HOST 패스워드 검사
SELECT COUNT(*) AS COUNT
FROM HOST_PROFILE
WHERE HOST_CODE = 'H000001'
  AND HOST_PW = 'test12345@';


--######################################### 3. PROFILE

--○ MEMBER 프로필 가져오기
CREATE OR REPLACE VIEW MEMBER_PROFILEVIEW
AS
SELECT MP.MEMBER_EMAIL AS EMAIL, MP.MEMBER_CODE AS CODE
     , MP.MEMBER_PW AS PW, MP.MEMBER_NICKNAME AS NICK
     , MP.MEMBER_NAME AS NAME, MP.MEMBER_TEL AS TEL
     , TO_CHAR(M.MEMBER_SIGN_UP_DATE, 'YYYY-MM-DD') AS CREATEDATE
FROM MEMBER_PROFILE MP, MEMBER M
WHERE MP.MEMBER_CODE = M.MEMBER_CODE;

SELECT EMAIL, CODE, PW, NICK, NAME, TEL, CREATEDATE
FROM MEMBER_PROFILEVIEW
WHERE CODE = 'M000001';

--○ HOST 프로필 가져오기
CREATE OR REPLACE VIEW HOST_PROFILEVIEW
AS
SELECT HP.HOST_EMAIL AS EMAIL, HP.HOST_CODE AS CODE
     , HP.HOST_PW AS PW, HP.HOST_NICKNAME AS NICK
     , HP.HOST_NAME AS NAME, HP.HOST_TEL AS TEL
     , TO_CHAR(H.HOST_SIGN_UP_DATE, 'YYYY-MM-DD') AS CREATEDATE
FROM HOST_PROFILE HP,  HOST H
WHERE HP.HOST_CODE = H.HOST_CODE;

SELECT EMAIL, CODE, PW, NICK, NAME, TEL, CREATEDATE
FROM HOST_PROFILEVIEW
WHERE CODE = 'H000001';


--○ MEMBER 전화번호 수정
UPDATE MEMBER_PROFILE
SET MEMBER_TEL = '010-1212-1212'
WHERE MEMBER_CODE = 'M000001';

--○ HOST 전화번호 수정
UPDATE HOST_PROFILE
SET HOST_TEL = '010-1212-1212'
WHERE HOST_CODE = 'H000001';


--○ MEMBER 블랙리스트 전환일
SELECT TO_CHAR(MB.MEMBER_BLACKLIST_DATE, 'YYYY-MM-DD')
FROM MEMBER_BLACKLIST MB JOIN MEMBER_PROFILE MP
ON MB.MEMBER_EMAIL = MP.MEMBER_EMAIL
WHERE MP.MEMBER_CODE = 'M000003'
;


--○ HOST 블랙리스트 전환일
SELECT TO_CHAR(HB.HOST_BLACKLIST_DATE, 'YYYY-MM-DD')
FROM HOST_BLACKLIST HB JOIN HOST_PROFILE HP
ON HB.HOST_EMAIL = HP.HOST_EMAIL
WHERE HP.HOST_CODE = 'H000004'
;

--○ MEMBER 비밀번호 수정
UPDATE MEMBER_PROFILE
SET MEMBER_PW = '비밀번호'
WHERE MEMBER_CODE = '코드';

--○ HOST 비밀번호 수정
UPDATE HOST_PROFILE
SET HOST_PW = '비밀번호'
WHERE HOST_CODE = '코드';


--○ MEMBER 이메일 존재여부 확인
SELECT COUNT(*) AS COUNT
FROM MEMBER_PROFILE
WHERE MEMBER_EMAIL = 'sb9212@kpu.ac.kr';

--○ HOST 이메일 존재여부 확인
SELECT COUNT(*) AS COUNT
FROM HOST_PROFILE
WHERE HOST_EMAIL = 'sb921204@naver.com';


--○ MEMBER 비밀번호 변경(MEMBER)
UPDATE MEMBER_PROFILE
SET MEMBER_PW = 'java006$'
WHERE MEMBER_EMAIL = 'sb92120@gmail.com';

--○ HOST 비밀번호 변경(HOST)
UPDATE HOST_PROFILE
SET HOST_PW = 'java006$'
WHERE HOST_EMAIL = 'sb921204@naver.com';

SELECT * FROM MEMBER_WITHDRAW;

--######################################### 4. MAIN
--○ MEMBER 수(탈퇴자 제외)
SELECT COUNT(*) AS COUNT
FROM MEMBER M LEFT OUTER JOIN MEMBER_WITHDRAW MW
ON M.MEMBER_CODE = MW.MEMBER_CODE
WHERE MW.MEMBER_CODE IS NULL;

SELECT COUNT(*) AS COUNT
FROM MEMBER;

--○ HOST 수(탈퇴자 제외)
SELECT COUNT(*) AS COUNT
FROM HOST H LEFT OUTER JOIN HOST_WITHDRAW HW
ON H.HOST_CODE = HW.HOST_CODE
WHERE HW.HOST_CODE IS NULL;

SELECT COUNT(*) AS COUNT
FROM HOST;

--○ 예약거래 성사 수
SELECT COUNT(*) AS COUNT
FROM BOOK_LIST BL LEFT OUTER JOIN HOST_CANCEL_LIST HCL
ON BL.BOOK_CODE = HCL.BOOK_CODE
       LEFT OUTER JOIN MEMBER_CANCEL_LIST MCL
       ON BL.BOOK_CODE = MCL.BOOK_CODE
WHERE HCL.BOOK_CODE IS NULL
  AND MCL.BOOK_CODE IS NULL;
  
SELECT COUNT(*) AS COUNT
FROM BOOK_LIST;
  
--○ 공간 갯수
SELECT COUNT(*)
FROM INSPECT_REG_LIST IRL JOIN INSPECT_PROC_LIST IPL
ON IRL.INSPECT_REG_CODE = IPL.INSPECT_REG_CODE
    JOIN INSPECT_TYPE IT
      ON IPL.INSPECT_TYPE_CODE = IT.INSPECT_TYPE_CODE
WHERE IT.INSPECT_TYPE = '검수승인';

SELECT COUNT(*)
FROM LOC;


--○ 오늘의 공간
-- 오늘의 공간에 필요한 정보 뷰
/*
// 썸네일사진(링크)  THUMBNAIL
// 공간명            LOC_BASIC_INFO
// 최대 인원수       LOC_DETAIL_INFO
// 주소 (동) LOC_BASIC_INFO

// 평점(평균)        REVIEW (이 공간의)
// 패키지 가격(제일 싼것) APPLY_PACKAGE(PACKAGE)(PACKAGE_FORM)
*/

CREATE OR REPLACE VIEW TODAYS_LOC_DEFAULT_VIEW
AS
SELECT L.LOC_CODE AS CODE, BL.BOOK_CODE AS BOOK_CODE
     , AP.APPLY_PACKAGE_CODE AS PACK_CODE
     , LBI.LOC_NAME AS NAME, LDI.MAX_PEOPLE AS MAX
     , R.REVIEW_RATE AS RATE, P.PACKAGE_PRICE AS PRICE
     , LBI.LOC_ADDR AS ADDR, TH.THUMBNAIL_URL AS URL
FROM LOC L JOIN LOC_BASIC_INFO LBI 
  ON L.LOC_CODE = LBI.LOC_CODE
       JOIN THUMBNAIL TH
       ON LBI.LOC_BASIC_INFO_CODE = TH.LOC_BASIC_INFO_CODE
            JOIN LOC_DETAIL_INFO LDI
            ON L.LOC_CODE = LDI.LOC_CODE
                LEFT OUTER JOIN REVIEW R
                ON L.LOC_CODE = R.LOC_CODE
                    JOIN PACKAGE_FORM PF
                    ON L.LOC_CODE = PF.LOC_CODE
                       LEFT OUTER JOIN PACKAGE P
                       ON PF.PACKAGE_FORM_CODE = P.PACKAGE_FORM_CODE
                           LEFT OUTER JOIN APPLY_PACKAGE AP
                           ON P.PACKAGE_CODE = AP.PACKAGE_CODE
                               LEFT OUTER JOIN BOOK_LIST BL
                               ON AP.APPLY_PACKAGE_CODE = BL.APPLY_PACKAGE_CODE;
   
       
-- 평점순으로 100개 뽑음        
-- 예약 X, 적용 패키지 O(보여주기용)
CREATE OR REPLACE VIEW TODAYS_LOC_NOT_REAL_VIEW
AS
SELECT DISTINCT TLV_DEFAULT.CODE, TLV_DEFAULT.NAME
              , TLV_DEFAULT.MAX, TLV_DEFAULT.ADDR, TLV_DEFAULT.URL
              , TLV_AVG.AVG, TLV_MIN.MIN
FROM TODAYS_LOC_DEFAULT_VIEW TLV_DEFAULT 
JOIN (SELECT CODE
      FROM TODAYS_LOC_DEFAULT_VIEW
      WHERE PACK_CODE IS NOT NULL) TLV_AVAILABLE
ON TLV_DEFAULT.CODE = TLV_AVAILABLE.CODE
    JOIN (SELECT CODE, TRUNC(NVL(AVG(RATE), 0), 1) AS AVG
          FROM TODAYS_LOC_DEFAULT_VIEW
          GROUP BY CODE) TLV_AVG
          ON TLV_DEFAULT.CODE = TLV_AVG.CODE
              JOIN (SELECT CODE, NVL(MIN(PRICE), 0) AS MIN
                    FROM TODAYS_LOC_DEFAULT_VIEW
                    GROUP BY CODE) TLV_MIN
                    ON TLV_DEFAULT.CODE = TLV_MIN.CODE
WHERE ROWNUM <= 100
ORDER BY TLV_AVG.AVG DESC;
                    

-- 예약 O, 적용 패키키 O(실제)
CREATE OR REPLACE VIEW TODAYS_LOC_REAL_VIEW
AS
SELECT DISTINCT TLV_DEFAULT.CODE, TLV_DEFAULT.NAME
              , TLV_DEFAULT.MAX, TLV_DEFAULT.ADDR, TLV_DEFAULT.URL
              , TLV_AVG.AVG, TLV_MIN.MIN
FROM TODAYS_LOC_DEFAULT_VIEW TLV_DEFAULT 
JOIN (SELECT CODE
      FROM TODAYS_LOC_DEFAULT_VIEW
      WHERE PACK_CODE IS NOT NULL
        AND BOOK_CODE IS NULL) TLV_AVAILABLE
ON TLV_DEFAULT.CODE = TLV_AVAILABLE.CODE
    JOIN (SELECT CODE, TRUNC(NVL(AVG(RATE), 0), 1) AS AVG
          FROM TODAYS_LOC_DEFAULT_VIEW
          GROUP BY CODE) TLV_AVG
          ON TLV_DEFAULT.CODE = TLV_AVG.CODE
              JOIN (SELECT CODE, NVL(MIN(PRICE), 0) AS MIN
                    FROM TODAYS_LOC_DEFAULT_VIEW
                    GROUP BY CODE) TLV_MIN
                    ON TLV_DEFAULT.CODE = TLV_MIN.CODE
WHERE ROWNUM <= 100
ORDER BY TLV_AVG.AVG DESC;



-- 랜덤으로 3개 뽑음
SELECT CODE, NAME, MAX, ADDR, URL, AVG, MIN
FROM (SELECT * 
      FROM TODAYS_LOC_NOT_REAL_VIEW
      ORDER BY DBMS_RANDOM.VALUE)
WHERE ROWNUM <= 3;

SELECT CODE, NAME, MAX, ADDR, URL, AVG, MIN
FROM (SELECT * 
      FROM TODAYS_LOC_REAL_VIEW
      ORDER BY DBMS_RANDOM.VALUE)
WHERE ROWNUM <= 3;


--○ 이용자 리뷰
/*
공간 제목    
패키지 가격 
썸네일 THUMBNAIL
평점     REVIEW
리뷰내용 REVIEW
*/

CREATE OR REPLACE VIEW TODAYS_REVIEW_DEFAULT_VIEW
AS
SELECT L.LOC_CODE AS CODE, R.REVIEW_CODE AS REVIEW_CODE
     , LBI.LOC_NAME AS NAME, P.PACKAGE_PRICE AS PRICE
     , TH.THUMBNAIL_URL AS URL, R.REVIEW_CONTENT AS CONTENT
     , R.REVIEW_RATE AS RATE
FROM LOC L JOIN LOC_BASIC_INFO LBI 
  ON L.LOC_CODE = LBI.LOC_CODE
       JOIN THUMBNAIL TH
       ON LBI.LOC_BASIC_INFO_CODE = TH.LOC_BASIC_INFO_CODE
            LEFT OUTER JOIN REVIEW R
            ON L.LOC_CODE = R.LOC_CODE
                JOIN PACKAGE_FORM PF
                ON L.LOC_CODE = PF.LOC_CODE
                   LEFT OUTER JOIN PACKAGE P
                   ON PF.PACKAGE_FORM_CODE = P.PACKAGE_FORM_CODE
                       LEFT OUTER JOIN APPLY_PACKAGE AP
                       ON P.PACKAGE_CODE = AP.PACKAGE_CODE;
       
-- 리뷰 데이터 부족으로 리뷰 데이터 추가
SELECT * FROM REVIEW;
DESC REVIEW;
INSERT INTO REVIEW(REVIEW_CODE, LOC_CODE, MEMBER_CODE, REVIEW_RATE, REVIEW_CONTENT, REVIEW_DATE)
VALUES('RV000002', 'L000001', 'M000005', '5', '어승승 너무 조아요~', TO_DATE('2021-01-04', 'YYYY-MM-DD'));
INSERT INTO REVIEW(REVIEW_CODE, LOC_CODE, MEMBER_CODE, REVIEW_RATE, REVIEW_CONTENT, REVIEW_DATE)
VALUES('RV000003', 'L000002', 'M000001', '3', '항상 잘 쓰고 있어요! 자주 이용할게요', TO_DATE('2021-01-07', 'YYYY-MM-DD'));
INSERT INTO REVIEW(REVIEW_CODE, LOC_CODE, MEMBER_CODE, REVIEW_RATE, REVIEW_CONTENT, REVIEW_DATE)
VALUES('RV000004', 'L000002', 'M000002', '1', '별로네요. 그래도 번창하세요~', TO_DATE('2021-01-01', 'YYYY-MM-DD'));
INSERT INTO REVIEW(REVIEW_CODE, LOC_CODE, MEMBER_CODE, REVIEW_RATE, REVIEW_CONTENT, REVIEW_DATE)
VALUES('RV000005', 'L000001', 'M000004', '0', '최악입니다! 분발하세요!', TO_DATE('2020-12-04', 'YYYY-MM-DD'));
INSERT INTO REVIEW(REVIEW_CODE, LOC_CODE, MEMBER_CODE, REVIEW_RATE, REVIEW_CONTENT, REVIEW_DATE)
VALUES('RV000006', 'L000003', 'M000005', '4', '정말 깨끗해요!', TO_DATE('2021-01-15', 'YYYY-MM-DD'));
       
-- 최종 뷰 구성           
CREATE OR REPLACE VIEW TODAYS_REVIEW_VIEW
AS
SELECT DISTINCT TRV_DEFAULT.CODE, TRV_DEFAULT.REVIEW_CODE
              , TRV_DEFAULT.NAME, TRV_MIN.PRICE AS MIN
              , TRV_DEFAULT.URL, TRV_DEFAULT.CONTENT
              , TRV_DEFAULT.RATE
FROM TODAYS_REVIEW_DEFAULT_VIEW TRV_DEFAULT 
JOIN (SELECT CODE, MIN(PRICE) AS PRICE 
      FROM TODAYS_REVIEW_DEFAULT_VIEW 
      GROUP BY CODE) TRV_MIN
ON TRV_DEFAULT.CODE = TRV_MIN.CODE
WHERE TRV_DEFAULT.REVIEW_CODE IS NOT NULL;  

-- 최종 쿼리문
SELECT CODE, NAME, MIN, URL, CONTENT, RATE
FROM (SELECT * 
      FROM TODAYS_REVIEW_VIEW 
      ORDER BY DBMS_RANDOM.VALUE)
WHERE ROWNUM <= 15;


--######################################### 5. PACKAGE

--○ 공간코드를 이용해 패키지양식을 찾는 쿼리문
SELECT P.PACKAGE_CODE AS CODE, P.PACKAGE_NAME AS NAME
     , P.PACKAGE_START AS TIME_START, P.PACKAGE_END AS TIME_END
     , P.PACKAGE_PRICE AS PRICE
FROM PACKAGE P JOIN PACKAGE_FORM PF
ON P.PACKAGE_FORM_CODE = PF.PACKAGE_FORM_CODE
        LEFT OUTER JOIN PACKAGE_REMOVE PR
        ON P.PACKAGE_CODE = PR.PACKAGE_CODE
WHERE PF.LOC_CODE = 'L000001'
  AND PR.PACKAGE_REMOVE_CODE IS NULL;


--○ 공간코드를 이용해 패키지양식 폐기(호스트가 삭제시)
INSERT INTO PACKAGE_REMOVE 
VALUES(F_CODE(PRM_SEQ.NEXTVAL), 'P000001', SYSDATE);


--○ 적용된 패키지를 찾는 쿼리문
-- 뷰로 구성
CREATE OR REPLACE VIEW APPLY_PACKAGE_VIEW
AS
SELECT P.PACKAGE_CODE AS CODE, PF.LOC_CODE AS LOC_CODE
     , AP.APPLY_PACKAGE_CODE AS APPLY_CODE
     , B.BOOK_CODE AS BOOK_CODE, P.PACKAGE_NAME AS NAME
     , P.PACKAGE_START AS TIME_START, P.PACKAGE_END AS TIME_END
     , P.PACKAGE_PRICE AS PRICE
     , TO_CHAR(AP.APPLY_DATE, 'YYYY-MM-DD') AS APPLY_DATE
FROM PACKAGE_FORM PF JOIN PACKAGE P
ON PF.PACKAGE_FORM_CODE = P.PACKAGE_FORM_CODE
        JOIN APPLY_PACKAGE AP 
        ON AP.PACKAGE_CODE = P.PACKAGE_CODE
            LEFT OUTER JOIN BOOK_LIST B
            ON AP.APPLY_PACKAGE_CODE = B.APPLY_PACKAGE_CODE
ORDER BY AP.APPLY_DATE, P.PACKAGE_START;

--
SELECT CODE, APPLY_CODE, NAME
     , TIME_START, TIME_END
     , PRICE, APPLY_DATE
FROM APPLY_PACKAGE_VIEW
WHERE LOC_CODE = #{loc_code}
  AND BOOK_CODE IS NULL
  AND APPLY_DATE > SYSDATE;

-- 데이터 조금 추가
INSERT INTO APPLY_PACKAGE(APPLY_PACKAGE_CODE, PACKAGE_CODE, APPLY_DATE)
VALUES(F_CODE('AP', AP_SEQ.NEXTVAL), 'P000001', TO_DATE('2021-01-20', 'YYYY-MM-DD'));
INSERT INTO APPLY_PACKAGE(APPLY_PACKAGE_CODE, PACKAGE_CODE, APPLY_DATE)
VALUES(F_CODE('AP', AP_SEQ.NEXTVAL), 'P000003', TO_DATE('2021-01-22', 'YYYY-MM-DD'));
INSERT INTO APPLY_PACKAGE(APPLY_PACKAGE_CODE, PACKAGE_CODE, APPLY_DATE)
VALUES(F_CODE('AP', AP_SEQ.NEXTVAL), 'P000002', TO_DATE('2021-01-25', 'YYYY-MM-DD'));
INSERT INTO APPLY_PACKAGE(APPLY_PACKAGE_CODE, PACKAGE_CODE, APPLY_DATE)
VALUES(F_CODE('AP', AP_SEQ.NEXTVAL), 'P000001', TO_DATE('2021-01-30', 'YYYY-MM-DD'));
INSERT INTO APPLY_PACKAGE(APPLY_PACKAGE_CODE, PACKAGE_CODE, APPLY_DATE)
VALUES(F_CODE('AP', AP_SEQ.NEXTVAL), 'P000002', TO_DATE('2021-02-12', 'YYYY-MM-DD'));

COMMIT;


--○ 패키지를 적용하기 위한 쿼리문
-- 존재여부를 위한 카운트값
SELECT COUNT(*) AS COUNT
FROM APPLY_PACKAGE
WHERE APPLY_PACKAGE_CODE = '패키지적용코드';

-- 새로 적용된 공간 등록
INSERT INTO APPLY_PACKAGE(APPLY_PACKAGE_CODE, PACKAGE_CODE, APPLY_DATE)
VALUES(F_CODE('AP', AP_SEQ.NEXTVAL), '받아온패키지코드', TO_DATE('받아온날짜')); 

-- 기존 적용된 공간 수정
UPDATE APPLY_PACKAGE
SET APPLY_DATE = '수정된날짜'
WHERE APPLY_PACKAGE_CODE = '수정할패키지적용코드';

-- 기존 적용된 공간 삭제
DELETE 
FROM APPLY_PACKAGE
WHERE APPLY_PACKAGE_CODE = '삭제할패키지적용코드';


select * from apply_package;


--○ 패키지 폼을 등록
INSERT INTO PACKAGE(PACKAGE_CODE, PACKAGE_FORM_CODE, PACKAGE_NAME
                  , PACKAGE_START, PACKAGE_END, PACKAGE_PRICE)
VALUES(F_CODE('P', P_SEQ.NEXTVAL), (SELECT PACKAGE_FORM_CODE
                                     FROM PACKAGE_FORM
                                     WHERE LOC_CODE = 'L000001')
      , '어승승', 10, 24, 100000);
      
DESC PACKAGE_REMOVE;

--○ 패키지 폼을 삭제
INSERT INTO PACKAGE_REMOVE(PACKAGE_REMOVE_CODE, PACKAGE_CODE, PACKAGE_REMOVE_DATE)
VALUES(F_CODE('PRM', PRM_SEQ.NEXTVAL), 'P000001', SYSDATE);


--○ 공간 리스트 조회

CREATE OR REPLACE VIEW LOC_LIST_VIEW
AS
SELECT H.HOST_CODE AS HOST_CODE, LRM.LOC_REMOVE_CODE AS REMOVE_CODE
     , L.LOC_CODE AS LOC_CODE, LBIF.LOC_NAME AS LOC_NAME
     , TO_CHAR(L.LOC_REG_DATE, 'YYYY.MM.DD') AS LOC_REG_DATE
     , T.THUMBNAIL_URL AS THUMBNAIL_URL
     , NVL(IT.INSPECT_TYPE, '검수대기') AS INSPECT_TYPE
FROM HOST H JOIN LOC L
ON H.HOST_CODE = L.HOST_CODE
    LEFT OUTER JOIN LOC_REMOVE LRM
    ON LRM.LOC_CODE = L.LOC_CODE
        JOIN LOC_BASIC_INFO LBIF
        ON L.LOC_CODE = LBIF.LOC_CODE
            JOIN THUMBNAIL T
            ON LBIF.LOC_BASIC_INFO_CODE = T.LOC_BASIC_INFO_CODE
                JOIN INSPECT_REG_LIST IR
                ON L.LOC_CODE = IR.LOC_CODE
                    LEFT OUTER JOIN INSPECT_PROC_LIST IP
                    ON IR.INSPECT_REG_CODE = IP.INSPECT_REG_CODE
                        LEFT OUTER JOIN INSPECT_TYPE IT
                        ON IP.INSPECT_TYPE_CODE = IT.INSPECT_TYPE_CODE;
                    
SELECT LOC_CODE, LOC_NAME, LOC_REG_DATE, THUMBNAIL_URL, INSPECT_TYPE
FROM LOC_LIST_VIEW
WHERE REMOVE_CODE IS NOT NULL;

DELETE
FROM LOC_REMOVE
WHERE LOC_REMOVE_CODE = 'LRM000002';

COMMIT;


--○ 공간 패키지 폼 추가
INSERT INTO PACKAGE_FORM(PACKAGE_FORM_CODE, LOC_CODE)
VALUES(F_CODE('PF', PF_SEQ.NEXTVAL), #{loc_code}) 


