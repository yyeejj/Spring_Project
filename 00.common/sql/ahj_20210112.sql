SELECT USER
FROM DUAL;

--<<������ �α���>>
SELECT ADMIN_NICKNAME 
FROM ADMIN WHERE ADMIN_ID = 'admin_lookation01' 
AND ADMIN_PW = 'java006$';
--==>> ������_1

-- Ȯ��
SELECT ADMIN_NICKNAME  FROM ADMIN WHERE ADMIN_ID = 'admin_lookation01' AND ADMIN_PW = 'java006$'
;


--<<���� �˼� ����>>
-- �׸� : �˼���û�ڵ� ������ �������� 

--���� �˼� ���� ��(VIEW) ���� �̰ϵ�
CREATE OR REPLACE VIEW ADMIN_INSPECT_LIST_VIEW
AS
SELECT IR.INSPECT_REG_CODE, LBIF.LOC_NAME, LOCT.LOC_TYPE
,(SELECT COUNT(*)
FROM INSPECT_PROC_LIST
WHERE INSPECT_REG_CODE = IR.INSPECT_REG_CODE ) AS COUNT
FROM INSPECT_REG_LIST IR JOIN LOC_BASIC_INFO LBIF
    ON IR.LOC_CODE = LBIF.LOC_CODE
        JOIN LOC_TYPE LOCT
            ON LOCT.LOC_TYPE_CODE = LBIF.LOC_TYPE_CODE;


SELECT *
FROM ADMIN_INSPECT_LIST_VIEW;

SELECT *
FROM inspect_REG_list;
-- * Ȯ��
SELECT INSPECT_REG_CODE,LOC_NAME,LOC_TYPE,COUNT
FROM ADMIN_INSPECT_LIST_VIEW
WHERE COUNT<1;

--Ȯ�ο� ������ �Է�
INSERT INTO INSPECT_REG_LIST(INSPECT_REG_CODE, LOC_CODE, INSPECT_REG_DATE)
VALUES(F_CODE('IR', IR_SEQ.NEXTVAL), 'L000001', SYSDATE); 
COMMIT;

--<<���� �˼� �󼼺���>>

--�˼�ó�� �丸��� (URL������Ʈ,��������,���̹����� ���� )

CREATE OR REPLACE VIEW ADMIN_INSPECT_PR_VIEW
AS
SELECT IR.INSPECT_REG_CODE,LBIF.LOC_NAME,LBIF.LOC_SHORT_INTRO,LBIF.LOC_INTRO,LBIF.LOC_ADDR,LBIF.LOC_DETAIL_ADDR
,LOCT.LOC_TYPE, LDIF.MIN_PEOPLE,LDIF.MAX_PEOPLE
,LC.LOC_TEL,LC.LOC_MAIN_TEL,LC.LOC_EMAIL
,BZ.BIZ_NAME,BZ.BIZ_CEO,BZ.BIZ_CEO_TYPE,BZ.BIZ_MAIN_TYPE,BZ.BIZ_SUB_TYPE,BZ.BIZ_ADDR,BZ.BIZ_LICENSE_NUMBER
,LUI.LOC_USE_HOUR,LUI.LOC_USE_DAY_OFF,LUI.LOC_USE_APPOINT_DAY_OFF
FROM  LOC_BASIC_INFO LBIF JOIN LOC_TYPE LOCT
    ON LBIF.LOC_TYPE_CODE = LOCT.LOC_TYPE_CODE
        JOIN inspect_reg_list IR
            ON LBIF.LOC_CODE = IR.LOC_CODE
                    JOIN LOC_DETAIL_INFO LDIF
                        ON LBIF.LOC_CODE = LDIF.LOC_CODE
                            JOIN LOC_CONTACT LC
                                ON LBIF.LOC_CODE = LC.LOC_CODE
                                    JOIN BIZ_INFO BZ
                                        ON LC.LOC_CODE = BZ.LOC_CODE
                                            JOIN LOC_USE_INFO LUI
                                                ON LC.LOC_CODE = LUI.LOC_CODE
                                                        ; 

 --Ȯ��
 SELECT INSPECT_REG_CODE,LOC_NAME,LOC_SHORT_INTRO,LOC_INTRO,LOC_ADDR,LOC_DETAIL_ADDR
