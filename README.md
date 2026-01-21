# ReactorGraphy

### 📌 Project Overview

Prography 과제를 UIKit + ReactorKit으로 구현한 사이드 프로젝트.  
CollectionView, UIKit, 무한 스크롤, 상태 관리, 아키텍처 분리 ReactorKit에 대한 연습 프로젝트.  

* 총 3개의 화면 구현
  * Home
  * Random Photo
  * Detail
* UICollectionView 기반 이미지 리스트
* Pagination을 이용한 무한 스크롤 구현
* ReactorKit을 활용한 단방향 데이터 흐름 적용  

---  

### 🛠 Tech Stack

Language: Swift  
UI Framework: UIKit  
Architecture: Clean Architecture  
State Management: ReactorKit, RxSwift, RxCocoa  
Image: Kingfisher  
Layout: SnapKit  

---  

### ✨ Features

* Home / Random Photo / Detail 화면 구성  
* UICompositionalLayout 기반 Carousel 구현
* 복잡한 CollectionView 구현
  * 섹션별 레이아웃 분리
  * 스크롤 방향이 다른 섹션 혼합 구성
    * UICollectionView 내부에 가변 Width / 가변 Height 섹션 처리
      * 가변 Width 처리
        * 셀 내부에 UICollectionView를 한 번 더 중첩
        * 내부 컬렉션뷰에 FlowLayout 적용
        * 콘텐츠 크기에 따라 동적으로 가로 스크롤 레이아웃 구성
      * 가변 Height (Waterfall Layout) 처리
        * UICollectionViewLayout을 직접 구현
        * 각 아이템의 height를 계산하여 가장 짧은 컬럼에 배치 (waterfall 원리)
        * Pinterest 스타일의 Waterfall 레이아웃 구성
* Pagination 기반 무한 스크롤
  * Waterfall Layout과 Pagination을 함께 적용
  * 스크롤 하단 도달 시 다음 페이지 로딩
* Kingfisher 기반 이미지 로딩 및 캐싱
* ReactorKit 기반 상태 관리 및 이벤트 처리  

---  

### 🏗 Architecture  

Clean Architecture 구조를 기반으로 계층 분리  
* Presentation  
  * ViewController
  * Reactor
* Domain
  * UseCase
  * RepositoryProtocol
  * Entity Model
* Data
  * Repository
  * APIService

---   

### 🔄 ReactorKit  

ReactorKit의 단방향 데이터 흐름을 적용.  
```  
View → Action → Mutation → State → View
```   

- View는 Action만 전달  
- 비즈니스 로직은 Reactor에서 처리  
- 상태 변경은 State를 통해서만 반영  

---  

### 📝 What I Learned  

UICollectionView와 UIKit 조합의 유연함과 확장성을 경험  
Pagination 및 셀 재사용 구조에 대한 이해도 향상  
ReactorKit 기반 단방향 아키텍처 설계 경험  
UIKit 환경에서 Clean Architecture를 적용하는 흐름 정리  