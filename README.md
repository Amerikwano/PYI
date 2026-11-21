# PYI — Protect Your Inner-self

A responsive, single-page Korean self-care journal PWA for Android and Windows.

## Current behavior
- Monthly calendar and daily records
- Mounjaro injection checkbox/dose and side-effect notes (no redundant manual medication-name/dose field)
- Meal notes for breakfast/lunch/dinner/snacks, optional photos
- Mood scale and free-form journal
- Editable small to-do list
- Selectable/custom daily influence factors
- Local browser storage works without an account

## Enable private cross-device cloud sync
This starter includes Supabase Auth, database and private photo-storage integration. It does **not** sync online until you connect your own Supabase project.

1. Create a Supabase project.
2. In SQL Editor, run `supabase-setup.sql`.
3. In Authentication > Providers, enable Email. Configure email confirmation as desired.
4. In Project Settings > API, copy the Project URL and anon/public key.
5. In `index.html`, replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY` with those values. Never put a `service_role` key in the browser.
6. Host this folder on an HTTPS static host. Then open the URL on Android and Windows and sign in with the same account.

The SQL enables row-level security so each signed-in user can access only their own daily entries and photos. Keep the project private; use a strong unique password and enable MFA if available. This is a personal journaling tool, not a medical device. Do not rely on it as the only copy of important health information; export/backup functionality should be added before long-term use.

## Run locally
Serve this folder from localhost (service workers require HTTPS or localhost). For example:

```bash
python -m http.server 8000
```

Then visit http://localhost:8000.
