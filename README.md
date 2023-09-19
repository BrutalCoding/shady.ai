<div align="center">
  <image alt="Main logo" height=256 src="https://raw.githubusercontent.com/BrutalCoding/shady.ai/main/shady_ai_flutter/assets/shady_app_icon.png"/>
  <h1>ShadyAI</h1>

  <sub>My take to get privacy friendly, offline AI models accessible to as many people as possible. Offline first. Privacy first. Open source. Free. **What happens in ShadyAI, stays in ShadyAI**. No ads. No tracking. No data collection. No registration. No subscription. No in-app purchases. No premium features. Nada. Nothing. That's it. Pure AI, pure intentions—that's the essence of this app.</sub>
</div>

## Intro

Ever noticed how AI tends to lurk in the shadows? With a sea of startups sporting cryptic names, ShadyAI playfully acknowledges AI's penchant for mystique. It's all a bit of light-hearted banter. In the contrary, behind this playful façade lies a genuine commitment to transparency and ethical AI practices. ShadyAI is fully open source, and is dedicated to bringing clarity, openness, and strong emphasis on privacy.

There are many cutting edge offline AI models, and I want to catch 'em all. Think of [Segment Anything](https://ai.facebook.com/research/publications/segment-anything/), [LLaMA](https://github.com/facebookresearch/llama) and [Whisper](https://github.com/openai/whisper). What do I mean by that? Well, I want to make it easy for anyone to use cutting edge AI advancements like these without the technical hurdles that come with it.

## Sponsors

