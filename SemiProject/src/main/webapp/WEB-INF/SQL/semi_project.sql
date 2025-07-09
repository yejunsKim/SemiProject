-- 1. Users 테이블
CREATE TABLE Users (
    id VARCHAR2(40),
    name VARCHAR2(30) NOT NULL,
    password VARCHAR2(200) NOT NULL,
    email VARCHAR2(200) NOT NULL,
    mobile VARCHAR2(200) NOT NULL,
    postcode VARCHAR2(5),
    address VARCHAR2(200),
    addressDetail VARCHAR2(200),
    addressExtra VARCHAR2(200),
    point NUMBER DEFAULT 0,
    grade VARCHAR2(20) DEFAULT 'bronze',
    registerday DATE DEFAULT SYSDATE,
    passwordChanged DATE DEFAULT SYSDATE,
    isDormant CHAR(1) DEFAULT 'N',
    isDeleted CHAR(1) DEFAULT 'N',
    
    CONSTRAINT PK_Users PRIMARY KEY (id),
    
    -- constraint UQ_tbl_member_email  unique(email),

    CONSTRAINT CK_Users_isDormant CHECK (isDormant IN ('Y', 'N')),
    CONSTRAINT CK_Users_isDeleted CHECK (isDeleted IN ('Y', 'N'))
);

ALTER TABLE Users
ADD CONSTRAINT UQ_Users_email UNIQUE (email);


-- 2. login_history
CREATE TABLE login_history (
    id VARCHAR2(40) NOT NULL,
    loginHistoryNo number,
    lastLogin DATE DEFAULT SYSDATE NOT NULL,
    ip VARCHAR2(45) NOT NULL,
    CONSTRAINT PK_LoginHistory PRIMARY KEY(loginHistoryNo),
    CONSTRAINT FK_LoginHistory_User FOREIGN KEY (id) REFERENCES Users(id)
);


-- 3. category
CREATE TABLE category (
    categoryNo NUMBER,
    categoryName NVARCHAR2(100) DEFAULT '기타' NOT NULL,
    categoryImagePath NVARCHAR2(255),
    CONSTRAINT PK_Category PRIMARY KEY (categoryNo)
);


-- 4. Item
CREATE TABLE Item (
    itemNo NUMBER,
    itemName NVARCHAR2(150) NOT NULL,
    itemPhotoPath NVARCHAR2(255),
    itemInfo NVARCHAR2(500),
    price NUMBER NOT NULL,
    itemAmount NUMBER DEFAULT 0 NOT NULL,
    volume NUMBER(3) NOT NULL,
    company NVARCHAR2(50) NOT NULL,
    CONSTRAINT PK_Item PRIMARY KEY (itemNo),
    CONSTRAINT CK_Item_Price CHECK (price >= 0),
    CONSTRAINT CK_Item_Amount CHECK (itemAmount >= 0),
    CONSTRAINT CK_Item_Volume CHECK (volume >= 0)
);



commit;


desc users;
select * from users;

desc login_history;
select * from login_history;

desc category;
select * from category;

desc item;
select * from item;


-- login_history 시퀀스 생성
create sequence login_history_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- CATEGORY 시퀀스 생성
create sequence category_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- ITEM_SEQ 시퀀스 생성
create sequence item_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


insert into users(id, name, password, email, mobile, postcode, address, addressdetail, addressextra, point, grade)
values('leejh', '이준혁', 'qwer1234$', 'leejh@naver.com', '01011111111', '06035', '서울 강남구 가로수길 5', '101', '(신사동)', 2000, 'bronze');
insert into users(id, name, password, email, mobile, postcode, address, addressdetail, addressextra, point, grade)
values('goyj', '고윤정', 'qwer1234$', 'goyj@naver.com', '01022222222', '02512', '서울 동대문구 겸재로 24', '101-301', '(휘경동, 서울가든아파트)', 2000, 'bronze');
insert into users(id, name, password, email, mobile, postcode, address, addressdetail, addressextra, point, grade)
values('seohj', '서현진', 'qwer1234$', 'seohj@naver.com', '01033333333', '03900', '서울 마포구 가양대로 1', '205', '(상암동)', 2000, 'bronze');
insert into users(id, name, password, email, mobile, postcode, address, addressdetail, addressextra, point, grade)
values('leedh', '이도현', 'qwer1234$', 'leedh@naver.com', '01044444444', '06035', '서울 동대문구 서울시립대로 7', '307', '(답십리동)', 2000, 'bronze');
insert into users(id, name, password, email, mobile, postcode, address, addressdetail, addressextra, point, grade)
values('kimsc', '김성철', 'qwer1234$', 'kimsc@naver.com', '01055555555', '05400', '서울 강동구 강동대로 143-10', '504', '(성내동)', 2000, 'bronze');


