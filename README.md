# ReactorGraphy

Prography 과제를 UIKit + ReactorKit으로 구현해 본 프로젝트.  

Home, Random Photo, Detail 총 3개의 페이지를 구현했고,  
UICollectionView와 무한 스크롤을 활용한 이미지 리스트를 구현함.  
ReactorKit을 활용한 단방향 데이터 흐름과 구조 설계를 연습해보았음.  

### Tech Stacks  
- Language: Swift 
- UI framework: UIKit  
- Architecture: Clean Architecture  
- State Management: ReactorKit, RxSwift, RxCocoa
- Image Loading: Kingfisher
- Layout: Snapkit

### Features

- Home
- RandomPhoto
- Detail
- 무한 스크롤(Pagination) 구현
- Kingfisher를 활용한 이미지 로딩 및 캐싱

### Architecture

- Presentation (ViewController, Reactor)
- Domain (UseCase, RepositoryProtocol, Entity Model)
- Data (Repository, APIService)

### ReactorKit

ReactorKit을 활용한 단방향 데이터 흐름 적용  

**View -> Action -> Mutation -> State -> View**  

---  

### 마무리...  

여러 어려운 UI들을 짜며 개인적으로는 collectionView와 UIKit을 조합했을 때의 강점을 알게 된 프로젝트.  
또한, ReactorKit이라는 좋은 단방향 아키텍처를 써보며 UIKit + ReactorKit 조합을 경험하며 더 친해지는 계기가 된 프로젝트.  
