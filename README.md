# Aju Util

Native **iOS** utility app for **Aracaju (Sergipe)** — emergency numbers, public services, health tips, offline coordinates and local tech shortcuts.

> Português: [README.pt-BR.md](README.pt-BR.md)

## Highlights

- Quick emergency chips + full emergency mode
- Search, categories, favorites, share, copy phone
- Health tips (offline, informational only)
- Map + offline coordinate mode
- JSON content on device

## CI / build

| Workflow | Purpose |
|----------|---------|
| `ci.yml` | Structure check (Ubuntu) |
| `ios-build.yml` | `swift build` on macOS; optional IPA job (disabled until Xcode project + signing secrets) |

See **[docs/IOS_BUILD.md](docs/IOS_BUILD.md)** for IPA requirements (Apple certs, provisioning, Team ID).

> Compiling in the cloud is not the same as installing on an iPhone without proper code signing.

## Stack

- SwiftUI · MapKit
- [swift-toolkit](https://github.com/RknDEV1/swift-toolkit)
- [swift-ui-kit](https://github.com/RknDEV1/swift-ui-kit)

## Run on a Mac

1. Create an iOS App (SwiftUI) in Xcode  
2. Add packages (branch `main`)  
3. Root: `HomeView()` / `AjuUtilEntry.rootView`  

## Disclaimer

Not affiliated with the City of Aracaju. Not medical advice. Verify official sources.

## License

MIT
