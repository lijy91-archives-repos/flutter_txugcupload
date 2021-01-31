# flutter_txugcupload

适用于 Flutter 的腾讯云点播上传 SDK

[![pub version][pub-image]][pub-url]

[pub-image]: https://img.shields.io/pub/v/flutter_txugcupload.svg
[pub-url]: https://pub.dev/packages/flutter_txugcupload

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [快速开始](#%E5%BF%AB%E9%80%9F%E5%BC%80%E5%A7%8B)
  - [安装](#%E5%AE%89%E8%A3%85)
  - [用法](#%E7%94%A8%E6%B3%95)
- [相关链接](#%E7%9B%B8%E5%85%B3%E9%93%BE%E6%8E%A5)
- [许可证](#%E8%AE%B8%E5%8F%AF%E8%AF%81)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 快速开始

### 安装

将此添加到包的 pubspec.yaml 文件中：

```yaml
dependencies:
  flutter_txugcupload: ^0.0.3
```

您可以从命令行安装软件包：

```bash
$ flutter packages get
```

### 集成

如果您在 `Podfile` 中使用 `use_frameworks!`，请按以下示例进行修改你的 `Podfile` 文件。

```ruby
# 省略上方非关键代码

target 'Runner' do
  use_frameworks!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))

  # If you use `use_frameworks!` in your Podfile,
  # uncomment the below $static_framework array and also
  # the pre_install section. 
  $static_framework = ['flutter_txugcupload']
  
  pre_install do |installer|
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
    installer.pod_targets.each do |pod|
        if $static_framework.include?(pod.name)
          def pod.build_type;
            Pod::BuildType.static_library
          end
        end
      end
  end
end

# 省略下方非关键代码
```

### 用法

实现一个视频上传进度监听器（TXVideoPublishListener）

```dart
class VideoPublishListener extends TXVideoPublishListener {
  final Function(int uploadBytes, int totalBytes) onVideoPublishProgress;
  final Function(TXPublishResult result) onVideoPublishComplete;

  VideoPublishListener({
    this.onVideoPublishProgress,
    this.onVideoPublishComplete,
  });

  @override
  void onPublishProgress(int uploadBytes, int totalBytes) {
    if (this.onVideoPublishProgress == null) return;

    this.onVideoPublishProgress(uploadBytes, totalBytes);
  }

  @override
  void onPublishComplete(TXPublishResult result) {
    if (this.onVideoPublishComplete == null) return;

    this.onVideoPublishComplete(result);
  }
}
```

上传视频

```dart
TXUGCPublish txUgcPublish = TXUGCPublish(customKey: '<customKey>');

TXPublishParam param = TXPublishParam(
  videoPath: '<videoPath>',
  signature: '<signature>',
);
txUgcPublish.setVideoPublishListener(VideoPublishListener(
  onVideoPublishProgress: (uploadBytes, totalBytes) {
    int progress = ((uploadBytes / totalBytes) * 100).toInt();
  },
  onVideoPublishComplete: (result) {
    // 当 result.errCode 为 0 时即为上传成功，更多错误码请查看下方链接
    // https://cloud.tencent.com/document/product/266/9539#.E9.94.99.E8.AF.AF.E7.A0.81
  },
));
txUgcPublish.publishVideo(param);
```

## 相关链接

- https://cloud.tencent.com/document/product/266/9539
- https://cloud.tencent.com/document/product/266/13793

## 许可证

```
MIT License

Copyright (c) 2020 LiJianying <lijy91@foxmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
