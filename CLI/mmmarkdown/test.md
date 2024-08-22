在 macOS 开发中，如果你希望 `NSTextView` 根据内容宽度自动缩放，有几种方法可以实现这个效果。下面介绍其中两种常见的方法：

### 方法 1: 使用 Auto Layout 和 Hugging Priority

你可以通过设置 `NSTextView` 的 `contentHuggingPriority` 和 `contentCompressionResistancePriority` 来实现自动根据内容宽度调整尺寸。

#### 步骤：

1. **设置约束**：确保 `NSTextView` 的宽度由其内容决定，而不是由外部约束强制设置。

2. **设置 `contentHuggingPriority` 和 `contentCompressionResistancePriority`**：
   - 提高 `NSTextView` 的水平 `contentHuggingPriority`，使得它在不受约束时尽量缩小到合适的宽度。
   - 调整 `contentCompressionResistancePriority` 以防止文本被压缩。

```objective-c
NSTextView *textView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, 200, 50)];
[textView setString:@"This is a sample text that may need resizing."];

// 设置文本视图的约束
[textView setTranslatesAutoresizingMaskIntoConstraints:NO];

// 提高 Hugging Priority
[textView setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];

// 提高 Compression Resistance Priority
[textView setContentCompressionResistancePriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationHorizontal];
```

### 方法 2: 手动调整尺寸

另一种方式是手动计算 `NSTextView` 的内容尺寸，并根据内容动态调整 `NSTextView` 的宽度。

#### 步骤：

1. **计算文本的宽度**：使用 `NSLayoutManager` 和 `NSTextContainer` 来计算文本的实际宽度。

2. **设置 `NSTextView` 的尺寸**：根据计算结果调整 `NSTextView` 的宽度。

```objective-c
NSTextView *textView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, 200, 50)];
[textView setString:@"This is a sample text that may need resizing."];

// 获取 TextView 的内容大小
NSLayoutManager *layoutManager = textView.layoutManager;
[textView.layoutManager ensureLayoutForTextContainer:textView.textContainer];
NSSize textSize = [layoutManager usedRectForTextContainer:textView.textContainer].size;

// 手动调整 TextView 的尺寸
NSRect frame = textView.frame;
frame.size.width = textSize.width + 20; // 加上额外的 padding
textView.frame = frame;
```

### 方法 3: 使用 `sizeToFit`

在 iOS 中常用的 `sizeToFit` 方法在 macOS 的 `NSTextView` 中不可用。但你可以实现类似的效果，通过手动调整文本视图的尺寸来适应其内容。

### 小结

- **Auto Layout** 方法适合在 Interface Builder 中进行 UI 布局，依赖于自动布局约束。
- **手动调整尺寸** 更加灵活，适合在代码中动态调整 `NSTextView` 的尺寸。

你可以根据具体需求选择合适的方法。如果有更多问题或需要进一步的帮助，请随时告诉我！
