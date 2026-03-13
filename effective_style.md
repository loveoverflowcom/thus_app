# Một số quy ước khuyến nghị sử dụng trong dự án

---
## Mục lục
- [I. Quy ước đặt tên](#i-quy-ước-đặt-tên)
  - [1. UpperCamelCase](#1-uppercamelcase)
  - [2. lowerCamelCase](#2-lowercamelcase)
  - [3. lowercase_with_underscores](#3-lowercase_with_underscores)
  - [4. Các từ viết tắt](#4-các-từ-viết-tắt)
  - [5. Tham số chưa dùng](#5-tham-số-chưa-dùng)
  - [6. Phạm vi cục bộ](#6-phạm-vi-cục-bộ)

- [II. Quy ước thiết kế](#ii-quy-ước-thiết-kế)
  - [1. Đặt tên nhất quán](#1-đặt-tên-nhất-quán)
  - [2. Viết tắt](#2-viết-tắt)
  - [3. Danh từ chính ở cuối tên](#3-danh-từ-chính-ở-cuối-tên)
  - [4. Câu lệnh dễ đọc](#4-câu-lệnh-dễ-đọc)
  - [5. Biến non-boolean](#5-biến-non-boolean)
  - [6. Biến boolean](#6-biến-boolean)
  - [7. Tên phương thức](#7-tên-phương-thức)
  - [8. Tên tham số generic](#8-tên-tham-số-generic)
  - [9. Thư viện](#9-thư-viện)
  - [10. Lớp và mixin](#10-lớp-và-mixin)
  - [11. Kiểu dữ liệu](#11-kiểu-dữ-liệu)
  - [12. Tham số](#12-tham-số)
  - [13. Xử lý lỗi](#13-xử-lý-lỗi)


- [III. Quy ước tổ chức package CSB Super App](#iii-quy-ước-tổ-chức-package-csb-super-app)
  - [1. Tổng quan](#1-tổng-quan)
  - [2. Csb Super App](#2-csb-super-app)
  - [3. Csb Mini App](#3-csb-mini-app)
  - [4. Package dùng chung](#4-package-dùng-chung)

---

## I. Quy ước đặt tên

### 1. UpperCamelCase
Dùng cho tên `class`, `interface`, `enum`, `typedef`, `metadata annotation`, `extension` và các kiểu dữ liệu.
  ```dart
  ✅ Good
  class SliderMenu {
    ...
  }

  class Foo {
    const Foo([Object? arg]);
  }

  @Foo(anArg)
  class A {
    ...
  }

  typedef Predicate<T> = bool Function(T value);

  extension MyFancyList<T> on List<T> {
    ...
  }
  ```

### 2. lowerCamelCase
Dùng cho tên biến, tên hàm, tên tham số, thậm chí cả hằng số và các giá trị trong `enum`. 
 
  ```dart
  ✅ Good
  var count = 3;

  HttpRequest httpRequest;

  void align(bool clearItems) {
    // ...
  }

  const pi = 3.14;
  const defaultTimeout = 1000;
  final urlScheme = RegExp('^([a-z]+):');

  class Dice {
    static final numberGenerator = Random();
  }

  ```


### 3. lowercase_with_underscores
Dùng cho tên `file`, `folder`, `package`, `project` và `name alias`. 
  ```dart
  ✅ Good
  import 'dart:math' as math;
  import 'package:angular_components/angular_components.dart' as angular_components;
  import 'package:js/js.dart' as js;
  ```

---

### 4. Các từ viết tắt

Các từ viết tắt mà viết hoa toàn bộ có thể khó đọc.
Như với định danh `HTTPSFTP`, người đọc sẽ không biết nó ám chỉ `HTTPS FTP` hay `HTTP SFTP`.

Để tránh điều này, hãy viết hoa hầu hết các từ viết tắt và chữ rút gọn như những từ thông thường.
Ngoại lệ là các từ viết tắt hoặc chữ rút gọn có hai chữ cái và được viết hoa trong Tiếng Anh.
  ```dart
  ✅ Good
  // Nhiều hơn hai chữ cái, viết nó như một từ thông thường bằng UpperCamelCase:
  Http // "hypertext transfer protocol"
  Nasa // "national aeronautics and space administration"
  Uri // "uniform resource identifier"
  Esq // "esquire"
  Ave // "avenue"

  // Hai chữ cái, được viết hoa trong Tiếng Anh:
  ID // "identifier"
  TV // "television"
  UI // "user interface"

  // Hai chữ cái, nhưng không được viết hoa trong Tiếng Anh:
  Mr // "mister"
  St // "street"
  Rd // "road"
  ```

### 5. Tham số chưa dùng
Đôi khi kiểu của hàm `callback` yêu cầu một tham số, nhưng phần gọi `callback` lại không dùng tham số đó.

Trong trường hợp này, nên đặt tên cho tham số không dùng đến là `_`, đây là một biến `wildcard` (ký tự đại diện) không có ràng buộc. Nếu có nhiều hơn một biến `wildcard`, có thể dùng nhiều dấu gạch dưới.

```dart
✅ Good
try {
  throw '!';
} catch (_, __) {
  print('oops');
}

futureOfVoid.then((_) {
  print('Operation complete.');
});
```

### 6. Phạm vi cục bộ:
Không có khái niệm `private` cho **biến cục bộ**, **tham số**, **hàm cục bộ**, hoặc **tiền tố thư viện** (library prefixes).  

Nếu những đối tượng này có tên bắt đầu bằng dấu gạch dưới, nó sẽ tạo ra tín hiệu gây nhầm lẫn cho người đọc.  

Vì vậy, **không nên dùng dấu gạch dưới ở đầu tên** cho các đối tượng này.

## II. Quy ước thiết kế

### 1. Đặt tên nhất quán
Sử dụng một tên và quy ước tương đồng cho cùng một khái niệm xuyên suốt dự án.
```dart
✅ Good
pageCount         // Một thuộc tính.
updatePageCount() // Nhất quán với `pageCount`.
```

Vì `Dart SDK` có những hàm chuẩn như `toList()`, hay `asMap()`, chúng ta có thể áp dụng quy ước tương tự
```dart
✅ Good
toSomething()     // Nhất quán with Iterable.toList().
asSomething()     // Consistent with List.asMap().
```

```dart
❌ Bad
convertToSomething()
wrappedAsSomething()
```

### 2. Viết tắt
Chỉ nên viết tắt khi những từ viết tắt đã phổ biến hơn từ gốc.
```dart
IOStream thay cho InputOutputStream
HttpRequest thay cho HypertextTransferProtocolRequest
```

### 3. Danh từ chính ở cuối tên

Từ cuối cùng nên là từ mô tả rõ nhất về biến hay đối tượng đó. Có thể thêm các từ khác, chẳng hạn như tính từ, vào trước để mô tả rõ hơn.

```dart
✅ Good
pageCount             // A count (of pages).
ConversionSink        // A sink for doing conversions.
ChunkedConversionSink // A ConversionSink that's chunked.
CssFontFaceRule       // A rule for font faces in CSS.
```

```dart
❌ Bad
numPages                  // Not a collection of pages.
CanvasRenderingContext2D  // Not a "2D".
RuleFontFaceCss           // Not a CSS.
```

### 4. Câu lệnh dễ đọc
Cố gắng viết câu lệnh để nó xếp theo thứ tự của một câu mệnh đề.
```dart
✅ Good
// "If errors is empty..."
if (errors.isEmpty) {
  // ...
}

// "Hey, subscription, cancel!"
subscription.cancel();

// "Get the monsters where the monster has claws."
monsters.where((monster) => monster.hasClaws);
```

Sẽ mơ hồ nếu viết như sau:
```dart
❌ Bad
// Telling errors to empty itself, or asking if it is?
if (errors.empty) {
  // ...
}

// Toggle what? To what?
subscription.toggle();

// Filter the monsters with claws *out* or include *only* those?
monsters.filter((monster) => monster.hasClaws);
```

Tuy nhiên, không nên thêm các loại từ khác như mạo từ để làm nó trông đúng ngữ pháp:
```dart
❌ Bad
if (theCollectionOfErrors.isEmpty) {
  // ...
}

monsters.producesANewSequenceWhereEach((monster) => monster.hasClaws);
```

### 5. Biến non-boolean

Ưu tiên sử dụng các cụm danh từ cho biến `non-boolean`
```dart
✅ Good
list.length
context.lineWidth
quest.rampagingSwampBeast
```

```
❌ Bad
list.deleteItems
```

### 6. Biến boolean

Ưu tiên sử dụng cụm động từ không phải mệnh lệnh cho các biến `boolean`
```dart
✅ Good
isEmpty
hasElements
canClose
closesWindow
canShowPopup
hasShownPopup
```

```dart
❌ Bad
empty         // Adjective or verb?
withElements  // Sounds like it might hold elements.
closeable     // Sounds like an interface.
              // "canClose" reads better as a sentence.
closingWindow // Returns a bool or a window?
showPopup     // Sounds like it shows the popup.
```

Tuy nhiên, khi tham số `boolean` được dán nhãn, thì nên bỏ dạng động từ:
```dart
✅ Good
Isolate.spawn(entryPoint, message, paused: false); // Thay vì isPaused
var copy = List.from(elements, growable: true);   // Thay vì isGrowable
var regExp = RegExp(pattern, caseSensitive: false); // Thay vì isCaseSensitive
```

Ngoài ra, nên ưu tiên dạng khẳng định cho các thuộc tính hoặc biến `boolean`:
```dart
✅ Good
if (socket.isConnected && database.hasData) {
  socket.write(database.read());
}
```

```dart
❌ Bad
if (!socket.isDisconnected && !database.isEmpty) {
  socket.write(database.read());
}
```

**Lưu ý:** Vẫn có trường hợp ngoại lệ, khi nhận thấy thuộc tính đó sẽ được dùng với toán tử `!` là chủ yếu, thì khi này mới nên ưu tiên dạng phủ định.

### 7. Tên phương thức
+ Nếu một hàm sẽ gây ra `side-effect`, hãy dùng động từ mang tính mệnh lệnh, thực thi.
  ```dart
  ✅ Good
  list.add('element');
  queue.removeFirst();
  window.refresh();
  ```

+ Nếu một hàm chủ yếu là được dùng trả về giá trị, nên dùng danh từ hoặc cụm động từ không manh tính mệnh lệnh
  ```dart
  ✅ Good
  var element = list.elementAt(3);
  var first = list.firstWhere(test);
  var char = string.codeUnitAt(4);
  ```

+ Nếu một hàm chủ yếu trả về giá trị, nhưng nội bộ của nó cần thực thi những tác vụ nặng hay quan trọng như làm việc với `I/O` mà không ngó lơ để gọi một cách thoải mái được, thì có thể dùng cụm động từ
  ```dart
  ✅ Good
  var table = database.downloadData();
  var packageVersions = packageGraph.solveConstraints();
  ```
+ Tránh hầu hết các phương thức bắt đầu với `get`. Do Dart đã có từ khoá `get` để định nghĩa các `getter`. Ví dụ, thay vì tạo phương thức `getBreakfastOrder()`, có thể tạo một `getter` là `breakfastOrder`.
Ngay cả khi cần tham số và tạo phương thức, vẫn nên tránh dùng get. Ví dụ, `breakfastOrder(DateTime time)`. 
Nếu muốn nhấn mạnh vào hành động, hãy dùng những động từ khác như: `create, download, fetch, calculate`, `request`, `aggregate`

+ Nên dùng cách đặt tên `to___()` nếu cần sao chép trạng thái đối tượng sang một đối tượng mới.
  ```dart
  ✅ Good
  list.toSet();
  stackTrace.toString();
  dateTime.toLocal();
  ```

+ Nên dùng cách đặt tên `as___()` nếu nó trả về một dạng xem khác khác dựa trên giữ liệu gốc
  
  ```dart
  ✅ Good
  var map = table.asMap();
  var list = bytes.asFloat32List();
  var future = subscription.asFuture();
  ```

+ Nên tránh để tên tham số trong phương thức để mô tả.
Các Editor / IDE đã hỗ trợ rất tốt trong việc cung cấp thông tin tham số khi người dùng sử dụng, nên để tên tham số sẽ không tăng khả năng đọc hiểu.
  
  ```dart
  ✅ Good
  list.add(element);
  map.remove(key);
  ```
  ```
  ❌ Bad
  list.addElement(element)
  map.removeKey(key)
  ```
  Tuy nhiên, vì Dart không hỗ trợ `function overloading`, nên có những trường hợp cần thiết với việc đặt tham số trong tên phương thức để phân biệt.
  ```dart
  ✅ Good
  map.containsKey(key);
  map.containsValue(value);
  ```

### 8. Tên tham số generic
Tham số generic thường được dùng một chữ cái viết hoa để biểu thị, nên tuân theo những quy ước chung để rõ nghĩa:
+ `E` cho các phần tử của `collection`:
  ```dart
  ✅ Good
  class IterableBase<E> {}
  class List<E> {}
  class HashSet<E> {}
  class RedBlackTree<E> {}
  ```
+ `K` và `V` cho `key` và `value` trong các `associative collection`:
  ```dart
  ✅ Good
  class Map<K, V> {}
  class Multimap<K, V> {}
  class MapEntry<K, V> {}
  ```
+ `T`, `S` và `U` được sử dụng lần lượt để biểu thị các kiểu generic đơn khác, khi chúng lồng nhau.
  ```dart
  ✅ Good
  class Future<T> {
    Future<S> then<S>(FutureOr<S> onValue(T value)) => ...
  }
  ```
+ Nếu không rơi vào những trường hợp trên, có thể tự đặt tên để tăng tính biểu đạt.
  ```dart
  ✅ Good
  class Graph<N, E> {
    final List<N> nodes = [];
    final List<E> edges = [];
  }

  class Graph<Node, Edge> {
    final List<Node> nodes = [];
    final List<Edge> edges = [];
  }
  ```

### 9. Thư viện
Mỗi tệp `.dart` mặc định sẽ được coi là một thư viện, nếu không khai báo gì thêm.

Ký tự gạch dưới ở đầu `_` cho biết một thành viên là `private` đối với thư viện của nó. Điều này không chỉ là quy ước, mà còn được tích hợp sẵn trong chính ngôn ngữ.
+ **Ưu tiên khai báo `private`:** Nếu không dùng `_` cho một thành viên, thì bạn đang `public`cho thư viện khác có thể và nên truy cập thành viên đó. Vì vậy, hãy dùng `_` nhiều nhất có thể, nó giúp lập trình viên khác sử dụng thư viện ít cần biết về những thành viên không cần thiết. Đồng thời, `analyzer` sẽ báo cho bạn biết các khai báo `private` không được sử dụng, giúp bạn có thể xóa bỏ code thừa. Nếu thành viên là `public`, analyzer sẽ không thể làm điều đó vì nó không biết liệu có code bên ngoài đang dùng nó hay không.

+ **Cân nhắc khai báo nhiều `class` trong cùng một thư viện**: Một số ngôn ngữ như `Java` gắn chặt cấu trúc tệp với cấu trúc `class` — mỗi tệp chỉ được phép định nghĩa một `class` cấp `top-level`. `Dart` thì không có giới hạn đó. Thư viện (`library`) là một thực thể tách biệt với `class`. Việc một thư viện chứa nhiều `class`, biến `top-level` và hàm là bình thường nếu chúng có liên quan về mặt logic.
Đặt nhiều `class` trong cùng một thư viện có thể mở ra một số `pattern` hữu ích. Vì tính `private` trong `Dart` hoạt động ở cấp thư viện chứ không phải cấp `class`, đây là một cách để định nghĩa các `friend class` giống như trong C++. Mọi `class` trong cùng thư viện đều có thể truy cập thành viên `private` của nhau, trong khi mã bên ngoài thì không thể.

### 10. Lớp và mixin
+ **Tránh định nghĩa một lớp trừu tượng có một phương thức.**
  Nếu chỉ cần định nghĩa `callback` hay một khởi tạo nào đó để `invoke` một hàm, hãy tránh dùng `class`
  ```dart
  ❌ Bad
  abstract class Predicate<E> {
    bool test(E element);
  }
  ```
  ```dart
  ✅ Good
  typedef Predicate<E> = bool Function(E element);
  ```
+ **Tránh dùng các `class` mà chỉ chứa những thành viên `static`.**
  Vì `Dart` cho phép khai báo ở cấp `top-level` của thư viện.
  Thư viện hỗ trợ `import prefix` và các toán tử `show`/`hide`. Đây là những công cụ mạnh mẽ cho phép người dùng code của bạn xử lý việc trùng tên theo cách phù hợp nhất với họ.
  ```dart
  ✅ Good
  DateTime mostRecent(List<DateTime> dates) {
    return dates.reduce((a, b) => a.isAfter(b) ? a : b);
  }

  const _favoriteMammal = 'weasel';
  ```
  ```dart
  ❌ Bad
  class DateUtils {
    static DateTime mostRecent(List<DateTime> dates) {
      return dates.reduce((a, b) => a.isAfter(b) ? a : b);
    }
  }

  class _Favorites {
    static const mammal = 'weasel';
  }
  ```

  Tuy nhiên, với những trường hợp cần nhóm các hằng số lại, như một `enum`, có thể nhóm chúng lại trong một `class`, cũng tương tự như `class Icons` và `class Colors` trong `Flutter SDK`.
  ```dart
  ✅ Good
  abstract final class Colors {
    static const red = '#f00';
    static const green = '#0f0';
    static const blue = '#00f';
    static const black = '#000';
    static const white = '#fff';
  }
  ```

+ **Cẩn thận với việc `extends` và `implements`**
  Một `class` cần có chủ đích, `comment` rõ ràng về việc nó có thể cho phép kế thừa hay không. Vì nếu không, các lớp con của lớp này trong tương lai có thể bị hỏng do lớp cha bị một số sửa đổi như chuyển từ `generative constructor` sang `factory constructor`.
  Đồng thời, muốn kiểm soát tốt hơn về việc lớp đó sẽ được kế thừa hay không, có thể cân nhắc sử dụng các `modifier` như `interface`, `final`, `sealed`.

  Tương tự, nên tránh việc `implements` một `class` không được tạo ra có chủ đích cho việc `implements`.
+ **Nên sử dụng `const constructor` khi có thể**
+ **Nên sử dụng `final` cho các thuộc tính khi có thể**
+ **Ưu thiên sử dụng `getter` thay cho những phương thức truy cập giá trị mà không yêu cầu tham số.**
  Nhiều hoạt động chỉ cần một phép tính hoặc chỉ đơn giản trả về một `private value`, nó nên là một `getter`, vừa ngắn gọn lại bớt boilerplate code trong quá trình phát triển.
  ```dart
  ✅ Good
  rectangle.area;
  collection.isEmpty;
  button.canShow;
  dataSet.minimumValue;
  ```

  Tuy nhiên, nếu nó nhấn mạnh vào việc thực hiện một hành động tính toán, thì sẽ không phù hợp.
  ```dart
  ❌ Bad
  connection.nextIncomingMessage; // Does network I/O.
  expression.normalForm; // Could be exponential to calculate.

  stdout.newline; // Produces output.
  list.clear; // Modifies object.
  DateTime.now; // New result each time.
  ```
+ **Ưu thiên sử dụng `setter` thay cho những phương thức chỉ mang ý nghĩa gán lại giá trị.**
  ```dart
  ✅ Good
  rectangle.width = 3;
  
  class Rectangle {
    double _width = 0;

    double get width => _width;

    set width(double value) {
      if (value < 0) {
        throw ArgumentError('Width cannot be negative');
      }
      _width = value;
    }
  }
  ```
+ **Tránh tạo `setter` mà không có `getter` tương ứng**:
  Người dùng coi `getter` và `setter` là các thuộc tính hiển thị của một đối tượng. Một thuộc tính có thể được ghi vào nhưng không được nhìn thấy sẽ gây nhầm lẫn về cách thức hoạt động của các thuộc tính. 
  Ví dụ, một `setter` không có `getter` nghĩa là ta có thể sử dụng `=` để sửa đổi nó, nhưng không thể sử dụng `+=`.
+ **Tránh `public` `late final` mà không chắc sẽ khởi tạo trước trong `class`**:
  Tránh lỗi truy cập khi chưa khởi hoặc bị gán giá trị sai cách
+ **Tránh trả về `this` trong các phương thức.**
  Vì `method cascades` trong `Dart` đã hỗ trợ việc nối các `method call`:
  ```dart
  ✅ Good
  var buffer =
    StringBuffer()
      ..write('one')
      ..write('two')
      ..write('three');
  ```
  ```dart
  ❌ Bad
  var buffer =
    StringBuffer()
        .write('one')
        .write('two')
        .write('three');
  ```

### 11. Kiểu dữ liệu
+ **Hãy khai báo kiểu dữ liệu của biến và tham số khi nó Dart không tự suy luận được, khiến nó nhận về kiểu `dynamic`**
  ```dart
  ✅ Good
  List<AstNode> parameters;
  if (node is Constructor) {
    parameters = node.signature;
  } else if (node is Method) {
    parameters = node.parameters;
  }

  Future<bool> install(PackageId id, String destination) => ...
  
  const screenWidth = 640; // Inferred as int.

  void sayRepeatedly(String message, {int count = 2}) {
    for (var i = 0; i < count; i++) {
      print(message);
    }
  }

  var playerScores = <String, int>{};
  final events = StreamController<Event>();

  class Downloader {
    final Completer<String> response = Completer();
  }

  bool isValid(String value, bool Function(String) test) => ...
  ```
  ```dart
  ❌ Bad
  var parameters;
  if (node is Constructor) {
    parameters = node.signature;
  } else if (node is Method) {
    parameters = node.parameters;
  }

  install(id, destination) => ...

  void sayRepeatedly(message, {count = 2}) {
    for (var i = 0; i < count; i++) {
      print(message);
    }
  }

  var playerScores = {};
  final events = StreamController();

  class Downloader {
    final response = Completer();
  }

  bool isValid(String value, Function test) => ...
  ```
  

### 12. Tham số
+ **Nên dán nhán cho các tham số `boolean` để dễ đọc.**
  ```dart
  ❌ Bad
  new Task(true);
  new Task(false);
  new ListBox(false, true, true);
  new Button(false);
  ```
  ```dart
  ✅ Good
  Task.oneShot();
  Task.repeating();
  ListBox(scroll: true, showScrollbars: true);
  Button(ButtonState.enabled);
  ```
+ **Nên hỗ trợ các tham số tuỳ chọn, để lập trình viên có thể bỏ qua nếu muốn.**
  ```dart
  ✅ Good
  String.fromCharCodes(Iterable<int> charCodes, [int start = 0, int? end]);

  DateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]);

  Duration({
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  });
  ```

### 13. Xử lý lỗi
- **Hạn chế sử dụng `try-catch` trực tiếp**
  - Chỉ nên dùng ở **tầng lá**, ví dụ khi giao tiếp với hạ tầng (HTTP request, DB, file I/O).
  - Không dùng `try-catch` trong logic business layer hoặc feature layer để tránh code rối, khó maintain.

- **Ưu tiên sử dụng các monad / functional approach** (ví dụ `fpdart`) để handle lỗi:
  - **Option:** đại diện cho giá trị có thể có hoặc không.
  - **Either:** đại diện cho kết quả thành công hoặc lỗi.
  - **IO / Task / TaskEither:** xử lý async / side-effect với khả năng handle lỗi.
  - **Reader / ReaderTask / ReaderTaskEither:** inject dependency vào các computation.
  - **State:** quản lý trạng thái thuần túy.
  - **Immutable Collections:** danh sách, map, set immutable giúp tránh side-effects.
  - **Do notation:** viết logic monad mượt mà như imperative style nhưng vẫn an toàn.

- **Lợi ích:**
  - Tách biệt **business logic** và **error handling** rõ ràng.
  - Code **an toàn hơn**, dễ test và maintain.
  - Giảm `side-effect` và lỗi runtime không mong muốn.


## III. Quy ước tổ chức package CSB Super App

### 1. Tổng quan
Xem thêm tại: [Super Mobile App Packages](https://docs.google.com/spreadsheets/d/1qH5GqNX0Fs4NDp_PnsoP0czJ99SgfJLHTqmDLhN6Fd0/edit?usp=sharing)


- Tất cả file Dart dùng `snake_case.dart`.
  - Ví dụ: `auth_bloc.dart`, `dashboard_view.dart`, `main.dart`.

- Các file `part of / part` sử dụng quy tắc đặc biệt:
  - File `root`: `root.dart`  
  - File `part`:
    - `root.event.dart` – chứa các `event` cho `bloc`.
    - `root.state.dart` – chứa các `state` cho `bloc` (nếu có).
    - `root.g.dart` – `file auto-generated` (codegen).

- Mỗi thư mục nên có một file cùng tên để `export` tất cả nội dung trong cần `export` trong thư mục đó. Để tiện `import` từ bên ngoài và giảm số lượng `import` trực tiếp tới nhiều file con
  - Ví dụ:
    - `features/auth.dart` `export` tất cả các `bloc`, `view` của `auth`.
    - `features/dashboard/blocs.dart` `export` tất cả các bloc trong dashboard.


### 2. Csb Super App

#### Root-level files
- Các file cấu hình hoặc entry point của ứng dụng:
  - `main.dart` – Điểm bắt đầu của ứng dụng.
  - `app.dart` – Cấu hình tổng thể của ứng dụng.
  - `auth.dart` – Module xác thực chung.
  - `env.dart`, `env.example.dart` – Cấu hình môi trường.
  - `features.dart` – Tập hợp các feature-level exports.

#### Thư mục `app/`
- Chứa các phần core của ứng dụng:
  - `csb_super_app.dart` – App-level logic, entry class cho app.
  - `injectors/` – Dependency injection (DI):
    - `repository_injector.dart` – Injector cho `repository`.
    - `usecase_injector.dart` - Injector cho `use case`
  - `injectors.dart` – Export các injector.
  - `routes.dart` – Định nghĩa route name.
  - `routes.g.dart` – File tự động sinh từ code generator.

**Quy tắc:** 
`app/` chứa các `core`, `injectors` và `routes`, không chứa logic feature cụ thể.

#### Thư mục `features/`
- Chia theo từng **tính năng chính (feature)** của ứng dụng:
  - Ví dụ: `auth/`, `dashboard/`, `home/`, `login/`.
- Mỗi feature có thể bao gồm:
  - `features.dart` – **entry export** cho toàn bộ `feature`.
  - `blocs/` – chứa `bloc/cubit`, `event`, `state`.
  - `use_cases/` chứa các logic nghiệp vụ phức tạp cần tách khỏi `bloc/cubit`.
  - `views/` – chứa các widget/page của `feature`.
  - `blocs.dart` & `views.dart` – **export** các bloc và view để tiện import.

**Quy tắc:**
- Mỗi feature là một `module` độc lập.
- `Bloc/cubit` và `view` được tách riêng trong thư mục con.
- `Export` file (`blocs.dart`, `views.dart`) giúp import gọn gàng.
- `Use case` rất phức tạp hoặc cần tái sử dụng trong nhiều `blocs` liên quan đến `feature`, nên tách thành thư mục riêng.

#### Thư mục `l10n/`
- Chứa các file `localization`:
  - `app_localizations.dart`, `app_localizations_vi.dart`
  - `.arb` chứa nội dung đa ngôn ngữ.

**Quy tắc:** Mọi thứ liên quan đến localization đều nằm trong `l10n/`.

#### Thư mục `shared/`
- Chứa các **widget chung, reusable** mà không chứa logic feature đặc thù
- Chứa các use case cross features
- Chứa các utils

### 3. Csb Mini App
- Mỗi mini app là một **package** độc lập, bao gồm đầy đủ các layer mà super app có (ngoại trừ `env`, `main.dart` và có thêm thư mục `bootstrap/`):
  - `app/` – chứa để chạy riêng cho mini app:
    - `mini_app.dart` – entry point chính của mini app.
    - `injectors/` – cấu hình dependency injection riêng cho mini app.
    - `routes.dart` & `routes.g.dart` – định nghĩa route riêng.
  - `bootstrap/` - chứa một project app import `package` mini app này để khởi chạy riêng nếu cần.
  - `features/` – chứa các **feature** tương tự super app
  - `shared/` – chứa các widget, use case, utils dùng chung cho mini app, tương tự super app.
  - `l10n/` – localization riêng cho mini app.
  
**Quy tắc:**
- Mini app là package độc lập nhưng có thể **nhúng vào super app** với vai trò là một **package**.
- `bootstrap/` hỗ trợ mini app chạy độc lập mà không phụ thuộc super app.

### 4. Package dùng chung

- **Design System**
  - **Widget Reusable:** chứa các widget dùng chung như gestures, forms, dialogs, painting, ...
  - **Theme:** light & dark theme (nếu yêu cầu).
  - **Measurements:** spacing, radius, elevation, sizing ...

- **Auth Client**
  - **Credentials:** tenant, username, password, ...
  - **OTP:** SMS / Email.
  - **OAuth:** đăng nhập OAuth.

- **CSB Rest Client**
  - **Error Messages:** quản lý thông báo lỗi từ API.
  - **Authorize Token:** quản lý token và refresh.
  - **Interceptors:** logger, decrypt data.
  - **Download / Upload:** sử dụng work manager nếu cần.

- **Work Manager**
  - Quản lý isolate.
  - Lập lịch cho các task nặng hoặc async.

- **Permission Handler**
  - Quản lý quyền truy cập thiết bị: camera, storage, microphone, ...

- **Notification Client**
  - Quản lý thông báo push, local notification.

- **Safety Storage**
  - **Locking:** khóa dữ liệu.
  - **Secure / Encrypted Storage:** lưu trữ an toàn, mã hóa.

- **Event Bus**
  - Giao tiếp giữa các mini app (nếu cần).
  - Giao tiếp giữa mini app và super app.

- **Remote Config Service**
  - Cập nhật cấu hình từ xa.
  - Có thể sử dụng Firebase Remote Config hoặc tự triển khai.

- **Crashlytics**
  - Giám sát lỗi từ máy người dùng.
  - Có thể dùng Firebase Crashlytics hoặc tự triển khai.

- **Realtime Message Client**
  - Nếu cần realtime messaging giữa người dùng hoặc hệ thống.

- **Các plugins sẵn có**
  Có thể import qua `pubspec.yaml`
  - `url_launcher:` gọi điện, gửi SMS, mở trình duyệt qua native intent.
  - `connectivity_plus:` kiểm tra trạng thái mạng.
  - `device_info_plus:` lấy thông tin thiết bị như model, OS version, SDK level từ native APIs.
  - ...

**Quy tắc chung:**
- Mỗi package là **một module độc lập**, với folder và export file rõ ràng.
- Tên folder và file theo **snake_case**, dễ hiểu và phản ánh chức năng.
