<div align="center">
  <image alt="Main logo" height=256 src="assets/shady_app_icon.png"/>
  <h1>ShadyAI</h1>

  <sub>My take to get privacy friendly, offline AI models accessible to as many people as possible. The cutting edge offline AI models such as [Segment Anything](https://ai.facebook.com/research/publications/segment-anything/), [LLaMA](https://github.com/facebookresearch/llama) and [Whisper](https://github.com/openai/whisper) have been optimised by many other developers in various forms and sizes. The small to medium sizes are the ones I'm interested in.</sub>
</div>

## Getting Started

Unlike the majority of frontends for AI models, this project aims to be easier than even those with 1-click installers to launch a web app.

### Website

Visit [shady.ai](https://shady.ai) (experimental!). This web-app gets freshly built and deployed every night at 00:00 UTC, as seen on the [deployments page](https://github.com/BrutalCoding/shady.ai/deployments?environment=github-pages#activity-log).

### Other platforms

No builds are available yet.

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

April 2023 - No Talk, Just Code

- [x] Mac app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)
- [ ] iOS app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)
- [ ] Android app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)
- [ ] Windows app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp)
- [x] Setup various CI/CD pipelines
- [x] Update documentation to include instructions on how to build the apps from source or download the prebuilt apps from GitHub releases.

May 2023 - Whisper Quiet

- [ ] Update apps to support [whisper.cc](https://github.com/ggerganov/whisper.cpp)
- [ ] Start working on Flutter web app & Dart web server powered by [Serverpod](https://github.com/serverpod/serverpod)
- [ ] Start with the tedious tasks such as new assets (e.g. icons, images), splash screen, configure dev/staging/prod environments, bug fixes, auto-updater, support for different sizes etc.

June 2023 - Mask On

- [ ] My 2nd attempt to port [ONNX Runtime](https://github.com/microsoft/onnxruntime) over to [Dart](https://dart.dev/). This should save a lot of time and effort to run [Segment Anything](https://ai.facebook.com/research/publications/segment-anything/) and generally helps to use models independent of the model's original ML platform (e.g. PyTorch, TensorFlow, etc).
- [ ] Publish [ONNX Runtime](https://github.com/microsoft/onnxruntime) for [Dart](https://dart.dev/) to [pub.dev](https://pub.dev/) so that it can be used by other developers. Using ffigen to generate the bindings.

July 2023 - Real Shady

- [ ] Reearching state of the art models in the audio sector.
- [ ] Prototyping with voice synthesis and music generation.
- [ ] Trying out WASM for Flutter web (experimental)

*Stretch goal. 7B is the size of the model, which might be too big for Android for a good user experience. Quantized smaller models tend to be completely broken. There's lots of developments in the field of quantization, which I'm keeping an eye on.

## Tech Stack

- [Flutter](https://flutter.dev/) - Frontend (in Dart)
- [Serverpod](https://serverpod.dev/) - Backend (in Dart)
- [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp) - Allows me to run one of BlinkDL's models on the CPU, fast inference.
- [Design System](https://m3.material.io/) - Design system made by Google for their own apps. I will use their Figma template and their theme builder generator (official Flutter support)
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
