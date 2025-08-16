# Notion Clone (Flutter)

이 프로젝트는 Flutter와 Supabase를 사용하여 인기 생산성 앱인 Notion의 핵심 기능을 클론하는 것을 목표로 합니다.

## ✨ 주요 기능 (MVP)

-   **사용자 인증:**
    -   이메일, Google, 패스키를 이용한 로그인 및 회원가입
-   **페이지 관리:**
    -   새 페이지 생성, 조회, 수정, 삭제
    -   계층 구조를 가진 사이드바 메뉴
-   **블록 기반 에디터:**
    -   기본 텍스트, 헤딩, 체크리스트 블록 추가 및 편집

## 🛠️ 기술 스택

-   **프레임워크:** Flutter
-   **백엔드 & 데이터베이스:** Supabase
-   **상태 관리:** Provider
-   **라우팅:** go_router
-   **환경 변수 관리:** flutter_dotenv

## 🚀 시작하기

1.  **저장소 복제:**
    ```bash
    git clone [저장소 URL]
    cd notion_clone
    ```

2.  **`.env` 파일 생성:**
    프로젝트 최상위 폴더에 `.env` 파일을 생성하고 Supabase API 정보를 입력합니다.
    ```
    SUPABASE_URL=YOUR_SUPABASE_URL
    SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
    ```

3.  **의존성 설치:**
    ```bash
    flutter pub get
    ```

4.  **앱 실행:**
    ```bash
    flutter run
    ```