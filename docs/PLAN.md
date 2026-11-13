# Family delirium app: build spec for Claude Code

Save this file in the repository as `docs/PLAN.md`. It is the source of truth for the build. If a later instruction conflicts with the section "Hard rules", stop and ask before going on.

## 1. What we are building

A native iPhone app that coaches a family through proven delirium prevention steps while a relative is in hospital. The family member is the user. The patient never has to touch the phone.

- Platform: iPhone only. Swift and SwiftUI. Support the newest iOS version and the one before it.
- No hospital contract, no hardware, no account, no server that we run.
- One stay lasts about 3 to 10 days. The app must be useful within two minutes of first opening.
- Languages: English and Spanish from the first build.

Who the user is: a tired, worried person aged 50 to 80, standing at a hospital bed, often with one free hand and a weak phone signal.

## 2. Hard rules

These apply to every screen, string and commit.

1. The app never says or implies that a patient has delirium. It reports what the family saw and tells them to show the nurse.
2. The app gives no advice about drugs, doses, or stopping or starting any treatment.
3. The app makes no claim that it prevents, treats or detects delirium. Store text and in-app text say it helps families follow steps and keep notes for nurses.
4. Every prevention step and help card must cite a study from section 3. Do not invent steps.
5. No AI-generated answers inside the app in version 1. All content is fixed and reviewed.
6. All data stays on the device, except the small shared set in section 7.
7. No analytics kits, no ad kits, no third-party tracking. No sign-up.
8. The validated family delirium check is copyrighted. Do not copy its wording. Use placeholders until approved wording is supplied.
9. Never play audio at night. Never send a reminder at night.
10. If unsure whether something breaks a rule, stop and ask.

## 3. Features and the evidence behind them

| # | Feature | What the family does | Evidence |
|---|---|---|---|
| 1 | Daily plan built on six risk factors | Steps for thinking, sleep, movement, sight, hearing, fluids | Inouye 1999, 852 patients aged 70+: delirium in 9.9% with the program, 15.0% without |
| 2 | Several steps together | Does the whole set each day | Hshieh 2015, 14 studies, 4,267 patients: 53% fewer cases, 62% fewer falls |
| 3 | Family does the steps | Stays with the patient, brings a clock, calendar, familiar objects, glasses and hearing aids, talks about the day | Martinez 2012, 287 patients: delirium in 5.6% with family, 13.3% without |
| 4 | Family taught the steps | Short lessons, then action | Family-involved program, 281 surgery patients: 2.6% with the program, 19.4% without |
| 5 | Recorded family voice messages | Records short orienting messages, played hourly in the daytime | Munro 2025, 178 ventilated ICU patients: more days without delirium, and more plays gave more such days |
| 6 | Night sleep protection | Earplugs, eye mask, dim lights, ask for quiet hours | Litton 2016, 5 studies, 832 ICU patients: 41% lower risk, high risk of bias. A 2025 review was mixed. Present as a sleep aid only. |
| 7 | Sight, hearing and teeth check | Glasses, hearing aids and dentures in each morning | Part of Inouye 1999 and Martinez 2012 |
| 8 | One-minute daily check | Notes sudden change, attention and thinking | Zhou 2023, 7 studies, 483 pairs: family check caught 74% of cases and correctly cleared 91% of patients without it. Most misses were families not spotting poor attention. |

Things the evidence says to avoid:

- Do not claim music prevents delirium. A 2025 trial of prescribed slow music found no benefit. The app may play the patient's own music for comfort, with no health claim.
- Do not promise results from earplugs or eye masks.
- Do not claim voice messages work outside intensive care.

## 4. Design rules

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

## 5. Screens

**Home.** Six large buttons: Today, Check, Voices, Family, Nurse page, Help.

**First open.** Three questions only:
- The patient's first name.
- Whether they use glasses, hearing aids or dentures.
- Their usual sleep and wake times.

**Today.**
- The day's steps from the content library, grouped into morning, afternoon and night.
- One tap marks a step done. One tap undoes it.
- Steps for glasses, hearing aids and dentures appear only if the patient uses them.
- Local reminders at three daytime moments. The user can turn them off.

**Check.**
- A one-minute flow, one question per screen.
- Includes one short attention task the family tries with the patient, with a plain example of what poor attention looks like.
- Question text is a placeholder marked "waiting for approved wording".
- Two possible results only: "Nothing new to report today" or "You noticed a change. Show the nurse now."
- The second result opens the Nurse page.