,LOC_TYPE,MIN_PEOPLE,MAX_PEOPLE
,LOC_TEL,LOC_MAIN_TEL,LOC_EMAIL
,BIZ_NAME,BIZ_CEO,BIZ_CEO_TYPE,BIZ_MAIN_TYPE,BIZ_SUB_TYPE,BIZ_ADDR,BIZ_LICENSE_NUMBER
,LOC_USE_HOUR,LOC_USE_DAY_OFF,LOC_USE_APPOINT_DAY_OFF
FROM ADMIN_INSPECT_PR_VIEW
where INSPECT_REG_CODE='IR000001';

DROP VIEW ADMIN_INSPECT_PR_VIEW;


DESC FACILITY_INFO;
FACILITY_CONTENT,CAUTION_CONTENT
FIF.FACILITY_CONTENT,CAU.CAUTION_CONTENT
,


                   
                   
--�ü��ȳ�
CREATE OR REPLACE VIEW FACILITY_INFO_VIEW
AS
SELECT FIF.FACILITY_CONTENT, LBIF.LOC_BASIC_INFO_CODE, IR.INSPECT_REG_CODE 
FROM FACILITY_INFO FIF JOIN LOC_BASIC_INFO LBIF
 ON FIF.LOC_BASIC_INFO_CODE = LBIF.LOC_BASIC_INFO_CODE
    JOIN  INSPECT_REG_LIST IR
        ON IR.LOC_CODE = LBIF.LOC_CODE;
        
--Ȯ��
SELECT FACILITY_CONTENT FROM FACILITY_INFO_VIEW
WHERE INSPECT_REG_CODE='IR000001';

--���ǻ���
CREATE OR REPLACE VIEW CAUTION_VIEW
AS
SELECT CAU.CAUTION_CONTENT, LBIF.LOC_BASIC_INFO_CODE, IR.INSPECT_REG_CODE 
FROM CAUTION CAU JOIN LOC_BASIC_INFO LBIF
 ON CAU.LOC_BASIC_INFO_CODE = LBIF.LOC_BASIC_INFO_CODE
    JOIN  INSPECT_REG_LIST IR
        ON IR.LOC_CODE = LBIF.LOC_CODE
--==>>View CAUTION_VIEW��(��) �����Ǿ����ϴ�.

--Ȯ��
SELECT CAUTION_CONTENT FROM CAUTION_VIEW
WHERE INSPECT_REG_CODE='IR000001';

--URL������Ʈ
CREATE OR REPLACE VIEW WEB_VIEW
AS
SELECT LW.LOC_WEB_URL, LDIF.LOC_DETAIL_INFO_CODE, IR.INSPECT_REG_CODE 
FROM LOC_WEB LW JOIN LOC_DETAIL_INFO LDIF
    ON  LW.LOC_DETAIL_INFO_CODE= LDIF.LOC_DETAIL_INFO_CODE 
        JOIN  INSPECT_REG_LIST IR
            ON IR.LOC_CODE = LDIF.LOC_CODE;
            
--Ȯ��
SELECT LOC_WEB_URL FROM WEB_VIEW
WHERE INSPECT_REG_CODE='IR000001';

--�������� (�̹���) ��ȸ����
--�̹�����ũ ��� ��ȸ ����

--�ش� �˼���� ���� �˼� ����/�ݷ� ��, �˼�ó������ INSERT ������
INSERT INTO INSPECT_PROC_LIST (INSPECT_PROC_CODE, INSPECT_REG_CODE, INSPECT_TYPE_CODE
,INSPECT_PROC_REASON ,INSPECT_PROC_DATE)
VALUES (F_CODE('IP', IP_SEQ.NEXTVAL), 'IR000005', 'IT000001','�˼����ݷ��Ȱ�', SYSDATE); 


