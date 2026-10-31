# Aju Util

Native **iOS** utility app for **Aracaju** and Greater Aracaju — emergency numbers, public services, city info and local tech ecosystem shortcuts.

> Português: [README.pt-BR.md](README.pt-BR.md)

## Goal

Give residents a fast, offline-friendly way to find useful contacts and links without digging through scattered websites and chats.

## Features (MVP)

- Search across curated items
- Categories: Emergency, Government, Health, Education, City, Tech
- Call / open website actions
- Favorites (local storage)
- JSON-driven content (easy to expand)

## Stack

- SwiftUI
- [swift-toolkit](https://github.com/RknDEV1/swift-toolkit)
- [swift-ui-kit](https://github.com/RknDEV1/swift-ui-kit)

## Run in Xcode

1. Create a new **iOS App** (SwiftUI)
2. Add packages (branch `main`):
   - `https://github.com/RknDEV1/swift-toolkit.git`
   - `https://github.com/RknDEV1/swift-ui-kit.git`
   - this repo (or copy `Sources/AjuUtil`)
3. Set root view to `HomeView()` / `AjuUtilEntry.rootView`
4. Build & run on simulator or device

Phone calls only work on a real iPhone.

## Content

Items live in `Sources/AjuUtil/Resources/items.json`.  
Prefer **official** phones and URLs. Do not invent schedules or legal advice.

## License

MIT
