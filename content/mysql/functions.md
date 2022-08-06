---
title: "Functions"
date: 2022-08-06T12:06:41+09:00
draft: false
tag: ["database", "RDB", "SQL"]
---

# Overview

개인적으로 업무 진행중 빠르게 DB 데이터를 bulk 로 넣어야할 때에는 function 생성을 선호하는 편이다.

ORM 을 통해 코드로 넣는 방법도 있지만, 코드 수정하고 코드를 다시 실행해서 테스트 코드를 돌리고 데이터 결과를 쿼리로 다시 확인하는것보다.
쿼리를 바로 바로 작성해서 바로 수정하는게 더 생산성이 좋기 때문.

> 1. 코드 작성 (IDE)
> 2. 프로그램 실행 (SVR APP)
> 3. 테스트 코드 실행 (SWAGGER BROWSER)
> 4. 데이터 삽입 결과 확인 (DB CLIENT)

VS 

> 1. function 작성 (DB CLIENT)
> 2. function 실행 (DB CLIENT)
> 3. 데이터 삽입 결과 확인 (DB CLIENT)

절차는 크게 차이나지 않아보이지만, 화면 이동, 적합한 프로그램 실행등의 과정에서 
누적되면 생산성의 차이가 발생한다. (조금이라도 시간을 아끼려는 vimer 들의 습성..이랄까..) 
물론, 더미 데이터를 넣는 것 외에도 필요하다고 판단되는 케이스에는 사용하는 편.

작업시마다 항상 인터넷에서 자료를 찾아서, 비 효율적이므로.. 여기에 정리해둔다. 

# Creating Function

```sql

DROP FUNCTION IF EXISTS database.func

DELIMETER $$

CREATE FUNCTION database.func(nums INT) RETURNS INT
BEGIN
  DECLARE i INT DEFAULT 0;
  DECLARE affected INT DEFAULT 0;
  DECLARE temp INT DEFAULT 0;
  
  WHILE i < nums DO

    INSERT INTO database.table(name, message)
      (SELECT name, message FROM database.table_old(name, message));
   
    -- it isn't good way for in this example, 
    -- but I've used this just for showing usage 
    -- for selecting row_count() and set variable in function;
    SELECT ROW_COUNT() INTO temp; 
    SET affected = affected + temp;
    SET i = i + 1;
  END WHILE;

  RETURN affected;

END $$

DELIMETER ;

```

추후 개인적인 참조를 위해 기본적인 골격만 붙여두어, 이해하는데 어려움은 없을 것.

