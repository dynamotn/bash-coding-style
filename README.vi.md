<!-- vim: set nospell: -->
# bash-coding-style

[English](README.md) | [Tiếng Việt](README.vi.md)

Phong cách lập trình Bash này không phải là tuyệt đối, bạn có thể không tuân thủ nó nếu cần thiết. Mục đích của tôi khi lập phong cách này là giảm bớt các rào cản tâm lý để viết các đoạn mã Bash và cung cấp câu trả lời cho các vấn đề phổ biến gặp phải khi viết các đoạn mã Bash. Các đoạn mã bash thường gây khó xử, khó duy trì và có thể dễ dàng trở nên bị ghét. Tuy nhiên, việc viết đoạn mã Bash đôi khi là cần thiết, vì vậy tài liệu phong cách này đã được viết ra.

Khi cảm thấy không chắc chắn thì hãy ưu tiên tính nhất quán trước. Bằng cách sử dụng một kiểu duy nhất một cách nhất quán trong suốt các đoạn mã, bạn có thể tập trung vào các vấn đề khác quan trọng hơn. Tính nhất quán cũng cho phép tự động hóa. Trong nhiều trường hợp, quy tắc `duy trì tính nhất quán` có nghĩa là `chọn một thứ và ngừng lo lắng về nó`. Giá trị tiềm năng của việc cho phép sự linh hoạt này vượt trội so với chi phí để mọi người tranh cãi về chúng. Tuy nhiên, có những giới hạn cần thống nhất. Tính nhất quán là một yếu tố tốt để đưa ra quyết định khi không có lập luận kỹ thuật rõ ràng hoặc định hướng dài hạn. Mặt khác, tính nhất quán không nên được sử dụng để biện minh cho việc tiếp tục với một phong cách lỗi thời khi có những lợi thế rõ ràng cho người mới.

## Mục lục

<!-- toc -->

- [Giới thiệu](#gi%E1%BB%9Bi-thi%E1%BB%87u)
- [Bối cảnh](#b%E1%BB%91i-c%E1%BA%A3nh)
  - [Nên sử dụng shell nào](#nen-s%E1%BB%AD-d%E1%BB%A5ng-shell-nao)

<!-- tocstop -->

## Giới thiệu

Phong cách này cung cấp các hướng dẫn để viết đoạn mã Bash. Nó được lập nên dựa trên [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) và [icy/bash-coding-style](https://github.com/icy/bash-coding-style) với một vài quy tắc được điều chỉnh.
Các mục được thực hiện có chủ ý tùy chỉnh được đánh dấu rõ ràng là `(tùy chỉnh)`.

Các ký hiệu sau được sử dụng trong hướng dẫn này:

| Ký hiệu | Ý nghĩa |
| ------ | ------- |
| ✔️ NÊN | Nên thực hiện theo kiến nghị. |
| ❌ TRÁNH | Không đề nghị làm theo. Nên dành thời gian chỉnh sửa để tránh điều đó . |
| ⚠️ CÂN NHẮC | Cân nhắc nếu có thể. Nó có thể áp dụng tùy theo tình huống cụ thể. |

## Bối cảnh

### Nên sử dụng shell nào

> ![NOTE]
> Quy tắc tùy chỉnh

- ✔️ NÊN: Sử dụng Bash cho tất cả các script
- ✔️ NÊN: Viết `#!/usr/bin/env bash` ở đầu script. (tùy chỉnh)
- ✔️ NÊN: Sử dụng `set -euo pipefail` cho các cài đặt tùy chọn shell. (tùy chỉnh)
- ⚠️ CÂN NHẮC: Nếu sử dụng các shell khác, hãy giải thích lý do trong phần nhận xét. (tùy chỉnh)

Sử dụng Bash. Hạn chế tất cả các script shell có thể thực thi đối với `bash` đảm bảo một shell nhất quán được cài đặt trên tất cả các máy.

Các tệp thực thi phải bắt đầu bằng `#!/usr/bin/env bash` và các cờ tối thiểu. Sử dụng `#!/usr/bin/env bash` cung cấp một số lợi thế đáng chú ý: hoạt động trên các môi trường (như Fedora hoặc Termux), mặc dù có một chút ảnh hưởng đến hiệu suất từ việc gọi env để tìm kiếm PATH.

Sử dụng `set` cho cài đặt tùy chọn shell đảm bảo rằng ngay cả khi script được gọi bằng `bash script_name`, chức năng của nó không bị suy giảm. `set -euo pipefail` tự động phát hiện lỗi sớm và kết thúc script nếu xảy ra lỗi. `set -e` kết thúc script nếu xảy ra lỗi. `set -u` kích hoạt lỗi khi tham chiếu đến các biến không xác định. `set -o pipefail` kết thúc script nếu xảy ra lỗi ở giữa pipeline.

**Kiến nghị**

```shell
#!/usr/bin/env bash
set -euo pipefail
```

**Không khuyến khích**

```shell
#!/bin/bash
# Thiếu set
# Sai shebang

#!/bin/bash -euo pipefail
# Để tùy chọn -euo ngay sau shebang, nó sẽ bị vô hiệu hóa khi gọi `bash ./script.sh`
# Sai shebang
```