- My empty wallet
- My free time (I'm a full-time dad, full-time employee, and part-time seeker of getting my work-life balance right)

## Progress

Here's a list of things I have done so far and things I'm working on.

- [x] Make a slide deck with Flutter (Bonus: [contribute back custom changes](https://github.com/serverpod/slick_slides/pull/1))
- [x] Generate Dart bindings for [llama.cpp](https://github.com/ggerganov/llama.cpp)
- [x] Generate .dylib for macOS (ARM64) (Bonus: with Metal artifact for GPU acceleration)
- [x] Successfully Load instance of LLaMA with dylib
- [x] Successfully load LLaMA model in GGUF format with default LLaMA context parameters
- [x] Successfully run inference on LLaMA model with custom prompt
  - [x] Refactor implementation because the model, after eval, is returning garbage tokens / pieces.
- [x] Make a quick start UI layout
  - [x] Step 1: Drag-and-drop a model
  - [x] Step 2: Select a pre-defined prompt template
  - [x] Step 3: Type in your instruction (user prompt)
  - [x] Step 4: Press continue in last step to start inference
  - [x] Step 5: Show inference result (dialog) (Bonus: show progress indicator)
- [ ] (In progress, nearly there) Create a cross-platform Flutter FFI plugin so you can power your own apps the same way ShadyAI does (but without the countless nights of frustation).
- [ ] Publish videos, blog posts, add preview images in README, and spread the word.
- [ ] Explore & tinker with tech hurdles: chat, image, voice, music, video

Tthere are many more steps, but I'm not going to list them all here, I'll update this list as I go.

## Features

Anything that's checked is implemented.
Otherwise, it's on my list of things-to-tinker-around-with but does not guarantee it will become a feature.

- [x] Ask AI a single question.
(Example: "What is the meaning of life?")
- [x] Give AI a single instruction.
(Example: "Write a Flutter widget with a button that says 'Hello World'")
- [x] Choose from pre-defined prompt templates.
- [x] Get started quickly by using the built-in tiny-but-mighty AI model.
(Note: It's the TinyStories model of < 100 MB, great at generating short stories. I'm keeping an eye on several ~1B models though)
- [ ] Ask AI generate an image based on a short description.
(Example: "A cat with a hat")
- [ ] On-going chat conversation with AI.
(Like talking to a friend, with a twist)
- [ ] Translate text to another language.
- [ ] Copy anyone's voice and say anything you want.
- [ ] Make music with AI.
- [ ] Make short videos with AI.

If you want to see a feature implemented, please open an issue.

## Verified Devices

Here is a list of devices I've tested ShadyAI on. This is not an exhaustive list, your device should work too. If that's not the case, please let me know by opening an issue.

- MacBook Pro (16-inch, 2021).
  - macOS Ventura - Version 13.5.1
  - Chip: Apple M1 Pro
  - Memory: 16 GB

### Experimental

ShadyAI might also work by just visiting [shady.ai](https://shady.ai). This is very experimental though, don't get too excited yet!

This website gets freshly baked from the oven every night at 00:00 UTC, as seen on this [deployments page](https://github.com/BrutalCoding/shady.ai/deployments?environment=github-pages#activity-log).

### DIY

#### Do it yourself. You've got the source code, here's how you can build it

1. Install Flutter and make sure you can run their example app (counter app).
2. Install FVM (Flutter Version Manager) and make sure you can run it (e.g. `fvm --version` outputs 2.4.1 at the time of this writing).
3. Open your terminal, navigate to the root of this project (e.g. `cd ~/my-favorite-projects/shady.ai`)
4. Navigate to the frontend: `cd shady_ai_flutter`
5. Install the same Flutter version: `fvm install`
6. Finally, run the app with: `flutter run` (if multiple platforms are detected, e.g. MacOS and your phone, you'll be prompted to pick 1 device)

## Benchmark

My dad, the retired butcher in his mid-70s, is going to be the benchmark.

In order for the benchmark to pass, this checklist must be completed.

**Checklist:**

- [ ] Tell dad to download the app.
- [ ] Ask him to have a conversation with the app. It's a pass if he's chatting with the AI for at least 5 minutes.
- [ ] Ask him to generate an image. It's a pass if he's able to generate an image, he's happy with the result, and he's able to share it with anyone.

**If it's not completed, it's a fail. If it's completed, it's a pass.**

**About my dad.**

He's in his mid 70s. Great memory. Always forgets my date of birth, yet somehow remembers details about his customers from 30 years ago. Has a great sense of humour. Oh wait a minute, his memory is not that great after all. Still, he's a great dad.

Say hi to my dad:

<img alt="Shady's Daddy" src="https://raw.githubusercontent.com/BrutalCoding/shady.ai/main/shady_ai_flutter/assets/dad_the_benchmark.png" height=256>

## Tech Stack

- [Flutter](https://flutter.dev/) - Frontend (in Dart)
- [llama.cpp](https://github.com/saharNooby/rwkv.cpp) - Allows me to run one of BlinkDL's models on the CPU, fast inference.
- [Design System](https://m3.material.io/) - Design system made by Google. Helps me to get a consisting theme throughout the app in less effort than doing it all myself.
- And many more...
- [Serverpod](https://serverpod.dev/) - Backend (in Dart). ShadyAI is currently not using any backend. But I'm planning to use Serverpod to make it easier later to run powerful models that you can deploy on your own server. I bet the folks at r/SelfHosted would love that. I know I would. Just imagine a single command line to run a Docker image that runs a powerful AI model (or multiple models) that you can access from anywhere. That's the dream. I'm not there yet, but I'm working on it.

## FAQ

Q: What is so shady about it?

A: Ironically, nothing at all. The name ShadyAI is a playful twist, hinting at the often-mysterious nature of AI. If using it makes you "shady," well, that'll be our little secret. Bottom line? What happens in ShadyAI stays in ShadyAI.

Q: What advice do you have for someone who wants to build something like this?

A: It starts with passion. Jumping on the bandwagon because something's "in vogue" won't sustain you in the long run. Trends are fleeting. Dive deep into the subject — in this instance, AI. Understand its capabilities and think critically about the real-world problems you're eager to tackle. For me, it's not just about talking up AI's potential; it's about demonstrating it, making it tangible and accessible to all. I use a simple benchmark: if my parents start using it voluntarily, I know I'm onto something. It's a journey, and while I'm not there yet, I'm committed to the path.

## Disclaimer

This project is not affiliated with Meta, OpenAI or any other company. This is a personal project made by me. ShadyAI, myself, and anyone else involved in this project are not responsible for any damages caused by the use of this app. Use at your own risk.

## License

See the [LICENSE](LICENSE) file.

## Contributing

Feel free to open an issue or a pull request. I'm open to any suggestions.

## Friends of ShadyAI

- [llama.dart](https://github.com/BrutalCoding/llama.dart) - Dart bindings for [llama.cpp](https://github.com/ggerganov/llama.cpp). Made by me.
- [llama.cpp](https://github.com/ggerganov/llama.cpp) - C++ library for building and running AI models locally.
- [Flutter Perth](https://www.meetup.com/Flutter-Perth/) - Perth's Flutter meetup group. I'm the organizer. Join my regular online meetups to learn more about Flutter and AI.
