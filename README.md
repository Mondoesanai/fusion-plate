# Fusion Plate

Speak a craving — cultures, a format, even just a feeling — and Fusion Plate invents an original recipe on the spot: full ingredients, real quantities and oven temps, step-by-step instructions, an AI-generated picture of the plate, and voice-driven ingredient substitutions if you're missing something.

**Live app:** https://fusion-plate.vercel.app

## How it works

This is a single static page (`index.html`) — no backend, no build step.

- **Voice input** — the browser's built-in Web Speech API (`SpeechRecognition`). Works in Chrome and Edge; other browsers fall back to the text field automatically.
- **Recipe generation** — calls the Claude API (`claude-sonnet-5`) directly from your browser using your own Anthropic API key. Nothing passes through a server we run.
- **The picture** — generated for free, keylessly, via [Pollinations.ai](https://pollinations.ai)'s image endpoint, from a food-photography prompt Claude writes for its own dish.
- **Ingredient substitutions** — a second Claude call, seeded with the current recipe plus whatever you say/type you have or don't have.
- **Vegan mode** — a toggle that hard-constrains every generated recipe to 100% vegan ingredients.
- **Recent creations** — your last 16 dishes, saved to `localStorage` on your device.

### Bring your own API key

Click the key/gear icon (top right) and paste an Anthropic API key. Get one at [console.anthropic.com/settings/keys](https://console.anthropic.com/settings/keys). The key is saved only in your browser's `localStorage` — it is never sent anywhere except directly to Anthropic's API when you generate a recipe.

This keeps the app free to host (pure static file, no server, no secrets to manage) and means usage is billed to whoever's key is in the browser, at Anthropic's normal API rates (a recipe call is a few cents at most).

## Running locally

Double-click **START SERVER.bat**, then open `http://localhost:3000`.

(Or manually: `node local-server.mjs`.)

## Deploying

This repo auto-deploys to Vercel on every push to `main` — just `git push` and the live link updates in a minute or two. No environment variables are needed since the app is fully client-side.

## Known limitations / open items

- **Voice input needs Chrome or Edge** (or another browser with `SpeechRecognition` support). Safari and Firefox fall back to typing.
- **Images are best-effort.** Pollinations is a free, keyless image API — quality is good but not guaranteed, and it occasionally times out. If an image fails to load, a labeled placeholder shows instead.
- **Everyone needs their own Anthropic key.** There's no shared backend key — this was a deliberate choice to avoid standing up and paying for a server. If you'd rather have one shared key that you control (so friends/family don't need their own), that needs a small serverless proxy holding the key server-side — say the word and it can be added.
- **No login / no shared history** — "Recent creations" is per-browser, local only.
