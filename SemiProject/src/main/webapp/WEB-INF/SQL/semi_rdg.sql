----- 이건 미정! 임시 혹시나 공부용입니다..
select table_name
FROM user_tables;

select *
from order_history;

select *
from users;

select *
from order_history
where id = 'rdg';

CREATE TABLE grade (
    gradename VARCHAR2(20) PRIMARY KEY,     -- 'bronze', 'silver', 'gold'
    mintotalamount NUMBER NOT NULL         -- 누적 결제 금액 기준
);

INSERT INTO grade(gradename, mintotalamount) VALUES('bronze', 0);
INSERT INTO grade(gradename, mintotalamount) VALUES('silver', 300000);
INSERT INTO grade(gradename, mintotalamount) VALUES('gold', 1000000);

ALTER TABLE users
ADD CONSTRAINT fk_users_grade
FOREIGN KEY (grade) REFERENCES grade(grade_name);

UPDATE users U SET U.grade = ( SELECT G.gradename 
                               FROM grade G WHERE ( SELECT SUM(totalamount) 
                                                    FROM order_histroy OH 
                                                    WHERE OH.id = U.id AND OH.orderdate > sysdate - 180 
                                                  ) >= G.mintotalamount
                               ORDER BY G.mintotalamount DESC
                               FETCH FIRST 1 ROWS ONLY 
                             )
                             WHERE U.id = 'rdg';




delete from item where itemName like ('%exam%');

commit;



