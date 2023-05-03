<div align="center">
  <image alt="Main logo" height=256 src="assets/shady_app_icon.png"/>
  <h1>ShadyAI</h1>

  <sub>My take to get privacy friendly, offline AI models accessible to as many people as possible. The cutting edge offline AI models such as [Segment Anything](https://ai.facebook.com/research/publications/segment-anything/), [LLaMA](https://github.com/facebookresearch/llama) and [Whisper](https://github.com/openai/whisper) have been optimised by many other developers in various forms and sizes. The small to medium sizes are the ones I'm interested in.</sub>
</div>

## Getting Started

Unlike the majority of frontends for AI models, this project aims to be easier than even those with 1-click installers to launch a web app.

### Web version

Visit [shady.ai](https://shady.ai) (experimental!). This web-app gets freshly built and deployed every night at 00:00 UTC, as seen on the [deployments page](https://github.com/BrutalCoding/shady.ai/deployments?environment=github-pages#activity-log).

### Other platforms

No builds are available yet. However, let me show you a snapshot of what I'm trying to push out as the first prototype. It's not pretty (yet!), but function over form because I'd like to get the last 2 letters of __ShadyAI__ to be true first.

__Dev snapshot of macOS - 3 May 2023__

<image alt="Snapshot of ShadyAI for MacOS" height="384" width="auto" src="https://user-images.githubusercontent.com/5500332/235390984-5c69a7bf-ed95-47f7-897d-830a19590d30.png"/>

### DIY

#### You've got the source code, here's how you can build it yourself

1. Install Flutter and make sure you can run their example app (counter app).
2. Install FVM (Flutter Version Manager) and make sure you can run it (e.g. `fvm --version` outputs 2.4.1 at the time of this writing).
3. Open your terminal, navigate to the root of this project (e.g. `cd ~/my-favorite-projects/shady.ai`)
4. Navigate to the frontend: `cd shady_ai_flutter`
5. Install the same Flutter version: `fvm install`
4. Finally, run the app with: `flutter run` (if multiple platforms are detected, e.g. MacOS and your phone, you'll be prompted to pick 1 device)

## Benchmark

My dad, the retired butcher in his mid-70s, is going to be the benchmark.

If dad the retired butcher can install ShadyAI and interact with AI, it's a pass. Otherwise there's room for improvements to be made.

Stats: mid-70s. Great memory. Always forgets my date of birth, yet somehow remembers details about his customers from 30 years ago. Has a great sense of humour.

That's him 👇

<img alt="Shady's Daddy" src="shady_ai_flutter/assets/dad_the_benchmark.png" height=256>

## Goal

The goal is to have a "normal" app for all platforms, including Windows, Mac, Linux, iOS, Android and Web. Should be as simple as downloading the app and running it. No need to install Python, download models, install dependencies, etc.

The web version will be powered by [Serverpod](https://github.com/serverpod/serverpod) as the backend. A experimental web version is available on [shady.ai](https://shady.ai). No guarantees on the ease of use, but I'll try my best. It's going to be a bumpier ride than the other frontends, but I'm up for the challenge.

## Roadmap

_Planned release dates are estimates and subject to change._

__April 2023 - No Talk, Just Code__

- [x] Mac app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)
- [ ] iOS app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)

- [ ] Android app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)
- [x] Setup various CI/CD pipelines
- [x] Update documentation to include instructions on how to build the apps from source or ~~download the prebuilt apps from GitHub releases~~.

<sup>End of April update from @BrutalCoding: April's missed goals are now May's goals.</sup>

__May 2023 - Whisper Quiet__

- [ ] iOS app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)
- [ ] Android app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)
- [ ] Add whisper.cc support in at least one of the platforms. This allows you to transcribe audio to text powered by [whisper.cc](https://github.com/ggerganov/whisper.cpp)

__June 2023 - Mask On__

- [ ] Start Fastlane integration for iOS and Android, this is a pre-requisite step so that I can start automating releases to targets like: [ShadyAI's GitHub Releases](https://github.com/BrutalCoding/shady.ai/releases), Google Play Store, Apple App Store, etc.
- [ ] Windows app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)
- [ ] Start with the tedious tasks such as new assets (e.g. icons, images), splash screen, configure dev/staging/prod environments, bug fixes, auto-updater, support for different sizes etc.

__July 2023 - Real Shady__

- [ ] Start working on Flutter web app & Dart web server powered by [Serverpod](https://github.com/serverpod/serverpod)
- [ ] Prototyping with state of the art models in the audio sector. I've seen open source code to try it out, however, I'd like to get rid of the developer experience. That's the challenge for me. Would be nice to generate Lo-Fi music, or even better, generate music based on your voice, on your devices, without internet connection.

### Taken away from roadmap

These are the things I've decided to take away from the roadmap. I'd still like to do them, but they're not a priority. This could be due to missing my own deadlines on certain items of my roadmap, or simply because I've decided to focus on other ShadyAI goals.

- [ ] ~~My 2nd attempt to port [ONNX Runtime](https://github.com/microsoft/onnxruntime) over to [Dart](https://dart.dev/). This should save a lot of time and effort to run [Segment Anything](https://ai.facebook.com/research/publications/segment-anything/) and generally helps to use models independent of the model's original ML platform (e.g. PyTorch, TensorFlow, etc).~~
- [ ] ~~Trying out WASM for Flutter web (experimental)~~
- [ ] ~~Publish [ONNX Runtime](https://github.com/microsoft/onnxruntime) for [Dart](https://dart.dev/) to [pub.dev](https://pub.dev/) so that it can be used by other developers. Using ffigen to generate the bindings.~~

## Tech Stack

- [Flutter](https://flutter.dev/) - Frontend (in Dart)
- [Serverpod](https://serverpod.dev/) - Backend (in Dart)
- [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp) - Allows me to run one of BlinkDL's models on the CPU, fast inference.
- [Design System](https://m3.material.io/) - Design system made by Google. Helps me to get a consisting theme throughout the app in less effort than doing it all myself.
Once finished implementing the roadmap items ([see roadmap](#roadmap)), I'll start moving away to the following available Flutter UI kits:
-- Android: No changes required, Android's theme is Material.
-- iOS: [Flutter's Cupertino](https://flutter.dev/docs/development/ui/widgets/cupertino)
-- Windows: [pub.dev/fluent_ui](https://pub.dev/packages/fluent_ui)
-- macOS: [pub.dev/macos_ui](https://pub.dev/packages/macos_ui)
- And many more...

## FAQ

Q: Why the name Shady.ai?

A: Because it's shady. It's shady because it's not using the internet. Wait, that doesn't make any sense. I'll think of something better.

## Disclaimer

This project is not affiliated with Facebook, OpenAI or any other company. This is a personal project made by a hobbyist.

## License

See the [LICENSE](LICENSE) file.

## Contributing

Feel free to open an issue or a pull request. I'm open to any suggestions.

## App Preview

![shadyai_eval_ok](https://user-images.githubusercontent.com/5500332/234497371-eeb5be33-f884-4a90-b977-0d5f162641da.gif)