insert into login_history(id, loginhistoryno, lastlogin, ip)
values(leejh, login_history_seq.nextval, sysdate, '172.30.1.43');
insert into login_history(id, loginhistoryno, lastlogin, ip)
values(goyj, login_history_seq.nextval, TO_DATE('2023-03-01','YYYY-MM-DD'), '172.30.1.43');
insert into login_history(id, loginhistoryno, lastlogin, ip)
values(seohj, login_history_seq.nextval, TO_DATE('2025-01-17','YYYY-MM-DD'), '172.30.1.43');
insert into login_history(id, loginhistoryno, lastlogin, ip)
values(leedh, login_history_seq.nextval, sysdate, '172.30.1.43');
insert into login_history(id, loginhistoryno, ip)
values(kimsc, login_history_seq.nextval, TO_DATE('2025-04-23','YYYY-MM-DD'), '172.30.1.43');


insert into category(categoryno, categoryname, categoryimagepath)
values(category_seq.nextval, '10대', 'images/category/10대.png');
insert into category(categoryno, categoryname, categoryimagepath)
values(category_seq.nextval, '20대', 'images/category/20대.png');
insert into category(categoryno, categoryname, categoryimagepath)
values(category_seq.nextval, '남성', 'images/category/남성.png');
insert into category(categoryno, categoryname, categoryimagepath)
values(category_seq.nextval, '여성', 'images/category/여성.png');


insert into item(itemno, itemname, itemphotopath, iteminfo, price, itemamount, volume, company, infoimg, Fk_Catagory_No)
values(item_seq.nextval, '도손', 'images/item/도손.png', '여름철 하롱베이 도손 바닷가의 추억을 그린 향', 253000, 10, 100, '씨씨아이알앤디', 'images/infoimg/도손.png', '10대');
insert into item(itemno, itemname, itemphotopath, iteminfo, price, itemamount, volume, company)
values(item_seq.nextval, '테싯', 'images/item/테싯.png', '유자나무를 품은 흙내음, 숲의 자유로움을 싣고 번지는 들바람 향기', 187000, 20, 50, 'Emeis Cosmetics Pty. Ltd.', 'images/infoimg/테싯.png', '20대');
insert into item(itemno, itemname, itemphotopath, iteminfo, price, itemamount, volume, company)
values(item_seq.nextval, '블랑쉬', 'images/item/블랑쉬.png', '깨끗한 코튼 시트와 같은 부드러운 향기', 280000, 5, 50, '바이레도 프랑스', 'images/infoimg/블랑쉬.png', '남성');
insert into item(itemno, itemname, itemphotopath, iteminfo, price, itemamount, volume, company)
values(item_seq.nextval, '네롤리', 'images/item/네롤리.png', '따뜻하고 싱그러운 플로럴 향에 센슈얼한 베이스를 더해 독창적으로 만들어졌습니다.', 310000, 25, 50, '이엘씨에이한국(유)', 'images/infoimg/네롤리.png', '여성');
insert into item(itemno, itemname, itemphotopath, iteminfo, price, itemamount, volume, company)
values(item_seq.nextval, '아쿠아델라', 'images/item/아쿠아델라.png', '카트리나 공주의 사랑을 담은 프레시 시트러스 부케향', 210000, 15, 100, 'Officina Profumo Farmaceutica di Santa Maria Novella S.p.A', 'images/infoimg/아쿠아델라.png', '10대');


select itemno, itemname, price, volume, iteminfo, infoimg
from item;

update item set infoimg='images/iteminfo/앤젤스 셰어.jpeg'
where itemno=12;

commit;

SELECT itemno, itemname, itemphotopath, price, volume, iteminfo, infoimg
FROM item 
WHERE itemNo = 1;

SELECT * FROM item WHERE itemno = 1;

desc order_history;

select id, name, email, grade from users;



///

desc ORDER_ITEMS;
desc ORDER_HISTORY;



SELECT orderitemno
FROM ORDER_ITEMS I JOIN ORDER_HISTORY H
ON I.ORDERNO = H.ORDERNO 
WHERE H.id = ? AND I.itemNo = to_number(?);

select * from REVIEWS;

