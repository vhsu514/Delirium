# Family delirium app

Native iPhone app (Swift, SwiftUI) that coaches a family through proven steps
while a relative is in hospital. The full spec is `docs/PLAN.md`. It is the
source of truth. Read it before any change.

## Hard rules

These apply to every screen, string and commit. If a later instruction
conflicts with them, stop and ask before going on.

1. The app never says or implies that a patient has delirium. It reports what the family saw and tells them to show the nurse.
2. The app gives no advice about drugs, doses, or stopping or starting any treatment.
3. The app makes no claim that it prevents, treats or detects delirium. Store text and in-app text say it helps families follow steps and keep notes for nurses.
4. Every prevention step and help card must cite a study from section 3 of the plan. Do not invent steps.
5. No AI-generated answers inside the app in version 1. All content is fixed and reviewed.
6. All data stays on the device, except the small shared set in section 7 of the plan.
7. No analytics kits, no ad kits, no third-party tracking. No sign-up.
8. The validated family delirium check is copyrighted. Do not copy its wording. Use placeholders until approved wording is supplied.
9. Never play audio at night. Never send a reminder at night.
10. If unsure whether something breaks a rule, stop and ask.

## Design rules

1. One task per screen. No more than six items on the home screen.
2. Every screen is one tap from home. No nested menus.
3. Buttons are at least 44 points tall with clear gaps between them. No small text links.
4. Body text is 17 points or larger and follows Dynamic Type up to the largest accessibility size without clipping.
5. Text contrast is at least 4.5 to 1 in light and dark mode.
6. Every control has a VoiceOver label. Every step can be read aloud.
7. Every tap gives visible feedback. Every action can be undone.
8. Sixth grade reading level. Say "sudden confusion" before using the word "delirium". Short sentences.
9. No streaks, scores, badges or guilt. A missed step shows as "still to do".
10. No typing where a tap or a voice recording will do.
11. Everything works in airplane mode.
12. Silent by default. Dark screen option for night use.
13. A "Show the nurse" button appears on every screen.
14. All user-facing text lives in a strings catalog with English and Spanish.

## How we work

- Build one stage at a time, in the order in section 8 of the plan. After each
  stage, run all tests and report what was built, what was tested and what is
  left open. Do not start the next stage until told.
- The owner supplies the items in section 11 of the plan. Ask. Do not guess.

## Project layout

- `Delirium.xcodeproj` — one app target and two test targets. Folders are
  synced with the file system, so new files in a folder join its target
  without editing the project file.
- `Delirium/` — app code, `Localizable.xcstrings`, assets.
- `DeliriumTests/` — unit tests (Swift Testing). They run inside the app.
- `DeliriumUITests/` — UI tests (XCTest).
- `docs/PLAN.md` — the spec.

## Conventions

- Every user-facing string is a key in `Delirium/Localizable.xcstrings` with
  English and Spanish values. No string literals in views.
- New strings must pass `StringsTests` (same keys in both languages, no banned
  phrases, no drug names).
- Find controls in UI tests by accessibility identifier, never by visible
  text, so tests pass in both languages.
- Minimum iOS is 26.0 (the newest version and the one before it).
- The bundle identifier and display name are placeholders until the owner
  supplies them.

## Build and test

Needs a Mac with Xcode 26 or later.

    xcodebuild test -project Delirium.xcodeproj -scheme Delirium \
      -destination 'platform=iOS Simulator,name=iPhone 17'