----------------------------------------------------------------------------------<<Ȥ�ð����޼ҵ�����ؼ��������󼭳���>>
--�ش� �˼���� ���� �⺻���� ��ȸ ����
--(������, �������ټҰ�,  �����ּ�, �������ּ�,��������, �ü��ȳ�, ���ǻ��� )
SELECT LBIF.LOC_NAME,LBIF.LOC_SHORT_INTRO,LBIF.LOC_ADDR,LBIF.LOC_DETAIL_ADDR,LOCT.LOC_TYPE,FIF.FACILITY_CONTENT,CAU.CAUTION_CONTENT 
FROM LOC_BASIC_INFO LBIF JOIN LOC_TYPE LOCT
    ON LBIF.LOC_TYPE_CODE = LOCT.LOC_TYPE_CODE
        JOIN FACILITY_INFO FIF
            ON LBIF.LOC_BASIC_INFO_CODE =  FIF.LOC_BASIC_INFO_CODE
                JOIN CAUTION CAU
                    ON LBIF.LOC_BASIC_INFO_CODE =  CAU.LOC_BASIC_INFO_CODE; 

--�ش� �˼���� ���� ������ ��ȸ ����
--(�׸� : �ּ��ο�,�ִ��ο�,����������Ʈ)
SELECT LDIF.MIN_PEOPLE,LDIF.MAX_PEOPLE,LW.LOC_WEB_URL
FROM LOC_DETAIL_INFO LDIF JOIN LOC_WEB LW
    ON LDIF.LOC_DETAIL_INFO_CODE = LW.LOC_DETAIL_INFO_CODE
    ;

--�ش� �˼���� ���� ��Ű�� ��ȸ ����
--(�׸� :  ��Ű����,��Ű�� ���۽ð�, ��Ű�� ����ð�,��Ű�� ����)
CREATE OR REPLACE VIEW INSPECT_PACKAGE_VIEW
AS
SELECT P.PACKAGE_NAME,P.PACKAGE_START,P.PACKAGE_END,IR.INSPECT_REG_CODE
FROM PACKAGE P JOIN PACKAGE_FORM PF
ON P.PACKAGE_FORM_CODE = PF.PACKAGE_FORM_CODE
JOIN INSPECT_REG_LIST IR
ON PF.LOC_CODE = IR.LOC_CODE;
where Inspect_reg_code='IR000001';

SELECT PACKAGE_NAME, PACKAGE_START,PACKAGE_END
FROM INSPECT_PACKAGE_VIEW
where Inspect_reg_code='IR000001';

DROP VIEW INSPECT_PACKAGE_VIEW;

INSPECT_REG_LIST
--�ش� �˼���� ���� ����ó ��ȸ ����
--(�׸� : �޴���, ��ǥ��ȭ, �̸��� )
SELECT LOC_TEL, LOC_MAIN_TEL,LOC_EMAIL
FROM LOC_CONTACT;

-- �ش� �˼���� ���� ��������� ��ȸ ����
--(�׸� : ��ȣ��, ��ǥ�ڸ�, ���������, �־���, ������, ������ּ�, ����ڵ�Ϲ�ȣ, ����ڵ����)
SELECT BIZ_NAME,BIZ_CEO,BIZ_CEO_TYPE,BIZ_MAIN_TYPE,BIZ_SUB_TYPE,BIZ_ADDR,BIZ_LICENSE_NUMBER,BIZ_LICENSE_URL
FROM BIZ_INFO;

--�ش� �˼���� ���� �̿�ȳ� ��ȸ ����
--(�̿�ð�,�����޹�,�����޹���)
SELECT LOC_USE_HOUR,LOC_USE_DAY_OFF,OC_USE_APPOINT_DAY_OFF
FROM LOC_USE_INFO;


