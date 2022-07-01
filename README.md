# 네이버 영화 검색 APP

### 개발 환경
![](https://img.shields.io/badge/Xcode-13.3-blue) ![](https://img.shields.io/badge/Swift-5.6-orange) ![](https://img.shields.io/badge/RxSwift-6.5.0-red) ![](https://img.shields.io/badge/SPM-0.6.0-red)

### 디렉토리 구조
```
└── NaverMovieSearch
    ├── Application
    ├── Resources
    ├── Extension
    ├── Utility
    ├── Presentation
    │   ├── Coordinator
    │   │   └── Protocol
    │   └── Scene
    │       ├── Common
    │       │   └── View
    │       ├── MovieSearchList
    │       │   ├── ViewModel
    │       │   └── View
    │       ├── Detail
    │       │   ├── ViewModel
    │       │   └── View
    │       └── Favorites
    │           ├── ViewModel
    │           └── View
    ├── Domain
    │   ├── UseCase
    │   ├── Entity
    │   │   └── CoreData
    │   └── Interfase
    │       ├── Repository
    │       └── MovieSearchList
    └── Data
        ├── Repository
        ├── Network
        │   ├── API
        │   └── HTTP
        │       └── Error
        └── NetworkDTO
```

### 구동 화면
|검색 화면|상세 화면|즐겨찾기 화면|
|---|---|---|
|![Simulator Screen Recording - iPhone 13 - 2022-06-15 at 01 13 34](https://user-images.githubusercontent.com/98801129/173625686-5a0ea7bf-530c-4a14-ba3c-b1c57906edd1.gif)|![](https://i.imgur.com/NOcB9zI.gif)|![](https://i.imgur.com/C1FCbHq.gif)

### 주요 기능
+ MVVM+C + CleanArchitecture를 적용하여 객체별 역할을 명확히 하였습니다.
+ 영화 검색시 텍스트 필드의 값이 변하는 과정마다 영화 리스트를 출력했습니다.
+ 코어 데이터를 활용하여 즐겨찾기 목록을 구현하였습니다.
+ 화면 전환과 의존성 주입을 위한 Coordinator 패턴을 적용하였습니다.
