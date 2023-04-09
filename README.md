# Shady.ai

My take to get privacy friendly, offline AI models accessible to as many people as possible. The cutting edge offline AI models such as [Segment Anything](https://ai.facebook.com/research/publications/segment-anything/), [LLaMA](https://github.com/facebookresearch/llama) and [Whisper](https://github.com/openai/whisper) have been optimised by many other developers in various forms and sizes. The small to medium sizes are the ones I'm interested in.

## Getting Started

This project has just started, so there is not much to see yet. Please check back later.

Unlike the majority of the frontends for the AI models, this project aims to be easier than even those with 1-click installers. The goal is to have a single click install for all platforms, including Windows, Mac, Linux, iOS, Android and web. The web version will be powered by [Serverpod](https://github.com/serverpod/serverpod) and eventually be hosted on [shady.ai](https://shady.ai) (not yet available).

## Roadmap

_Planned release dates are estimates and subject to change._

April 2023 - No Talk, Just Code

- [ ] Mac app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp) | 14B | 7B
- [ ] iOS app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp) | 3B
- [ ] Android app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp) | 3B | 7B*
- [ ] Windows app powered by [rwkv.cpp](https://github.com/saharNooby/rwkv.cpp) | 14B | 7B
- [ ] Setup CI/CD with Fastlane (Google's open source tool) to create consistent GitHub releases for all platforms.
- [ ] Update documentation to include instructions on how to build the apps from source or download the prebuilt apps from GitHub releases.

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

*Stretch goal. 7B is the size of the model, which might be too big for Android for a good user experience. Quantized models on smaller models tend to be completely broken. There's lots of developments in the field of quantization, which I'm keeping an eye on.

## Disclaimer

This project is not affiliated with Facebook, OpenAI or any other company. This is a personal project made by a hobbyist.

## License

See the [LICENSE](LICENSE) file.