SELECT PF.LOC_CODE, P.PACKAGE_CODE, P.PACKAGE_FORM_CODE, P.PACKAGE_NAME
, P.PACKAGE_START, P.PACKAGE_END, P.PACKAGE_PRICE, AP.APPLY_DATE
FROM PACKAGE P
JOIN PACKAGE_FORM PF
ON P.PACKAGE_FORM_CODE = PF.PACKAGE_FORM_CODE
    JOIN APPLY_PACKAGE AP
    ON P.PACKAGE_CODE = AP.PACKAGE_CODE
WHERE PF.LOC_CODE = 'L000001';



--==============================================================

--��hostQnaManager

--hostQnaManager ������ qna ��� ������
CREATE OR REPLACE VIEW QNA_REPLY_VIEW
AS
SELECT QR.QNA_REPLY_CODE,Q.LOC_CODE,Q.QNA_CONTENT,QR.QNA_CODE, H.HOST_CODE
,QR.QNA_REPLY_CONTENT,HP.HOST_NICKNAME
,QNA_REPLY_DATE
,(SELECT COUNT(*)
FROM QNA_REPLY_REMOVE
WHERE QNA_REPLY_CODE = QR.QNA_REPLY_CODE ) AS COUNT
FROM QNA Q JOIN QNA_REPLY QR
    ON Q.QNA_CODE = QR.QNA_CODE
        JOIN LOC L
            ON  Q.LOC_CODE = L.LOC_CODE
                JOIN HOST H
                    ON L.HOST_CODE = H.HOST_CODE
                        JOIN HOST_PROFILE HP    
                            ON H.HOST_CODE = HP.HOST_CODE;
                            
--Ȯ��
SELECT QNA_REPLY_CODE,QNA_CONTENT,QNA_REPLY_CONTENT,HOST_NICKNAME,QNA_REPLY_DATE,loc_code
FROM QNA_REPLY_VIEW;
WHERE LOC_CODE='L000001';

--Ȯ�ο� ������ �Է�
INSERT INTO QNA_REPLY (QNA_REPLY_CODE, QNA_CODE, QNA_REPLY_CONTENT, QNA_REPLY_DATE)
VALUES (F_CODE('QRE', QRE_SEQ.NEXTVAL), 'Q000001', '���ѹ�°....�׸��ұ�', sysdate);            

commit;             

--HOST QNA POPUP������
CREATE OR REPLACE VIEW QNA_REPLY_SECOND_VIEW
AS
SELECT Q.LOC_CODE,QNA_REPLY_DATE,MP.MEMBER_NICKNAME,Q.QNA_CONTENT,QR.QNA_CODE,HP.HOST_NICKNAME, H.HOST_CODE
,QR.QNA_REPLY_CONTENT,QR.QNA_REPLY_CODE
FROM QNA Q JOIN QNA_REPLY QR
    ON Q.QNA_CODE = QR.QNA_CODE
        JOIN LOC L
            ON  Q.LOC_CODE = L.LOC_CODE
                JOIN HOST H
                    ON L.HOST_CODE = H.HOST_CODE
                        JOIN HOST_PROFILE HP    
                            ON H.HOST_CODE = HP.HOST_CODE
                                JOIN MEMBER_PROFILE MP
                                    ON Q.MEMBER_CODE = MP.MEMBER_CODE;
--==>>View QNA_REPLY_SECOND_VIEW��(��) �����Ǿ����ϴ�.



--Ȯ��
SELECT LOC_CODE, QNA_REPLY_DATE, MEMBER_NICKNAME, QNA_CONTENT
		,HOST_NICKNAME,QNA_REPLY_CONTENT
		FROM QNA_REPLY_SECOND_VIEW
		WHERE QNA_REPLY_CODE ='QRE000001';

--������
CREATE SEQUENCE QRRM_SEQ;

--HOST QNA �ش� �׸� ����
INSERT INTO QNA_REPLY_REMOVE(QNA_REPLY_REMOVE_CODE, QNA_REPLY_CODE, QNA_REPLY_REMOVE_DATE)
		VALUES (F_CODE('QRRM', QRRM_SEQ.NEXTVAL), 'QRE000001', SYSDATE);
        
