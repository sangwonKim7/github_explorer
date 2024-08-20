# GitHub Explorer
*설계내용은 `설계문서.md` 참조

## 개요
GitHub API를 사용하여 GitHub 사용자 목록을 표시하고, 상세 화면으로 이동시에 각 사용자의 저장소를 보여줍니다. 
- 깃허브에서 제공하는 API를 활용한 통신, MVVM구조, 스크롤컨트롤러를 통한 페이지네이션, 10번째마다 광고 배너, 다크 모드 등이 포함되어 있습니다.

## 기능
- GitHub 사용자 목록을 스크롤링+페이지네이션 방식으로 표시
- MVVM 구조: Riverpod, Dio 사용
- go_router을 사용한 라우팅 처리
- 사용자 아바타 사진 및 사용자명을 표시 (홈화면)
- 10번째마다 광고 배너 표시
- 선택한 사용자의 저장소를 상세 화면에서 표시 (상세화면)
- 다크 모드 기능
- 폰트 크기 고정 기능

## 프로젝트 구조
```
lib/
│
├── main.dart           # 앱 진입점
├── core/
│   ├── network/        # 네트워크 관련 코드 (Dio 설정)
│   └── theme/          # 테마 관리 코드 (Dark Mode)
│   ├── utils/          # 공통 유틸리티
├── models/
│   ├── github_user.dart  # GitHub 사용자 모델
│   └── github_repo.dart  # GitHub 레포 모델
├── providers/
│   └── theme_provider.dart  # 테마 상태관리 프로바이더
├── routers/
│   └── app_router.dart      # 라우팅 처리
├── services/
│   └── github_service.dart  # GitHub API와의 통신 서비스
├── viewmodels/
│   └── repo_viewmodel.dart  # 저장소 목록 및 상태 관리
│   ├── user_viewmodel.dart  # 사용자 목록 및 상태 관리
└── views/
    ├── home_screen.dart      # 홈 화면
    ├── detail_screen.dart    # 상세 화면
    └── widgets/
        └── ad_banner.dart       # 광고 배너 위젯
        └── border_widget.dart   # 보더 위젯
        └── error_widget.dart    # 에러 위젯
```

## 패키지
```
dependencies:
   go_router: ^14.2.3
   gap: ^3.0.1
   flutter_riverpod: ^2.5.1
   dio: ^5.6.0
   logger: ^2.4.0
   cached_network_image: ^3.4.1
   url_launcher: ^6.3.0

dev_dependencies:
   custom_lint: ^0.6.4
   riverpod_lint: ^2.3.10
   integration_test:
      sdk: flutter
```

## 설정

### 버전
- Flutter: 3.22.2
- Dart: 3.4.3
- Xcode: 15.4

### 설치 방법
1. 레포지토리 클론:
   ```
   git clone https://github.com/sangwonKim7/github_user_explorer.git
2. 프로젝트 재설정:
   ```
   flutter clean
   flutter pub get
   cd ios
   rm -rf Podfile.lock
   pod install
   cd ..
3. 프로젝트 실행: 
   ```
   flutter run
   ```
   *광고배너 이미지가 에러나는 경우 아래 명령어로 실행
   ```
   flutter run --no-enable-impeller

### 기타
- Line Length: 120 사용
