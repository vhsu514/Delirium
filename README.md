# Delirium

An iPhone app that helps a family follow simple steps and keep notes for
nurses while a relative is in hospital.

- Spec: [docs/PLAN.md](docs/PLAN.md)
- Rules for contributors: [CLAUDE.md](CLAUDE.md)

## Run it

Open `Delirium.xcodeproj` in Xcode 26 or later, pick the iPhone 17 simulator
and press Run. To run the tests from a terminal:

```bash
xcodebuild test -project Delirium.xcodeproj -scheme Delirium -destination 'platform=iOS Simulator,name=iPhone 17'
```