--==============================================================

--��hostReviewManager

--hostReviewManager ������ Review ��� ������
CREATE OR REPLACE VIEW RW_REPLY_VIEW
AS
SELECT RVRE.REVIEW_REPLY_CODE,RV.LOC_CODE,RV.REVIEW_CONTENT,RVRE.REVIEW_CODE, H.HOST_CODE
,RVRE.REVIEW_REPLY_CONTENT,HP.HOST_NICKNAME
,REVIEW_REPLY_DATE
,(SELECT COUNT(*)
FROM REVIEW_REPLY_REMOVE
WHERE REVIEW_REPLY_CODE = RVRE.REVIEW_REPLY_CODE ) AS COUNT
FROM REVIEW RV JOIN REVIEW_REPLY RVRE
    ON RV.REVIEW_CODE = RVRE.REVIEW_CODE
        JOIN LOC L
            ON  RV.LOC_CODE = L.LOC_CODE
                JOIN HOST H
                    ON L.HOST_CODE = H.HOST_CODE
                        JOIN HOST_PROFILE HP    
                            ON H.HOST_CODE = HP.HOST_CODE;
 -->>View RW_REPLY_VIEW��(��) �����Ǿ����ϴ�.                     
                            
--Ȯ��
SELECT REVIEW_REPLY_CODE,REVIEW_CONTENT,REVIEW_REPLY_CONTENT,HOST_NICKNAME,REVIEW_REPLY_DATE
FROM RW_REPLY_VIEW
WHERE LOC_CODE='L000001';
 
 DROP VIEW RW_REPLY_VIEW;                   

--HOST QNA POPUP������
CREATE OR REPLACE VIEW RW_REPLY_SECOND_VIEW
AS
SELECT RV.LOC_CODE,REVIEW_REPLY_DATE,MP.MEMBER_NICKNAME,RV.REVIEW_CONTENT,RVRE.REVIEW_CODE,HP.HOST_NICKNAME, H.HOST_CODE
,RVRE.REVIEW_REPLY_CONTENT,RVRE.REVIEW_REPLY_CODE
FROM REVIEW RV JOIN REVIEW_REPLY RVRE
    ON RV.REVIEW_CODE = RVRE.REVIEW_CODE
        JOIN LOC L
            ON  RV.LOC_CODE = L.LOC_CODE
                JOIN HOST H
                    ON L.HOST_CODE = H.HOST_CODE
                        JOIN HOST_PROFILE HP    
                            ON H.HOST_CODE = HP.HOST_CODE
                                JOIN MEMBER_PROFILE MP
                                    ON RV.MEMBER_CODE = MP.MEMBER_CODE;
--==>>View RW_REPLY_SECOND_VIEW��(��) �����Ǿ����ϴ�.

-- �� ����                
-- DROP VIEW RW_REPLY_SECOND_VIEW;   

--Ȯ��
SELECT LOC_CODE, REVIEW_REPLY_DATE, MEMBER_NICKNAME, REVIEW_CONTENT
		,HOST_NICKNAME,REVIEW_REPLY_CONTENT
		FROM RW_REPLY_SECOND_VIEW
		WHERE REVIEW_REPLY_CODE ='RVRE000001';

CREATE SEQUENCE RVRERM_SEQ;

--HOST QNA �ش� �׸� ����
INSERT INTO REVIEW_REPLY_REMOVE(REVIEW_REPLY_REMOVE_CODE, REVIEW_REPLY_CODE, REVIEW_REPLY_REMOVE_DATE)
		VALUES (F_CODE('RVRERM', RVRERM_SEQ.NEXTVAL), 'ȣ��ƮREVIEW�ڵ�', SYSDATE);

                    
--==============================================================

--��HELP Manager

