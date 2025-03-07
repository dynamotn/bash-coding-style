<!-- vim: set nospell: -->
# bash-coding-style

[English](README.md) | [Tiếng Việt](README.vi.md)

Phong cách lập trình Bash này không phải là tuyệt đối, bạn có thể không tuân thủ nó nếu cần thiết. Mục đích của tôi khi lập phong cách này là giảm bớt các rào cản tâm lý để viết các đoạn mã Bash và cung cấp câu trả lời cho các vấn đề phổ biến gặp phải khi viết các đoạn mã Bash. Các đoạn mã bash thường gây khó xử, khó duy trì và có thể dễ dàng trở nên bị ghét. Tuy nhiên, việc viết đoạn mã Bash đôi khi là cần thiết, vì vậy tài liệu phong cách này đã được viết ra.

Khi cảm thấy không chắc chắn thì hãy ưu tiên tính nhất quán trước. Bằng cách sử dụng một kiểu duy nhất một cách nhất quán trong suốt cơ sở mã, bạn có thể tập trung vào các vấn đề khác quan trọng hơn. Tính nhất quán cũng cho phép tự động hóa. Trong nhiều trường hợp, quy tắc "duy trì tính nhất quán" có nghĩa là "chọn một tùy chọn và ngừng lo lắng về nó." Giá trị tiềm năng của việc cho phép sự linh hoạt trên các điểm này vượt trội so với chi phí của mọi người tranh luận về chúng. Tuy nhiên, có những giới hạn để thống nhất. Tính nhất quán là một yếu tố tốt để đưa ra quyết định khi không có lập luận kỹ thuật rõ ràng hoặc định hướng dài hạn. Mặt khác, tính nhất quán không nên được sử dụng để biện minh cho việc tiếp tục với một phong cách lỗi thời khi có những lợi thế rõ ràng cho một người mới.

## Mục lục

<!-- toc -->

- [Giới thiệu](#gi%E1%BB%9Bi-thi%E1%BB%87u)

<!-- tocstop -->

## Giới thiệu

Phong cách này cung cấp các hướng dẫn để viết đoạn mã Bash. Nó được lập nên dựa trên [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) và [icy/bash-coding-style](https://github.com/icy/bash-coding-style) với một vài luật tùy chỉnh.
Các mục được thực hiện có chủ ý tùy chỉnh được đánh dấu rõ ràng là `(tùy chỉnh)`.

Các ký hiệu sau được sử dụng trong hướng dẫn này:

| Ký hiệu | Ý nghĩa |
| ------ | ------- |
| ✔️ NÊN | Nên thực hiện theo kiến nghị. |
| ❌ TRÁNH | Không đề nghị làm theo. Nên dành thời gian chỉnh sửa để tránh điều đó . |
| ⚠️ CÂN NHẮC | Cân nhắc nếu có thể. Nó có thể áp dụng tùy theo tình huống cụ thể. |
