# ItBook 프로젝트

## 화면 목록
|검색|상세|
|:--:|:--:|
|<img width="200" alt="검색" src="https://github.com/shapiro711/ItBookDaangn/assets/57553889/200e9336-67b2-4f7a-bd0b-8e22b7a38ec7">|<img width="200" alt="상세" src="https://github.com/shapiro711/ItBookDaangn/assets/57553889/5a330894-41b3-4b73-8b1d-cfbb470a2e99">|

&nbsp;   

## 프로젝트 구성
- ImageCache: 이미지 캐시, 다운로드 
- Networking: 네트워크 처리
- Scene: 검색, 상세 화면
- Utility: 유틸리티, 확장 모음

&nbsp;   

## 네트워크 구성
### 1. Repository
- 추상화된 Service 의존
- Service간 로직이 있다면 수행
- Data Decoding, Encoding 로직 수행
- Paginationable 하다면 페이지 로직 수행

### 2. Service
- 추상화된 SessionManager 의존
- 네트워킹 관련 후처리 로직 진행

### 3.SessionManager
- URLSession을 래핑한 객체
- 실제 통신 진행

&nbsp;   

## 뷰 구성
- DIContainer: 외부 의존성을 주입받고 구현체들을 생성 및 주입
- MVC 패턴 사용

&nbsp;  

## 테스트 구성
- 네트워킹에 관련된 UnitTest 수행
- TestDIContainer를 이용하여 Mock 의존성 주입