--HELPManager ������ Review ��� ������
CREATE OR REPLACE VIEW  HELP_VIEW
AS
SELECT  HLP.HELP_CODE, BT.BOARD_TYPE, HLP.HELP_TITLE, HLP.HELP_CONTENT, HLP.HELP_DATE
FROM HELP HLP JOIN BOARD_TYPE BT
ON HLP.BOARD_TYPE_CODE = BT.BOARD_TYPE_CODE;

 -->>View HELP_VIEW��(��) �����Ǿ����ϴ�.                     
                            
--Ȯ��
SELECT HELP_CODE, BOARD_TYPE, HELP_TITLE, HELP_CONTENT, HELP_DATE
FROM HELP_VIEW
WHERE HELP_CODE='HLP000001';

SELECT HELP_CODE, BOARD_TYPE, HELP_TITLE, HELP_DATE
FROM HELP_VIEW
ORDER BY HELP_DATE DESC;

SELECT *
FROM BOARD_TYPE;

--���� �� �ۼ�
REVIEW_REPLY_REMOVE(REVIEW_REPLY_REMOVE_CODE, REVIEW_REPLY_CODE, REVIEW_REPLY_REMOVE_DATE)
		VALUES (F_CODE('RVRERM', RVRERM_SEQ.NEXTVAL), 'ȣ��ƮREVIEW�ڵ�', SYSDATE);

INSERT INTO HELP(HELP_CODE,BOARD_TYPE_CODE,HELP_TITLE,HELP_CONTENT,HELP_DATE)
    VALUES(F_CODE('HLP',HLP_SEQ.NEXTVAL),'BT000001','�����̼������¹��','�����̼��������ʹٰ���?',SYSDATE);
    COMMIT;

-- ���� ����   
DELETE FROM HELP WHERE HELP_CODE = 'HLP000006';

--���� ����
UPDATE help
SET board_type_code = 'BT000001'
  		  , help_title = '�����̼Ǳ׸��ϴ¹�'
          , help_content = '�׸���~!'
          , help_date = sysdate
WHERE HELP_CODE = 'HLP000003';

--Ȯ��
SELECT HELP_CODE,BOARD_TYPE_CODE,HELP_TITLE,HELP_CONTENT,HELP_DATE
		FROM HELP
		WHERE HELP_CODE =  'HLP000001';
        
        
-- ��������
select notice_code,important_notice_code,notice_title ,notice_content,notice_date
from notice;

--�������� �� ����
CREATE OR REPLACE VIEW  NOTICE_VIEW
AS
SELECT N.NOTICE_CODE, I.IMPORTANT_NOTICE, N.NOTICE_TITLE, N.NOTICE_CONTENT, N.NOTICE_DATE,N.IMPORTANT_NOTICE_CODE
FROM NOTICE N JOIN IMPORTANT_NOTICE I
ON N.IMPORTANT_NOTICE_CODE = I.IMPORTANT_NOTICE_CODE;
--==>>View NOTICE_VIEW��(��) �����Ǿ����ϴ�.

-- �������� ��ȸ
SELECT NOTICE_CODE, IMPORTANT_NOTICE, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE
FROM NOTICE_VIEW
;

