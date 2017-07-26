---
title: "스프링 기본 용어/정리"
date: 2017-07-26T23:11:14+09:00
Categories: ["Spring"]
Tags: ["Spring", "Programming", "Note", "Web Server"]
Author: "nolleh"
---

> 어쩌다보니 그동안 손댈 일이 없던 웹서버에 좀 손을 대게 되서 (게임서버, 클라이언트, 그리고 웹서버..정녕 풀스택 개발자가 되는것인가..ㅋ), 예전 선배님이 버리고 간(?) 스프링 책을 꺼내서 읽어 보며 정리한 내용이므로 본 글을 처음 접한 사람이 이해하기에 많은 내용을 담지 않을 수 있음.

## Spring Bean 객체  
 
스프링에서 생성하여 관리하여 주는 스프링 빈 객체 혹은 빈 객체라고 부른다. 
res/applicationContext.xml 에 <bean> 태그로 선언할 수도 있다. 
이렇게 선언한경우, 리플렉션을 활용하여 bean id 클래스의 인스턴스를 지정한 세부 태그의 속성으로 메서드를 호출하여 객체를 초기화한다. 

## ApplicationContext

스프링에서 제공하는 인터페이스. 컨테이너가 제공해야할 기본 기능 정의. BeanFactory 인터페이스를 상위에 두고 있다. 

### ApplicationContext::getBean

인자는 이름/타입. 이를 통해 빈객체를 얻어올 수 있다. 


## Spring DI 

설명이 장황한데, 여기서의 의존은 (composite 패턴으로) 다른 객체를 요할때를 의미한다. 
- 생성자를 통해 객체를 받거나  
- 다른 멤버메서드를 통해 객체를 받거나

### DI
의존성을 주입하는 방식으로, 외부로부터 의존객체를 전달 받는 구현 방식을 의미한다. 

스프링은, 결국 DI 컨테이너다. 


### XML 을 통한 DI 설정

```xml

<beans xmlns="http://www.springframework.org/scheme/beans"...>
  <bean id="식별자" class="클래스명">
    <constructor-arg value="test"/>
    <constructor-arg ref="Other Bean"/>
    <property name="프로퍼티명">
      <value>프로퍼티값</value> 
    </property>
  </bean>
</beans>
```
프로퍼티 지정시, 역시 리플렉션을 활용, set{PropertyName}() 을 이용하여 값을 설정한다. 
- 스프링의 property 태그는 자바빈 규약에 따른다. 

### 자바코드를 이용한 DI 설정
org.stringframework.annotation.AnnotationConfigApplicationContext
빈컨테이너 사용

#### @Configuration
클래스를 스프링 설정으로 사용함을 의미

#### @Bean
메서드의 리턴값을 빈 객체로 사용함을 의미

#### example

```java
@configuration
public class Config {
  @Bean
  public User user1() {
    return new User("nolleh");
  }
}
```
요렇게 선언하고

```java
AnnotationConfigApplicationContext ctx =
  new AnnotationConfigApplicationContext(Config.class);

User user1 = ctx.getBean("user1", User.class);
```
요렇게 쓴다.  
생성자나 프로퍼티 값 설정시 직접 호출하면 된다. 

set{프로퍼티}(..);


**끝**