**Voices.**
- Record up to ten messages, each up to two minutes.
- Script prompts: who I am, where you are, what day it is, what happens next, you are safe.
- A "Play through the day" switch plays one message each hour from 9 am to 7 pm.
- Shows the number of plays per day.
- Works with the screen locked, with headphones and with a speaker.

**Family.**
- Create a shared plan and send an invite link.
- Members see the same Today checklist and who ticked each step.

**Nurse page.**
- One screen to show staff. Top line: "Notes from the family. Not a medical assessment."
- Steps done today and yesterday.
- How the patient slept, in the family's words.
- The latest daily check answers, in the family's words.
- A button to share the page as a PDF.

**Help.**
- A searchable list of help cards from the content library. No chat. No AI.

## 6. Content library

File: `content/library.json`. One array of items.

```json
{
  "id": "sleep-eye-mask",
  "kind": "step",
  "title_en": "Offer an eye mask at bedtime",
  "body_en": "Ask if they would like an eye mask tonight. Take it off in the morning and open the blinds.",
  "title_es": "",
  "body_es": "",
  "time_of_day": "night",
  "risk_factor": "sleep",
  "requires": null,
  "source": "Litton 2016",
  "needs_clinician_review": true
}
```

- `kind`: `step` or `help`.
- `time_of_day`: `morning`, `afternoon`, `night` or `any`.
- `risk_factor`: `thinking`, `sleep`, `movement`, `sight`, `hearing`, `fluids` or `comfort`.
- `requires`: `glasses`, `hearing_aids`, `dentures` or null.
- `source`: must match a study named in section 3.
- Body text is 60 words or fewer.
- Start with 25 steps and 20 help cards. Mark all as needing clinician review.
- Movement and fluid steps must tell the family to ask the nurse first, because some patients have limits on walking or drinking.

Add a test that fails if any item has no source, an unknown source, or a body over 60 words.

## 7. Data and privacy

Stored on the device only:
- Patient first name and setup answers.
- Step completion by day.
- Daily check answers.
- Voice recordings.
- Sleep notes.

Shared through CloudKit sharing when the user turns on Family:
- Family members' first names.
- Step ticks and who made them.

Never shared or uploaded: voice recordings, daily check answers, sleep notes.

Other rules:
- Use SwiftData or Core Data for local storage.
- A "Delete everything" button in settings removes all local data and leaves the shared plan.
- The app works fully for one person with sharing off.

## 8. Build order

Build one stage at a time. After each stage: run all tests, build to a real device, and report what was built, what was tested and anything left open. Do not start the next stage until told.

| Stage | Build | Done when |
|---|---|---|
| 1 | Project, `CLAUDE.md` with the hard rules and design rules, home screen with six buttons and empty screens | App runs on a phone. Tests pass. |
| 2 | Content library with tests | 25 steps and 20 cards pass the content tests |
| 3 | First open and Today, with local storage and reminders | A full day can be planned and ticked in airplane mode |
| 4 | Nurse page with PDF share and the button on every screen | The page shows today and yesterday correctly |
| 5 | Check flow with placeholder wording | Both results work and are saved by day |
| 6 | Voices with recording and daytime schedule | A full day of hourly plays runs with the screen locked. Nothing plays after 7 pm. |
| 7 | Family sharing with CloudKit | Three phones show the same plan |
| 8 | Help screen, then a full pass for large text, VoiceOver, dark mode, Spanish and airplane mode | Every problem found is listed and fixed |
| 9 | Privacy page, App Store privacy answers, store text, TestFlight build | Build uploads without errors |

## 9. Testing

- Unit tests for all logic: step selection by time and setup answers, reminder times, voice schedule, check result, content rules.
- A test that scans all strings for banned phrases: "has delirium", "diagnos", "prevents delirium", "treats", and any drug name.
- UI tests for the first open flow and for ticking and undoing a step.
- Snapshot or manual checks at the largest Dynamic Type size on the smallest supported iPhone.

## 10. Out of scope for version 1

- Android.
- AI chat or generated answers.
- Any wearable or sensor data.
- Accounts, payments or subscriptions.
- Links to hospital record systems.
- Any content for patients under 18.

## 11. What the owner will supply

Ask for these when a stage needs them. Do not guess.

- Approved wording for the daily check.
- Clinician sign-off on each content item.
- Spanish review by a native speaker.
- Apple Developer account details and the app's bundle name.
- A lawyer's decision on whether the daily check can ship.
