-- ADMIN(관리자)
INSERT INTO ADMIN(ADMIN_ID, ADMIN_PW, ADMIN_NICKNAME)
VALUES('admin_lookation01', 'java006$', '관리자_1');

--============================================================= 1. FAQ, NOTICE
-- IMPORTANT_NOTICE(중요공지 분류, 숫자)
INSERT INTO IMPORTANT_NOTICE(IMPORTANT_NOTICE_CODE, IMPORTANT_NOTICE)
VALUES(F_CODE('IN', 1), '중요공지');

INSERT INTO IMPORTANT_NOTICE(IMPORTANT_NOTICE_CODE, IMPORTANT_NOTICE)
VALUES(F_CODE('IN', 2), '일반공지');


-- BOARD_TYPE(게시물 분류, 코드)
INSERT INTO BOARD_TYPE (BOARD_TYPE_CODE, BOARD_TYPE) 
VALUES (F_CODE('BT',1), '호스트되기');

INSERT INTO BOARD_TYPE (BOARD_TYPE_CODE, BOARD_TYPE) 
VALUES (F_CODE('BT',2), '공간등록');

INSERT INTO BOARD_TYPE (BOARD_TYPE_CODE, BOARD_TYPE) 
VALUES (F_CODE('BT',3), '공간조회');

INSERT INTO BOARD_TYPE (BOARD_TYPE_CODE, BOARD_TYPE) 
VALUES (F_CODE('BT',4), '공간정보관리');

INSERT INTO BOARD_TYPE (BOARD_TYPE_CODE, BOARD_TYPE) 
VALUES (F_CODE('BT',5), '예약및결제');

INSERT INTO BOARD_TYPE (BOARD_TYPE_CODE, BOARD_TYPE) 
VALUES (F_CODE('BT',6), '취소및환불');

INSERT INTO BOARD_TYPE (BOARD_TYPE_CODE, BOARD_TYPE) 
VALUES (F_CODE('BT',7), '공간이용및후기');

INSERT INTO BOARD_TYPE (BOARD_TYPE_CODE, BOARD_TYPE) 
VALUES (F_CODE('BT',8), '공간정보관리');

INSERT INTO BOARD_TYPE (BOARD_TYPE_CODE, BOARD_TYPE) 
VALUES (F_CODE('BT',9), '기타');


--LOC_TYPE(공간분류, LOCT)
INSERT INTO LOC_TYPE (LOC_TYPE_CODE, LOC_TYPE) 
VALUES (F_CODE('LOCT',1), '파티룸');

INSERT INTO LOC_TYPE (LOC_TYPE_CODE, LOC_TYPE) 
VALUES (F_CODE('LOCT',2), '엠티공간');

INSERT INTO LOC_TYPE (LOC_TYPE_CODE, LOC_TYPE) 
VALUES (F_CODE('LOCT',3), '루프탑');

INSERT INTO LOC_TYPE (LOC_TYPE_CODE, LOC_TYPE) 
VALUES (F_CODE('LOCT',4), '브라이덜샤워');


-- INSPECT_TYPE(검수분류, IT)
INSERT INTO INSPECT_TYPE(INSPECT_TYPE_CODE, INSPECT_TYPE)
VALUES(F_CODE('IT', IT_SEQ.NEXTVAL), '검수승인');

INSERT INTO INSPECT_TYPE(INSPECT_TYPE_CODE, INSPECT_TYPE)
VALUES(F_CODE('IT', IT_SEQ.NEXTVAL), '검수반려');


-- LOAD_TYPE(마일리지 충전 분류, LT)
INSERT INTO LOAD_TYPE(LOAD_TYPE_CODE, LOAD_TYPE)
VALUES(F_CODE('LT', 1), '충전성공');

INSERT INTO LOAD_TYPE(LOAD_TYPE_CODE, LOAD_TYPE)
VALUES(F_CODE('LT', 2), '충전실패');


-- REPORT_PROC_TYPE(신고처리분류 RPPT)
INSERT INTO REPORT_PROC_TYPE(REPORT_PROC_TYPE_CODE, REPORT_PROC_TYPE)
VALUES('RPPT000001', '신고인정');

INSERT INTO REPORT_PROC_TYPE(REPORT_PROC_TYPE_CODE, REPORT_PROC_TYPE)
VALUES('RPPT000002', '신고반려');


-- BOOK_REPORT_TYPE(신고유형분류(예약내역), BRPT)
INSERT INTO BOOK_REPORT_TYPE(BOOK_REPORT_TYPE_CODE, BOOK_REPORT_TYPE)
VALUES('BRPT000001', '부적절한언행');

INSERT INTO BOOK_REPORT_TYPE(BOOK_REPORT_TYPE_CODE, BOOK_REPORT_TYPE)
VALUES('BRPT000002', '기물파손');

INSERT INTO BOOK_REPORT_TYPE(BOOK_REPORT_TYPE_CODE, BOOK_REPORT_TYPE)
VALUES('BRPT000003', '이용규정위반');

INSERT INTO BOOK_REPORT_TYPE(BOOK_REPORT_TYPE_CODE, BOOK_REPORT_TYPE)
VALUES('BRPT000004', '기타');


-- LOC_REPORT_TYPE(신고처리(이용자)(공간), LRPP)
INSERT INTO LOC_REPORT_TYPE(LOC_REPORT_TYPE_CODE, LOC_REPORT_TYPE)
VALUES('LRPP000001', '서비스미충족');

INSERT INTO LOC_REPORT_TYPE(LOC_REPORT_TYPE_CODE, LOC_REPORT_TYPE)
VALUES('LRPP000002', '추가결제 유도');

INSERT INTO LOC_REPORT_TYPE(LOC_REPORT_TYPE_CODE, LOC_REPORT_TYPE)
VALUES('LRPP000003', '공유규정위반');

INSERT INTO LOC_REPORT_TYPE(LOC_REPORT_TYPE_CODE, LOC_REPORT_TYPE)
VALUES('LRPP000004', '허위매물');

INSERT INTO LOC_REPORT_TYPE(LOC_REPORT_TYPE_CODE, LOC_REPORT_TYPE)
VALUES('LRPP000005', '기타');


