# πΆ μ΄λ°μν«-JSP/Servlet
>### λ°λ €λλ¬Ό μν νλ«νΌ μ΄λ°μν« ν΄λ‘  μ½λ©  
>JSP/Servletμ νμ©νμ¬ MVC ν¨ν΄μΌλ‘ κ΅¬νν νλ‘μ νΈ

</br>

## 1. μ μ κΈ°κ° & μ°Έμ¬ μΈμ
- 2021.05.26 ~ 2021.07.23
- 5μΈ ν νλ‘μ νΈ

</br>

## 2. μ¬μ© κΈ°μ 
#### `Back-end`
  - Java 8
  - JDBC (ojdbc6)
  - Oracle 11g

</br>

## 3. λ΄λΉ μ­ν 
|νμ|μ­ν |
|:--|:--|
|μν¬μ|νμ μλΉμ€|
|A(νμ₯)|ν«TV, ν«μ€μΏ¨ μμ μλΉμ€|
|B|ν«λ‘κ·Έ SNS μλΉμ€|
|C, D|ν«μ€ν μ΄ μ£Όλ¬Έκ²°μ  μλΉμ€|

</br>

## 4. κ΅¬ν κΈ°λ₯
κ΅¬ν κΈ°λ₯μ νμκ°μ, λ‘κ·ΈμΈ, λ§μ΄νμ΄μ§ μλλ€.

### 4.1. μ μ²΄ νλ¦
![image](https://user-images.githubusercontent.com/92259017/165451389-aaf88004-c69c-467c-9d74-cd1a017b393d.png)
  
### 4.2. μ¬μ©μ μμ²­
![image](https://user-images.githubusercontent.com/92259017/159844196-6b660383-8758-4458-922e-285627fb268b.png)
  
- **νμκ°μ μμ²­** :pushpin: [μ½λ νμΈ](https://github.com/heewonim131/about-pet-jsp/blob/d93040a9bb9486e90a175563f199abec047dfa21/WebContent/Project/aboutPet/join1.jsp#L714)
  - νμκ°μμ νμν μ λ³΄λ€μ λ΄μ POST νμμΌλ‘ μμ²­ν©λλ€.

### 4.3. Controller
![image](https://user-images.githubusercontent.com/92259017/159844366-1719e4b0-4eb0-4e3f-b18a-449f2955e361.png)
  
- **νμκ°μ μμ²­ μ²λ¦¬** :pushpin: [μ½λ νμΈ](https://github.com/heewonim131/about-pet-jsp/blob/d93040a9bb9486e90a175563f199abec047dfa21/src/project/aboutPet/mypage/command/SignUpHandler.java#L15)
  - νμκ°μ μμ²­μ μ²λ¦¬νκ³  κ²°κ³Όλ₯Ό νλ©΄λ¨μ μλ΅ν©λλ€.
  
### 4.4. Service
![image](https://user-images.githubusercontent.com/92259017/159844601-7b304b8f-0381-4be7-8215-34174df95093.png)

- **νμκ°μ μν** :pushpin: [μ½λ νμΈ](https://github.com/heewonim131/about-pet-jsp/blob/d93040a9bb9486e90a175563f199abec047dfa21/src/project/aboutPet/mypage/service/SignUpService.java#L22)
  - μ λ¬λ°μ νμ μ λ³΄λ‘ νμκ°μμ μνν©λλ€.
  
### 4.5. DAO
![image](https://user-images.githubusercontent.com/92259017/159845144-5d1cfb49-ed05-49b1-846d-7ba03a8a13f9.png)

- **νμ λ°μ΄ν° μ μ₯** :pushpin: [μ½λ νμΈ](https://github.com/heewonim131/about-pet-jsp/blob/d93040a9bb9486e90a175563f199abec047dfa21/src/project/aboutPet/mypage/dao/MyPageDAO.java#L35)
  - νμ λ°μ΄ν°λ₯Ό DBμ μ μ₯ν©λλ€.

</br>
