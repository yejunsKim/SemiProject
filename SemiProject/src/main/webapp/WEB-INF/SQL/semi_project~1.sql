show user;
-- USER이(가) "SEMI_ORAUSER2"입니다.

create table tbl_kyj_test 
 (no number,
  name varchar2(100)
  );
  
-- Table TBL_KYJ_TEST이(가) 생성되었습니다.

insert into tbl_kyj_test(no, name) values (1,'연습맨1');
insert into tbl_kyj_test(no, name) values (1,'연습맨2');
-- 1 행 이(가) 삽입되었습니다.
-- 1 행 이(가) 삽입되었습니다.


commit;
-- 커밋 완료.

select * from tbl_kyj_test;

select * from tab;
-- 전체 테이블 조회

drop table tbl_kyj_test purge;

commit;