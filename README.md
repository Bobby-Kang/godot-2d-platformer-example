# Godot 2D Platformer Example

Godot 4 기반의 2D 플랫포머 예제 프로젝트입니다.

## 기술 스택

- **엔진**: Godot 4.6.2 stable
- **렌더러**: Mobile (D3D12)
- **물리**: Jolt Physics

## 프로젝트 구조

```
├── main.tscn          # 메인 씬 (배경 + 바닥 + 플레이어 배치)
├── scenes/
│   └── Player.tscn    # 플레이어 씬 (CharacterBody2D)
├── scripts/
│   └── player.gd      # 플레이어 이동 스크립트
└── icon.svg           # 플레이어 스프라이트 (임시)
```

## 조작법

| 키 | 동작 |
|---|---|
| `←` / `→` | 좌우 이동 |
| `Space` / `Enter` | 점프 |

## 실행 방법

1. [Godot 4.6](https://godotengine.org/) 설치
2. 프로젝트 폴더를 Godot 에디터에서 열기
3. `F5` 로 실행

## 플레이어 스펙

- 이동 속도: 200
- 점프력: 400
- 중력: Godot 기본값
