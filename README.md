<div align="center">
  <image alt="Main logo" height=256 src="assets/shady_app_icon.png"/>
  <h1>ShadyAI</h1>

  <sub>My take to get privacy friendly, offline AI models accessible to as many people as possible. The cutting edge offline AI models such as [Segment Anything](https://ai.facebook.com/research/publications/segment-anything/), [LLaMA](https://github.com/facebookresearch/llama) and [Whisper](https://github.com/openai/whisper) have been optimised by many other developers in various forms and sizes. The small to medium sizes are the ones I'm interested in.</sub>
</div>

## Intro

ShadyAI can be seen as a storefront with curated AI models.

No internet connection required. No need to install Python, download models, install dependencies, etc.

Offline first. Privacy first. Open source. Free. No ads. No tracking. No data collection. No registration. No subscription. No in-app purchases.

## Sponsors

- My empty wallet
- My free time (I'm a full-time dad, full-time employee, and part-time seeker of getting my work-life balance right)

## Features

Anything that's checked is implemented.
Otherwise, it's on my list of things-to-tinker-around-with but does not guarantee it will become a feature.

- [x] Ask AI a single question.
(Example: "What is the meaning of life?")
- [ ] Ask AI generate an image based on a short description.
(Example: "A cat with a hat")
- [ ] On-going chat conversation with AI.
(Like talking to a friend, with a twist)
- [ ] Translate text to another language.
- [ ] Copy anyone's voice and say anything you want.

If you want to see a feature implemented, please open an issue.

## Verified Devices

Here is a list of devices I've tested ShadyAI on. This is not an exhaustive list, your device should work too. If that's not the case, please let me know by opening an issue.

- MacBook Pro (16-inch, 2021).
  - macOS Ventura - Version 13.5.1
  - Chip: Apple M1 Pro
  - Memory: 16 GB
  - **Last verified: 9 September 2023**

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

**About my dad**
He's in his mid 70s. Great memory. Always forgets my date of birth, yet somehow remembers details about his customers from 30 years ago. Has a great sense of humour. Oh wait a minute, his memory is not that great after all. Still, he's a great dad.

Say hi to my dad:

<img alt="Shady's Daddy" src="shady_ai_flutter/assets/dad_the_benchmark.png" height=256>

## Tech Stack

- [Flutter](https://flutter.dev/) - Frontend (in Dart)
- [Serverpod](https://serverpod.dev/) - Backend (in Dart)
- [llama.cpp](https://github.com/saharNooby/rwkv.cpp) - Allows me to run one of BlinkDL's models on the CPU, fast inference.
- [Design System](https://m3.material.io/) - Design system made by Google. Helps me to get a consisting theme throughout the app in less effort than doing it all myself.
Once finished implementing the roadmap items ([see roadmap](#roadmap)), I'll start moving away to the following available Flutter UI kits:
-- Android: No changes required, Android's theme is Material.
-- iOS: [Flutter's Cupertino](https://flutter.dev/docs/development/ui/widgets/cupertino)
-- Windows: [pub.dev/fluent_ui](https://pub.dev/packages/fluent_ui)
-- macOS: [pub.dev/macos_ui](https://pub.dev/packages/macos_ui)
- And many more...

## FAQ

Q: What is so shady about it?
A: Who knows? Maybe it's the AI that's shady. Maybe it's me. Or is it you? Maybe there's nothing shady about it. Maybe it's just a name that I like. Subscribing to the newsletter will give you a hint (or not). If I had one, that is.

## Disclaimer

This project is not affiliated with Facebook, OpenAI or any other company. This is a personal project made by me. ShadyAI, myself, and anyone else involved in this project are not responsible for any damages caused by the use of this app.

## License

See the [LICENSE](LICENSE) file.

## Contributing

Feel free to open an issue or a pull request. I'm open to any suggestions.

## Friends of ShadyAI

- [Flutter Perth](https://www.meetup.com/Flutter-Perth/) - A meetup group for Flutter developers in Perth, Western Australia. (I'm the organiser)

## Previews

![shadyai_eval_ok](https://user-images.githubusercontent.com/5500332/234497371-eeb5be33-f884-4a90-b977-0d5f162641da.gif)