--�������� ��� 
INSERT INTO NOTICE (NOTICE_CODE, IMPORTANT_NOTICE_CODE, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE)
    	VALUES(F_CODE('N',N_SEQ.NEXTVAL),#{important_notice_code},#{notice_title},#{notice_content},SYSDATE);

--������ �־��         
INSERT INTO NOTICE(NOTICE_CODE, IMPORTANT_NOTICE_CODE, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE)
VALUES(F_CODE('N',N_SEQ.NEXTVAL),'IN000001','�ǶǶ��Ϲݰ���', '�׸��׸��׸��׸�',SYSDATE);

SELECT *
FROM NOTICE;

--�������� ����
DELETE FROM NOTICE WHERE NOTICE_CODE = 'N000003';

commit;

--�������� ����
UPDATE NOTICE SET IMPORTANT_NOTICE_CODE = 'IN000002'
  		  , NOTICE_TITLE = '�Ϲݰ����Դϴ�'
          , NOTICE_CONTENT = '�׷��ű׷��ű׷���'
          , NOTICE_DATE = SYSDATE
		WHERE NOTICE_CODE = 'N000010';

        
UPDATE NOTICE SET IMPORTANT_NOTICE_CODE = #{important_notice_code}
  		  , NOTICE_TITLE = #{notice_title}
          , NOTICE_CONTENT = #{notice_content}
          , NOTICE_DATE = SYSDATE
		WHERE NOTICE_CODE = #{notice_code}

CREATE OR REPLACE VIEW  UNOTICE_VIEW
AS
SELECT N.NOTICE_CODE, I.IMPORTANT_NOTICE, N.NOTICE_TITLE, N.NOTICE_CONTENT, N.NOTICE_DATE,N.IMPORTANT_NOTICE_CODE
FROM NOTICE N JOIN IMPORTANT_NOTICE I
ON N.IMPORTANT_NOTICE_CODE = I.IMPORTANT_NOTICE_CODE;
--==>>View UNOTICE_VIEW��(��) �����Ǿ����ϴ�.

--Notice(������ [1.�߿�/2.�Ϲ�]- �ֱ� ��¥�� ��������) ��� ������
SELECT NOTICE_CODE, IMPORTANT_NOTICE, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE,IMPORTANT_NOTICE_CODE
FROM UNOTICE_VIEW
ORDER BY IMPORTANT_NOTICE_CODE ASC , NOTICE_DATE DESC 
;
		

SELECT NOTICE_CODE, IMPORTANT_NOTICE, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE,IMPORTANT_NOTICE_CODE
FROM UNOTICE_VIEW
WHERE NOTICE_CODE= 'N000009';
---------------------------------------------------------

INSERT INTO QNA_REPLY (QNA_REPLY_CODE, QNA_CODE, QNA_REPLY_CONTENT, QNA_REPLY_DATE)
VALUES (F_CODE('QRE', QRE_SEQ.NEXTVAL), 'Q000002', '�׽�Ʈ�׽�Ʈ.', TO_DATE('2020-12-27','YYYY-MM-DD'));         

INSERT INTO REVIEW_REPLY(REVIEW_REPLY_CODE, REVIEW_CODE, REVIEW_REPLY_CONTENT
          , REVIEW_REPLY_DATE)
VALUES(F_CODE('RVRE', RVRE_SEQ.NEXTVAL), 'RV000001', '�׽�Ʈ�غ����غ����غ���'
     , TO_DATE('2021-01-18', 'YYYY-MM-DD'));

SELECT HELP_CODE, HELP_TITLE, HELP_CONTENT, HELP_DATE
FROM HELP_VIEW
WHERE HELP_CODE='HLP000009';

----------------------------=========================================

--�� MEMBER ������ ��������
CREATE OR REPLACE VIEW MEMBER_PROFILEVIEW
AS
SELECT MP.MEMBER_EMAIL AS EMAIL, MP.MEMBER_CODE AS CODE
     , MP.MEMBER_PW AS PW, MP.MEMBER_NICKNAME AS NICK
     , MP.MEMBER_NAME AS NAME, MP.MEMBER_TEL AS TEL
     , TO_CHAR(M.MEMBER_SIGN_UP_DATE, 'YYYY-MM-DD') AS CREATEDATE
FROM MEMBER_PROFILE MP, MEMBER M
WHERE MP.MEMBER_CODE = M.MEMBER_CODE;


--�� HOST ������ ��������
CREATE OR REPLACE VIEW HOST_PROFILEVIEW
AS
SELECT HP.HOST_EMAIL AS EMAIL, HP.HOST_CODE AS CODE
     , HP.HOST_PW AS PW, HP.HOST_NICKNAME AS NICK
     , HP.HOST_NAME AS NAME, HP.HOST_TEL AS TEL
     , TO_CHAR(H.HOST_SIGN_UP_DATE, 'YYYY-MM-DD') AS CREATEDATE
FROM HOST_PROFILE HP,  HOST H
WHERE HP.HOST_CODE = H.HOST_CODE;