SELECT sequence_name FROM user_sequences;


insert into reviews(reviewid, fk_id, fk_itemno, content, createdat)
values(review_seq.nextval, ?, ?, ?, default);

SELECT reviewId, fk_id, name, content, to_char(createAt, 'yyyy-mm-dd hh24:mi:ss') AS createAt
FROM reviews R JOIN users U
ON R.fk_id = U.id
WHERE R.fk_itemno
order by reviewId desc;

select * from order_items;


WITH OH AS (
    SELECT orderNo
    FROM order_history
),
OI AS (
    SELECT orderNo, ITEMNO, quantity, orderPrice
    FROM order_items
)
SELECT 
    C.categoryName,
    COUNT(*) AS CNT,
    SUM(OI.quantity * OI.orderPrice) AS SUMPAY,
    ROUND(
        SUM(OI.quantity * OI.orderPrice) / (
            SELECT SUM(OI2.quantity * OI2.orderPrice)
            FROM OH 
            JOIN order_items OI2 ON OH.orderNo = OI2.orderNo
        ) * 100,
        2
    ) AS SUMPAY_PCT
FROM OI 
JOIN OH ON OH.orderNo = OI.orderNo
JOIN item I ON OI.ITEMNO = I.ITEMNO
JOIN category C ON I.fk_category_no = C.categoryNo  
GROUP BY C.categoryName
ORDER BY SUMPAY DESC;




WITH OH AS (
    SELECT orderno, orderdate
    FROM order_history
),
OI AS (
    SELECT orderNo, ITEMNO, quantity, orderPrice
    FROM order_items
)
SELECT 
    C.categoryName,
    COUNT(*) AS CNT,
    SUM(OI.quantity * OI.orderPrice) AS SUMPAY,
    ROUND(
        SUM(OI.quantity * OI.orderPrice) / (
            SELECT SUM(OI2.quantity * OI2.orderPrice)
            FROM OH
            JOIN order_items OI2 ON OH.orderNo = OI2.orderNo
        ) * 100, 2
    ) AS SUMPAY_PCT,
    
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '01', OI.quantity * OI.orderPrice, 0)) AS M_01,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '02', OI.quantity * OI.orderPrice, 0)) AS M_02,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '03', OI.quantity * OI.orderPrice, 0)) AS M_03,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '04', OI.quantity * OI.orderPrice, 0)) AS M_04,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '05', OI.quantity * OI.orderPrice, 0)) AS M_05,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '06', OI.quantity * OI.orderPrice, 0)) AS M_06,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '07', OI.quantity * OI.orderPrice, 0)) AS M_07,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '08', OI.quantity * OI.orderPrice, 0)) AS M_08,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '09', OI.quantity * OI.orderPrice, 0)) AS M_09,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '10', OI.quantity * OI.orderPrice, 0)) AS M_10,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '11', OI.quantity * OI.orderPrice, 0)) AS M_11,
    SUM(DECODE(TO_CHAR(OH.orderdate, 'mm'), '12', OI.quantity * OI.orderPrice, 0)) AS M_12

FROM OI
JOIN OH ON OH.orderNo = OI.orderNo
JOIN item I ON OI.ITEMNO = I.itemNo
JOIN category C ON I.fk_category_no = C.categoryNo
GROUP BY C.categoryName
ORDER BY SUMPAY DESC;

select * from tab;

select * from category;


---- **** MyMVC 다이내믹웹프로젝트 에서 작업한 것 **** ----

-- 오라클 계정 생성을 위해서는 SYS 또는 SYSTEM 으로 연결하여 작업을 해야 합니다. [SYS 시작] --
show user;
-- USER이(가) "SYS"입니다.

-- 오라클 계정 생성시 계정명 앞에 c## 붙이지 않고 생성하도록 하겠습니다.
alter session set "_ORACLE_SCRIPT"=true;
-- Session이(가) 변경되었습니다.

-- 오라클 계정명은 semi_project 이고 암호는 seven 인 사용자 계정을 생성합니다.
create user semi_project identified by seven default tablespace users; 
-- User semi_project이(가) 생성되었습니다.

-- 위에서 생성되어진 semi_project 이라는 오라클 일반사용자 계정에게 오라클 서버에 접속이 되어지고,
-- 테이블 생성 등등을 할 수 있도록 여러가지 권한을 부여해주겠습니다.
grant connect, resource, create view, unlimited tablespace to semi_project;
-- Grant을(를) 성공했습니다.

















