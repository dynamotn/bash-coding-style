<!-- vim: set nospell: -->
# bash-coding-style

[English](README.md) | [Tiếng Việt](README.vi.md)

Phong cách lập trình Bash này không phải là tuyệt đối, bạn có thể không tuân thủ nó nếu cần thiết. Mục đích của tôi khi lập phong cách này là giảm bớt các rào cản tâm lý để viết các kịch bản (script) Bash và cung cấp câu trả lời cho các vấn đề phổ biến gặp phải khi viết các kịch bản Bash. Các kịch bản Bash thường gây khó xử, khó duy trì và có thể dễ dàng trở nên bị ghét. Tuy nhiên, việc viết kịch bản Bash đôi khi là cần thiết, vì vậy tài liệu phong cách này đã được viết ra.

Khi cảm thấy không chắc chắn thì hãy ưu tiên tính nhất quán trước. Bằng cách sử dụng một kiểu duy nhất một cách nhất quán trong suốt các đoạn mã, bạn có thể tập trung vào các vấn đề khác quan trọng hơn. Tính nhất quán cũng cho phép tự động hóa. Trong nhiều trường hợp, quy tắc `duy trì tính nhất quán` có nghĩa là `chọn một thứ và ngừng lo lắng về nó`. Giá trị tiềm năng của việc cho phép sự linh hoạt này vượt trội so với chi phí để mọi người tranh cãi về chúng. Tuy nhiên, có những giới hạn cần thống nhất. Tính nhất quán là một yếu tố tốt để đưa ra quyết định khi không có lập luận kỹ thuật rõ ràng hoặc định hướng dài hạn. Mặt khác, tính nhất quán không nên được sử dụng để biện minh cho việc tiếp tục với một phong cách lỗi thời khi có những lợi thế rõ ràng cho người mới.

## Mục lục

<!-- toc -->

- [Giới thiệu](#gi%E1%BB%9Bi-thi%E1%BB%87u)
  - [Thư viện hỗ trợ](#th%C6%B0-vi%E1%BB%87n-h%E1%BB%97-tr%E1%BB%A3)
  - [Trình kiểm tra](#tr%C3%ACnh-ki%E1%BB%83m-tra)
- [Bối cảnh](#b%E1%BB%91i-c%E1%BA%A3nh)
  - [Nên sử dụng shell nào](#n%C3%AAn-s%E1%BB%AD-d%E1%BB%A5ng-shell-n%C3%A0o)
  - [Phiên bản Bash](#phi%C3%AAn-b%E1%BA%A3n-bash)
  - [Khi nào nên sử dụng shell](#khi-n%C3%A0o-n%C3%AAn-s%E1%BB%AD-d%E1%BB%A5ng-shell)
- [Tệp shell và cách thực thi trình thông dịch](#t%E1%BB%87p-shell-v%C3%A0-c%C3%A1ch-th%E1%BB%B1c-thi-tr%C3%ACnh-th%C3%B4ng-d%E1%BB%8Bch)
  - [Phần mở rộng tệp](#ph%E1%BA%A7n-m%E1%BB%9F-r%E1%BB%99ng-t%E1%BB%87p)
  - [SUID/SGID](#suidsgid)
- [Môi trường](#m%C3%B4i-tr%C6%B0%E1%BB%9Dng)
  - [Cách gọi script](#c%C3%A1ch-g%E1%BB%8Di-script)
  - [Kiểm soát tham số của script](#ki%E1%BB%83m-so%C3%A1t-tham-s%E1%BB%91-c%E1%BB%A7a-script)
  - [Tự hoàn thành trong shell](#t%E1%BB%B1-ho%C3%A0n-th%C3%A0nh-trong-shell)
  - [Phiên bản và phân phối](#phi%C3%AAn-b%E1%BA%A3n-v%C3%A0-ph%C3%A2n-ph%E1%BB%91i)
  - [Chế độ gỡ lỗi và chạy thử](#ch%E1%BA%BF-%C4%91%E1%BB%99-g%E1%BB%A1-l%E1%BB%97i-v%C3%A0-ch%E1%BA%A1y-th%E1%BB%AD)
  - [Output theo vết](#output-theo-v%E1%BA%BFt)
  - [Lệnh tự kiểm tra](#l%E1%BB%87nh-t%E1%BB%B1-ki%E1%BB%83m-tra)
  - [STDOUT và STDERR](#stdout-v%C3%A0-stderr)
  - [Hiển thị tiến độ](#hi%E1%BB%83n-th%E1%BB%8B-ti%E1%BA%BFn-%C4%91%E1%BB%99)
  - [Ghi log hệ thống](#ghi-log-h%E1%BB%87-th%E1%BB%91ng)
  - [Hàm sử dụng chung](#h%C3%A0m-s%E1%BB%AD-d%E1%BB%A5ng-chung)
  - [Môi trường kế thừa](#m%C3%B4i-tr%C6%B0%E1%BB%9Dng-k%E1%BA%BF-th%E1%BB%ABa)
  - [Tệp cấu hình](#t%E1%BB%87p-c%E1%BA%A5u-h%C3%ACnh)
  - [Tác dụng phụ của thư viện](#t%C3%A1c-d%E1%BB%A5ng-ph%E1%BB%A5-c%E1%BB%A7a-th%C6%B0-vi%E1%BB%87n)
  - [Nhập liệu tương tác](#nh%E1%BA%ADp-li%E1%BB%87u-t%C6%B0%C6%A1ng-t%C3%A1c)
  - [Menu và lựa chọn](#menu-v%C3%A0-l%E1%BB%B1a-ch%E1%BB%8Dn)
  - [Chạy không người trông](#ch%E1%BA%A1y-kh%C3%B4ng-ng%C6%B0%E1%BB%9Di-tr%C3%B4ng)
  - [Entrypoint của container](#entrypoint-c%E1%BB%A7a-container)
  - [Người dùng hiện tại](#ng%C6%B0%E1%BB%9Di-d%C3%B9ng-hi%E1%BB%87n-t%E1%BA%A1i)
  - [Giới hạn tài nguyên](#gi%E1%BB%9Bi-h%E1%BA%A1n-t%C3%A0i-nguy%C3%AAn)
  - [Tiến trình chạy lâu dài](#ti%E1%BA%BFn-tr%C3%ACnh-ch%E1%BA%A1y-l%C3%A2u-d%C3%A0i)
- [Quy ước đặt tên](#quy-%C6%B0%E1%BB%9Bc-%C4%91%E1%BA%B7t-t%C3%AAn)
  - [Tên hàm](#t%C3%AAn-h%C3%A0m)
  - [Tên biến](#t%C3%AAn-bi%E1%BA%BFn)
  - [Tên biến cục bộ trong hàm nameref và hàm callback](#t%C3%AAn-bi%E1%BA%BFn-c%E1%BB%A5c-b%E1%BB%99-trong-h%C3%A0m-nameref-v%C3%A0-h%C3%A0m-callback)
- [Chú thích](#ch%C3%BA-th%C3%ADch)
  - [Phần đầu file](#ph%E1%BA%A7n-%C4%91%E1%BA%A7u-file)
  - [Chú thích hàm](#ch%C3%BA-th%C3%ADch-h%C3%A0m)
  - [Chú thích triển khai](#ch%C3%BA-th%C3%ADch-tri%E1%BB%83n-khai)
  - [TODO Comments](#todo-comments)
  - [Code bị comment lại](#code-b%E1%BB%8B-comment-l%E1%BA%A1i)
- [Định dạng](#%C4%91%E1%BB%8Bnh-d%E1%BA%A1ng)
  - [Dấu tab và dấu cách](#d%E1%BA%A5u-tab-v%C3%A0-d%E1%BA%A5u-c%C3%A1ch)
  - [Kết thúc dòng và mã hóa ký tự](#k%E1%BA%BFt-th%C3%BAc-d%C3%B2ng-v%C3%A0-m%C3%A3-h%C3%B3a-k%C3%BD-t%E1%BB%B1)
  - [Độ dài dòng code và chuỗi dài](#%C4%91%E1%BB%99-d%C3%A0i-d%C3%B2ng-code-v%C3%A0-chu%E1%BB%97i-d%C3%A0i)
  - [Pipelines (Đường ống)](#pipelines-%C4%91%C6%B0%E1%BB%9Dng-%E1%BB%91ng)
  - [Luồng điều khiển](#lu%E1%BB%93ng-%C4%91i%E1%BB%81u-khi%E1%BB%83n)
  - [Độ sâu lồng nhau](#%C4%91%E1%BB%99-s%C3%A2u-l%E1%BB%93ng-nhau)
  - [Kích thước hàm](#k%C3%ADch-th%C6%B0%E1%BB%9Bc-h%C3%A0m)
  - [Câu lệnh case](#c%C3%A2u-l%E1%BB%87nh-case)
  - [Khai triển biến](#khai-tri%E1%BB%83n-bi%E1%BA%BFn)
  - [Dấu nháy](#d%E1%BA%A5u-nh%C3%A1y)
  - [Khai báo hàm](#khai-b%C3%A1o-h%C3%A0m)
- [Tính năng và lỗi](#t%C3%ADnh-n%C4%83ng-v%C3%A0-l%E1%BB%97i)
  - [Sử dụng ShellCheck](#s%E1%BB%AD-d%E1%BB%A5ng-shellcheck)
  - [Thay thế lệnh](#thay-th%E1%BA%BF-l%E1%BB%87nh)
  - [Kiểm tra đầu vào trong thay thế lệnh](#ki%E1%BB%83m-tra-%C4%91%E1%BA%A7u-v%C3%A0o-trong-thay-th%E1%BA%BF-l%E1%BB%87nh)
  - [Biểu thức kiểm tra](#bi%E1%BB%83u-th%E1%BB%A9c-ki%E1%BB%83m-tra)
  - [Kiểm tra chuỗi](#ki%E1%BB%83m-tra-chu%E1%BB%97i)
  - [Chuyển đổi chữ hoa chữ thường](#chuy%E1%BB%83n-%C4%91%E1%BB%95i-ch%E1%BB%AF-hoa-ch%E1%BB%AF-th%C6%B0%E1%BB%9Dng)
  - [Biểu thức chính quy](#bi%E1%BB%83u-th%E1%BB%A9c-ch%C3%ADnh-quy)
  - [Khai triển ký tự đại diện cho tên tệp](#khai-tri%E1%BB%83n-k%C3%BD-t%E1%BB%B1-%C4%91%E1%BA%A1i-di%E1%BB%87n-cho-t%C3%AAn-t%E1%BB%87p)
  - [Locale và thứ tự sắp xếp](#locale-v%C3%A0-th%E1%BB%A9-t%E1%BB%B1-s%E1%BA%AFp-x%E1%BA%BFp)
  - [Eval là xấu xa](#eval-l%C3%A0-x%E1%BA%A5u-xa)
  - [Bí mật và thông tin xác thực](#b%C3%AD-m%E1%BA%ADt-v%C3%A0-th%C3%B4ng-tin-x%C3%A1c-th%E1%BB%B1c)
  - [Dựng output có cấu trúc](#d%E1%BB%B1ng-output-c%C3%B3-c%E1%BA%A5u-tr%C3%BAc)
  - [In dữ liệu](#in-d%E1%BB%AF-li%E1%BB%87u)
  - [Here document](#here-document)
  - [Mảng](#m%E1%BA%A3ng)
  - [Mảng kết hợp](#m%E1%BA%A3ng-k%E1%BA%BFt-h%E1%BB%A3p)
  - [Đường ống vào while](#%C4%91%C6%B0%E1%BB%9Dng-%E1%BB%91ng-v%C3%A0o-while)
  - [Thay thế tiến trình](#thay-th%E1%BA%BF-ti%E1%BA%BFn-tr%C3%ACnh)
  - [File descriptor](#file-descriptor)
  - [Vòng lặp for](#v%C3%B2ng-l%E1%BA%B7p-for)
  - [Biến cục bộ](#bi%E1%BA%BFn-c%E1%BB%A5c-b%E1%BB%99)
  - [Trả về giá trị](#tr%E1%BA%A3-v%E1%BB%81-gi%C3%A1-tr%E1%BB%8B)
  - [Số học](#s%E1%BB%91-h%E1%BB%8Dc)
  - [Ngày giờ và khoảng thời gian](#ng%C3%A0y-gi%E1%BB%9D-v%C3%A0-kho%E1%BA%A3ng-th%E1%BB%9Di-gian)
  - [Tính di động](#t%C3%ADnh-di-%C4%91%E1%BB%99ng)
  - [So sánh phiên bản](#so-s%C3%A1nh-phi%C3%AAn-b%E1%BA%A3n)
- [Gọi lệnh](#g%E1%BB%8Di-l%E1%BB%87nh)
  - [Kiểm tra giá trị trả về](#ki%E1%BB%83m-tra-gi%C3%A1-tr%E1%BB%8B-tr%E1%BA%A3-v%E1%BB%81)
  - [Errexit trong điều kiện](#errexit-trong-%C4%91i%E1%BB%81u-ki%E1%BB%87n)
  - [Xử lý lỗi](#x%E1%BB%AD-l%C3%BD-l%E1%BB%97i)
  - [Mã thoát](#m%C3%A3-tho%C3%A1t)
  - [Lệnh dựng sẵn và lệnh bên ngoài](#l%E1%BB%87nh-d%E1%BB%B1ng-s%E1%BA%B5n-v%C3%A0-l%E1%BB%87nh-b%C3%AAn-ngo%C3%A0i)
  - [Trình xử lý tín hiệu](#tr%C3%ACnh-x%E1%BB%AD-l%C3%BD-t%C3%ADn-hi%E1%BB%87u)
  - [Tiến trình con](#ti%E1%BA%BFn-tr%C3%ACnh-con)
  - [Song song có giới hạn](#song-song-c%C3%B3-gi%E1%BB%9Bi-h%E1%BA%A1n)
  - [Hàm trong tiến trình con](#h%C3%A0m-trong-ti%E1%BA%BFn-tr%C3%ACnh-con)
  - [Đổi thư mục](#%C4%91%E1%BB%95i-th%C6%B0-m%E1%BB%A5c)
  - [Kết thúc tùy chọn](#k%E1%BA%BFt-th%C3%BAc-t%C3%B9y-ch%E1%BB%8Dn)
  - [Request mạng](#request-m%E1%BA%A1ng)
  - [Chờ một điều kiện](#ch%E1%BB%9D-m%E1%BB%99t-%C4%91i%E1%BB%81u-ki%E1%BB%87n)
  - [Lệnh trên máy remote](#l%E1%BB%87nh-tr%C3%AAn-m%C3%A1y-remote)
  - [Xác minh host key](#x%C3%A1c-minh-host-key)
  - [Lệnh đã lỗi thời](#l%E1%BB%87nh-%C4%91%C3%A3-l%E1%BB%97i-th%E1%BB%9Di)
- [Ổn định hóa script](#%E1%BB%95n-%C4%91%E1%BB%8Bnh-h%C3%B3a-script)
  - [Viết script chạy lại được](#vi%E1%BA%BFt-script-ch%E1%BA%A1y-l%E1%BA%A1i-%C4%91%C6%B0%E1%BB%A3c)
  - [Kiểm tra trạng thái trước khi thay đổi](#ki%E1%BB%83m-tra-tr%E1%BA%A1ng-th%C3%A1i-tr%C6%B0%E1%BB%9Bc-khi-thay-%C4%91%E1%BB%95i)
  - [Tạo tệp tạm an toàn](#t%E1%BA%A1o-t%E1%BB%87p-t%E1%BA%A1m-an-to%C3%A0n)
  - [Lock](#lock)
  - [Ghi nguyên tử](#ghi-nguy%C3%AAn-t%E1%BB%AD)
  - [Lệnh phá hủy](#l%E1%BB%87nh-ph%C3%A1-h%E1%BB%A7y)
- [Kiểm thử](#ki%E1%BB%83m-th%E1%BB%AD)
  - [Assertion output nghiêm ngặt](#assertion-output-nghi%C3%AAm-ng%E1%BA%B7t)
  - [Cô lập test](#c%C3%B4-l%E1%BA%ADp-test)
  - [Giả lập lệnh](#gi%E1%BA%A3-l%E1%BA%ADp-l%E1%BB%87nh)
  - [Ma trận phiên bản Bash](#ma-tr%E1%BA%ADn-phi%C3%AAn-b%E1%BA%A3n-bash)
  - [Coverage](#coverage)
  - [Ghim phiên bản công cụ](#ghim-phi%C3%AAn-b%E1%BA%A3n-c%C3%B4ng-c%E1%BB%A5)
- [Tài liệu tham khảo](#t%C3%A0i-li%E1%BB%87u-tham-kh%E1%BA%A3o)

<!-- tocstop -->

## Giới thiệu

Phong cách này được lập nên dựa trên các hướng dẫn trong [Tài liệu tham khảo](#t%C3%A0i-li%E1%BB%87u-tham-kh%E1%BA%A3o) với một vài quy tắc được điều chỉnh.
Các mục được thực hiện có chủ ý tùy chỉnh được đánh dấu rõ ràng là `(tùy chỉnh)`.

Các ký hiệu sau được sử dụng trong hướng dẫn này:

| Ký hiệu | Ý nghĩa |
| ------ | ------- |
| ✔️ NÊN | Nên thực hiện theo kiến nghị. |
| ❌ TRÁNH | Không đề nghị làm theo. Nên dành thời gian chỉnh sửa để tránh điều đó . |
| ⚠️ CÂN NHẮC | Cân nhắc nếu có thể. Nó có thể áp dụng tùy theo tình huống cụ thể. |

### Thư viện hỗ trợ

Để giúp tuân thủ hướng dẫn phong cách, tôi đã viết một thư viện Bash [dybatpho](https://github.com/dynamotn/dybatpho). Bằng cách sử dụng thư viện, một số quy tắc trong hướng dẫn phong cách này đã được đảm bảo. Các mục được hỗ trợ sẵn được đánh dấu rõ ràng là `(dybatpho)`.

```sh
DYBATPHO_DIR="<path to dybatpho>"
. "${DYBATPHO_DIR}/init.sh"
```

### Trình kiểm tra

[dyshellint](https://github.com/dynamotn/dyshellint) ([GitLab](https://gitlab.com/dynamo-tools/dyshellint)) kiểm tra một script theo hướng dẫn này. Nó điều phối toàn bộ việc kiểm tra: các quy tắc riêng của hướng dẫn này — namespace, chú thích sh-docs, bố cục tệp, quy ước dybatpho — cùng với [ShellCheck](https://www.shellcheck.net/) dùng `.shellcheckrc` và [shfmt](https://github.com/mvdan/sh) dùng các tùy chọn của chương Định dạng. Quy tắc ✔️ NÊN và ❌ TRÁNH được báo là lỗi, quy tắc ⚠️ CÂN NHẮC được báo là cảnh báo.

```sh
go install gitlab.com/dynamo-tools/dyshellint/cmd/dyshellint@latest

# Một kho, hoặc một tệp
dyshellint ./scripts
dyshellint --format json ./scripts/deploy.sh

# Toàn bộ quy tắc, kèm mục trong hướng dẫn này mà nó thuộc về
dyshellint --list-rules

# Buffer chưa được lưu, thứ mà trình soạn thảo cần kiểm tra
cat script.sh | dyshellint --stdin-filename script.sh -
```

Mỗi quy tắc có một mã: `BSG###` cho quy tắc của hướng dẫn này, `SC####` cho phát hiện của ShellCheck, và `FMT001` cho khác biệt định dạng. Có thể tắt bất kỳ mã nào cho một lần chạy bằng `--exclude-rules`, và có thể tắt tại chỗ một phát hiện của ShellCheck bằng chú thích `# shellcheck disable=SCXXXX` kèm lý do. Một gợi ý được trình kiểm tra kiểm tra sẽ kết thúc bằng mã của quy tắc kiểm tra nó, hiển thị như một phím bấm, chẳng hạn <kbd>BSG010</kbd>, để một phát hiện dẫn thẳng tới câu mà nó thực thi. [`scripts/sync_rule_codes.sh`](scripts/sync_rule_codes.sh) giữ các mã đó khớp với `dyshellint --list-rules`: nó gắn mã của một quy tắc mới vào gợi ý khớp nhất trong mục của quy tắc, để bạn xem lại, gỡ mã của quy tắc đã bị bỏ, và chép các mã sang bản dịch; `--check`, thứ mà hook và CI chạy, chỉ báo cáo.

[`.shellcheckrc`](.shellcheckrc) và [`.editorconfig`](.editorconfig) trong kho này là cấu hình mà hướng dẫn yêu cầu, và được dùng để sao chép vào dự án của bạn. `dyshellint` đọc `.shellcheckrc` của dự án mà nó kiểm tra, và cũng kèm sẵn một định nghĩa [nvim-lint](https://github.com/mfussenegger/nvim-lint) cho Neovim.

Các ví dụ nên dùng của hướng dẫn này cũng phải tuân theo nó. [`scripts/lint_examples.sh`](scripts/lint_examples.sh) trích mọi khối `sh` nằm dưới nhãn **Nên dùng**, ở cả hai ngôn ngữ, chạy dyshellint trên đó, và báo từng phát hiện theo dòng của README. Nó chỉ bỏ qua những quy tắc mà một đoạn mã vi phạm chỉ vì nó là một đoạn trích: không có phần đầu tệp, không có shebang, biến được đặt ở nơi khác. Một khối cố ý minh họa một ngoại lệ ghi tên ngoại lệ đó ở dòng ngay trước dấu mở khối, `<!-- lint: allow BSG040 -->`, và `<!-- lint: skip -->` loại một khối ra. Cùng bước kiểm tra này chạy như một hook [prek](https://github.com/j178/prek) từ [`.pre-commit-config.yaml`](.pre-commit-config.yaml), và trong CI.

```sh
bash ./scripts/lint_examples.sh
prek run --all-files
```

## Bối cảnh

### Nên sử dụng shell nào

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng Bash cho tất cả các script
> - ✔️ NÊN: Viết `#!/usr/bin/env bash` ở đầu script. (tùy chỉnh) <kbd>BSG030</kbd>
> - ✔️ NÊN: Sử dụng `set -euo pipefail` cho các cài đặt tùy chọn shell. (tùy chỉnh) <kbd>BSG031</kbd>
> - ✔️ NÊN: Sau khi source [dybatpho](https://github.com/dynamotn/dybatpho), bạn có thể bỏ qua `set -euo pipefail`. (dybatpho)
> - ⚠️ CÂN NHẮC: Nếu sử dụng các shell khác, hãy giải thích lý do trong phần nhận xét. (tùy chỉnh)

Sử dụng Bash. Hạn chế tất cả các script shell có thể thực thi đối với `bash` đảm bảo một shell nhất quán được cài đặt trên tất cả các máy.

Các tệp thực thi phải bắt đầu bằng `#!/usr/bin/env bash` và các cờ tối thiểu. Sử dụng `#!/usr/bin/env bash` cung cấp một số lợi thế đáng chú ý: hoạt động trên các môi trường (như Fedora hoặc Termux), mặc dù có một chút ảnh hưởng đến hiệu suất từ việc gọi env để tìm kiếm PATH.

Sử dụng `set` cho cài đặt tùy chọn shell đảm bảo rằng ngay cả khi script được gọi bằng `bash script_name`, chức năng của nó không bị suy giảm. `set -e` kết thúc script nếu xảy ra lỗi. `set -u` kích hoạt lỗi khi tham chiếu đến các biến không xác định. `set -o pipefail` kết thúc script nếu xảy ra lỗi ở giữa pipeline. Chỉ thêm `-E` khi script tự cài trap `ERR`, để các hàm và subshell kế thừa nó; `dybatpho::register_common_handlers` tự bật cờ này.

**Nên dùng**

```sh
#!/usr/bin/env bash
set -euo pipefail
# Nếu không dùng dybatpho

#!/usr/bin/env bash
DYBATPHO_DIR="<path to dybatpho>"
if [[ ! -f "${DYBATPHO_DIR}/init.sh" ]]; then
  printf 'dybatpho not found in %s\n' "${DYBATPHO_DIR}" >&2
  exit 1
fi
. "${DYBATPHO_DIR}/init.sh"
# Nếu dùng dybatpho
```

**Không nên dùng**

```sh
#!/bin/bash
# Thiếu set
# Sai shebang

#!/bin/bash -euo pipefail
# Để tùy chọn -euo ngay sau shebang, nó sẽ bị vô hiệu hóa khi gọi `bash ./script.sh`
# Sai shebang
```

### Phiên bản Bash

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Nhắm tới Bash 4.4 trở lên, và ghi rõ điều này trong README của dự án. (tùy chỉnh)
> - ✔️ NÊN: Kiểm tra `BASH_VERSINFO` ở đầu một entrypoint, trước mọi thứ cần một tính năng mới hơn, và dừng lại với một thông báo nêu phiên bản đang có <kbd>BSG099</kbd>
> - ✔️ NÊN: Ghi phiên bản đã giới thiệu một tính năng bên cạnh quy tắc phụ thuộc vào nó, khi phiên bản đó mới hơn mục tiêu
> - ❌ TRÁNH: Không cho rằng `bash` trên `PATH` là bản mới: macOS vẫn đi kèm Bash 3.2 ở `/bin/bash`
> - ❌ TRÁNH: Không so sánh phiên bản theo dạng `major >= X && minor >= Y`, dạng này từ chối Bash 6.0 khi mức tối thiểu là 5.2, và không so sánh `BASH_VERSION` như chuỗi, khi đó `5.10` xếp trước `5.2` <kbd>BSG116</kbd>

Hướng dẫn này dựa vào các tính năng mà những bản cũ không có: nameref (`local -n`, 4.3), `mapfile -d` và `local -` (4.4), và mảng rỗng được `set -u` chấp nhận (4.4). Trên Bash 3.2, một script viết theo cách này không thất bại ngay chỗ thiếu tính năng; nó thất bại muộn hơn, với `invalid option` hay `unbound variable`, ở xa nguyên nhân. Một bước kiểm tra ở đầu biến điều đó thành một thông báo mà người dùng có thể xử lý, chẳng hạn cài một bản Bash mới hơn bằng Homebrew, bản mà `#!/usr/bin/env bash` sẽ tìm thấy trước.

dybatpho tự kiểm tra phiên bản Bash nó cần khi được source. (dybatpho)

**Nên dùng**

```sh
#!/usr/bin/env bash
# Bash 3.2 vẫn phân tích được đoạn này, nên người dùng thấy đúng thông báo
if ((BASH_VERSINFO[0] < 4 || (BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4))); then
  printf 'This script needs Bash 4.4 or newer, found %s\n' "${BASH_VERSION}" >&2
  exit 1
fi
set -euo pipefail
```

**Không nên dùng**

```sh
#!/usr/bin/env bash
set -euo pipefail
# Trên Bash 3.2: `local: -n: invalid option`, rồi `mapfile: command not found`
local -n result="$1"
mapfile -d '' -t files < <(command find . -print0)
```

Mức tối thiểu 5.2 thỏa mãn với mọi major lớn hơn 5 bất kể minor, và với major 5 chỉ từ minor 2 trở lên. Kiểm tra cả hai số bằng `&&` làm mất nửa đầu: Bash 6.0 có minor là 0 và bị từ chối. Hãy viết phép so sánh major và trường hợp biên riêng rẽ, như trong bước kiểm tra ở trên.

**Không nên dùng**

```sh
# Từ chối Bash 6.0: minor 0 nhỏ hơn 2
((BASH_VERSINFO[0] >= 5 && BASH_VERSINFO[1] >= 2)) || exit 1
# So sánh chuỗi: "5.10.0" < "5.2"
[[ "${BASH_VERSION}" > "5.2" ]] || exit 1
```

### Khi nào nên sử dụng shell

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Chỉ sử dụng cho các tiện ích nhỏ hoặc các đoạn wrapper script đơn giản
> - ✔️ NÊN: Nếu bạn muốn viết một vài dòng script trong CI như GitHub Actions, Gitlab CI..., hãy tạo một shell script thay vì nhúng nó vào file yaml. (tùy chỉnh)
> - ✔️ NÊN: Nếu gọi cùng một tiến trình với các tham số khác nhau trong nhiều workflow, hãy tạo một shell script. (tùy chỉnh)
> - ⚠️ CÂN NHẮC: Nếu hiệu năng là yếu tố quan trọng, hãy cân nhắc các ngôn ngữ khác ngoài shell
> - ⚠️ CÂN NHẮC: Nếu viết một script trên 100 dòng hoặc sử dụng logic điều khiển phức tạp, hãy viết lại nó bằng một ngôn ngữ có cấu trúc càng sớm càng tốt. Nên dự kiến trước rằng script sẽ phát triển. Viết lại sớm có thể tránh được việc viết lại tốn thời gian sau này
> - ⚠️ CÂN NHẮC: Khi đánh giá độ phức tạp của code (ví dụ: quyết định có nên chuyển đổi ngôn ngữ hay không), hãy xem xét liệu code có thể dễ dàng được bảo trì bởi người khác ngoài tác giả ban đầu hay không

Shell là một lựa chọn phù hợp cho các tác vụ chủ yếu liên quan đến việc gọi các tiện ích khác và thực hiện tương đối ít thao tác dữ liệu. Mặc dù shell script không phải là một ngôn ngữ phát triển, chúng được sử dụng để tạo ra các script tiện ích khác nhau trong CI hoặc triển khai tới máy người dùng.


## Tệp shell và cách thực thi trình thông dịch

### Phần mở rộng tệp

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng phần mở rộng `.sh` cho các script là thư viện và `chmod -x` cho chúng. <kbd>BSG037</kbd>
> - ✔️ NÊN: Không sử dụng phần mở rộng cho các script trong PATH và `chmod -x` cho chúng.
> - ✔️ NÊN: Sử dụng phần mở rộng `.sh` cho các script không ở trong PATH và có thể gọi từ CLI. `chmod +x` cho chúng. (tùy chỉnh)

Các tệp thực thi nên có phần mở rộng `.sh` (rất khuyến khích) hoặc không có phần mở rộng. Các script được source từ bên ngoài phải có phần mở rộng `.sh` và không nên được đánh dấu là có thể thực thi.

### SUID/SGID

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng `sudo` nếu bạn cần nâng quyền
> - ⚠️ CÂN NHẮC: Chạy một lệnh với quyền root bằng `dybatpho::privilege_run`, hàm chỉ dùng `sudo` hay `doas` khi script chưa phải root. (dybatpho)
> - ✔️ NÊN: Xóa các biến của trình nạp và trình thông dịch trước khi một wrapper có quyền cao chuyển giao bằng `exec`: `LD_PRELOAD`, `LD_LIBRARY_PATH`, `LD_AUDIT`, `BASH_ENV`, `ENV`, `PYTHONPATH`, `PERL5LIB`, `RUBYLIB`, `NODE_PATH`, hoặc khởi động chương trình dưới `env -i`
> - ❌ TRÁNH: SUID và SGID bị cấm
> - ❌ TRÁNH: `sudo` cũng bị cấm trong các script CI (tùy chỉnh). <kbd>BSG035</kbd>

SUID và SGID bị cấm trong shell script. Shell có nhiều vấn đề bảo mật, khiến cho việc đảm bảo an toàn đầy đủ để cho phép SUID/SGID là gần như không thể. Mặc dù bash gây khó khăn cho việc thực thi SUID, nhưng nó vẫn có thể xảy ra trên một số nền tảng, vì vậy nó bị cấm. Nếu cần nâng quyền, hãy sử dụng `sudo`.

Miễn là các script được thực thi trong CI, `sudo`, SUID và SGID là không cần thiết và do đó bị cấm.

**Nên dùng**

<!-- lint: allow BSG035 -->
```sh
# Sử dụng sudo khi gọi (Trừ trong CI)
sudo ./foo.sh
```

**Không nên dùng**

```sh
# Chuyển sang người dùng su hoặc root bên trong script
```

Một wrapper chạy qua `sudo`, một unit systemd hay `ForceCommand` của SSH rồi khởi động một chương trình khác sẽ truyền môi trường của nó sang. `LD_PRELOAD` nạp một thư viện do bên gọi chọn vào chương trình đó, `BASH_ENV` chạy một tệp trước mọi script Bash mà nó khởi động, và `PYTHONPATH` tráo các module của một helper Python. Xóa chúng, hoặc bắt đầu từ một môi trường rỗng, giữ cho helper chạy đúng đoạn mã mà nó được cài đặt cùng.

**Nên dùng**

```sh
unset LD_PRELOAD LD_LIBRARY_PATH LD_AUDIT BASH_ENV ENV PYTHONPATH PERL5LIB RUBYLIB NODE_PATH
exec /usr/libexec/app/helper "$@"
```

```sh
# Mạnh hơn: không kế thừa gì ngoài những gì được nêu tên
exec env -i HOME="${HOME}" PATH=/usr/bin:/bin /usr/libexec/app/helper "$@"
```

**Không nên dùng**

```sh
# Chạy qua sudo: LD_PRELOAD và BASH_ENV tới được helper
exec /usr/libexec/app/helper "$@"
```

`dybatpho::privilege_run` chạy thẳng lệnh khi script đã là root, nếu không thì chạy qua `sudo`, hoặc `doas` ở nơi không có `sudo`, có tôn trọng `DRY_RUN`. Hàm không từ chối chạy trong CI và cũng không xóa `LD_PRELOAD` cùng các biến khác của trình nạp, nên các quy tắc ở trên vẫn áp dụng cho nó. (dybatpho)

**Nên dùng**

```sh
dybatpho::privilege_run -- systemctl restart nginx
```

## Môi trường

### Cách gọi script

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Gọi script bằng `bash ./script.sh`, hoặc bằng tên của nó nếu script nằm trong PATH
> - ✔️ NÊN: Đặt dấu nháy cho mọi tham số có thể chứa dấu cách
> - ❌ TRÁNH: Không gọi một script thực thi bằng `.` hay `source`. Chỉ dùng chúng cho script thư viện. (tùy chỉnh)

Gọi bằng `bash ./script.sh` đảm bảo đúng trình thông dịch dù tệp có quyền thực thi hay không, và giữ cho các tùy chọn `set` bên trong script không rò rỉ ra shell đang gọi. Khi `source` một script thực thi, nó chạy ngay trong shell hiện tại, nên một lệnh `exit` thất bại sẽ đóng luôn phiên làm việc thay vì chỉ dừng script.

**Nên dùng**

```sh
bash ./scripts/test.sh --all
bash ./scripts/docker.sh --log-level debug "${identity}"
```

**Không nên dùng**

```sh
# Phụ thuộc vào quyền thực thi và vào việc shebang có được tôn trọng hay không
./scripts/test.sh --all

# Chạy ngay trong shell đang gọi, một lệnh exit bên trong sẽ đóng phiên làm việc
. ./scripts/test.sh --all
```

### Kiểm soát tham số của script

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Nhận mọi tham số dưới dạng tùy chọn có tên `--option value`
> - ✔️ NÊN: Khai báo giao diện của script trong hàm `_spec_<entrypoint>` bằng `dybatpho::opts::*`, rồi chạy nó với `dybatpho::generate_from_spec "_spec_<entrypoint>" "$@"`. (dybatpho) <kbd>BSG051</kbd>
> - ✔️ NÊN: Đặt tên biến nhận giá trị tùy chọn bằng `CHỮ HOA`, và cho mọi tùy chọn không bắt buộc một giá trị mặc định qua `init:=`. (tùy chỉnh)
> - ✔️ NÊN: Gom các tham số vị trí còn lại vào một mảng duy nhất, khai báo ở `dybatpho::opts::setup`
> - ✔️ NÊN: Khai báo tham số của hàm bằng `dybatpho::expect_args name... -- "$@"` thay vì tự đọc `$1`, `$2`. (dybatpho) <kbd>BSG050</kbd>
> - ✔️ NÊN: Luôn cung cấp `--help` thông qua `dybatpho::opts::disp` và `dybatpho::generate_help`. (dybatpho) <kbd>BSG052</kbd>
> - ❌ TRÁNH: Không nhận tham số vị trí trần như `script.sh value1 value2`, trừ khi đó là danh sách các phần tử cùng loại
> - ❌ TRÁNH: Không định nghĩa tùy chọn chỉ có tên viết tắt một chữ cái

Tùy chọn có tên tự giải thích ngay tại chỗ gọi: `--dry-run false` nói rõ nó làm gì, còn `false` đứng một mình thì không. Khai báo giao diện dưới dạng spec giúp gom việc phân tích tham số, giá trị mặc định, kiểm tra hợp lệ và văn bản trợ giúp vào một chỗ, và khiến mọi script trong kho mã có cùng một cách hành xử trên dòng lệnh.

Bên trong hàm cũng áp dụng quy tắc tương tự ở mức thấp hơn. `dybatpho::expect_args` đặt tên cho các tham số, báo lỗi rõ ràng khi bên gọi truyền thiếu, và đồng thời đóng vai trò tài liệu cho hàm.

**Nên dùng**

```sh
#######################################
# @description Spec of test.sh
#######################################
function _spec_main {
  dybatpho::opts::setup "Test the dotfiles setup" MAIN_ARGS action:"_main"
  dybatpho::opts::flag "Run all tests" ALL --all -a on:true off:false init:="false"
  dybatpho::opts::param "Log level" LOG_LEVEL --log-level -l init:="info" \
    validate:"dybatpho::validate_log_level \$OPTARG"
  dybatpho::opts::disp "Show help" --help -h action:"dybatpho::generate_help _spec_main"
}

dybatpho::generate_from_spec _spec_main "$@"
```

```sh
#######################################
# @description Install tool using dytoy
# @arg $1 string Name of tool
#######################################
function misc::install_tool {
  local name
  dybatpho::expect_args name -- "$@"
  dybatpho::is command "${name}" || dybatpho::dry_run dytoy -t "${name}"
}
```

**Không nên dùng**

```sh
# Tham số vị trí, không có giá trị mặc định, không có trợ giúp, không kiểm tra hợp lệ
name=$1
dry_run=$2

# Tự viết lại phần phân tích tham số, mỗi script một kiểu hơi khác nhau
while [[ $# -gt 0 ]]; do
  case "$1" in
    -a) ALL=true ;;
  esac
  shift
done
```

### Tự hoàn thành trong shell

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: In phần tự hoàn thành bằng `dybatpho::generate_completion <spec> <shell> [name]`, cho `bash`, `zsh` hoặc `fish`, từ một lệnh con `completion` hoặc một tùy chọn hiển thị của spec gốc, để có đủ các lệnh con và tùy chọn của chúng. (dybatpho)
> - ⚠️ CÂN NHẮC: Sinh phần tự hoàn thành từ hàm `_spec_*` phân tích tham số, không phải từ một hàm `complete` viết tay <kbd>BSG133</kbd>
> - ✔️ NÊN: Sinh văn bản trợ giúp và trang man từ cùng spec đó, bằng `dybatpho::generate_help` và `dybatpho::generate_man`. (dybatpho)
> - ✔️ NÊN: Khai báo một danh sách giá trị cố định bằng `choices:`, thứ mà bộ phân tích kiểm tra và phần tự hoàn thành gợi ý
> - ⚠️ CÂN NHẮC: Giữ bộ nhớ đệm của phần tự hoàn thành: dybatpho đặt khóa của nó theo script, tệp khai báo spec và phiên bản thư viện, trong `DYBATPHO_CLI_CACHE_DIR`, nên một lần sửa không bao giờ trả về bản cũ; `DYBATPHO_CLI_CACHE=false` sinh lại mỗi lần. (dybatpho)

Một hàm tự hoàn thành viết tay là danh sách tùy chọn thứ hai. Bộ phân tích bỏ `--region`, phần tự hoàn thành vẫn tiếp tục gợi ý nó, và không có gì thất bại cho tới khi người dùng nhấn tab và nhận được một tùy chọn mà script từ chối. Khi được sinh ra từ hàm `_spec_*` mà bộ phân tích được dựng từ đó, phần tự hoàn thành, văn bản trợ giúp và trang man thay đổi trong cùng commit với tùy chọn, vì không còn chỗ nào khác phải sửa.

Script in ra phần tự hoàn thành và shell của người dùng nạp nó, nên cài đặt chỉ là một lần chuyển hướng cho mỗi shell. Một shell source phần tự hoàn thành mỗi lần khởi động sẽ phải duyệt cả cây spec mỗi lần như vậy; dybatpho lưu output vào bộ nhớ đệm, và khóa tự thay đổi khi script, tệp chứa spec hay thư viện thay đổi. (dybatpho)

**Nên dùng**

```sh
#######################################
# @description Spec of deploy.sh
# @noargs
#######################################
function _spec_main {
  dybatpho::opts::setup "Deploy a service" MAIN_ARGS action:"_main"
  dybatpho::opts::param "Target environment" DEPLOY_ENV --env -e init:="staging" \
    choices:staging,production
  dybatpho::opts::cmd completion _spec_completion
  dybatpho::opts::disp "Show the man page" --man action:"dybatpho::generate_man _spec_main deploy.sh"
  dybatpho::opts::disp "Show help" --help -h action:"dybatpho::generate_help _spec_main"
}

#######################################
# @description Spec of deploy.sh completion
# @noargs
#######################################
function _spec_completion {
  dybatpho::opts::setup "Print the shell completion" COMPLETION_ARGS args:none action:"_completion"
  dybatpho::opts::param "Shell to complete for" COMPLETION_SHELL --shell \
    choices:bash,zsh,fish required:true
  dybatpho::opts::disp "Show help" --help -h action:"dybatpho::generate_help _spec_completion"
}

#######################################
# @description Print the completion of the whole command, from the root spec
# @noargs
#######################################
function _completion {
  dybatpho::generate_completion _spec_main "${COMPLETION_SHELL}" deploy.sh
}
```

```sh
deploy.sh completion --shell bash > "${XDG_DATA_HOME:-${HOME}/.local/share}/bash-completion/completions/deploy.sh"
deploy.sh completion --shell fish > "${XDG_CONFIG_HOME:-${HOME}/.config}/fish/completions/deploy.sh.fish"
```

**Không nên dùng**

```sh
function _spec_main {
  dybatpho::opts::setup "Deploy a service" MAIN_ARGS action:"_main"
  dybatpho::opts::param "Target environment" DEPLOY_ENV --env -e init:="staging"
  dybatpho::opts::disp "Show help" --help -h action:"dybatpho::generate_help _spec_main"
}

# Danh sách tùy chọn thứ hai: --region, đã bị bỏ khỏi spec, vẫn được gợi ý
function _complete_deploy {
  mapfile -t COMPREPLY < <(compgen -W "--env --region --help" -- "${COMP_WORDS[COMP_CWORD]-}")
}
complete -F _complete_deploy deploy.sh
```

### Phiên bản và phân phối

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Cung cấp `--version` trong spec của một entrypoint, in ra phiên bản đọc từ tệp `VERSION` hoặc từ một hằng số. (dybatpho) <kbd>BSG159</kbd>
> - ✔️ NÊN: Đánh dấu một tùy chọn là lỗi thời trong một bản phát hành trước khi xóa nó: giữ cho nó vẫn chạy và in cảnh báo, bằng `deprecated:"Use --new instead"` trên dòng `dybatpho::opts::*` của nó. (dybatpho)
> - ⚠️ CÂN NHẮC: Kiểm tra một tệp tải về với checksum hoặc chữ ký trước khi chạy, cài đặt hay giải nén nó <kbd>BSG160</kbd>
> - ✔️ NÊN: Để một bước tự cập nhật hay một trình cài đặt kiểm tra chữ ký của tệp checksum, rồi kiểm tra tệp mới với tệp đó bằng `dybatpho::verify_checksum`, trước khi thay thế bất cứ thứ gì. (dybatpho)
> - ✔️ NÊN: Phát hành kèm mỗi bản một tệp `SHA256SUMS` và ký nó, bằng `dybatpho::release_checksums` và `dybatpho::release_sign`. (dybatpho)

Một script được chép sang máy khác cần nói được nó là bản nào: một báo cáo lỗi bắt đầu bằng output của `--version` chỉ ra đúng đoạn code đã lỗi. Đọc phiên bản từ một tệp `VERSION` duy nhất, hoặc một hằng số duy nhất, giữ cho bản phát hành, phần trợ giúp và output đó khớp nhau. Xóa một tùy chọn làm hỏng mọi nơi gọi vẫn còn truyền nó, thường là trong một cron job không ai theo dõi; đánh dấu nó `deprecated:` trong một bản phát hành giúp các nơi đó vẫn chạy và, ở mỗi lần chạy, cho họ biết nên dùng gì thay thế.

**Nên dùng**

```sh
#######################################
# @description Print the version of this script
# @noargs
# @stdout The version, from the VERSION file next to the script
#######################################
function _print_version {
  local version
  read -r version < "${SCRIPT_DIR}/VERSION"
  printf '%s\n' "${version}"
}

#######################################
# @description Spec of deploy.sh
# @noargs
#######################################
function _spec_main {
  dybatpho::opts::setup "Deploy the app" MAIN_ARGS action:"_main"
  dybatpho::opts::param "Target environment" TARGET --target init:="staging"
  # Vẫn được nhận trong một bản phát hành, kèm cảnh báo, rồi bị xóa
  dybatpho::opts::param "Target environment" TARGET --env hidden:true deprecated:"Use --target instead"
  dybatpho::opts::disp "Show help" --help action:"dybatpho::generate_help _spec_main"
  dybatpho::opts::disp "Show version" --version action:"_print_version"
}
```

Một tệp tải về là bất cứ thứ gì mà server, một mirror hay một proxy ở giữa đã gửi, bị cắt ngắn khi kết nối rớt. Chạy, cài đặt hay giải nén nó trước khi kiểm tra là trao quyết định đó cho họ. Một checksum công bố cạnh tệp chỉ bắt được tệp tải về bị cắt ngắn hay hỏng, vì ai sửa được tệp thì cũng sửa được checksum bên cạnh; một chữ ký tạo bằng khóa mà script đã giữ sẵn thì bắt được cả tệp giả mạo. Hãy ký tệp checksum thay vì ký từng artifact: khi đó một chữ ký bao phủ mọi tệp mà nó liệt kê.

**Nên dùng**

```sh
# Khóa phát hành đi kèm script; một tệp checksum giả mạo dừng lại ở đây
local dir expected
dybatpho::create_temp_dir dir "update"
dybatpho::curl_download "${release_url}/SHA256SUMS" "${dir}/SHA256SUMS"
dybatpho::curl_download "${release_url}/SHA256SUMS.asc" "${dir}/SHA256SUMS.asc"
dybatpho::curl_download "${release_url}/deploy.sh" "${dir}/deploy.sh"
gpgv --keyring "${SCRIPT_DIR}/release.gpg" "${dir}/SHA256SUMS.asc" "${dir}/SHA256SUMS"
expected="$(awk '$2 == "deploy.sh" { print $1 }' "${dir}/SHA256SUMS")"
dybatpho::verify_checksum "${dir}/deploy.sh" "sha256:${expected}"
install -m 0755 -- "${dir}/deploy.sh" "${SCRIPT_DIR}/deploy.sh"
```

**Không nên dùng**

```sh
# Thay script bằng bất cứ thứ gì server gửi về
curl --fail -sSL --max-time 60 "${release_url}/deploy.sh" -o "${SCRIPT_DIR}/deploy.sh"
chmod +x "${SCRIPT_DIR}/deploy.sh"
```

`dybatpho::verify_checksum` nhận digest mong đợi dưới dạng `algorithm:hex`, với `sha256`, `sha1` hoặc `md5`, tính nó bằng công cụ nào mà hệ thống có, và trả về 7 khi không khớp; một digest rỗng hay sai dạng sẽ dừng script. Ở phía phát hành, `dybatpho::release_checksums` ghi một tệp `SHA256SUMS` theo đúng bố cục mà `sha256sum -c` đọc và in ra đường dẫn của nó, còn `dybatpho::release_sign` ký một tệp bằng `gpg`, hoặc bằng lệnh trong `DYBATPHO_RELEASE_SIGN_CMD`, như `minisign`, và in ra đường dẫn của chữ ký. (dybatpho)

**Nên dùng**

```sh
local sums
sums="$(dybatpho::release_checksums ./dist)"
dybatpho::release_sign "${sums}"
```

### Chế độ gỡ lỗi và chạy thử

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Để người gọi chọn mức chi tiết của log bằng tùy chọn `--log-level` gắn với `LOG_LEVEL`, kiểm tra bằng `dybatpho::validate_log_level`. (dybatpho)
> - ✔️ NÊN: Bật theo vết lệnh bằng `dybatpho::start_trace` thay vì viết `set -x` trực tiếp, và tắt bằng `dybatpho::end_trace`. (dybatpho) <kbd>BSG034</kbd>
> - ✔️ NÊN: Chạy mọi lệnh làm thay đổi trạng thái qua `dybatpho::dry_run`, để chế độ chạy thử chỉ in ra lệnh thay vì thực thi nó. (dybatpho) <kbd>BSG095</kbd>
> - ✔️ NÊN: Ưu tiên chế độ chạy thử do chính công cụ cung cấp, như `chezmoi diff` hay `kubectl --dry-run=server`, hơn là tự in lệnh ra
> - ❌ TRÁNH: Không thực hiện trực tiếp một tác dụng phụ trong script có hỗ trợ chạy thử, kể cả một lần tải về hay ghi cache "vô hại"
> - ⚠️ CÂN NHẮC: Đặt chạy thử làm mặc định cho script mà lần chạy thật có tính phá hủy. (tùy chỉnh)

Một script có thể được hỏi rằng nó *sẽ* làm gì là một script mà người ta dám chạy trên máy họ quan tâm. Bọc lệnh thay đổi trạng thái, thay vì rẽ nhánh quanh nó, giúp đường chạy thử và đường chạy thật giống hệt nhau cho tới bước cuối, nên lần chạy thử đi qua đúng những điều kiện và đúng những tham số đó.

**Nên dùng**

```sh
# Hàm bọc tự quyết định là chạy hay chỉ báo cáo
dybatpho::dry_run mv -- "${temp_file}" "${output_path}"
dybatpho::dry_run chmod +x -- "${output_path}"

# Đọc thẳng DRY_RUN cũng được khi cần bỏ qua cả một khối lệnh
if dybatpho::is true "${DRY_RUN}"; then
  dybatpho::info "Would download ${url}"
  return 0
fi

# Theo vết lệnh, có giới hạn phạm vi
dybatpho::start_trace
do_something
dybatpho::end_trace
```

**Không nên dùng**

```sh
# Theo vết không bao giờ được tắt, và người gọi không điều khiển được
set -x

# Logic bị lặp: nhánh chạy thử dần dần lệch khỏi nhánh chạy thật
if [[ "$DRY_RUN" == "true" ]]; then
  echo "mv $temp_file $output_path"
else
  mv "$temp_file" "$output_path"
fi
```

Chạy thử chỉ có giá trị khi nó không thay đổi gì. Chỉ một lệnh `curl -o`, `rm` hay `systemctl` chạy trực tiếp giữa những lệnh đã được bọc cũng khiến `--dry-run` nói dối: người dùng tin nó, và chính tác dụng phụ nó không báo vẫn xảy ra.

**Nên dùng**

```sh
dybatpho::dry_run curl --fail -sSL "${url}" -o "${target}"
dybatpho::dry_run rm -f -- "${old_version}"
dybatpho::dry_run systemctl --user restart app.service
```

**Không nên dùng**

```sh
# --dry-run vẫn tải về và ghi tệp
curl --fail -sSL "${url}" -o "${target}"
dybatpho::dry_run systemctl --user restart app.service
```

### Output theo vết

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Để `PS4` cho biết mỗi dòng theo vết đến từ đâu: tệp, `${LINENO}` và hàm <kbd>BSG156</kbd>
> - ✔️ NÊN: Bật theo vết lệnh bằng `dybatpho::start_trace`, hàm đã đặt sẵn một `PS4` gồm tệp, dòng và hàm. (dybatpho)
> - ✔️ NÊN: Gửi output theo vết vào một tệp riêng bằng `BASH_XTRACEFD` (Bash 4.1), chỉ chủ sở hữu đọc được, để nó không lẫn với các thông báo trên `STDERR` và không rơi vào `2>&1` của bên gọi
> - ❌ TRÁNH: Không theo vết một dòng có khai triển một bí mật, trong một biến hay trong một tham số: output theo vết in ra giá trị đó, ở dạng rõ, vào một log tồn tại lâu hơn lần chạy
> - ✔️ NÊN: Tắt theo vết trong một hàm xử lý bí mật, `local -` rồi `{ set +x; } 2> /dev/null`; `local -` (Bash 4.4) bật lại nó khi hàm trả về
> - ✔️ NÊN: Đọc bí mật bằng `dybatpho::secret_from_file`, `dybatpho::secret_from_env` hoặc `dybatpho::secret_from_stdin`, các hàm tạm dừng theo vết trong lúc giữ giá trị, và đưa nó cho một lệnh bằng `dybatpho::secret_with_file`, hàm giữ theo vết ở trạng thái tắt trong lúc lệnh chạy. (dybatpho)

`PS4` mặc định là `+ `: khi đó output theo vết của một script source ba thư viện là một chuỗi lệnh không cách nào biết mỗi lệnh đến từ tệp, dòng hay hàm nào. `PS4` được khai triển lại trước mỗi dòng theo vết, nên một giá trị trong nháy đơn có `${BASH_SOURCE[0]}`, `${LINENO}` và `${FUNCNAME[0]}` gắn cho mỗi dòng vị trí của nó.

`BASH_XTRACEFD` chỉ ra descriptor mà output theo vết đi tới. Unset nó sẽ đưa output theo vết về lại `STDERR` và đóng descriptor đó; vì lý do này nó không bao giờ giữ giá trị `2`, vì unset sẽ đóng luôn cả descriptor này.

**Nên dùng**

```sh
PS4='+ ${BASH_SOURCE[0]##*/}:${LINENO}:${FUNCNAME[0]:-main}: '

# Output theo vết chứa mọi giá trị script xử lý: chỉ chủ sở hữu đọc được
local trace_fd
(umask 077 && : >> "${TRACE_FILE}")
exec {trace_fd}>> "${TRACE_FILE}"
BASH_XTRACEFD="${trace_fd}"
dybatpho::start_trace
deploy::run
dybatpho::end_trace
# Đồng thời đóng trace_fd
unset BASH_XTRACEFD
```

**Không nên dùng**

```sh
# "+ cp ..." từ tệp nào, hàm nào?
PS4='+ '
```

Theo vết in ra mỗi lệnh sau khi khai triển, kèm các tham số của nó. Mọi dòng khai triển một token, trong một phép gán, một header của `curl` hay các tham số của một helper, đều in ra token đó. `dybatpho::secret_mask` che các giá trị đã đăng ký trong văn bản nó nhận, nhưng dòng theo vết của chính lời gọi nó đã được ghi ra rồi; output theo vết an toàn duy nhất là output được tắt trong lúc giá trị nằm trên một dòng lệnh.

`dybatpho::secret_from_file`, `dybatpho::secret_from_env` và `dybatpho::secret_from_stdin` tắt theo vết trong lúc đọc và đăng ký giá trị, và chỉ bật lại nếu trước đó nó đang bật. `dybatpho::secret_with_file` nhận tên của biến, không phải giá trị của nó, và giữ theo vết ở trạng thái tắt trong lúc lệnh đọc bí mật từ một đường dẫn `/dev/fd`. (dybatpho)

**Nên dùng**

```sh
local passphrase
dybatpho::secret_from_file passphrase "${PASSPHRASE_FILE}"
dybatpho::secret_with_file passphrase gpg --batch --passphrase-file '{}' --decrypt -- "${archive}"

function api::get {
  local url target
  dybatpho::expect_args url target -- "$@"
  # Theo vết dừng ở đây và tiếp tục khi hàm trả về
  local -
  { set +x; } 2> /dev/null
  dybatpho::curl_auth_bearer "${url}" "${API_TOKEN}" "${target}"
}
```

**Không nên dùng**

```sh
dybatpho::start_trace
# Bị theo vết thành: + dybatpho::curl_auth_bearer https://... eyJhbGciOi... /tmp/me.json
dybatpho::curl_auth_bearer "${url}" "${API_TOKEN}" "${target}"
```

### Lệnh tự kiểm tra

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Cung cấp một lệnh con `doctor`, hoặc một tùy chọn `--check`, báo cáo mọi thứ script cần đã sẵn sàng hay chưa và không thay đổi gì
> - ✔️ NÊN: Kiểm tra hết, báo cáo mọi vấn đề tìm thấy, và chỉ khi đó mới thoát với mã khác 0, để một lần chạy liệt kê đủ mọi thứ cần sửa
> - ✔️ NÊN: Báo cáo những gì các module dybatpho đã nạp cần bằng `dybatpho::doctor` (`--quiet` để chỉ lấy mã thoát, `--json` cho máy đọc), rồi thêm các bước kiểm tra riêng của dự án bằng `dybatpho::is command`, `dybatpho::command_version`, `dybatpho::command_exists_all` và `dybatpho::is readable`/`writeable`/`dir`. (dybatpho)
> - ✔️ NÊN: Giữ `dybatpho::require` cho phần đầu của một lần chạy thật, nơi dừng lại ở lệnh thiếu đầu tiên là đúng; một bản báo cáo dừng ở đó sẽ che mất phần còn lại. (dybatpho)
> - ❌ TRÁNH: Không sửa chữa gì từ bước kiểm tra: không cài đặt, không `mkdir`, không ghi cấu hình

Người dùng chạy một script trên máy mới sẽ gặp một công cụ còn thiếu, cài nó, chạy lại, rồi gặp công cụ tiếp theo. Một lệnh tự kiểm tra biến vòng lặp đó thành một danh sách duy nhất. Đó cũng là thứ mà một job CI hay một script cài đặt có thể gọi trước phần việc thật, nên nó phải trả lời bằng mã thoát chứ không chỉ bằng văn bản: 0 chỉ khi một lần chạy thật sẽ tìm thấy đủ những gì nó cần.

Một bước kiểm tra tự sửa những gì nó tìm thấy thì không còn là bước kiểm tra nữa. Nó cần cùng quyền với lần chạy thật, nó có thể thất bại giữa chừng, và người dùng hỏi "máy này đã sẵn sàng chưa?" nhận về một cái máy đã bị thay đổi thay vì một câu trả lời. Hãy báo cáo vấn đề cùng lệnh để sửa nó, và để việc sửa cho người dùng hoặc cho lần chạy thật.

`dybatpho::doctor` đi kèm module `doctor` và bao quát chính thư viện: các lệnh mà những module đã nạp gọi tới, phiên bản của chúng, và bản Bash đang chạy, so với mức tối thiểu của riêng dybatpho. Nó không biết gì về các công cụ mà dự án gọi, cũng không biết gì về mức Bash tối thiểu của dự án (xem [Ma trận phiên bản Bash](#ma-tr%E1%BA%ADn-phi%C3%AAn-b%E1%BA%A3n-bash)). (dybatpho)

**Nên dùng**

```sh
#######################################
# @description Report whether deploy.sh can run here, and change nothing
# @noargs
# @exitcode 0 Everything a run needs is in place
# @exitcode 1 Something is missing; every problem was reported
#######################################
function _doctor {
  local failed=0 tool version
  dybatpho::doctor || failed=1
  for tool in kubectl helm jq; do
    if ! dybatpho::is command "${tool}"; then
      dybatpho::error "${tool} is not installed"
      failed=1
    elif version="$(dybatpho::command_version "${tool}")"; then
      dybatpho::info "${tool} ${version}"
    fi
  done
  dybatpho::command_exists_all gpg age \
    || dybatpho::warn "Encrypted backups are off: they need both gpg and age"
  dybatpho::is readable "${CONFIG_FILE}" || {
    dybatpho::error "Cannot read ${CONFIG_FILE}; copy config.example.yaml there"
    failed=1
  }
  dybatpho::is writeable "${STATE_DIR}" || {
    dybatpho::error "Cannot write to ${STATE_DIR}; create it with: mkdir -p ${STATE_DIR}"
    failed=1
  }
  return "${failed}"
}
```

**Không nên dùng**

```sh
function _doctor {
  # Dừng ở lệnh thiếu đầu tiên: mỗi lần chạy chỉ thấy một vấn đề
  dybatpho::require kubectl
  dybatpho::require helm
  # Bước kiểm tra thay đổi chính cái máy mà nó được hỏi tới
  mkdir -p -- "${STATE_DIR}"
  dybatpho::success "Everything is in place"
}
```

### STDOUT và STDERR

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Tất cả các thông báo lỗi và nghiêm trọng nên được chuyển đến `STDERR` <kbd>BSG036</kbd>
> - ✔️ NÊN: Sử dụng biến `LOG_LEVEL` để kiểm soát mức độ ghi log với 6 cấp độ: trace, debug, info, warn, error, fatal. (tùy chỉnh)
> - ✔️ NÊN: Triệt tiêu tất cả các thông báo không cần thiết vào `/dev/null`. (tùy chỉnh)
> - ✔️ NÊN: Sử dụng thư viện ghi log từ [dybatpho](https://github.com/dynamotn/dybatpho) để xuất các thông báo để ghi log tốt hơn. (dybatpho)
> - ✔️ NÊN: Giữ standard output của một hàm bị bắt output chỉ cho kết quả của nó: gửi tiến độ, đường dẫn và thông báo sang `STDERR` hoặc `/dev/null`
> - ✔️ NÊN: Gửi cả hai luồng về một nơi bằng `&>` và `&>>`: `cmd &> /dev/null`, `cmd &>> "${log}"`
> - ❌ TRÁNH: Không gọi một helper in ra `STDOUT` từ một hàm mà output của nó bị bên gọi bắt lại hoặc pipe vào một tệp
> - ❌ TRÁNH: Không trộn `&>` với `> file 2>&1` trong cùng một codebase, và không bao giờ viết `2>&1 > file`, cách này vẫn gửi lỗi ra terminal <kbd>BSG122</kbd>

**Nên dùng**

```sh
# thông báo lỗi đến stderr
echo "Error: Không thể thực hiện do_something" >&2

# mức log mặc định là info
LOG_LEVEL=info

# triệt tiêu các thông báo không cần thiết
curl -fsSL --max-time 30 "${url}" 2> /dev/null

# sử dụng dybatpho
dybatpho::error "Không thể thực hiện do_something"
dybatpho::debug "var_1 là ${var_1}"
dybatpho::start_trace
do_something
```

**Không nên dùng**

```sh
# thông báo lỗi đến stdout
echo "LỖI: Không thể thực hiện do_something"

# hiển thị các thông báo không cần thiết
grep -rn "abc" README.md || echo "LỖI: README.md không có từ 'abc'"
```

Khi bên gọi viết `value="$(fn)"` hay `fn | store`, mọi thứ trên standard output đều là kết quả. Một helper bên trong `fn` in ra thư mục nó vừa tạo, hay một dòng tiến độ, sẽ trở thành một phần của giá trị: một mục cache bắt đầu bằng một đường dẫn, một đường dẫn archive kèm theo `Packaging ...`.

**Nên dùng**

```sh
function cache::set {
  local key
  dybatpho::expect_args key -- "$@"
  dybatpho::ensure_dir "${CACHE_DIR}" > /dev/null
  cat > "${CACHE_DIR}/${key}"
}

function release::package {
  printf 'Packaging %s\n' "${name}" >&2
  printf '%s\n' "${archive}"
}
```

**Không nên dùng**

```sh
function release::package {
  # Bên gọi bắt đường dẫn archive, và nhận luôn cả dòng tiến độ
  printf 'Packaging %s\n' "${name}"
  printf '%s\n' "${archive}"
}
archive="$(release::package)"
```

Các phép chuyển hướng được áp dụng từ trái sang phải. `> file 2>&1` trỏ standard output vào tệp, rồi trỏ standard error vào cùng chỗ đó; `2>&1 > file` trỏ standard error vào terminal trước rồi mới chuyển standard output đi, nên lỗi vẫn hiện ra màn hình. `&>` nói "cả hai" trong một toán tử và không thể bị viết sai thứ tự.

**Nên dùng**

```sh
command -v jq &> /dev/null
backup::run &>> "${LOG_FILE}"
```

**Không nên dùng**

```sh
# Lỗi vẫn ra terminal: 2>&1 sao chép nó trước khi > chuyển stdout đi
backup::run 2>&1 > "${LOG_FILE}"
```

### Hiển thị tiến độ

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Ghi tiến độ ra `STDERR`, không bao giờ ra `STDOUT`, nơi nó trở thành một phần của kết quả mà bên gọi bắt lại hoặc pipe đi tiếp
> - ⚠️ CÂN NHẮC: Chỉ vẽ một dòng tiến độ bằng `\r` hay một escape xóa dòng khi STDERR là terminal, `[[ -t 2 ]]` <kbd>BSG157</kbd>
> - ✔️ NÊN: Khi không có terminal, ghi một dòng thường cho mỗi bước, hoặc một dòng tóm tắt ở cuối, thay vì vẽ lại
> - ✔️ NÊN: Bỏ màu và việc di chuyển con trỏ khi `NO_COLOR` được đặt hoặc `TERM` là `dumb`; `dybatpho::color_supported stderr` trả lời cả hai, còn `dybatpho::is_tty stderr` hỏi xem có terminal không. (dybatpho)
> - ✔️ NÊN: Hiển thị tiến độ bằng `dybatpho::spinner` và `dybatpho::tui_progress_start`, `dybatpho::tui_progress_step` và `dybatpho::tui_progress_stop`, các hàm chỉ vẽ trên `STDERR` khi có terminal và ghi các dòng log khi không có. (dybatpho)
> - ❌ TRÁNH: Không hiển thị tiến độ bằng `dybatpho::progress` hay `dybatpho::progress_bar`: cả hai ghi ra `STDOUT` và không bao giờ kiểm tra terminal. (dybatpho)

Một dòng tiến độ tự vẽ lại chính nó: `\r` đưa con trỏ về đầu dòng và `\033[K` xóa phần còn lại. Terminal biến việc đó thành một dòng thay đổi tại chỗ; một log CI, một tệp hay một pipe giữ lại mọi ký tự, và một nghìn lần cập nhật đến nơi thành một dòng gồm một nghìn khung hình và mã điều khiển. Trên `STDOUT`, các khung hình đó còn rơi vào `value="$(fn)"` và vào bất cứ thứ gì output được pipe tới.

`NO_COLOR`, với bất kỳ giá trị khác rỗng nào, yêu cầu không dùng màu, còn `TERM=dumb`, như trong một buffer shell của Emacs, là một terminal không di chuyển được con trỏ hay xóa được dòng. Cả hai vẫn đọc tốt các dòng thường.

**Nên dùng**

```sh
local total=${#files[@]} done_count=0 file
for file in "${files[@]}"; do
  upload::one "${file}"
  done_count=$((done_count + 1))
  if [[ -t 2 && "${TERM:-}" != dumb ]]; then
    printf '\r\033[KUploaded %d/%d' "${done_count}" "${total}" >&2
  fi
done
[[ ! -t 2 ]] || printf '\n' >&2
dybatpho::info "Uploaded ${total} files"
```

**Không nên dùng**

```sh
for file in "${files[@]}"; do
  upload::one "${file}"
  done_count=$((done_count + 1))
  # Trong log CI là một dòng dài vô tận toàn khung hình; trong $(...) là một phần của kết quả
  printf '\rUploaded %d/%d' "${done_count}" "${total}"
done

# Tương tự qua một helper: ra STDOUT, dù có terminal hay không
dybatpho::progress_bar "$((done_count * 100 / total))"
```

`dybatpho::spinner` chạy một lệnh và hiển thị một spinner cạnh một thông báo trong lúc lệnh chạy, chỉ khi `STDERR` là terminal; nếu không, nó ghi log thông báo một lần. Các helper `dybatpho::tui_progress_*` vẽ một thanh tiến độ trên `STDERR` khi standard input và `STDERR` là terminal và `TERM` không phải `dumb`, và ghi một dòng log ở mỗi mốc báo cáo khi không phải. `dybatpho::progress` in một banner và `dybatpho::progress_bar` in một thanh với `\r`, cả hai ra `STDOUT` mà không kiểm tra gì: hãy để chúng ngoài mọi hàm có output bị bắt lại và mọi script có output được ghi log. (dybatpho)

**Nên dùng**

```sh
dybatpho::spinner "Downloading dependencies" -- npm ci

dybatpho::tui_progress_start "Uploading" "${#files[@]}"
for file in "${files[@]}"; do
  upload::one "${file}"
  dybatpho::tui_progress_step
done
dybatpho::tui_progress_stop "Uploaded ${#files[@]} files"
```

### Ghi log hệ thống

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dưới systemd, ghi thông báo ra `STDERR`: journald lưu mỗi dòng cùng unit, thời gian và tiến trình
> - ✔️ NÊN: Gửi thông báo tới log hệ thống từ một script chạy ngoài trình giám sát bằng `logger -t <tag>`, và đặt độ ưu tiên cho nó bằng `-p`
> - ✔️ NÊN: Chạy một lệnh có output thuộc về journal dưới `systemd-cat -t <tag>`
> - ⚠️ CÂN NHẮC: Để `/var/log` cho hệ thống: ghi ra `STDERR` hoặc dùng `logger` thay vì ghi nối vào một tệp ở đó <kbd>BSG138</kbd>
> - ✔️ NÊN: Khi bắt buộc phải có tệp log, thiết lập nó bằng `dybatpho::log_to_file`, hàm tạo thư mục, đặt mode `600` cho tệp mới và tự xoay vòng tệp; đừng thêm `logrotate` lên trên. (dybatpho)

Một script do systemd hay cron chạy đã có sẵn chỗ để ghi log: systemd đưa những gì nó in ra standard error vào journal, còn cron gửi chúng qua mail cho chủ sở hữu. Khi đó `journalctl -u <unit>` hiện chúng cùng phần còn lại của hệ thống, lọc theo unit, thời gian và độ ưu tiên, mà không cần đi tìm tệp nào.

Ghi nối vào một tệp dưới `/var/log` cần quyền root, và tệp cứ lớn dần cho tới khi có người thêm một luật `logrotate` cho nó. `logger` giao một dòng cho syslog hay journald, nơi xoay vòng log thay bạn, và `-t` gắn tag để có thể tìm lại nó.

**Nên dùng**

```sh
# Dưới systemd hay cron, STDERR được thu thập
dybatpho::info "Backing up ${source}"
printf 'Backup of %s failed\n' "${source}" >&2

# Ngoài trình giám sát, giao dòng log cho log hệ thống
logger -t backup -p user.err "Backup of ${source} failed"
systemd-cat -t backup -p info rsync -a -- "${source}" "${target}"
```

**Không nên dùng**

```sh
# Cần root, và không có gì xoay vòng tệp
echo "Backing up ${source}" >> /var/log/backup.log
rsync -av -- "${source}" "${target}" | tee -a /var/log/backup.log
```

`dybatpho::log_to_file` gửi mọi thông báo log của dybatpho vào tệp dưới dạng một dòng JSON, song song với văn bản trên standard error, sau khi đã che các bí mật đã đăng ký. `rotate:SIZE` đổi tên tệp khi nó đạt tới kích thước đó và `keep:N` giữ lại chừng ấy bản cũ; một luật `logrotate` trên cùng tệp sẽ xoay vòng nó lần thứ hai. (dybatpho)

**Nên dùng**

```sh
dybatpho::log_to_file "$(dybatpho::xdg_state_dir backup)/backup.log" rotate:10M keep:3
dybatpho::info "Backing up ${source}"
```

### Hàm sử dụng chung

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng `.` để gọi các hàm chung <kbd>BSG032</kbd>
> - ✔️ NÊN: Các hàm chung nên được để chung dưới dạng library trong thư mục con `lib`
> - ✔️ NÊN: Chặn việc một thư viện bị source lần thứ hai trước khi nó khai báo các hằng `readonly` <kbd>BSG038</kbd>
> - ✔️ NÊN: Xác định vị trí một thư viện từ bên trong nó bằng `${BASH_SOURCE[0]}` <kbd>BSG039</kbd>
> - ✔️ NÊN: Kiểm tra đường dẫn thư viện được tính ra có tồn tại trước khi source, và nói cách lấy thư viện khi nó không có <kbd>BSG096</kbd>
> - ❌ TRÁNH: Không khai báo `readonly` ở cấp cao nhất của một thư viện có thể bị source hai lần
> - ❌ TRÁNH: Không dùng `$0` trong thư viện: nó là tên của script đã source thư viện <kbd>BSG039</kbd>
> - ❌ TRÁNH: Không source một đường dẫn tính ra mà không kiểm tra
> - ❌ TRÁNH: Không dựa vào thư mục của một script có thể được đọc từ standard input, `bash -c` hay process substitution: nó không có thư mục nào
> - ⚠️ CÂN NHẮC: Xác định thư mục của script bằng `CDPATH='' cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd` khi nó phải chạy ở nơi không có `realpath`, như macOS trước bản 13

Khi gọi các hàm chung, hãy sử dụng `.` thay vì `source`. Điều này là do `.` tuân thủ POSIX.

**Nên dùng**

```sh
. "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

**Không nên dùng**

```sh
# Sử dụng source
source "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

Một thư viện rất dễ bị source hai lần — bởi chính script và bởi một thư viện khác mà nó nạp. Lần `readonly NAME=...` thứ hai thất bại với lỗi `NAME: readonly variable`, mà `set -e` biến thành một lần thoát. Một điều kiện chặn dựa trên biến do thư viện đặt khiến lần source thứ hai không làm gì cả.

**Nên dùng**

```sh
# scripts/lib/net.sh
[[ -z "${__NET_LOADED-}" ]] || return 0
__NET_LOADED=1
readonly NET_TIMEOUT=10
```

**Không nên dùng**

```sh
# scripts/lib/net.sh: lần `.` thứ hai dừng script
readonly NET_TIMEOUT=10
```

`$0` là tên của script đang chạy, nên trong một thư viện nó trỏ tới bên đã source thư viện, và mọi đường dẫn dựng từ nó đều tính từ sai thư mục. `${BASH_SOURCE[0]}` là tệp mà đoạn code hiện tại được đọc ra.

**Nên dùng**

```sh
# scripts/lib/net.sh
NET_LIB_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
. "${NET_LIB_DIR}/http.sh"
```

**Không nên dùng**

```sh
# scripts/lib/net.sh: $0 là bên gọi, nên câu này tìm http.sh cạnh bên gọi
NET_LIB_DIR="$(dirname "$0")"
. "${NET_LIB_DIR}/http.sh"
```

Thư mục của một script chỉ xác định được khi script là một tệp. `curl ... | bash`, `bash -c "$(< script.sh)"` và `bash <(...)` cho `BASH_SOURCE[0]` một giá trị rỗng, `bash` hoặc `/dev/fd/63`, và mọi đường dẫn dựng từ nó đều không trỏ tới đâu. Vì vậy, một script nạp các tệp nằm cạnh nó phải được chạy như một tệp, và nên nói rõ điều đó khi không phải vậy. `realpath` xác định thư mục trong một lần gọi, nhưng không có trên macOS trước bản 13; `cd -P` và `pwd` là lệnh dựng sẵn và phân giải các symlink giống hệt.

**Nên dùng**

```sh
SCRIPT_DIR="$(CDPATH='' cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
if [[ ! -f "${SCRIPT_DIR}/lib/net.sh" ]]; then
  echo "Run this script from a clone, not from a pipe: ${SCRIPT_DIR}/lib/net.sh is missing" >&2
  exit 1
fi
```

**Không nên dùng**

```sh
# Chạy bằng `curl ... | bash`, BASH_SOURCE[0] rỗng và SCRIPT_DIR là thư mục hiện tại
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
. "${SCRIPT_DIR}/lib/net.sh"
```

Một submodule chưa từng được khởi tạo, hoặc một bản clone không kèm nó, khiến thư viện bị thiếu. `.` trên một tệp không tồn tại in ra `No such file or directory` và, khi không có `set -e`, script chạy tiếp rồi hỏng muộn hơn ở một hàm không tồn tại. Một bước kiểm tra kèm thông báo biến chuyện đó thành một dòng chỉ cho người dùng lệnh cần chạy.

**Nên dùng**

```sh
if [[ ! -f "${SCRIPT_DIR}/lib/dybatpho/init.sh" ]]; then
  echo "dybatpho is missing. Run: git submodule update --init scripts/lib/dybatpho" >&2
  exit 1
fi
# shellcheck source=lib/dybatpho/init.sh
. "${SCRIPT_DIR}/lib/dybatpho/init.sh"
```

**Không nên dùng**

```sh
# Thiếu submodule: "No such file", rồi "command not found" ở đoạn sau
. "${SCRIPT_DIR}/lib/dybatpho/init.sh"
```

### Môi trường kế thừa

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Xóa hoặc cố định các biến kế thừa mà thư viện phụ thuộc, trong phạm vi hẹp nhất: `GIT_DIR`, `FORCE_COLOR`, `CDPATH`, `IFS`, `TMPDIR`
> - ✔️ NÊN: Đọc một thiết lập kế thừa có chủ đích: ghi chú nó bằng `@env` và kiểm tra nó
> - ✔️ NÊN: Đặt `PATH` thành các thư mục hệ thống cố định ở đầu một script chạy với quyền cao, trước lệnh bên ngoài đầu tiên của nó
> - ❌ TRÁNH: Không cho rằng một biến bạn chưa từng đặt thì chưa được đặt
> - ❌ TRÁNH: Không đưa `.`, một phần tử rỗng (`::`, hay `:` ở đầu hoặc cuối) hoặc một thư mục ai cũng ghi được như `/tmp` vào `PATH` <kbd>BSG114</kbd>

Một script kế thừa mọi biến được xuất của shell đã khởi chạy nó. `CDPATH` làm `cd dir` in ra một đường dẫn và đi tới nơi khác; một `IFS` tùy chỉnh thay đổi cách mọi khai triển không có nháy bị tách; `GIT_DIR` trỏ mọi lệnh git sang một repository khác; `FORCE_COLOR` đưa mã escape vào output bị bắt lại. Một thư viện phụ thuộc vào bất kỳ biến nào trong số này phải tự đặt nó, chứ không phải hy vọng.

**Nên dùng**

```sh
# cd không in gì và đi đúng tới nơi tham số chỉ
dir="$(CDPATH='' cd -- "${relative}" && pwd -P)"

# Một lệnh git chỉ được tác động lên đúng thư mục này
env -u GIT_DIR -u GIT_WORK_TREE -u GIT_INDEX_FILE git -C "${repo}" status --porcelain
```

**Không nên dùng**

```sh
# Khi có CDPATH, đường dẫn bắt được bị in hai lần hoặc trỏ tới thư mục khác
dir="$(cd "${relative}" && pwd)"
```

Một phần tử rỗng của `PATH` nghĩa là thư mục hiện tại, giống hệt `.`: với `PATH=":/usr/bin"`, một tệp tên `ls` trong thư mục mà script được khởi động sẽ chạy thay cho `/usr/bin/ls`. Một thư mục ai cũng ghi được cho phép bất kỳ người dùng nào đặt sẵn một `grep` hay một `rm` ở đó. Một script chạy qua `sudo` kế thừa bất cứ `PATH` nào mà chính sách cho qua, nên nó tự đặt `PATH` của mình.

**Nên dùng**

```sh
# Một script chạy bằng root: chỉ các thư mục hệ thống, trước lệnh bên ngoài đầu tiên
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH

# Mở rộng PATH mà không tạo phần tử rỗng khi nó chưa được đặt
PATH="${HOME}/.local/bin${PATH:+:${PATH}}"
```

**Không nên dùng**

```sh
# Thư mục hiện tại đứng đầu: một ./ls hay ./grep đặt sẵn sẽ thắng
PATH=".:${PATH}"
# Một phần tử rỗng ở đầu cũng là thư mục hiện tại
PATH=":${PATH}"
# Ai cũng ghi được vào /tmp
PATH="/tmp/tools:${PATH}"
```

### Tệp cấu hình

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Đọc tệp cấu hình như dữ liệu: phân tích các dòng `key=value`, chỉ chấp nhận những khóa mà script biết, và kiểm tra từng giá trị
> - ✔️ NÊN: Nạp các tệp theo một thứ tự cố định, của hệ thống trước và của người dùng sau cùng, và ghi rõ trong `--help` những đường dẫn nào được đọc
> - ✔️ NÊN: Nạp cấu hình bằng `dybatpho::config_load`, khai báo từng khóa bằng `dybatpho::config_schema`, và kiểm tra mọi giá trị bằng `dybatpho::config_validate`. (dybatpho)
> - ⚠️ CÂN NHẮC: Chỉ `.` một tệp cấu hình khi nó thuộc về người dùng đang chạy script, hoặc root, và không ai khác ghi được vào nó
> - ❌ TRÁNH: Không `.` một tệp mà người dùng khác, một thư mục ai cũng ghi được hay một lần tải về có thể thay đổi: mọi dòng của nó chạy như chính script <kbd>BSG115</kbd>

Source một tệp nghĩa là chạy nó. Một tệp cấu hình trong thư mục dùng chung, hay một tệp mà người dùng có ít quyền hơn sửa được, khi đó trở thành cách để chạy bất kỳ lệnh nào với quyền của script — với một script chạy qua `sudo` là quyền root. Phân tích tệp giữ nó đúng với vai trò của nó: giá trị cho những thiết lập mà script biết, được kiểm tra như mọi input khác.

**Nên dùng**

```sh
# Mặc định của hệ thống trước, tệp của người dùng sau cùng; được phân tích, không bao giờ được chạy
dybatpho::config_load --optional /etc/app.env "${XDG_CONFIG_HOME:-${HOME}/.config}/app/config.env"

# Không có thư viện: chỉ những khóa đã biết, mỗi khóa được kiểm tra ở nơi nó được dùng
function app::load_config {
  local file key value
  dybatpho::expect_args file -- "$@"
  while IFS='=' read -r key value || [[ -n "${key}" ]]; do
    [[ -n "${key}" && "${key}" != \#* ]] || continue
    case "${key}" in
      port) APP_PORT="${value}" ;;
      log_level) APP_LOG_LEVEL="${value}" ;;
      *) dybatpho::warn "Unknown setting ${key@Q} in ${file@Q}" ;;
    esac
  done < "${file}"
}
```

**Không nên dùng**

```sh
# Chạy bất cứ thứ gì tệp chứa, với quyền của script
. "${XDG_CONFIG_HOME:-${HOME}/.config}/app/config"
# Một thư mục ai cũng ghi được: bất kỳ ai cũng có thể đặt sẵn tệp này
. "/tmp/app-${USER}.conf"
```

`dybatpho::config_load` đọc dotenv, JSON, YAML hay TOML như dữ liệu, tệp sau đè lên tệp trước, và `--optional` bỏ qua tệp không tồn tại. `dybatpho::config_schema` khai báo kiểu, lựa chọn, giới hạn, giá trị mặc định của một khóa và việc nó có bắt buộc hay không, còn `dybatpho::config_validate` điền giá trị mặc định và báo mọi vi phạm kèm khóa gây ra nó. Hàm không từ chối một khóa chưa từng được khai báo: hãy so các khóa đã nạp với các khóa đã khai báo khi một lỗi gõ phải làm dừng script. (dybatpho)

**Nên dùng**

```sh
dybatpho::config_load --optional /etc/app.env "${XDG_CONFIG_HOME:-${HOME}/.config}/app.env"
dybatpho::config_schema port port required:true
dybatpho::config_schema mode enum choices:dev,prod default:dev
dybatpho::config_validate || dybatpho::die "Invalid configuration"
```

### Tác dụng phụ của thư viện

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Trả về một trạng thái từ hàm thư viện, hoặc dừng qua helper die của thư viện, thứ báo rõ lỗi. (dybatpho)
> - ✔️ NÊN: Đổi thư mục bên trong một subshell, `( cd -- "${dir}" && ... )`, hoặc khôi phục thư mục cũ trước khi trả về <kbd>BSG091</kbd>
> - ✔️ NÊN: Giới hạn phạm vi một tùy chọn shell mà hàm cần: một subshell, `local -` cho tùy chọn của `set`, tiền tố `IFS=` trên đúng lệnh cần tách, `local IFS`, hoặc lưu và khôi phục nó trên mọi nhánh trả về <kbd>BSG092</kbd>
> - ❌ TRÁNH: Không gọi `exit` trong hàm thư viện: nó kết thúc script đã source thư viện <kbd>BSG090</kbd>
> - ❌ TRÁNH: Không `cd` trong shell của bên gọi từ một hàm thư viện
> - ❌ TRÁNH: Không để `set -e`/`+e`/`-C`/`-f`, một tùy chọn `shopt`, `IFS` hay `umask` bị thay đổi khi hàm thư viện trả về

Một thư viện chạy trong shell của bên gọi. `exit` ở đó kết thúc cả script — bỏ qua phần xử lý lỗi của bên gọi, quyết định dọn dẹp của nó và thông báo lẽ ra phải nói lý do — còn bên trong `$(...)` thì nó chỉ kết thúc subshell, nên bên gọi không phân biệt được lỗi với một câu trả lời rỗng.

**Nên dùng**

```sh
function net::fetch {
  local url
  dybatpho::expect_args url -- "$@"
  [[ -n "${url}" ]] || dybatpho::die "net::fetch: no URL given"
  # Mã thoát của curl đến thẳng bên gọi, bên gọi quyết định một thất bại nghĩa là gì
  curl --fail -sS --connect-timeout 10 --max-time 60 -- "${url}" || return $?
}
```

**Không nên dùng**

```sh
function net::fetch {
  # Kết thúc script của bên gọi mà không có thông báo hay cơ hội phục hồi
  curl --fail -sS "$1" || exit 1
}
```

Thư mục làm việc thuộc về bên gọi. Một hàm thư viện đổi nó sẽ khiến mọi đường dẫn tương đối mà bên gọi dùng sau đó trỏ sang nơi khác, và một lệnh `return` sớm hay một lỗi sẽ bỏ qua lệnh `cd -` dùng để hoàn tác.

**Nên dùng**

```sh
function repo::files {
  local root
  dybatpho::expect_args root -- "$@"
  (cd -- "${root}" && git ls-files)
}
```

**Không nên dùng**

```sh
function repo::files {
  # Bên gọi bị bỏ lại trong ${root} sau khi hàm này trả về
  cd "$1" && git ls-files
}
```

Tùy chọn shell có hiệu lực toàn shell. Một thư viện bật `nullglob` làm thay đổi kết quả khai triển của mọi glob sau đó của bên gọi; một thư viện để lại `set +e` tắt mất phần xử lý lỗi của bên gọi; một `IFS` hay `umask` bị đổi làm thay đổi cách tách từ và quyền tệp ở những chỗ cách xa dòng đã thay đổi chúng.

**Nên dùng**

```sh
function fs::list {
  local dir
  dybatpho::expect_args dir -- "$@"
  (
    shopt -s nullglob dotglob
    local -a entries=("${dir}"/*)
    # printf không có đối số vẫn in ra một dòng trống
    ((${#entries[@]} == 0)) || printf '%s\n' "${entries[@]}"
  )
}

function text::split_into {
  local __text_split_var __text_split_input
  dybatpho::expect_args __text_split_var __text_split_input -- "$@"
  local -n __text_split_ref="${__text_split_var}"
  # IFS chỉ đổi cho lệnh read này; một `local IFS` ở đây sẽ là một biến cục bộ mà nameref có thể trỏ vào
  IFS=, read -r -a __text_split_ref <<< "${__text_split_input}"
}
```

**Không nên dùng**

```sh
function fs::list {
  # Mọi glob mà bên gọi viết sau đó giờ khai triển thành rỗng khi không khớp
  shopt -s nullglob
  printf '%s\n' "$1"/*
}

function text::split_into {
  local __text_split_var __text_split_input
  dybatpho::expect_args __text_split_var __text_split_input -- "$@"
  local -n __text_split_ref="${__text_split_var}"
  IFS=,
  read -r -a __text_split_ref <<< "${__text_split_input}"
}
```

### Nhập liệu tương tác

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Chỉ hỏi khi standard input là terminal, hoặc tôn trọng chế độ không tương tác, và nếu không thì dùng một mặc định an toàn
> - ✔️ NÊN: Đặt timeout và câu trả lời mặc định cho một lời nhắc
> - ✔️ NÊN: Hỏi một câu có hay không bằng `dybatpho::confirm`, hàm chỉ hỏi khi có terminal, trả lời không khi không có, và nhận một câu trả lời mặc định. (dybatpho)
> - ✔️ NÊN: Nhận biết một lần chạy CI bằng `dybatpho::is_ci`, hàm tôn trọng `CI=false` và biết các dịch vụ không đặt `CI`. (dybatpho)
> - ❌ TRÁNH: Không gọi `read` hay một lời nhắc vô điều kiện trong script có thể chạy trong CI, cron hay một pipe <kbd>BSG098</kbd>

Khi không có terminal, `read` chờ một đầu vào không bao giờ tới — một job CI treo cho tới khi hết thời gian — hoặc đọc dòng tiếp theo của một pipe vốn dành cho thứ khác. Kiểm tra `[[ -t 0 ]]` và có sẵn một mặc định giúp lần chạy không người trông tự quyết định, còn timeout giới hạn lần chạy có tương tác.

**Nên dùng**

```sh
local answer="n"
if [[ -t 0 ]] && ! dybatpho::is true "${CI-}"; then
  read -r -t 30 -p "Overwrite ${file}? [y/N] " answer || answer="n"
fi
[[ "${answer}" == [yY] ]] || return 1
```

**Không nên dùng**

```sh
# Treo mãi trong CI, và đọc nhầm dòng từ một pipe
read -r -p "Overwrite ${file}? [y/N] " answer
[[ "${answer}" == [yY] ]] || return 1
```

`dybatpho::confirm` ghi câu hỏi ra standard error và chỉ đọc câu trả lời khi `dybatpho::is_interactive` thấy standard input là terminal, hoặc `DYBATPHO_INTERACTIVE=true` nói là có. Nếu không, nó cảnh báo và trả về 1, nên một lần chạy không người trông sẽ nhận câu trả lời an toàn, còn `DYBATPHO_FORCE=true` trả lời có cho một lần chạy đã được duyệt trước. Hàm không có timeout: trên terminal nó chờ câu trả lời. (dybatpho)

**Nên dùng**

```sh
dybatpho::confirm "Overwrite ${file}?" || return 1
dybatpho::confirm "Keep the backup?" yes || rm -f -- "${file}.bak"
```

`dybatpho::is_ci` đọc `CI` trước, nên `CI=false`, `0` hay `no` nghĩa là chạy cục bộ ngay cả trên máy CI, và chỉ khi `CI` chưa đặt nó mới tìm một dịch vụ tự xưng tên, như `GITHUB_ACTIONS` hay `GITLAB_CI`. (dybatpho)

**Nên dùng**

```sh
if dybatpho::is_ci; then
  DYBATPHO_INTERACTIVE=false
fi
```

### Menu và lựa chọn

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Cho mỗi lựa chọn mà một menu đưa ra một cờ hoặc một biến môi trường chọn đúng điều đó mà không cần hỏi
> - ⚠️ CÂN NHẮC: Kiểm tra có terminal trước khi mở một menu (`select`, `fzf`, `gum choose`, `whiptail`, `dialog`), và khi không có thì lấy cùng câu trả lời đó từ một cờ hoặc một biến môi trường <kbd>BSG161</kbd>
> - ✔️ NÊN: Khi không có terminal và không ai đưa câu trả lời, hãy thất bại với một thông báo nêu tên cờ cần truyền, thay vì đoán hay chờ
> - ✔️ NÊN: Vẽ menu bằng `dybatpho::tui_menu` hoặc `dybatpho::tui_multi_menu`, hai hàm chuyển sang lời nhắc đánh số khi không có terminal và sang `DYBATPHO_TUI_DEFAULT` khi không có gì trả lời. (dybatpho)

Một menu là một câu hỏi với một tập câu trả lời cố định, nên một cờ luôn có thể đưa ra cùng câu trả lời: `--env staging` làm đúng điều mà việc chọn "staging" lẽ ra sẽ làm. Khi đó script chạy giống hệt nhau trong CI, trong cron và khi được một script khác gọi, còn menu chỉ là một tiện ích cho người đang ngồi trước bàn phím.

Khi không có terminal, một menu không thất bại một cách gọn gàng. `select` kết thúc ở lần hết đầu vào đầu tiên, hoặc đọc câu trả lời từ một pipe vốn dành cho thứ khác; `fzf`, `gum`, `whiptail` và `dialog` dừng với một lỗi về terminal mà không nói gì về lựa chọn còn thiếu, hoặc chờ một phím bấm không bao giờ tới. Kiểm tra `[[ -t 0 ]]` trước giúp script dừng lại với một thông báo nói rõ cần truyền gì.

**Nên dùng**

```sh
# ENVIRONMENT đến từ --env, hoặc DEPLOY_ENV, qua spec
if [[ -z "${ENVIRONMENT}" ]]; then
  [[ -t 0 ]] || dybatpho::die "No terminal to ask on: pass --env or set DEPLOY_ENV"
  ENVIRONMENT="$(printf '%s\n' dev staging prod | fzf --prompt "Environment> ")"
fi
```

**Không nên dùng**

```sh
# Kết thúc, lỗi hoặc chờ trong CI, và không có cách nào trả lời nó bằng một cờ
select ENVIRONMENT in dev staging prod; do
  break
done
ENVIRONMENT="$(gum choose dev staging prod)"
```

`dybatpho::tui_menu` ghi lựa chọn vào một biến được đặt tên. Nó vẽ menu tại chỗ khi cả standard input lẫn standard error đều là terminal; nếu không, nó in một danh sách đánh số và đọc con số từ standard input, nên một redirect có thể trả lời nó, và khi hết đầu vào nó lấy `DYBATPHO_TUI_DEFAULT`, một vị trí đếm từ 1, hoặc thất bại với một lỗi nêu tên biến đó. `dybatpho::tui_multi_menu` làm điều tương tự cho nhiều mục, ghi vào một mảng. (dybatpho)

**Nên dùng**

```sh
if [[ -z "${ENVIRONMENT}" ]]; then
  dybatpho::tui_menu ENVIRONMENT "Deploy to which environment?" dev staging prod \
    || dybatpho::die "No environment chosen: pass --env"
fi
```

### Chạy không người trông

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Đặt `PATH` ở đầu một script do cron, systemd hay CI chạy, hoặc gọi các chương trình của nó bằng đường dẫn tuyệt đối
> - ✔️ NÊN: Lường trước việc không có terminal, và có thể không có `HOME` hay `USER`: chỉ hỏi sau khi `dybatpho::is_interactive` thấy có terminal, và thất bại với một thông báo rõ ràng khi thiếu một biến mà script cần. (dybatpho)
> - ✔️ NÊN: Ghi thông báo ra `STDERR`, nơi cron gửi chúng qua mail, systemd lưu chúng vào journal và CI hiện chúng trong log của job
> - ✔️ NÊN: Giữ các thiết lập mà job cần trong script, hoặc trong một tệp cấu hình mà nó đọc bằng đường dẫn đầy đủ
> - ❌ TRÁNH: Không source `~/.bashrc`, `~/.profile` hay một login profile khác từ script <kbd>BSG134</kbd>

Một script được khởi chạy bởi cron, một unit systemd hay một CI runner không nhận được môi trường của login shell. Cron khởi chạy nó với `PATH=/usr/bin:/bin`, nên một công cụ nằm dưới `/usr/local/bin` hay `/opt` sẽ "not found"; một service hệ thống có thể khởi động mà không có `HOME` hay `USER`; và không có terminal, nên mọi thứ đọc từ terminal sẽ chờ hoặc thất bại.

Source một login profile để lấy lại các thiết lập còn thiếu chỉ làm mọi thứ tệ hơn. Tệp đó có thể không tồn tại với tài khoản mà job chạy dưới tên, hoặc thuộc về người dùng khác khi chạy dưới `sudo`; nó được viết cho terminal, với lời nhắc, alias và các lời gọi `stty`; và nó gắn job với bất cứ thứ gì một người vừa thêm vào đó. Hãy khai báo những gì script cần ngay trong script.

**Nên dùng**

```sh
# PATH của cron và systemd ngắn, và không phải PATH mà login shell có
export PATH=/usr/local/bin:/usr/bin:/bin
: "${BACKUP_TARGET:?BACKUP_TARGET is not set}"

if dybatpho::is_interactive; then
  dybatpho::confirm "Back up ${BACKUP_SOURCE} now?" || exit 0
fi
dybatpho::info "Backing up ${BACKUP_SOURCE}"
rsync -a -- "${BACKUP_SOURCE}" "${BACKUP_TARGET}"
```

**Không nên dùng**

```sh
# Không có dưới cron, là của người khác dưới sudo, và được viết cho terminal
. ~/.bashrc
# Thất bại với "No such device or address": cron không có terminal
echo "Backing up ${BACKUP_SOURCE}" > /dev/tty
```

### Entrypoint của container

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Kết thúc entrypoint của container bằng `exec`, để chương trình nó khởi chạy thay thế Bash làm PID 1 và nhận được `SIGTERM` <kbd>BSG135</kbd>
> - ✔️ NÊN: Chạy lệnh của container bằng `exec "$@"` sau khi thiết lập xong, để `docker run <image> <command>` vẫn hoạt động
> - ✔️ NÊN: Khi lệnh có thể là tên một hàm của script, chạy thẳng hàm đó và `exec` mọi thứ khác: `if declare -F -- "$1" > /dev/null; then "$@"; else exec "$@"; fi`
> - ✔️ NÊN: Chạy image với `--init`, hoặc dưới `tini`, khi chương trình ở vai trò PID 1 không xử lý `SIGTERM` hay không thu dọn các tiến trình nó khởi chạy
> - ✔️ NÊN: Phân biệt container với máy host bằng `dybatpho::is_container`, hàm tìm các tệp đánh dấu của Docker và Podman, các biến `container` và `KUBERNETES_SERVICE_HOST`, và control group của PID 1. (dybatpho)

`docker stop` và Kubernetes gửi `SIGTERM` tới PID 1 của container, chờ hết thời gian ân hạn (10 giây với Docker, 30 giây với Kubernetes) rồi gửi `SIGKILL`. Khi entrypoint chạy server như một lệnh thông thường, PID 1 là Bash: nó giữ tín hiệu lại cho tới khi server thoát, điều không bao giờ xảy ra, và server bị kết liễu mà không kịp đóng kết nối hay ghi hết tệp. `exec` thay Bash bằng server, và khi đó chính server nhận tín hiệu.

Kernel không gán hành động mặc định nào cho PID 1 với một tín hiệu mà nó không xử lý, nên một chương trình không bao giờ cài handler cho `SIGTERM` vẫn bỏ qua tín hiệu đó dù đã `exec`. Hãy chạy chương trình như vậy dưới một init biết chuyển tiếp tín hiệu và thu dọn zombie: `docker run --init`, hoặc `tini` trong image.

**Nên dùng**

```sh
mkdir -p /data
if (($# == 0)); then
  set -- gunicorn --bind 0.0.0.0:8000 app:application
fi
exec "$@"
```

**Không nên dùng**

```sh
mkdir -p /data
# Bash vẫn là PID 1: docker stop chờ hết thời gian ân hạn, rồi kết liễu server
"$@"
```

`exec` thay tiến trình bằng một chương trình, mà một hàm shell thì không phải chương trình: `exec migrate` thất bại với "not found". Một entrypoint có cả các lệnh con riêng thì chạy thẳng hàm, và chính hàm đó kết thúc bằng một `exec` của nó.

**Nên dùng**

```sh
function migrate {
  exec /app/bin/migrate --apply
}

if (($# == 0)); then
  set -- /app/bin/server
fi
if declare -F -- "$1" > /dev/null; then
  "$@"
else
  exec "$@"
fi
```

`dybatpho::is_container` cho biết script có đang chạy trong Docker, Podman, Kubernetes hay LXC hay không, để một script dùng chung với máy host có thể bỏ qua những gì không có ý nghĩa trong container. (dybatpho)

**Nên dùng**

```sh
dybatpho::is_container || systemctl daemon-reload
```

### Người dùng hiện tại

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Kiểm tra root bằng `(( EUID == 0 ))`, không phải bằng cách so sánh `$USER`, `$(whoami)` hay `$(id -u)` dưới dạng chuỗi <kbd>BSG136</kbd>
> - ⚠️ CÂN NHẮC: Tìm thư mục home bằng `$HOME` hoặc `getent passwd`, không phải bằng cách tự ghép `/home/${user}` <kbd>BSG137</kbd>
> - ✔️ NÊN: Trên macOS, nơi không có `getent`, đọc thư mục home của người dùng khác bằng `dscl . -read "/Users/${user}" NFSHomeDirectory`
> - ✔️ NÊN: Kiểm tra root bằng `dybatpho::is_root`, hàm kiểm tra `EUID`, và in ra người dùng hiệu lực bằng `dybatpho::user`, hàm hỏi `id -un`. (dybatpho)

`USER` và `LOGNAME` là các biến thông thường: ai cũng đặt được, một container thường không đặt biến nào trong hai, và `sudo` tự quyết định theo chính sách của nó xem chúng chứa gì. Cái tên `root` chỉ là một quy ước; kernel kiểm tra user ID, và Bash giữ ID hiệu lực trong `EUID`, một biến mà không script nào thay đổi được.

Thư mục home nằm dưới `/Users` trên macOS, ở `/root` với root, dưới `/var/lib/<service>` với nhiều tài khoản service, và ở bất cứ đâu mà quản trị viên hay một directory service đặt chúng. `/home/${user}` chỉ đúng trên một loại máy; cơ sở dữ liệu mật khẩu, mà `getent passwd` đọc qua mọi nguồn hệ thống được cấu hình, thì đúng trên tất cả. Dùng `${HOME}` cho người dùng hiện tại. dybatpho không có helper nào tìm thư mục home của người dùng khác.

**Nên dùng**

```sh
((EUID == 0)) || dybatpho::die "Run this as root"

local home
if command -v getent &> /dev/null; then
  home="$(getent passwd "${user}" | cut -d: -f6)"
else
  home="$(dscl . -read "/Users/${user}" NFSHomeDirectory)"
  home="${home#NFSHomeDirectory: }"
fi
[[ -n "${home}" ]] || dybatpho::die "No such user: ${user}"
```

**Không nên dùng**

```sh
# USER không được đặt dưới cron và trong nhiều container, và ai cũng đặt được nó
[[ "${USER}" == "root" ]] || dybatpho::die "Run this as root"
# Sai trên macOS, với root và với các tài khoản service
home="/home/${user}"
```

`dybatpho::user` cho biết người dùng hiệu lực, nên một script chạy bằng `sudo` nhận được `root`, không phải tài khoản đã gọi nó. (dybatpho)

**Nên dùng**

```sh
dybatpho::is_root || dybatpho::die "Run this with sudo, not as $(dybatpho::user)"
```

### Giới hạn tài nguyên

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Chạy một job batch nặng với độ ưu tiên thấp bằng `nice -n 10`, và trên Linux thêm `ionice -c 3` khi nó dùng nhiều đĩa
> - ✔️ NÊN: Đặt `ulimit` trong một subshell bao quanh đúng lệnh mà nó nhắm tới
> - ✔️ NÊN: Kiểm tra dung lượng trống bằng `df -Pk` trước một lần ghi lớn, và dừng với một thông báo nêu rõ các kích thước
> - ❌ TRÁNH: Không gọi `ulimit` ở đầu script hay trong một thư viện: nó ràng buộc mọi lệnh mà script chạy sau đó
> - ❌ TRÁNH: Không đọc dung lượng trống từ `df -h`: các kích thước của nó có kèm đơn vị mà phép tính số học không so sánh được

Một job backup hay build do cron khởi chạy tranh tài nguyên với service trên cùng máy. `nice` giảm phần CPU của nó, còn `ionice -c 3` chỉ cho nó dùng đĩa khi không có gì khác cần. `ionice` chỉ có trên Linux, nên hãy kiểm tra nó trước.

Một giới hạn đặt bằng `ulimit` có hiệu lực với shell và mọi tiến trình nó khởi chạy từ đó trở đi, và một tiến trình không có đặc quyền có thể hạ hard limit nhưng không bao giờ nâng nó lên lại được. Trong một subshell, giới hạn kết thúc cùng subshell.

Một lần ghi làm đầy đĩa sẽ thất bại giữa chừng, và thường kéo theo cả service dùng chung đĩa đó. `df -P` in theo bố cục một dòng mà POSIX quy định, giống nhau trên GNU và BSD, còn `-k` tính bằng kibibyte bất kể `BLOCKSIZE` nói gì.

**Nên dùng**

```sh
local -a low=(nice -n 10)
if command -v ionice &> /dev/null; then
  low+=(ionice -c 3)
fi
"${low[@]}" tar -czf "${archive}" -C "${source}" .

# Chỉ riêng lần import chạy không có core dump và có giới hạn thời gian CPU
(
  ulimit -c 0
  ulimit -t 3600
  exec ./import.sh
)

local available
available="$(df -Pk -- "${target_dir}" | awk 'NR == 2 { print $4 }')"
((available >= needed_kb)) || dybatpho::die "${target_dir} has ${available} KiB free, ${needed_kb} KiB needed"
```

**Không nên dùng**

```sh
# Ràng buộc phần còn lại của script và mọi lệnh nó khởi chạy
ulimit -n 256
# "12G" hay "980M": không phải con số để so sánh
available="$(df -h "${target_dir}" | tail -n 1 | awk '{ print $4 }')"
```

### Tiến trình chạy lâu dài

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Giao một service cho systemd, launchd hay một trình quản lý tiến trình thay vì tách nó ra bằng `nohup` hay `setsid` <kbd>BSG139</kbd>
> - ✔️ NÊN: Viết một service thành chương trình chạy ở foreground và ghi log ra `STDERR`, và để trình giám sát khởi động lại, dừng và giữ output của nó
> - ✔️ NÊN: Khởi chạy một service dùng một lần từ script bằng `systemd-run`, lệnh biến nó thành một unit mà `systemctl` và `journalctl` biết tới
> - ❌ TRÁNH: Không khởi chạy một service bằng `&`, `disown` nó rồi thoát: đó vẫn là tiến trình không ai quản lý như `nohup` tạo ra, chỉ khó nhận ra hơn
> - ✔️ NÊN: Khởi chạy các job mà chính script đợi bằng `dybatpho::background_run`, tìm pid của chúng bằng `dybatpho::background_pid`, và đợi chúng bằng `dybatpho::wait_all`. (dybatpho)

Một tiến trình đã tách ra thì không có chủ. Không có gì khởi động lại nó khi nó sập hay dừng nó theo thứ tự lúc tắt máy, output của nó đi vào `nohup.out` hoặc biến mất, và pid mà script đã ghi lại thuộc về một tiến trình khác sau khi khởi động lại máy. Một trình giám sát đã làm sẵn tất cả những việc này: nó khởi chạy chương trình, khởi động lại theo chính sách, gửi `SIGTERM` khi cần dừng, và giữ output trong journal.

**Nên dùng**

```sh
# Một unit tạm thời: systemd ghi log, dừng nó và hiện nó trong systemctl status
systemd-run --user --unit=sync-watch "${HOME}/bin/sync-watch.sh"
```

```ini
[Service]
ExecStart=/usr/local/bin/sync-watch.sh
Restart=on-failure
```

**Không nên dùng**

```sh
# Không có gì khởi động lại, dừng nó lúc tắt máy hay giữ output của nó
nohup ./sync-watch.sh &> /dev/null &
setsid ./sync-watch.sh &
```

Một job nền mà script đợi trước khi thoát không phải là service, và không cần trình giám sát. `dybatpho::background_run` khởi chạy nó trong process group riêng dưới một cái tên, còn `dybatpho::wait_all` đợi mọi job và thất bại khi có job thất bại; xem [Tiến trình con](#ti%E1%BA%BFn-tr%C3%ACnh-con). Khi một công cụ khác đòi có tệp pid, `dybatpho::pid_file_write` ghi nó một cách nguyên tử và `dybatpho::pid_file_remove` chỉ xóa nó khi nó vẫn ghi pid của tiến trình này. (dybatpho)

**Nên dùng**

```sh
dybatpho::trap dybatpho::kill_children EXIT INT TERM
dybatpho::background_run server ./serve.sh --port 8080
dybatpho::info "Server started as pid $(dybatpho::background_pid server)"
./run-tests.sh
```

## Quy ước đặt tên

### Tên hàm

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dùng từ khóa `function` để khai báo hàm <kbd>BSG001</kbd>
> - ✔️ NÊN: Viết tên hàm bằng chữ thường, các từ ngăn cách bằng dấu gạch dưới <kbd>BSG003</kbd>
> - ✔️ NÊN: Ngăn cách không gian tên với tên hàm bằng `::`, và đặt tên không gian tên theo tên tệp thư viện: `scripts/lib/package_manager.sh` định nghĩa `package_manager::install` <kbd>BSG004</kbd>
> - ✔️ NÊN: Thêm tiền tố `__<namespace>_` cho hàm riêng tư của thư viện, và tiền tố `_` cho hàm riêng tư của một script thực thi. (tùy chỉnh)
> - ❌ TRÁNH: Không viết `()` sau tên hàm khi đã dùng từ khóa `function`. (tùy chỉnh) <kbd>BSG002</kbd>
> - ❌ TRÁNH: Không dùng PascalCase hay camelCase <kbd>BSG003</kbd>

Từ khóa `function` khiến phần khai báo dễ tìm bằng `grep`, điều này quan trọng trong một ngôn ngữ không có cách nào khác để liệt kê những gì một tệp định nghĩa. Dấu `::` cho thư viện một không gian tên mà bản thân Bash không có: hai thư viện đều có thể có bước `download` mà không đụng nhau, và người đọc biết ngay hàm đến từ đâu mà không cần tra cứu.

Quy ước tiền tố cho biết cái gì an toàn để gọi. `package_manager::install` là một phần API của thư viện; `__package_manager_resolve_args` là chi tiết cài đặt có thể đổi bất cứ lúc nào; `_main` chỉ thuộc về một script duy nhất.

**Nên dùng**

```sh
# API công khai của thư viện `binary`
function binary::verify_sha256 {
  ...
}

# Riêng tư trong cùng thư viện
function __binary_download_temp_suffix {
  ...
}

# Riêng tư cho một script thực thi
function _spec_main {
  ...
}
```

**Không nên dùng**

```sh
# Dấu ngoặc thừa khi đã có từ khóa
function binary::verify_sha256() {
  ...
}

# Không có không gian tên, người đọc không biết nó nằm ở đâu
function verifySha256 {
  ...
}
```

### Tên biến

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Viết tên biến cục bộ và biến thường bằng chữ thường, các từ ngăn cách bằng dấu gạch dưới
> - ✔️ NÊN: Khai báo mọi biến dùng trong hàm bằng `local`, và khai báo mảng cục bộ bằng `local -a name=()` <kbd>BSG011</kbd> <kbd>BSG013</kbd>
> - ✔️ NÊN: Dùng `CHỮ HOA` cho biến do bên gọi đặt: tùy chọn của script, biến môi trường được xuất ra và hằng số
> - ✔️ NÊN: Đặt hằng số ở đầu tệp và cho nó thuộc tính chỉ đọc bằng `readonly` hoặc `declare -r`
> - ✔️ NÊN: Đặt tên biến lặp theo tập hợp mà nó duyệt: `for tool in "${tools[@]}"` <kbd>BSG012</kbd>
> - ❌ TRÁNH: Không khai báo và gán từ một lệnh thay thế trên cùng một dòng <kbd>BSG010</kbd>

`local name="$(some_command)"` làm mất mã thoát của `some_command`, vì mã thoát của cả dòng là mã thoát của `local`, mà `local` thì luôn thành công. Dưới `set -e`, điều đó biến một lệnh thất bại thành một biến rỗng trong im lặng. Tách làm hai dòng giữ cho lỗi vẫn hiện ra. `readonly`, `export` và `declare` cũng nuốt mã thoát theo cùng cách đó, nên một hằng số được gán trước rồi mới đặt chỉ đọc ở dòng kế tiếp.

**Nên dùng**

```sh
# Hằng số đặt trước, chỉ đọc
SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
readonly SCRIPT_DIR

function dytoy::install {
  local name
  dybatpho::expect_args name -- "$@"

  # Khai báo trước, gán sau, để lỗi không bị nuốt mất
  local version
  version="$(dytoy::get_yaml "${name}" "version")"

  local -a dependencies=()
  readarray -t dependencies < <(dytoy::get_yaml "${name}" "dependencies")
  local dependency
  for dependency in "${dependencies[@]}"; do
    dytoy::install "${dependency}"
  done
}
```

**Không nên dùng**

```sh
# Mã thoát của lệnh thay thế bị mất
local version="$(dytoy::get_yaml "$name" "version")"
readonly SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

# Vô tình thành biến toàn cục, rò rỉ sang mọi hàm được gọi sau đó
version="1.2.3"

# Chữ hoa cho thứ mà bên gọi không bao giờ đặt
NAME="$1"

# Biến lặp không nói lên điều gì
for i in "${tools[@]}"; do
  install "$i"
done
```

### Tên biến cục bộ trong hàm nameref và hàm callback

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Thêm tiền tố cho mọi biến cục bộ khác của một hàm gắn `local -n` với một tên do bên gọi chọn: `__<namespace>_<function>_<name>` <kbd>BSG014</kbd>
> - ✔️ NÊN: Thêm tiền tố cho các biến cục bộ của một hàm chạy code của bên gọi — `"$@"`, `eval`, tên một callback, handler hay producer — khi chúng còn được dùng sau lần gọi đó <kbd>BSG015</kbd>
> - ❌ TRÁNH: Không đặt cho những hàm như vậy các biến cục bộ trơn như `status`, `name`, `path`, `count` hay `result`

Bash dùng phạm vi biến động. `local -n ref="$1"` chỉ phân giải tên bên gọi truyền vào lúc được dùng, nên nếu hàm có một biến cục bộ trùng tên đó, nameref sẽ gắn vào biến cục bộ và biến của bên gọi không bao giờ được gán. Code mà hàm chạy thay cho bên gọi cũng thấy các biến cục bộ của hàm theo cách đó, và có thể đọc hay ghi đè chúng: một lệnh tự giữ biến `count` của riêng nó từng làm thay đổi số lần thử lại của một helper retry.

**Nên dùng**

```sh
function text::split_into {
  local __text_split_var __text_split_input
  dybatpho::expect_args __text_split_var __text_split_input -- "$@"
  local -n __text_split_ref="${__text_split_var}"
  IFS=, read -r -a __text_split_ref <<< "${__text_split_input}"
}

function net::retry {
  local __net_retry_count=0
  until "$@"; do
    ((++__net_retry_count < 3)) || return 1
  done
}
```

**Không nên dùng**

```sh
function text::split_into {
  local -n ref="$1"
  # Bên gọi truyền tên `input` sẽ nhận lại biến cục bộ này, chưa được gán
  local input="$2"
  IFS=, read -r -a ref <<< "${input}"
}

function net::retry {
  local count=0
  # Một lệnh gán `count` sẽ làm thay đổi số lần thử lại
  until "$@"; do
    ((++count < 3)) || return 1
  done
}
```

## Chú thích

### Phần đầu file

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Thêm một comment ở đầu file để giải thích ngắn gọn mục đích hoặc nội dung của file. Tuy nhiên, không thêm comment trước dòng shebang. <kbd>BSG024</kbd>
> - ✔️ NÊN: Sử dụng định dạng [sh-docs](https://github.com/dynamotn/sh-docs) ([GitLab](https://gitlab.com/dynamo-tools/sh-docs)) bao gồm: `@file`, `@brief`, `@description` để giải thích file. (tùy chỉnh) <kbd>BSG020</kbd>
> - ⚠️ CÂN NHẮC: Ghi giấy phép của một script được phân phối bằng `# SPDX-License-Identifier: <id>`, không dùng một đoạn văn về giấy phép <kbd>BSG149</kbd>

Tất cả các file nên có một comment cấp cao nhất mô tả ngắn gọn nội dung của chúng.

**Nên dùng**

```sh
#!/usr/bin/env bash
# @file backup.sh
# @brief Thực hiện backup nóng cho các database Oracle
# @description Thực hiện backup nóng cho các database Oracle
```

Một script đi một mình, tách khỏi repository và file LICENSE của nó, ghi giấy phép bằng một dòng SPDX trong phần đầu file, ngay sau shebang. Định danh này là thứ các công cụ quét giấy phép đọc, và một dòng thì không thể lệch khỏi file LICENSE như một đoạn văn được dán vào. Dòng copyright có thể giữ ngay cạnh nó.

**Nên dùng**

```sh
#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# @file backup.sh
# @brief Thực hiện backup nóng cho các database Oracle
# @description Thực hiện backup nóng cho các database Oracle
```

**Không nên dùng**

```sh
#!/usr/bin/env bash
# @file backup.sh
# @brief Thực hiện backup nóng cho các database Oracle
# @description Thực hiện backup nóng cho các database Oracle
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License.
```

### Chú thích hàm

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng định dạng [sh-docs](https://github.com/dynamotn/sh-docs) ([GitLab](https://gitlab.com/dynamo-tools/sh-docs)) để giải thích hàm. (tùy chỉnh) <kbd>BSG021</kbd> <kbd>BSG022</kbd>

Người khác có thể học cách sử dụng chương trình của bạn hoặc sử dụng một hàm trong thư viện của bạn bằng cách đọc các comment (và tự tìm hiểu, nếu có) mà không cần đọc code.

Tất cả các comment header của hàm nên mô tả hành vi API dự kiến bằng cách sử dụng:

- `@description`: Mô tả về hàm.
- `@set`: Danh sách các biến toàn cục bị sửa đổi.
- `@arg`: Các tham số đầu vào. Nếu không có tham số, sử dụng `@noargs`.
- `@option`: Các option được sử dụng.
- `@stdout` và `@stderr`: Output ra STDOUT hoặc STDERR.
- `@exitcode`: Giá trị trả về của lệnh cuối cùng được chạy.

**Nên dùng**

```sh
#######################################
# @description Lấy đường dẫn thư mục cấu hình.
# @arg $1 string Đường dẫn của thư mục cấu hình
# @stdout Vị trí của thư mục cấu hình
# @stderr In ra 'Không có thư mục cấu hình' nếu lỗi
# @exitcode 0 Nếu thành công
# @exitcode 1 Nếu thư mục cấu hình không tồn tại
#######################################
function get_dir {
  local config_dir="${1:-${HOME}/.config/abc}"
  if [[ -e "${config_dir}" ]]; then
    printf '%s\n' "${config_dir}"
  else
    echo "Không có thư mục cấu hình" >&2
    return 1
  fi
}
```

### Chú thích triển khai

> [!TIP]
>
> - ✔️ NÊN: Thêm comment vào code khó hiểu, có ý nghĩa quan trọng hoặc cần được chú ý.
> - ✔️ NÊN: Giữ cho comment ngắn gọn và dễ hiểu nhất có thể.
> - ⚠️ CÂN NHẮC: Nếu một giải thích ngắn gọn là không đủ, hãy xem xét cung cấp thông tin chi tiết về background.

Comment về các phần code phức tạp, không rõ ràng, thú vị hoặc quan trọng. Tuy nhiên, không comment về mọi thứ. Thêm comment khi có các thuật toán phức tạp hoặc khi làm điều gì đó bất thường. Nếu một comment ngắn không thể cung cấp một giải thích rõ ràng, hãy bao gồm thông tin background chi tiết.

### TODO Comments

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Cân nhắc sử dụng comment TODO.
> - ❌ TRÁNH: Không bao gồm tên của người viết comment TODO. (tùy chỉnh) <kbd>BSG023</kbd>

Sử dụng comment TODO cho các giải pháp tạm thời, ngắn hạn hoặc code đủ tốt nhưng chưa hoàn hảo. Comment TODO nên bao gồm chuỗi viết hoa `TODO`. Không cần thiết phải bao gồm tên của cá nhân, vì có thể xác định bằng `git blame`. Mục đích của comment TODO là cung cấp một marker `TODO` nhất quán và dễ tìm kiếm, có thể được tra cứu để biết thêm chi tiết khi cần. Vì người được tham chiếu trong TODO không nhất thiết phải cam kết sửa lỗi, nên việc bao gồm giải pháp dự kiến là hữu ích.

**Nên dùng**

```sh
# TODO: Code này cần được sửa do xử lý lỗi không đầy đủ. Thêm kiểm tra lỗi và thoát với mã 1.
```

### Code bị comment lại

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Xóa code thay vì comment nó lại; git vẫn giữ phiên bản cũ. (tùy chỉnh) <kbd>BSG144</kbd>
> - ✔️ NÊN: Khi một dòng tạm thời phải tắt, đặt một TODO phía trên nói rõ vì sao và khi nào nó được bật lại
> - ✔️ NÊN: Đưa code ví dụ vào một `@example` của shdoc, không để thành các dòng comment rời rạc

Code bị comment lại sẽ mục dần. Không ai chạy nó, các tên nó dùng thay đổi bên dưới nó, và người đọc sau không phân biệt được đó là một bản sửa đang chờ, một hướng đã bỏ, hay một dòng debug bị bỏ quên. `git log -S '<text>'` tìm lại phiên bản cũ vào ngày có người cần đến.

Linter coi một loạt dòng comment là code khi nó parse được như shell và có một phép gán, một khai triển, `&&`, `||`, một pipe, `[[`, một từ khóa như `if` hay `done`, hoặc một lời gọi `ns::`. Nó bỏ qua phần đầu file, các khối shdoc cùng `@example` của chúng, các directive, một khối có TODO, và các dòng tiếp nối một câu văn hoặc đứng sau một câu kết thúc bằng `:`.

**Nên dùng**

```sh
mkdir -p -- "${dest}"
# TODO: Quay lại dùng rsync khi mọi host đã có rsync 3.2 (cần --mkpath).
# rsync -a --mkpath -- "${src}/" "${dest}/"
cp -a -- "${src}/." "${dest}/"
```

**Không nên dùng**

```sh
mkdir -p -- "${dest}"
# cp -r "${src}" "${dest}"
# if [[ -d "${dest}.old" ]]; then
#   rm -rf -- "${dest}.old"
# fi
cp -a -- "${src}/." "${dest}/"
```

## Định dạng

### Dấu tab và dấu cách

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Thụt lề bằng hai dấu cách. Không sử dụng dấu tab. <kbd>BSG071</kbd>
> - ✔️ NÊN: Chèn dòng trống giữa các khối mã để tăng tính dễ đọc.
> - ✔️ NÊN: Không bao gồm khoảng trắng ở cuối dòng. (tùy chỉnh) <kbd>BSG072</kbd>
> - ❌ TRÁNH: Không để quá một dòng trống liên tiếp

Thụt lề nên dùng hai dấu cách. Tuyệt đối không được sử dụng dấu tab.

Nhiều trình soạn thảo không thể chuyển đổi giữa thụt lề thực tế và hiển thị dấu cách/tab theo tùy chọn của người dùng. Cài đặt trình soạn thảo của người khác có thể không giống với của bạn. Sử dụng dấu cách đảm bảo rằng mã trông giống nhau trong mọi trình soạn thảo.

Một dòng trống là đủ để tách hai khối; dòng trống thứ hai không nói thêm điều gì mà chỉ đẩy phần mã bên dưới ra khỏi màn hình. shfmt gộp một chuỗi dòng trống thành một.

### Kết thúc dòng và mã hóa ký tự

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Lưu tệp shell với kết thúc dòng LF, ở dạng UTF-8 không có byte order mark <kbd>BSG140</kbd>
> - ✔️ NÊN: Cố định kết thúc dòng trong `.gitattributes`: `*.sh text eol=lf` và `*.bats text eol=lf`
> - ✔️ NÊN: Đặt `end_of_line = lf` và `charset = utf-8` trong `.editorconfig`, để trình soạn thảo lưu tệp đúng như vậy ngay từ đầu
> - ❌ TRÁNH: Không phó mặc kết thúc dòng cho `core.autocrlf` của từng bản clone: với `true`, một bản checkout trên Windows ghi ra CRLF, và một script chép từ đó vào container hay WSL sẽ hỏng

Bash kết thúc một dòng ở LF và giữ CR như một phần của từ cuối cùng trên dòng đó. Một tệp lưu với CRLF khi đó đòi `bash\r` trong shebang, đọc `then\r` thành một lệnh, và `cd` vào một thư mục có tên kết thúc bằng một ký tự vô hình; mọi thông báo lỗi trông như thể không có gì sai. Byte order mark đặt ba byte trước `#!`, nên kernel không còn thấy shebang nữa.

`text eol=lf` trong `.gitattributes` khiến Git checkout các tệp với LF trên mọi máy, bất kể thiết lập riêng của máy đó, và lưu chúng với LF trong repository.

**Nên dùng**

```gitattributes
*.sh text eol=lf
*.bats text eol=lf
```

```ini
[*.{sh,bats}]
charset = utf-8
end_of_line = lf
```

**Không nên dùng**

```text
$ ./deploy.sh
/usr/bin/env: 'bash\r': No such file or directory
```

### Độ dài dòng code và chuỗi dài

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Độ dài dòng tối đa là 120 ký tự. (tùy chỉnh) <kbd>BSG070</kbd>
> - ✔️ NÊN: Cân nhắc sử dụng here document hoặc ký tự xuống dòng trong chuỗi quá dài. (tùy chỉnh)
> - ⚠️ CÂN NHẮC: Tìm cách rút ngắn các chuỗi ký tự.

Giữ mọi dòng ở mức 120 ký tự hoặc ít hơn; `max_line_length` trong [`.editorconfig`](.editorconfig) đặt giới hạn này cho trình soạn thảo, và linter kiểm tra nó. Ngắt một lệnh dài tại các tùy chọn bằng `\`, và một chuỗi dài bằng here document hoặc ký tự xuống dòng. Một chuỗi không thể chia nhỏ, như một URL, nên được chuyển vào một biến riêng thay vì để nó vượt quá giới hạn.

**Nên dùng**

```sh
# Sử dụng here document
cat << END
Tôi là một chuỗi
đặc biệt dài.
END

# Ký tự xuống dòng
long_string="Tôi là một chuỗi
đặc biệt dài."
```

**Không nên dùng**

```sh
# Gộp vào một dòng sử dụng \n (có thể chấp nhận được cho các trường hợp cụ thể như Slack API)
str="Tôi là một chuỗi đặc biệt dài\n."
```

### Pipelines (Đường ống)

> [!TIP]
>
> - ✔️ NÊN: Viết toàn bộ pipeline trên một dòng nếu nó vừa vặn và dễ đọc
> - ✔️ NÊN: Chia pipeline thành nhiều dòng nếu nó dài và khó đọc
> - ✔️ NÊN: Áp dụng quy tắc tương tự cho các chuỗi lệnh với `|`, và các toán tử logic `||` và `&&`

Nếu một pipeline dài và khó đọc, hãy chia nó thành nhiều dòng riêng biệt. Nếu toàn bộ pipeline vừa vặn trên một dòng, hãy viết nó trên một dòng. Khi ngắt dòng, hãy chỉ ra sự tiếp tục cho các phần pipe tiếp theo bằng cách thêm dấu `\` ở cuối dòng, thụt vào hai khoảng trắng và đặt dấu pipe ở đầu dòng tiếp theo.

Điều này áp dụng cho các chuỗi lệnh sử dụng `|`, và các toán tử logic `||` và `&&`.

**Nên dùng**

```sh
# Nếu nó vừa trên một dòng
command1 | command2

# Lệnh dài
command1 \
  | command2 \
  | command3 \
  | command4
```

**Không nên dùng**

```sh
# Ngắt dòng không cần thiết khi nó vừa trên một dòng
command1 \
  | command2

# Khó đọc nếu không ngắt dòng
command1 | command2 | command3 | command4
```

### Luồng điều khiển

> [!TIP]
>
> - ✔️ NÊN: Đặt `; do` và `; then` trên cùng dòng với `while`, `for` và `if`
> - ✔️ NÊN: Đặt `elif` và `else` trên dòng riêng của chúng
> - ✔️ NÊN: Viết lựa chọn giữa hai hành động bằng `if`/`else`
> - ✔️ NÊN: Chọn giá trị đầu tiên không rỗng bằng `dybatpho::coalesce`, và lệnh đầu tiên đã được cài bằng `dybatpho::coalesce_cmd`, thay vì `test && x=a || x=b`. (dybatpho)
> - ✔️ NÊN: Chọn giá trị đầu tiên không rỗng bằng `dybatpho::coalesce`, và lệnh đầu tiên đã được cài bằng `dybatpho::coalesce_cmd`, thay vì `test && x=a || x=b`. (dybatpho)
> - ❌ TRÁNH: Không viết `test && action || other` thay cho if/else: `other` cũng chạy khi `action` lỗi. ShellCheck báo lỗi này là SC2015
> - ❌ TRÁNH: Không dùng `test && { ...; }` làm một `if` trải trên nhiều dòng
> - ❌ TRÁNH: Không kết thúc câu lệnh bằng `;`: dấu chấm phẩy chỉ đứng trước `then` và `do`, hoặc giữa các câu lệnh trên cùng một dòng

Vòng lặp shell hơi khác một chút, nhưng tuân theo nguyên tắc dấu ngoặc nhọn khi khai báo hàm, hãy đặt `; then` và `; do` trên cùng dòng với `if/for/while`. `else` nên được đặt trên dòng riêng của nó, và các cấu trúc đóng cũng nên ở trên dòng riêng của chúng. Chúng nên được căn chỉnh theo chiều dọc với các cấu trúc mở của chúng.

**Nên dùng**

```sh
if [[ -n "${name}" ]]; then
  dybatpho::info "Installing ${name}"
else
  dybatpho::die "No tool name given"
fi

for tool in "${tools[@]}"; do
  printf '%s\n' "${tool}"
done
```

**Không nên dùng**

```sh
if [[ -n "${name}" ]];
then
  dybatpho::info "Installing ${name}"
fi

for tool in "${tools[@]}"
do
  printf '%s\n' "${tool}"
done
```

`a && b || c` không phải là `if`: `c` chạy khi `a` lỗi, và cả khi `a` thành công nhưng `b` lỗi. Một thông báo như `|| echo "not found"` khi đó nói ngược lại với điều đã xảy ra. Một khối sau `&&` trông như `if` mà không nói ra, và trạng thái của nó lọt ra ngoài khi test sai — xem [Kiểm tra giá trị trả về](#ki%E1%BB%83m-tra-gi%C3%A1-tr%E1%BB%8B-tr%E1%BA%A3-v%E1%BB%81). Câu chặn một dòng `test || action`, để dừng hoặc bỏ qua, vẫn dùng được.

**Nên dùng**

```sh
if [[ -f "${config}" ]]; then
  dybatpho::info "Using ${config}"
else
  dybatpho::warn "No ${config}, using defaults"
fi

[[ -f "${config}" ]] || dybatpho::die "Missing ${config}"
```

**Không nên dùng**

```sh
# Vẫn cảnh báo khi tệp tồn tại nhưng không in được thông báo
[[ -f "${config}" ]] && dybatpho::info "Using ${config}" || dybatpho::warn "No ${config}, using defaults"

# Một `if` trá hình
[[ -f "${config}" ]] && {
  load_config "${config}"
  validate_config
}
```

Phần lớn các dòng `a && b || c` là để chọn một giá trị: một thiết lập hoặc giá trị mặc định của nó, công cụ đầu tiên đã được cài. `dybatpho::coalesce` in ra đối số đầu tiên không rỗng, còn `dybatpho::coalesce_cmd` in ra tên đầu tiên mà `command -v` tìm thấy. Cả hai đều thất bại khi không có giá trị nào, nên trường hợp thiếu được xử lý một lần, thay vì lọt vào nhánh `||`. (dybatpho)

**Nên dùng**

```sh
local editor pager
editor="$(dybatpho::coalesce "${VISUAL-}" "${EDITOR-}" vi)"
pager="$(dybatpho::coalesce_cmd bat less more)" || dybatpho::die "No pager is installed"
```

**Không nên dùng**

```sh
[[ -n "${VISUAL-}" ]] && editor="${VISUAL}" || editor="${EDITOR:-vi}"
# Chọn less ngay cả khi less cũng chưa được cài
command -v bat > /dev/null && pager=bat || pager=less
```

Phần lớn các dòng `a && b || c` là để chọn một giá trị: một thiết lập hoặc giá trị mặc định của nó, công cụ đầu tiên đã được cài. `dybatpho::coalesce` in ra đối số đầu tiên không rỗng, còn `dybatpho::coalesce_cmd` in ra tên đầu tiên mà `command -v` tìm thấy. Cả hai đều thất bại khi không có giá trị nào, nên trường hợp thiếu được xử lý một lần, thay vì lọt vào nhánh `||`. (dybatpho)

**Nên dùng**

```sh
local editor pager
editor="$(dybatpho::coalesce "${VISUAL-}" "${EDITOR-}" vi)"
pager="$(dybatpho::coalesce_cmd bat less more)" || dybatpho::die "No pager is installed"
```

**Không nên dùng**

```sh
[[ -n "${VISUAL-}" ]] && editor="${VISUAL}" || editor="${EDITOR:-vi}"
# Chọn less ngay cả khi less cũng chưa được cài
command -v bat > /dev/null && pager=bat || pager=less
```

Xuống dòng đã kết thúc một câu lệnh, nên `;` ở cuối dòng chỉ là thói quen thừa từ ngôn ngữ khác; shfmt sẽ xoá nó.

**Nên dùng**

```sh
name="dotfiles"
printf '%s\n' "${name}"
```

**Không nên dùng**

```sh
name="dotfiles";
printf '%s\n' "${name}";
```

### Độ sâu lồng nhau

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Thoát sớm bằng một guard clause thay vì bọc phần còn lại của hàm trong một `if`
> - ✔️ NÊN: `continue` sớm trong vòng lặp để bỏ qua một phần tử, thay vì lồng công việc vào dưới một `if`
> - ⚠️ CÂN NHẮC: Giữ `if`, vòng lặp và `case` lồng nhau tối đa 3 cấp trong một hàm; chuyển phần bên trong sang một hàm riêng. (tùy chỉnh) <kbd>BSG142</kbd>

Mỗi cấp lồng nhau là thêm một điều kiện người đọc phải nhớ để biết khi nào một dòng chạy, và `fi` đóng nó thì cách cả một màn hình. Một guard clause nêu điều kiện tiên quyết một lần rồi gạt nó đi, để công việc chính của hàm nằm ở cấp đầu tiên. Một `if` không có `else` mà câu lệnh duy nhất là thoát ra — `return`, `continue`, `break`, `exit` hay `dybatpho::die` — chính là một guard như vậy và không tính là một cấp.

**Nên dùng**

```sh
function deploy::sync_hosts {
  local host
  for host in "$@"; do
    [[ -n "${host}" ]] || continue
    if ! ping -c 1 "${host}" &> /dev/null; then
      printf 'Skipping %s: unreachable\n' "${host}" >&2
      continue
    fi
    deploy::sync_host "${host}"
  done
}
```

**Không nên dùng**

```sh
function deploy::sync_hosts {
  local host
  for host in "$@"; do
    if [[ -n "${host}" ]]; then
      if ping -c 1 "${host}" &> /dev/null; then
        if [[ -d "/srv/${host}" ]]; then
          if rsync -a -- "/srv/${host}/" "${host}:/srv/"; then
            printf 'Synced %s\n' "${host}"
          fi
        fi
      fi
    fi
  done
}
```

### Kích thước hàm

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Cho mỗi hàm một việc, đúng việc mà tên của nó nói
> - ✔️ NÊN: Tách việc quyết định làm gì khỏi việc làm: một hàm tính ra kế hoạch và in nó ra, một hàm khác thực hiện nó
> - ⚠️ CÂN NHẮC: Tách một hàm dài hơn 50 dòng code. (tùy chỉnh) <kbd>BSG143</kbd>

Một hàm làm một việc thì đặt tên được, test được và dùng lại được; một hàm vừa kiểm tra, vừa quyết định, vừa hành động thì chỉ có thể chạy nguyên khối. Tách phần quyết định khỏi tác dụng phụ được lợi hai lần: phần quyết định test được mà không đụng tới hệ thống, và chế độ dry-run chỉ cần bỏ qua phần hành động.

Linter đếm các dòng trong thân hàm không trống và không phải comment, và cảnh báo khi vượt 50, khoảng một màn hình. Đó là một tín hiệu, không phải giới hạn: một `case` dài để điều phối các lệnh con, hay một bảng tùy chọn, vẫn có thể ổn khi để nguyên một khối, và nói rõ điều đó bằng `# dyshellint disable=BSG143 # <lý do>` ngay trên hàm.

**Nên dùng**

```sh
function backup::plan {
  local source
  source="${1:?}"
  find "${source}" -type f -newer "${STAMP_FILE}" -print0
}

function backup::run {
  local source file
  source="${1:?}"
  while IFS= read -r -d '' file; do
    cp -p -- "${file}" "${BACKUP_DIR}/${file#"${source}"/}"
  done < <(backup::plan "${source}")
  touch -- "${STAMP_FILE}"
}
```

### Câu lệnh case

> [!TIP]
>
> - ✔️ NÊN: Thụt các case vào hai khoảng trắng
> - ✔️ NÊN: Đối với các case một dòng, đặt một khoảng trắng sau dấu ngoặc đơn đóng của pattern và trước `;;`
> - ✔️ NÊN: Đối với các case dài hoặc nhiều lệnh, chia pattern, action và `;;` thành nhiều dòng
> - ✔️ NÊN: Kết thúc mọi `case` bằng một nhánh `*)`, xử lý hoặc từ chối những gì không pattern nào khớp. `add-default-case` trong [`.shellcheckrc`](.shellcheckrc) kiểm tra điều này
> - ❌ TRÁNH: Không viết dấu ngoặc đơn mở trước pattern, và không rơi xuống nhánh dưới bằng `;&` hay `;;&`
> - ⚠️ CÂN NHẮC: Đối với các case lệnh ngắn, hãy cân nhắc đặt pattern, action và `;;` trên một dòng nếu duy trì được tính dễ đọc

Thụt các điều kiện vào một cấp so với `case` và `esac`. Đối với các action nhiều dòng, thụt thêm một cấp nữa. Không nên có dấu ngoặc đơn mở trước biểu thức pattern. Rơi xuống nhánh dưới bằng `;&` hay `;;&` buộc người đọc lần theo mọi nhánh bên dưới nhánh đã khớp, vì vậy hãy cho mỗi nhánh một action riêng. Không có nhánh `*)`, một giá trị không ai lường trước sẽ lặng lẽ đi qua.

**Nên dùng**

```sh
case "${format}" in
  json | yaml)
    output_file="${name}.${format}"
    renderer="render_${format}"
    ;;
  text) renderer=render_text ;;
  *) dybatpho::die "Unknown format: ${format}" ;;
esac
```

Đối với các lệnh đơn giản, hãy đặt pattern và `;;` trên cùng một dòng nếu duy trì được tính dễ đọc. Nếu action không vừa trên một dòng, hãy đặt pattern trên dòng riêng của nó, sau đó là action trên dòng tiếp theo và sau đó là `;;` trên dòng riêng của nó. Khi đặt pattern trên cùng dòng với action, hãy thêm một khoảng trắng sau dấu ngoặc đơn đóng của pattern và trước `;;`.

### Khai triển biến

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Đặt mọi biến có tên trong dấu ngoặc nhọn, `${var}`, kể cả khi nó đứng một mình trong dấu nháy. `require-variable-braces` trong [`.shellcheckrc`](.shellcheckrc) kiểm tra điều này
> - ✔️ NÊN: Đặt các khai triển biến trong dấu nháy kép. Dấu nháy đơn không khai triển biến
> - ✔️ NÊN: Đọc một biến môi trường có thể chưa được đặt kèm giá trị mặc định khi có `set -u`: `${NO_COLOR-}`, `${TMPDIR:-/tmp}` <kbd>BSG073</kbd>
> - ❌ TRÁNH: Tránh đặt các biến đặc biệt/tham số vị trí của shell trong dấu ngoặc nhọn trừ khi thực sự cần thiết hoặc để tránh nhầm lẫn nghiêm trọng <kbd>BSG043</kbd>
> - ❌ TRÁNH: Không đọc trơn một biến môi trường tùy chọn khi có `set -u`

Các biến nên được đặt trong dấu nháy kép. Sử dụng `${var}` thay vì `$var`, kể cả khi biến là toàn bộ chuỗi trong dấu nháy kép: một dạng duy nhất ở mọi nơi dễ đọc và dễ kiểm tra hơn một quy tắc có ngoại lệ.

**Nên dùng**

<!-- lint: allow BSG043,SC2145,SC2250,SC2320 -->
```sh
# Kiểu ưu tiên cho các biến 'đặc biệt':
echo "Positional: $1" "$5" "$3"
echo "Specials: !=$!, -=$-, _=$_. ?=$?, #=$# *=$* @=$@ \$=$$ …"

# Dấu ngoặc nhọn là cần thiết:
echo "many parameters: ${10}"

# Dấu ngoặc nhọn tránh nhầm lẫn:
# Đầu ra là "a0b0c0"
set -- a b c
printf '%s\n' "${1}0${2}0${3}0"

# Kiểu ưu tiên cho các biến khác:
echo "PATH=${PATH}, PWD=${PWD}, mine=${some_var}"
printf '%s\n' "${PATH}"
while IFS= read -r -d '' file; do
  echo "file=${file}"
done < <(command find /tmp -print0)
```

**Không nên dùng**

```sh
# Các biến không được đặt trong nháy kép, các biến không có ngoặc nhọn,
# các biến đặc biệt của shell một chữ cái được phân tách bằng dấu ngoặc nhọn.
echo a=$avar "b=$bvar" "PID=${$}" "${1}"

# Sử dụng gây nhầm lẫn: cái này được mở rộng thành "${1}0${2}0${3}0",
# không phải "${10}${20}${30}
set -- a b c
echo "$10$20$30"
```

`set -u` dừng script ngay lần đầu đọc một biến chưa được đặt. Những biến mà bên gọi có thể xuất hoặc không — `NO_COLOR`, `TMPDIR`, `XDG_*`, `CI` — chưa được đặt cũng thường như đã đặt, nên một `${NO_COLOR}` trơn chạy được trên máy người viết nhưng dừng mọi script mà người dùng đã chạy `unset NO_COLOR`. `${NAME-}` đọc biến chưa đặt thành chuỗi rỗng; `${NAME:-default}` còn thay luôn cả giá trị rỗng.

**Nên dùng**

```sh
if [[ -n "${NO_COLOR-}" ]]; then
  color=false
fi
cache_dir="${XDG_CACHE_HOME:-${HOME}/.cache}"
```

**Không nên dùng**

```sh
# `NO_COLOR: unbound variable` ngay khi nó không được xuất
if [[ -n "${NO_COLOR}" ]]; then
  color=false
fi
```

### Dấu nháy

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Luôn luôn đặt các biến, command substitution, các chuỗi chứa dấu cách hoặc các ký tự meta của shell trong dấu nháy kép, trừ khi cần một khai triển không được đặt trong nháy kép hoặc shell internal là một số nguyên <kbd>BSG131</kbd>
> - ✔️ NÊN: Dùng dấu nháy các biến đặc biệt nội bộ chỉ đọc của shell được định nghĩa là số nguyên là tùy chọn: `$?`, `$#`, `$$`, `$!` (xem `man bash`). Ưu tiên dùng dấu nháy cho biến nội bộ là số nguyên được định danh, ví dụ PPID
> - ✔️ NÊN: Đóng nháy các từ ngữ dạng chuỗi mà không phải là tùy chọn câu lệnh hoặc tên đường dẫn
> - ✔️ NÊN: Đóng nháy toàn bộ chuỗi có chứa biến, thay vì chỉ đóng nháy riêng lẻ từng biến (tùy chỉnh)
> - ❌ TRÁNH: Không dùng dấu nháy cho các số nguyên. Không dùng dấu nháy cho các biểu thức số học như `$((2 + 2))`
> - ⚠️ CÂN NHẮC: Chú ý đến các quy tắc dấu nháy cho xử lý mẫu (pattern) trong `[[...]]`
> - ⚠️ CÂN NHẮC: Sử dụng `"$@"` thay vì `$*` trừ khi bạn có lý do cụ thể để nối các đối số thành một chuỗi hoặc thông báo log

**Nên dùng**

```sh
# Dấu nháy 'đơn' cho biết rằng không có substitution nào được mong muốn.
# Dấu nháy "kép" cho biết rằng substitution là bắt buộc/được chấp nhận.

# Các ví dụ đơn giản

# "dấu nháy kép cho lệnh gán"
# Lưu ý rằng các dấu nháy được lồng bên trong "$()" không cần thoát.
flag="$(some_command and its args "$@" 'quoted separately')"

# "dấu nháy cho biến"
printf '%s\n' "${flag}"

# Sử dụng mảng với khai triển được dùng dấu nháy cho các list.
declare -a FLAGS
FLAGS=(--foo --bar='baz')
readonly FLAGS
mybinary "${FLAGS[@]}"

# Được chấp nhận nếu không dùng dấu nháy các biến số nguyên nội bộ.
if (($# > 3)); then
  echo "ppid=${PPID}"
fi

# "không bao giờ dùng dấu nháy các số nguyên"
value=32
# "dùng dấu nháy các lệnh gán", ngay cả khi bạn mong đợi số nguyên
number="$(generate_number)"

# "ưu tiên dùng dấu nháy từ", không bắt buộc
readonly USE_INTEGER='true'

# "dùng dấu nháy các ký tự meta của shell"
echo 'Hello stranger, and well met. Earn lots of $$$'
echo "Process $$: Done making \$\$\$."

# "các tùy chọn lệnh hoặc tên đường dẫn"
# ($1 được giả định là chứa một giá trị ở đây)
grep -li -- Hugo /dev/null "$1"

# Các ví dụ ít đơn giản hơn
# "dùng dấu nháy biến, trừ khi được chứng minh là sai": ccs có thể trống
git send-email --to "${reviewers}" ${ccs:+"--cc" "${ccs}"}

# Các biện pháp phòng ngừa tham số vị trí: $1 có thể không được set
# Dấu ngoặc đơn để regex như cũ.
grep -cE '([Ss]pecial|\|?characters*)$' ${1:+"$1"}

# Để chuyển các đối số,
# "$@" là đúng hầu hết mọi lúc, và
# $* là sai hầu hết mọi lúc:
#
# - $* và $@ sẽ split trên dấu cách, làm hỏng các đối số
#   chứa dấu cách và loại bỏ các chuỗi trống;
# - "$@" sẽ giữ lại các đối số như cũ, vì vậy không có đối số
#   nào được cung cấp sẽ dẫn đến không có đối số nào được chuyển;
#   Đây là trong hầu hết các trường hợp những gì bạn muốn sử dụng để chuyển
#   các đối số.
# - "$*" mở rộng thành một đối số, với tất cả các đối số được nối
#   bởi (thường là) dấu cách,
#   vì vậy không có đối số nào được cung cấp sẽ dẫn đến một chuỗi trống
#   được chuyển.
#
# Tham khảo
# https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html và
# https://mywiki.wooledge.org/BashGuide/Arrays để biết thêm

(
  set -- 1 "2 two" "3 three tres"
  echo $#
  set -- "$*"
  echo "$#, $*"
)
(
  set -- 1 "2 two" "3 three tres"
  echo $#
  set -- "$@"
  echo "$#, $*"
)
```

### Khai báo hàm

> [!TIP]
>
> - ✔️ NÊN: Đặt shebang và chú thích đầu tệp trước, rồi tới hằng số, rồi tới các khai báo hàm, và cuối cùng là dòng duy nhất khởi động script
> - ✔️ NÊN: Giữ lời gọi hàm vào (entrypoint) ở dòng cuối cùng của tệp
> - ⚠️ CÂN NHẮC: Bảo vệ lời gọi đó bằng `[[ "${BASH_SOURCE[0]}" == "$0" ]]` khi một bài kiểm thử source script để lấy các hàm của nó
> - ❌ TRÁNH: Không đặt mã thực thi xen giữa các khai báo hàm <kbd>BSG033</kbd>

Một tệp chỉ gồm các khai báo và kết thúc bằng một lời gọi thì có thể đọc theo thứ tự bất kỳ, và việc `source` nó để kiểm thử không chạy gì ngoài lời gọi đó — thứ mà một điều kiện trên `BASH_SOURCE` bỏ qua, vì `${BASH_SOURCE[0]}` chỉ bằng `$0` khi tệp được thực thi. Mã nằm rải rác giữa các hàm sẽ chạy ngay lúc nạp tệp, khiến script không thể `source` được và rất khó lần ra khi nó hỏng giữa chừng.

**Nên dùng**

```sh
#!/usr/bin/env bash
# @file test.sh
# @brief Run tests for the dotfiles setup
SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
# shellcheck source=lib/dybatpho/init.sh
. "${SCRIPT_DIR}/lib/dybatpho/init.sh" --modules cli
dybatpho::register_common_handlers

function _spec_main {
  ...
}

function _main {
  ...
}

# Chỉ chạy khi được thực thi, để bài kiểm thử có thể source tệp lấy các hàm
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  dybatpho::generate_from_spec _spec_main "$@"
fi
```

**Không nên dùng**

```sh
function _spec_main {
  ...
}

# Chạy ngay khi tệp được nạp, trước cả khi _main được định nghĩa
rm -rf "${cache_dir}"

function _main {
  ...
}
```

## Tính năng và lỗi

### Sử dụng ShellCheck

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng ShellCheck để xác định lỗi trong các tập lệnh shell
> - ✔️ NÊN: Giải quyết tất cả các cảnh báo ShellCheck với mức độ nghiêm trọng từ "warning" trở lên. (tùy chỉnh)
> - ✔️ NÊN: Sao chép [`.shellcheckrc`](.shellcheckrc) của hướng dẫn này vào dự án: nó bật các kiểm tra tùy chọn mà hướng dẫn yêu cầu theo tên, và cho phép ShellCheck đi theo các chỉ thị `source=`. (tùy chỉnh)
> - ✔️ NÊN: Chỉ cho ShellCheck biết thư viện được source qua một đường dẫn tính ra bằng `# shellcheck source=<path>`, thay vì tắt SC1091 <kbd>BSG109</kbd>
> - ⚠️ CÂN NHẮC: Cân nhắc giải quyết tất cả các cảnh báo ShellCheck với mức độ nghiêm trọng từ "info" trở lên. (tùy chỉnh)
> - ⚠️ CÂN NHẮC: Nếu bạn không thể giải quyết các cảnh báo ShellCheck với mức độ nghiêm trọng "info", hãy cân nhắc thêm các chú thích `# shellcheck disable=SCXXXX` để bỏ qua chúng, kèm lý do trên cùng dòng. (tùy chỉnh) <kbd>BSG123</kbd>

Dự án [ShellCheck](https://www.shellcheck.net/) phát hiện các lỗi và cảnh báo phổ biến trong các tập lệnh shell. Hãy áp dụng nó cho tất cả các tập lệnh shell, bất kể kích thước của chúng.

ShellCheck có thể được [cài đặt](https://github.com/koalaman/shellcheck) trên Windows, Ubuntu và macOS.

```sh
# Debian/Ubuntu
sudo apt install shellcheck
# macOS
brew install shellcheck
# Windows
winget install --id koalaman.shellcheck
scoop install shellcheck
```

**Nên dùng**

```sh
# Đặt các biến có khả năng chứa khoảng trắng vào trong dấu ngoặc kép.
ls "/foo/bar/${file}"

# Cho ShellCheck biết một đường dẫn tính ra trỏ tới tệp nào, tương đối với script này
# shellcheck source=lib/functions.sh
. "${SCRIPT_DIR}/lib/functions.sh"

# Một phát hiện sai trong ngữ cảnh này, được tắt kèm lý do
# shellcheck disable=SC2016 # do shell ở máy từ xa khai triển
ssh -o ConnectTimeout=10 "${host}" 'printf "%s\n" "$HOSTNAME"'
```

### Thay thế lệnh

> [!TIP]
>
> - ✔️ NÊN: Dùng `$(command)` để thay thế lệnh
> - ✔️ NÊN: Đọc các dòng từ một tham số chuỗi và từ standard input qua cùng một helper, để cả hai cho ra cùng các dòng
> - ❌ TRÁNH: Không dùng dấu nháy ngược
> - ❌ TRÁNH: Không trộn `$(...)` với `<<<` mà không tính tới ký tự xuống dòng mà mỗi cái bỏ đi hay thêm vào

`$(...)` cho phép lồng nhau mà không cần thoát ký tự, và dễ đọc hơn vì dấu mở và dấu đóng khác nhau.

**Nên dùng**

```sh
SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
```

**Không nên dùng**

```sh
# Lồng nhau thì phải thoát ký tự, và hai dấu trông giống hệt nhau
SCRIPT_DIR="`realpath \`dirname "${BASH_SOURCE[0]}"\``"
```

`$(...)` bỏ hết các ký tự xuống dòng ở cuối, còn `<<<` thêm vào một cái. Văn bản đi qua một lệnh thay thế rồi một here-string sẽ thêm hoặc mất một dòng: `mapfile -t lines <<< "${text}"` biến `$'a\nb\n'` thành ba dòng với dòng cuối rỗng, trong khi cùng văn bản đó truyền qua pipe chỉ cho ra hai dòng.

**Nên dùng**

```sh
function text::lines_into {
  local __text_lines_var __text_lines_text
  dybatpho::expect_args __text_lines_var __text_lines_text -- "$@"
  local -n __text_lines_ref="${__text_lines_var}"
  __text_lines_ref=()
  local __text_lines_line
  while IFS= read -r __text_lines_line || [[ -n "${__text_lines_line}" ]]; do
    __text_lines_ref+=("${__text_lines_line}")
  done < <(printf '%s' "${__text_lines_text}")
}
```

**Không nên dùng**

```sh
# `$'a\nb\n'` thành ba dòng, dòng cuối rỗng
mapfile -t lines <<< "${text}"
```

### Kiểm tra đầu vào trong thay thế lệnh

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Trả về một giá trị cần kiểm tra qua nameref, bằng một helper `*_into`, hoặc kiểm tra đầu vào trước khi thay thế lệnh
> - ✔️ NÊN: Kiểm tra mã thoát của một lệnh thay thế mà hàm bên trong có thể dừng script: `value="$(fn)" || return $?`
> - ✔️ NÊN: Gọi một hàm thay đổi trạng thái — biến toàn cục, cache hay memo, bộ đếm, việc đăng ký bí mật — trong shell của bên gọi, và trả giá trị qua nameref
> - ❌ TRÁNH: Không gọi một hàm có thể dừng script, qua `dybatpho::die` hay `exit`, bên trong `$(...)` rồi chạy tiếp vô điều kiện <kbd>BSG047</kbd>
> - ❌ TRÁNH: Không gọi hàm như vậy bên trong `$(...)`: mọi thay đổi nó tạo ra đều mất cùng subshell <kbd>BSG084</kbd>

`$(...)` chạy trong một subshell, nên `dybatpho::die` hay `exit` bên trong chỉ kết thúc subshell đó. Dưới `set -e`, phép gán thất bại vẫn dừng script, nhưng ở bất kỳ chỗ nào errexit bị tạm tắt — trong `if`, sau `||`, `&&` hay `!`, hoặc dưới `run` của bats — bên gọi vẫn chạy tiếp với một giá trị rỗng, ngay sau một thông báo lỗi nghiêm trọng nói rằng script sắp dừng. Một helper kiểm tra ngay trong shell của bên gọi sẽ dừng script đúng chỗ.

**Nên dùng**

```sh
# Kiểm tra trong shell của bên gọi, rồi gán biến mà bên gọi đặt tên
function __net_port_into {
  local __net_port_var __net_port_value
  dybatpho::expect_args __net_port_var __net_port_value -- "$@"
  local -n __net_port_ref="${__net_port_var}"
  [[ "${__net_port_value}" =~ ^[0-9]+$ ]] || dybatpho::die "Not a port: ${__net_port_value}"
  __net_port_ref="${__net_port_value}"
}

function net::connect {
  local raw_port port
  dybatpho::expect_args raw_port -- "$@"
  __net_port_into port "${raw_port}"
  nc "${HOST}" "${port}"
}

# Một lệnh thay thế không tránh được thì phải kiểm tra mã thoát của nó
local version
version="$(pkg::read_version "${file}")" || return $?
```

**Không nên dùng**

```sh
function net::port {
  [[ "$1" =~ ^[0-9]+$ ]] || dybatpho::die "Not a port: $1"
  printf '%s\n' "$1"
}

function net::connect {
  local port
  port="$(net::port "$1")"
  nc "${HOST}" "${port}"
}

# Lỗi chỉ kết thúc subshell: nc chạy với port rỗng
if ! net::connect "${raw_port}"; then
  dybatpho::warn "Could not connect"
fi
```

Subshell bỏ đi cả tác dụng phụ lẫn lời từ chối. Một memo được đặt trong `$(...)` không bao giờ được thấy lại, nên phép dò tốn kém mà nó định cache vẫn chạy ở mọi lần gọi; một token được đăng ký để che bên trong `$(...)` sau đó vẫn bị in ra nguyên vẹn; một bộ đếm thì không bao giờ tăng.

**Nên dùng**

```sh
function __date_flavor_into {
  local __date_flavor_var
  dybatpho::expect_args __date_flavor_var -- "$@"
  local -n __date_flavor_ref="${__date_flavor_var}"
  if [[ -z "${__DATE_FLAVOR-}" ]]; then
    if date --version &> /dev/null; then __DATE_FLAVOR=gnu; else __DATE_FLAVOR=bsd; fi
  fi
  __date_flavor_ref="${__DATE_FLAVOR}"
}

local flavor
__date_flavor_into flavor
```

**Không nên dùng**

```sh
# Memo được đặt trong subshell, nên lần gọi nào cũng dò lại
flavor="$(date::flavor)"

# Được đăng ký để che trong subshell: log của bên gọi vẫn hiện token
token="$(secret::read API_TOKEN)"
```

### Biểu thức kiểm tra

> [!TIP]
>
> - ✔️ NÊN: Dùng `[[ ... ]]` để kiểm tra điều kiện
> - ✔️ NÊN: Dùng `dybatpho::is` cho những phép kiểm tra nó đã bao phủ, như `command`, `file`, `dir`, `true` và `blank`. (dybatpho)
> - ❌ TRÁNH: Không dùng `[ ... ]`, `test` hay `/usr/bin/[`

`[[ ... ]]` là từ khóa của shell chứ không phải một lệnh, nên nó không tách từ và không khai triển ký tự đại diện cho các toán hạng, đồng thời hỗ trợ `=~` và `&&`. Thiếu một dấu nháy trong `[ ... ]` là một lỗi; trong `[[ ... ]]` thì thường là không.

**Nên dùng**

```sh
if [[ ! -f "${SCRIPT_DIR}/lib/dybatpho/init.sh" ]]; then
  git -C "${REPO_DIR}" submodule update --init "${SCRIPT_DIR}/lib/dybatpho"
fi

# Một phép kiểm tra có tên dễ đọc hơn là cờ mà nó bọc lại
dybatpho::is command "${name}" || dybatpho::dry_run dytoy -t "${name}"
```

**Không nên dùng**

```sh
# Tách từ khi biến chứa dấu cách, và không dùng được =~
if [ ! -f $SCRIPT_DIR/lib/dybatpho/init.sh ]; then
  ...
fi
```

### Kiểm tra chuỗi

> [!TIP]
>
> - ✔️ NÊN: Dùng `==` để so sánh chuỗi trong `[[ ... ]]`
> - ✔️ NÊN: Dùng `-z` để kiểm tra chuỗi rỗng và `-n` để kiểm tra chuỗi không rỗng
> - ✔️ NÊN: Dùng `dybatpho::string_is_blank` khi giá trị chỉ gồm khoảng trắng cũng phải được coi là rỗng. (dybatpho)
> - ✔️ NÊN: So sánh số bằng `(( ... ))`, hoặc bằng `-lt`, `-gt`, `-eq` trong `[[ ... ]]`
> - ❌ TRÁNH: Không dùng một dấu `=` để so sánh chuỗi
> - ❌ TRÁNH: Không dùng `<` hay `>` để so sánh số trong `[[ ... ]]`
> - ❌ TRÁNH: Không chạy một biến cờ như một lệnh, như `if ${force}; then` hay `while ${running}; do`: giá trị của nó bị thực thi <kbd>BSG121</kbd>
> - ❌ TRÁNH: Không thêm một chữ cái vào trước cả hai vế của phép so sánh, như `[[ "x${answer}" == "xyes" ]]`: hãy đặt biến trong dấu nháy <kbd>BSG127</kbd>

Trong `[[ ... ]]`, hai toán tử `<` và `>` so sánh theo thứ tự từ điển, nên `[[ 10 < 9 ]]` là đúng. Số thì phải nằm trong `(( ... ))`.

**Nên dùng**

```sh
if [[ "${identity}" == "personal" ]]; then
  passphrase="$(rbw get 'Age Dotfiles')"
fi

if dybatpho::string_is_blank "${expected_hash}"; then
  dybatpho::die "No checksum found for ${asset_name}"
fi

if ((${#MAIN_ARGS[@]} > 0)); then
  exec "${BATS_CMD}" "${MAIN_ARGS[@]}"
fi
```

**Không nên dùng**

```sh
# So sánh mà trông như phép gán
[[ "$identity" = "personal" ]]

# So sánh theo từ điển, nên với 10 và 9 thì điều kiện này đúng
[[ "${count}" > "${limit}" ]]

# Cách viết dài dòng của -z
[[ "${value}" == "" ]]
```

`if ${force}; then` chạy được chừng nào biến còn chứa `true` hay `false`, vì đó là các lệnh. Mọi giá trị khác cũng sẽ chạy: một lỗi gõ trong tệp cấu hình thành "command not found", và một giá trị do kẻ tấn công kiểm soát là một lệnh do chính họ chọn. Hãy so sánh giá trị thay vì chạy nó.

**Nên dùng**

```sh
if dybatpho::is true "${FORCE}"; then
  overwrite=true
fi
while [[ "${running}" == true ]]; do
  poll::once || running=false
done
```

**Không nên dùng**

```sh
# Chạy bất cứ thứ gì FORCE chứa
if ${FORCE}; then
  overwrite=true
fi
```

Tiền tố `x` là cách lách cho lệnh `test` cũ, vốn có thể hiểu một giá trị như `-n`, `!` hay `(` là toán tử. `[[ ... ]]` phân tích các toán tử trước khi khai triển bất cứ thứ gì, nên một giá trị không bao giờ bị hiểu là toán tử: biến đặt trong dấu nháy là đủ, còn tiền tố chỉ làm phép so sánh khó đọc hơn.

**Nên dùng**

```sh
if [[ "${answer}" == "yes" ]]; then
  confirmed=true
fi
```

**Không nên dùng**

```sh
# Đề phòng một vấn đề mà [[ ... ]] không hề có
if [[ "x${answer}" == "xyes" ]]; then
  confirmed=true
fi
```

### Chuyển đổi chữ hoa chữ thường

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Đổi chữ hoa/thường của một biến bằng `${var,,}` hoặc `${var^^}`, không dùng `tr`. Giữ `tr` cho một file hay một luồng dữ liệu <kbd>BSG145</kbd>
> - ✔️ NÊN: So sánh không phân biệt hoa/thường bằng cách hạ cả hai vế về chữ thường, `[[ "${answer,,}" == yes ]]`, thay vì bật `nocasematch`
> - ⚠️ CÂN NHẮC: Tắt `shopt -s nocasematch` lại bằng `shopt -u`, hoặc bật nó trong một subshell: `local -` không khôi phục các tùy chọn `shopt`. (tùy chỉnh) <kbd>BSG146</kbd>
> - ✔️ NÊN: Truyền `dybatpho::lower` hoặc `dybatpho::upper` ở chỗ cần một lệnh thay vì một khai triển, chẳng hạn một hàm mapper. (dybatpho)

`${var,,}` chuyển mọi chữ cái thành chữ thường, `${var^^}` chuyển mọi chữ cái thành chữ hoa, còn `${var^}` chỉ viết hoa chữ đầu. Chúng chạy ngay trong shell, trong khi `$(echo "${var}" | tr '[:upper:]' '[:lower:]')` tạo một pipe và hai tiến trình cho một giá trị, và `echo` làm hỏng giá trị như `-n`. Cả ba có từ Bash 4.0; trên Bash 3.2 của macOS không có khai triển nào làm việc này, thêm một lý do để kiểm tra phiên bản ngay từ đầu, xem [Phiên bản Bash](#phi%C3%AAn-b%E1%BA%A3n-bash).

`shopt -s nocasematch` không thuộc về riêng một phép so sánh: mọi `[[ == ]]`, `=~` và `case` sau nó, trong hàm, trong mọi thứ hàm gọi tới và trong phần còn lại của script, đều bỏ qua hoa/thường cho tới khi nó bị tắt. `local -` không giúp được ở đây: nó chỉ khôi phục các tùy chọn của `set`, không khôi phục các tùy chọn của `shopt`. Hãy hạ giá trị về chữ thường, hoặc tắt tùy chọn ngay sau phép so sánh. Trong một thư viện, BSG092 đã yêu cầu điều tương tự.

**Nên dùng**

```sh
local level="${LOG_LEVEL:-info}"
case "${level,,}" in
  debug | info) printf '%s\n' "${level^^}" ;;
  *) printf 'Unknown level: %s\n' "${level}" >&2 ;;
esac

function config::is_true {
  [[ "${1,,}" == @(1|true|yes|on) ]]
}

function config::is_false {
  local status=0
  shopt -s nocasematch
  [[ "${1-}" == @(0|false|no|off) ]] || status=1
  shopt -u nocasematch
  return "${status}"
}
```

**Không nên dùng**

```sh
level="$(echo "${LOG_LEVEL}" | tr '[:upper:]' '[:lower:]')"

shopt -s nocasematch
[[ "${answer}" == yes ]] && confirmed=true
```

`dybatpho::lower` và `dybatpho::upper` in ra `${1,,}` và `${1^^}`. Chúng không nhanh hơn khai triển, cũng không giúp gì trên Bash 3.2, nhưng chúng là lệnh: chúng dùng được ở chỗ cần tên một hàm, chẳng hạn mapper của `dybatpho::array_map`. (dybatpho)

**Nên dùng**

```sh
local -a tags=(Linux macOS BSD)
dybatpho::array_map tags dybatpho::lower
printf '%s\n' "${tags[@]}"
```

### Biểu thức chính quy

> [!TIP]
>
> - ✔️ NÊN: Giữ biểu thức chính quy trong một biến và khai triển nó không có nháy ở bên phải `=~`
> - ✔️ NÊN: Chỉ đặt trong nháy những phần phải khớp nguyên văn, như một giá trị được ghép vào mẫu
> - ✔️ NÊN: Sao chép những gì cần ra khỏi `BASH_REMATCH` ngay sau khi khớp
> - ⚠️ CÂN NHẮC: Dùng mẫu glob với `==` khi như vậy là đủ: `[[ "${file}" == *.tar.gz ]]`
> - ❌ TRÁNH: Không đặt cả biểu thức chính quy trong nháy: vế phải có nháy được so khớp như một chuỗi thường

Dấu nháy ở bên phải `=~` làm phần đó thành nguyên văn, nên `[[ "${tag}" =~ "^v[0-9]+" ]]` tìm đúng các ký tự `^v[0-9]+` và không bao giờ khớp một phiên bản. Viết thẳng mẫu vào `[[ ]]` chỉ chạy được cho tới khi nó chứa một khoảng trắng, một `|` hay một `)` mà shell đọc trước. Một biến tránh được cả hai. `BASH_REMATCH` bị ghi đè bởi lần `=~` tiếp theo, kể cả lần nằm trong một hàm mà bạn gọi.

**Nên dùng**

```sh
# Mẫu nằm trong biến, không có nháy sau =~
local version_re='^v?([0-9]+)\.([0-9]+)\.([0-9]+)$'
if [[ "${tag}" =~ ${version_re} ]]; then
  major="${BASH_REMATCH[1]}"
  minor="${BASH_REMATCH[2]}"
fi

# Một phần nguyên văn được ghép vào, có nháy; phần còn lại vẫn là mẫu
[[ "${name}" =~ ^"${prefix}"[0-9]+$ ]]
```

**Không nên dùng**

```sh
# Có nháy: chỉ khớp với chuỗi nguyên văn ^v?([0-9]+)...
[[ "${tag}" =~ "^v?([0-9]+)\.([0-9]+)" ]]

# Lúc này BASH_REMATCH có thể thuộc về một lần khớp bên trong other_check
[[ "${tag}" =~ ^v?([0-9]+)\.([0-9]+)$ ]]
other_check "${tag}"
major="${BASH_REMATCH[1]}"
```

### Khai triển ký tự đại diện cho tên tệp

> [!TIP]
>
> - ✔️ NÊN: Thêm tiền tố `./` cho mẫu đại diện khi nó được khai triển thành tham số của lệnh
> - ✔️ NÊN: Kiểm tra từng kết quả có tồn tại bằng `[[ -e "${file}" || -L "${file}" ]]`, hoặc bật `nullglob` trong một phạm vi kết thúc cùng vòng lặp <kbd>BSG093</kbd>
> - ⚠️ CÂN NHẮC: Dùng `compgen -G` khi bạn cần các kết quả khớp như dữ liệu và chấp nhận kết quả rỗng. (tùy chỉnh)
> - ❌ TRÁNH: Không truyền `*` trần cho một lệnh
> - ❌ TRÁNH: Không cho rằng một glob không khớp gì sẽ khai triển thành rỗng: nó vẫn giữ nguyên là mẫu
> - ❌ TRÁNH: Không parse output của `ls`: hãy lặp trên một glob, hoặc dùng `find -print0` cho cả một cây thư mục <kbd>BSG125</kbd>

Một tệp tên `-rf` trong thư mục sẽ biến `rm *` thành `rm -rf`. `./*` khai triển thành các đường dẫn bắt đầu bằng `./`, không lệnh nào nhầm chúng với tùy chọn được.

`ls` in tên tệp cho người đọc. Trong `$(ls)` hay `ls | ...`, một tên có dấu cách thành hai từ, một tên có ký tự xuống dòng thành hai dòng, và một tên có `*` lại bị khai triển lần nữa; một số phiên bản còn thay ký tự không in được bằng `?`. Glob trao từng tên cho script đúng như nó vốn có. `ls` chỉ để hiển thị danh sách cho người dùng thì vẫn dùng được.

**Nên dùng**

```sh
local file
for file in ./*.log; do
  [[ -e "${file}" ]] || continue
  gzip -- "${file}"
done
```

**Không nên dùng**

```sh
# "my app.log" thành "my" và "app.log"
for file in $(ls *.log); do
  gzip "${file}"
done
```

**Nên dùng**

```sh
rm -f ./*.tmp

# Kết quả khớp dùng như dữ liệu, chấp nhận rỗng
local -a matches=()
mapfile -t matches < <(compgen -G "${search_pattern}" || true)
```

**Không nên dùng**

```sh
# Một tệp tên '-rf' hay '--force' sẽ trở thành tùy chọn
rm -f *.tmp
```

dybatpho bật `nullglob`, `globstar` và `extglob` cho script source nó, nên ở đó một glob không khớp gì sẽ khai triển thành rỗng; bước kiểm tra bên dưới không tốn gì và giữ cho một hàm vẫn đúng khi được source mà không có thư viện. (dybatpho)

Khi không có `nullglob`, một mẫu không khớp tệp nào được giữ nguyên, nên vòng lặp chạy một lần với `file` là `/etc/app/*.conf` và lệnh thất bại trên một cái tên không tồn tại — hoặc, với thao tác ghi, sẽ tạo ra nó.

**Nên dùng**

```sh
local file
for file in "${dir}"/*.conf; do
  [[ -e "${file}" || -L "${file}" ]] || continue
  load_config "${file}"
done
```

**Không nên dùng**

```sh
# Không có tệp .conf nào, vòng lặp chạy một lần trên chuỗi "/etc/app/*.conf"
for file in "${dir}"/*.conf; do
  load_config "${file}"
done
```

### Locale và thứ tự sắp xếp

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Đặt `LC_ALL=C` cục bộ khi một thứ tự hay một phép so sánh phải theo từng byte và ổn định
> - ✔️ NÊN: So sánh số như số: tách hoặc đệm số 0 cho khóa số trước khi sắp xếp các tên có mang nó
> - ❌ TRÁNH: Không dựa vào việc thứ tự glob, `[[ a < b ]]`, `sort` hay `printf '%f'` hoạt động giống nhau dưới mọi locale

Khai triển glob, `[[ < ]]` và `sort` sắp xếp chuỗi theo quy tắc so sánh hiện hành, còn `printf '%f'` đọc và ghi dấu thập phân của locale. Cùng một script lại xếp `backup-1` trước hoặc sau `backup` tùy theo `LANG` của người dùng, và mọi locale đều xếp `-10` trước `-2`. Một chính sách lưu giữ dựa trên thứ tự đó sẽ xóa nhầm bản sao lưu.

**Nên dùng**

```sh
local LC_ALL=C
local -a backups=("${dir}"/backup-*)
# So sánh hậu tố số như một con số
if ((10#${a_suffix} < 10#${b_suffix})); then
  older="${a}"
fi
```

**Không nên dùng**

```sh
# Thứ tự phụ thuộc LANG, và -10 luôn đứng trước -2
for backup in "${dir}"/backup-*; do
  newest="${backup}"
done
```

### Eval là xấu xa

> [!TIP]
>
> - ✔️ NÊN: Đặt mọi giá trị ghép vào một chuỗi cho `eval`, hay cho `dybatpho::dry_run` một chuỗi, trong `printf %q`; tốt hơn nữa là truyền một danh sách tham số <kbd>BSG080</kbd> <kbd>BSG130</kbd>
> - ❌ TRÁNH: Không dùng `eval` <kbd>BSG040</kbd>
> - ❌ TRÁNH: Không dựng chuỗi lệnh cho `eval` hay `dybatpho::dry_run "<string>"` từ dữ liệu chưa được escape

`eval` khiến ta không thể biết, chỉ bằng cách đọc script, lệnh nào sẽ chạy hay biến nào sẽ được gán. Khi cần thực thi một giá trị, hãy dùng mảng cho lệnh và tham số của nó, hoặc tham chiếu gián tiếp cho biến.

**Nên dùng**

```sh
local -a options=() packages=()
options+=(--noconfirm)
packages+=("${name}")
dybatpho::dry_run pacman -S "${options[@]}" "${packages[@]}"
```

**Không nên dùng**

```sh
# Người đọc không biết nó khai triển thành gì, và một dấu cách trong $name sẽ làm hỏng nó
eval "pacman -S ${options} ${packages}"
```

Khi một chuỗi buộc phải được đánh giá — code parser được sinh ra, một mẫu lệnh cấu hình sẵn, một dòng chạy thử — mọi mẩu dữ liệu ghép vào đều trở thành code. Một đường dẫn có dấu cách bị tách làm hai tham số, và một giá trị chứa `$(...)` hay `;` sẽ được chạy. `printf %q` escape một giá trị để shell đọc lại đúng thành một từ, còn một danh sách tham số thì không bao giờ đi qua parser.

**Nên dùng**

<!-- lint: allow BSG040 -->
```sh
# Danh sách tham số: không có gì bị parse lại lần nữa
dybatpho::dry_run gpg --detach-sign --output "${signature}" "${path}"

# Một mẫu buộc phải là chuỗi: mọi giá trị đều được quote cho shell
local command
printf -v command '%s %q %q' "${SIGN_CMD}" "${signature}" "${path}"
eval "${command}"
```

**Không nên dùng**

```sh
# Đường dẫn có dấu cách bị tách, và đường dẫn chứa $(...) sẽ chạy nó
dybatpho::dry_run "${SIGN_CMD} ${signature} ${path}"
eval "${SIGN_CMD} ${signature} ${path}"
```

### Bí mật và thông tin xác thực

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Truyền token, mật khẩu và URL bí mật cho một lệnh qua tệp cấu hình, standard input hoặc biến môi trường: `curl --config`, `-H @file`
> - ✔️ NÊN: Gửi bearer token bằng `dybatpho::curl_auth_bearer`, hàm trao nó cho `curl` qua một tệp cấu hình riêng. (dybatpho)
> - ✔️ NÊN: Che URL trước khi nó vào một thông báo hay một log: giữ scheme và host, bỏ thông tin người dùng, đường dẫn và query
> - ✔️ NÊN: Đăng ký một bí mật để che ngay khi đọc nó, trong shell của bên gọi, bằng `dybatpho::secret_register`. (dybatpho)
> - ✔️ NÊN: Tạo tệp chứa bí mật dưới `umask 077`, trong một subshell, hoặc bằng `mktemp`, công cụ tạo tệp với quyền `0600`
> - ✔️ NÊN: Ghi bí mật vào tệp bằng `dybatpho::secret_write_file`, hàm tạo tệp với quyền `0600` rồi chuyển nó vào đúng chỗ. (dybatpho)
> - ❌ TRÁNH: Không đặt bí mật trong tham số của một lệnh, nơi mọi người dùng trên máy đọc được nó qua `ps` và `/proc` <kbd>BSG081</kbd>
> - ❌ TRÁNH: Không ghi nguyên vẹn URL hay body của request vào log khi nó có thể mang token
> - ❌ TRÁNH: Không ghi bí mật bằng một `>` trơn dưới umask mặc định: tệp đọc được bởi mọi người dùng, ít nhất cho tới một lệnh `chmod` sau đó

Tham số của một tiến trình đang chạy là công khai trên máy, và log sống lâu hơn lần chạy đã ghi ra nó. Một URL webhook thường chính là thông tin xác thực, nên in URL của một request thất bại cũng làm lộ nó y như in một token. Vì vậy bí mật đi theo đường khác — một tệp cấu hình riêng mà curl đọc, standard input, một biến được kế thừa — và một thông báo chỉ gọi tên request bằng host của nó.

**Nên dùng**

```sh
local config
dybatpho::create_temp config ".curl"
printf 'header = "Authorization: Bearer %s"\n' "${TOKEN}" > "${config}"
curl --config "${config}" --fail-with-body "${url}"

# Một tệp tồn tại lâu hơn lần chạy: được tạo ở chế độ riêng tư
(umask 077 && printf '%s\n' "${TOKEN}" > "${XDG_CONFIG_HOME}/app/token")

# Chỉ có scheme và host vào log: https://hooks.slack.com/[redacted]
dybatpho::error "Request to ${redacted_url} failed"
```

**Không nên dùng**

```sh
# Token nằm trong `ps` suốt thời gian request chạy
curl -H "Authorization: Bearer ${TOKEN}" "${url}"

# Ai cũng đọc được ngay khi nó vừa tồn tại, kể cả khi có chmod theo sau
printf '%s\n' "${TOKEN}" > "${XDG_CONFIG_HOME}/app/token"

# URL webhook chính là bí mật, và giờ nó nằm trong log
dybatpho::error "Request to ${WEBHOOK_URL} failed"
```

`dybatpho::secret_register` thêm một giá trị, và từng dòng của giá trị nhiều dòng, vào danh sách che mà mọi hàm log của dybatpho áp dụng, nên một thông báo mang giá trị đó sẽ in ra `***`. Hàm chạy trong shell của bên gọi: nếu đăng ký bên trong `$(...)`, giá trị sẽ bị quên khi substitution kết thúc. (dybatpho)

**Nên dùng**

```sh
API_TOKEN="$(< "${token_file}")"
dybatpho::secret_register "${API_TOKEN}"
# Ghi log "Request failed for ***"
dybatpho::error "Request failed for ${API_TOKEN}"
```

`dybatpho::secret_write_file` nhận tên của biến chứa bí mật, không phải giá trị của nó, nên giá trị không bao giờ xuất hiện trong danh sách tham số. Hàm ghi dưới `umask 077` vào một tệp tạm mà không ai khác có thể đã tạo trước, rồi đổi tên nó đè lên đích. (dybatpho)

**Nên dùng**

```sh
dybatpho::secret_write_file "${XDG_CONFIG_HOME:-${HOME}/.config}/app/token" API_TOKEN
```

`dybatpho::curl_auth_bearer` đặt header `Authorization` vào một tệp cấu hình mà chỉ script đọc được, rồi truyền tệp đó cho `curl`, nên token không nằm trong tham số của tiến trình nào. Hàm thử lại và thất bại giống `dybatpho::curl_do`. (dybatpho)

**Nên dùng**

```sh
dybatpho::curl_auth_bearer "${api}/v1/me" "${API_TOKEN}" "${response}" || dybatpho::die "Cannot read the profile"
```

### Dựng output có cấu trúc

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dựng JSON và YAML bằng `jq` hoặc `yq` với `--arg`, hoặc qua một helper escape duy nhất mà mọi module dùng chung
> - ✔️ NÊN: Dựng một object JSON bằng `dybatpho::json_object`, và quote một giá trị bằng `dybatpho::json_string`. (dybatpho)
> - ✔️ NÊN: Ghi các trường CSV qua một helper duy nhất, nhân đôi dấu nháy và đặt trong nháy những trường chứa dấu phân cách, dấu nháy hay ký tự xuống dòng
> - ⚠️ CÂN NHẮC: Ghi CSV bằng `dybatpho::csv_write`, hàm đặt trong nháy đúng những trường cần. (dybatpho)
> - ❌ TRÁNH: Không ghép một giá trị vào văn bản có cấu trúc bằng `printf '{"key":"%s"}'` <kbd>BSG086</kbd>

Một giá trị chứa dấu nháy, dấu gạch chéo ngược hay ký tự xuống dòng sẽ làm hỏng một tài liệu dựng tay, hoặc đổi nghĩa của nó — phía nhận đọc ra thêm một khóa hay một chuỗi bị cắt cụt. Module nào tự dựng JSON cũng sẽ mọc ra bộ escape riêng, và mỗi bộ lại bỏ sót một ký tự điều khiển khác nhau.

**Nên dùng**

```sh
jq -n --arg text "${message}" --arg channel "${channel}" \
  '{text: $text, channel: $channel}'
```

**Không nên dùng**

```sh
# Một thông điệp có dấu nháy hay xuống dòng tạo ra JSON không hợp lệ
printf '{"text":"%s","channel":"%s"}\n' "${message}" "${channel}"
```

`dybatpho::json_object` nhận lần lượt tên và giá trị, rồi truyền mọi giá trị cho `jq` hoặc `yq` dưới dạng dữ liệu, trong một lần gọi; một tên viết `name:json` nhận một tài liệu JSON thay vì một chuỗi. `dybatpho::json_string` escape một giá trị ngay trong Bash, không cần tiến trình. (dybatpho)

**Nên dùng**

```sh
local payload
payload="$(dybatpho::json_object text "${message}" channel "${channel}" tags:json '["deploy"]')" || return 1
```

`dybatpho::csv_write` ghi các bản ghi của một mảng theo dạng mà `dybatpho::csv_read` điền vào: mỗi phần tử là một bản ghi, các trường nối với nhau bằng ký tự ASCII unit separator. Một dòng dựng bằng tay nối các trường bằng `$'\x1f'`. (dybatpho)

**Nên dùng**

```sh
local -a rows=()
dybatpho::csv_read "${input}" rows
rows+=("total"$'\x1f'"${sum}")
dybatpho::csv_write rows > "${output}"
```

### In dữ liệu

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: In dữ liệu — một biến, một đường dẫn, bất cứ thứ gì đến từ bên ngoài — bằng `printf '%s\n' "${value}"`
> - ✔️ NÊN: Đặt các phần thay đổi vào đối số của `printf`, không bao giờ đặt vào chuỗi định dạng
> - ⚠️ CÂN NHẮC: `echo` vẫn ổn cho một thông báo cố định không chứa biến và không bắt đầu bằng `-`
> - ❌ TRÁNH: Không dùng `echo -e` hay `echo -n`, và không `echo` một giá trị có thể bắt đầu bằng `-` hoặc chứa dấu gạch chéo ngược <kbd>BSG100</kbd>

`echo` đọc các đối số đầu tiên như tùy chọn và, tùy shell và `xpg_echo`, khai triển dấu gạch chéo ngược. `echo "${value}"` không in gì khi giá trị là `-n`, và biến `C:\temp` thành một ký tự tab khi giá trị đi qua `echo -e`. `printf '%s\n'` in đối số đúng như nó là, trên mọi hệ thống. Một giá trị trong chuỗi định dạng cũng không an toàn: dấu `%` trong đó bị đọc như một chỉ thị.

**Nên dùng**

```sh
printf '%s\n' "${value}"
printf 'Processed: %s\n' "${count}" >&2
printf '%s' "${token}" | gpg --encrypt --recipient "${recipient}"

# Một thông báo cố định không chứa biến
echo "Installing tools"
```

**Không nên dùng**

```sh
# Không in gì khi value là -n
echo "${value}"
# Khai triển dấu gạch chéo ngược trong dữ liệu, và -n không di động
echo -e "${message}"
echo -n "${token}" | gpg --encrypt --recipient "${recipient}"
```

### Here document

> [!TIP]
>
> - ✔️ NÊN: Đặt dấu phân cách trong dấu nháy, `<< 'EOF'`, khi văn bản không cần khai triển, để `$`, dấu backtick và dấu gạch chéo ngược giữ nguyên như đã viết
> - ✔️ NÊN: Chỉ để dấu phân cách không có nháy khi văn bản cố ý khai triển biến
> - ✔️ NÊN: Viết phần thân và dấu phân cách đóng ở đầu dòng
> - ❌ TRÁNH: Không dùng `<<-` để thụt lề một here document: nó chỉ bỏ ký tự tab, thứ mà hướng dẫn này không cho phép <kbd>BSG101</kbd>
> - ❌ TRÁNH: Không escape từng dấu `$` của một văn bản không khai triển gì: hãy đặt dấu phân cách trong nháy <kbd>BSG102</kbd>

Một dấu phân cách không có nháy chạy khai triển tham số, thay thế lệnh và phép tính số học trên toàn bộ phần thân: một văn bản trợ giúp nhắc tới `$(date)` sẽ chạy `date`, và một mức giá `$5` trở thành đối số thứ năm. Dạng có nháy khiến phần thân được giữ nguyên. `<<-` chỉ bỏ các tab ở đầu dòng, nên với thụt lề hai khoảng trắng của hướng dẫn này nó không làm gì cả, và `EOF` đóng không được tìm thấy.

**Nên dùng**

```sh
# Văn bản nguyên văn: không có gì trong đó được khai triển
cat << 'EOF'
Run: ${HOME}/bin/tool --all
EOF

# Cố ý khai triển
cat << EOF > "${config}"
user = ${user}
cache = ${cache_dir}
EOF

# Bên trong một khối, phần thân và EOF vẫn bắt đầu ở đầu dòng
if [[ -n "${verbose}" ]]; then
  cat << EOF
Using ${config}
EOF
fi
```

**Không nên dùng**

```sh
# Escape bằng tay: sót một chỗ là nó bị khai triển
cat << EOF
Run: \$HOME/bin/tool, cost: \$5
EOF

# Thụt lề bằng tab với <<-, hỏng ngay khi trình soạn thảo đổi tab thành khoảng trắng
	cat <<- EOF
	Using ${config}
	EOF
```

### Mảng

> [!TIP]
>
> - ✔️ NÊN: Dùng mảng mỗi khi bạn giữ nhiều hơn một giá trị, nhất là các cờ dòng lệnh
> - ✔️ NÊN: Khai báo mảng một cách tường minh: `local -a names=()` trong hàm, `declare -a NAMES=()` ở phạm vi tệp
> - ✔️ NÊN: Thêm phần tử bằng `names+=("${value}")`
> - ✔️ NÊN: Khai triển bằng `"${names[@]}"`, và lấy số phần tử bằng `"${#names[@]}"`
> - ✔️ NÊN: Khai triển một mảng có thể rỗng bằng `${names[@]+"${names[@]}"}` khi script hỗ trợ Bash 4.3 dưới `set -u` <kbd>BSG049</kbd>
> - ✔️ NÊN: Duyệt các chỉ số mà mảng thật sự có bằng `"${!names[@]}"`
> - ✔️ NÊN: Thay cả mảng bằng `names=("${value}")`, và làm rỗng nó bằng `names=()`
> - ❌ TRÁNH: Không giữ nhiều giá trị trong một chuỗi ngăn cách bằng dấu cách
> - ❌ TRÁNH: Không duyệt từ `0` đến `${#names[@]} - 1` trên một mảng mà hàm không tự dựng <kbd>BSG085</kbd>
> - ❌ TRÁNH: Không gán một giá trị đơn cho mảng, `names="${value}"`: nó chỉ thay phần tử 0 và giữ nguyên mọi phần tử khác <kbd>BSG113</kbd>

Một chuỗi ngăn cách bằng dấu cách chỉ là mảng chừng nào chưa có phần tử nào chứa dấu cách. Mảng thì luôn đúng dù các phần tử là gì, và `"${names[@]}"` truyền đi đúng bằng số phần tử đang có, kể cả khi không có phần tử nào.

Trước Bash 4.4, `set -u` coi một mảng rỗng là chưa được đặt, nên `"${names[@]}"` trên một mảng rỗng dừng script với lỗi `unbound variable`. `${names[@]+"${names[@]}"}` khai triển thành không gì cả khi mảng rỗng và thành mọi phần tử trong trường hợp còn lại, trên mọi phiên bản.

**Nên dùng**

```sh
BUILD_ARGS=()
SECRETS=()
SECRETS+=(--secret "id=age_passphrases,env=AGE_PASSPHRASES")
BUILD_ARGS+=(--build-arg IDENTITIES="personal")
dybatpho::dry_run docker build "${BUILD_ARGS[@]}" "${SECRETS[@]}" .

# Có thể rỗng, và script vẫn chạy trên Bash 4.3
local -a extra=()
docker run ${extra[@]+"${extra[@]}"} "${image}"
```

**Không nên dùng**

```sh
# Hỏng ngay khi một giá trị chứa dấu cách, và dấu nháy không cứu được
BUILD_ARGS="--build-arg IDENTITIES=personal"
docker build $BUILD_ARGS .

# `unbound variable` trên Bash 4.3 dưới `set -u` khi không có tùy chọn nào được thêm
local -a extra=()
docker run "${extra[@]}" "${image}"
```

Một mảng có thể thưa: sau `unset 'names[1]'` các chỉ số là `0` và `2`, còn `${#names[@]}` là `2`. Khi đó một vòng lặp đếm sẽ đọc chỉ số bị thiếu — rỗng, hoặc `unbound variable` khi có `set -u` — và không bao giờ tới được phần tử cuối.

**Nên dùng**

```sh
local index
for index in "${!names[@]}"; do
  printf '%s=%s\n' "${index}" "${names[index]}"
done
```

**Không nên dùng**

```sh
# Bỏ sót phần tử cuối của mảng thưa, và dừng ở chỗ trống khi có set -u
for ((index = 0; index < ${#names[@]}; index++)); do
  printf '%s\n' "${names[index]}"
done
```

Một phép gán trơn vào tên mảng sẽ ghi vào phần tử 0. Sau `files=(a b c)` và `files=x`, mảng trở thành `(x b c)`: đoạn mã định bắt đầu lại từ đầu vẫn thấy các phần tử cũ, và `files+=x` nối thêm vào chuỗi đầu tiên thay vì thêm một phần tử.

**Nên dùng**

```sh
files=("${only_file}")
files+=("${another_file}")
files=()
```

**Không nên dùng**

```sh
# Giữ nguyên files[1] và files[2]
files="${only_file}"
# Nối thêm vào chuỗi của files[0]
files+="${another_file}"
```

### Mảng kết hợp

> [!TIP]
>
> - ✔️ NÊN: Khai báo map một cách tường minh, `local -A name=()` hoặc `declare -A NAME=()`: không có `-A`, các khóa bị tính như biểu thức số học <kbd>BSG103</kbd>
> - ✔️ NÊN: Đặt trong nháy một khóa đến từ biến: `"${map["${key}"]}"`
> - ✔️ NÊN: Kiểm tra khóa có tồn tại hay không bằng `[[ -v map["${key}"] ]]`, cách này phân biệt được khóa không có với giá trị rỗng
> - ✔️ NÊN: Sắp xếp các khóa trước khi dùng thứ tự của chúng: `"${!map[@]}"` không theo thứ tự nào cả
> - ❌ TRÁNH: Không dựa vào thứ tự của `"${!map[@]}"`, và không dùng `[[ -n "${map[key]}" ]]` để kiểm tra sự tồn tại

Không có `-A`, `versions[jq]=1` gán vào một mảng chỉ số: `jq` được đọc như một biến số học, có giá trị `0`, nên mọi khóa đều rơi vào chỉ số `0` và ghi đè khóa trước. Các khóa của một map đi ra theo thứ tự băm, thay đổi theo chính các khóa và giữa các phiên bản Bash, nên output dựng từ nó không tái lập được cho tới khi được sắp xếp.

**Nên dùng**

```sh
local -A versions=()
versions["jq"]="1.7.1"
versions["yq"]="4.44.3"

# Có mặt, kể cả khi giá trị rỗng
if [[ -v versions["${tool}"] ]]; then
  printf '%s\n' "${versions["${tool}"]}"
fi

# Một thứ tự ổn định
local -a tools=()
mapfile -t tools < <(printf '%s\n' "${!versions[@]}" | LC_ALL=C sort)
```

**Không nên dùng**

```sh
# Không có `declare -A`: dòng này đặt chỉ số 0 của một mảng chỉ số
versions[jq]="1.7.1"

# Rỗng và không có trông như nhau, và thứ tự vòng lặp đổi giữa các lần chạy
[[ -n "${versions[${tool}]}" ]] && install "${tool}"
for tool in "${!versions[@]}"; do
  printf '%s\n' "${tool}"
done
```

### Đường ống vào while

> [!TIP]
>
> - ✔️ NÊN: Cấp dữ liệu cho vòng lặp `while read` bằng thay thế tiến trình: `while read -r line; do ...; done < <(command)`
> - ✔️ NÊN: Dùng `readarray -t` hoặc `mapfile -t` khi cần lấy toàn bộ kết quả thành một mảng
> - ✔️ NÊN: Dùng `read -r`, và dùng `mapfile -d ''` cùng `-print0` khi giá trị có thể chứa ký tự xuống dòng
> - ✔️ NÊN: Đọc mọi dòng, kể cả dòng cuối không có ký tự xuống dòng: `while IFS= read -r line || [[ -n "${line}" ]]` <kbd>BSG094</kbd>
> - ❌ TRÁNH: Không đưa đường ống vào vòng lặp `while` <kbd>BSG041</kbd>
> - ❌ TRÁNH: Không chỉ dựa vào `while read -r line` với đầu vào có thể không kết thúc bằng ký tự xuống dòng

Vế phải của đường ống chạy trong một shell con, nên mọi biến mà vòng lặp gán đều bị vứt đi khi vòng lặp kết thúc. Thay thế tiến trình giữ vòng lặp ở lại trong shell hiện tại.

**Nên dùng**

```sh
local -a files=()
mapfile -d '' -t files < <(command find "${root}" -type f -print0 | sort -z)

local -a tools=()
readarray -t tools < <(dytoy::get_yaml "${name}" "tools")

local count=0 path
while IFS= read -r -d '' path; do
  count=$((count + 1))
done < <(command find "${root}" -type f -print0)
printf '%s\n' "${count}"
```

**Không nên dùng**

```sh
# count ở đây luôn bằng 0: vòng lặp đã chạy trong một shell con
local count=0
command find "${root}" -type f | while read -r line; do
  count=$((count + 1))
done
printf '%s\n' "${count}"
```

`read` trả về khác không khi gặp cuối đầu vào trước ký tự xuống dòng, dù nó đã gán giá trị cho biến. Một tệp có dòng cuối không có ký tự xuống dòng — thường gặp ở tệp cấu hình sửa tay và output của `printf '%s'` — sẽ mất dòng đó. `IFS=` còn giữ lại khoảng trắng ở đầu và cuối dòng.

**Nên dùng**

```sh
local line
while IFS= read -r line || [[ -n "${line}" ]]; do
  process "${line}"
done < "${file}"
```

**Không nên dùng**

```sh
# Dòng cuối bị mất khi tệp không kết thúc bằng ký tự xuống dòng
while read -r line; do
  process "${line}"
done < "${file}"
```

### Thay thế tiến trình

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Lưu output của một producer có thể thất bại vào một biến trước, kiểm tra mã thoát của nó, rồi mới đọc biến đó: `listing="$(cmd)" || return $?` <kbd>BSG048</kbd>
> - ✔️ NÊN: Kiểm tra những gì truyền cho producer trước khi đọc nó qua `< <(...)`, khi chỉ có đầu vào sai mới làm nó thất bại
> - ✔️ NÊN: Bật `pipefail` khi vế trái của một pipe có thể thất bại và kết quả phụ thuộc vào nó
> - ❌ TRÁNH: Không đọc `< <(cmd)` hay `<(cmd)` từ một lệnh mà khi nó thất bại thì công việc phải dừng

Không có gì chờ lệnh bên trong `<(...)`: `mapfile`, `while read` và hàm bao quanh chúng đều thành công dù lệnh đó thất bại hay không, nên một producer thất bại được đọc như đầu vào rỗng. Khi đó một archive hỏng không liệt kê entry nào và qua được bước kiểm tra an toàn, còn hai tài liệu không parse được thì so ra giống hệt nhau. Vế trái của một pipe cũng mất mã thoát theo cách đó khi không bật `pipefail`. [Đường ống vào while](#%C4%91%C6%B0%E1%BB%9Dng-%E1%BB%91ng-v%C3%A0o-while) nói về việc giữ biến; mục này nói về việc giữ lỗi.

**Nên dùng**

```sh
local listing
listing="$(tar -tzf "${archive}")" || dybatpho::die "Cannot list ${archive}"
local -a entries=()
[[ -z "${listing}" ]] || mapfile -t entries <<< "${listing}"
```

**Không nên dùng**

```sh
# Một archive hỏng không liệt kê gì, và vòng lặp không thấy gì nguy hiểm
local -a entries=()
mapfile -t entries < <(tar -tzf "${archive}")
```

### File descriptor

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Để Bash tự chọn descriptor bằng `exec {fd}> "${file}"`, thay vì một số cố định như `exec 3>` <kbd>BSG152</kbd>
> - ✔️ NÊN: Đóng một descriptor ngay khi xong việc với nó, `exec {fd}>&-`: cho tới lúc đó mọi lệnh mà script khởi chạy đều kế thừa nó
> - ✔️ NÊN: Ghi qua descriptor bằng một biến có quote: `printf '%s\n' "${line}" >&"${fd}"`
> - ⚠️ CÂN NHẮC: Chuyển hướng cả vòng lặp một lần, `done >> "${out}"`, thay vì ghi nối vào cùng một tệp ở mỗi lần lặp <kbd>BSG153</kbd>
> - ✔️ NÊN: Gom các lệnh cùng ghi một tệp vào `{ ...; } > "${file}"`, để tệp được mở, và bị cắt rỗng, chỉ một lần

Một số cố định là một cái tên dùng chung với mọi thứ khác trong tiến trình. Một thư viện giữ log của nó trên descriptor 3 sẽ mất nó, không một lời báo, ngay khi script chạy `exec 3> "${file}"`, và từ đó các dòng của thư viện đi vào tệp của script. `exec {fd}> "${file}"` (Bash 4.1) lấy một số còn trống từ 10 trở lên và lưu nó vào `fd`. Một số cố định trên một lệnh, như phép hoán đổi `3>&1 1>&2 2>&3`, chỉ tồn tại trong lệnh đó và không sao.

Một descriptor mở bằng `exec` vẫn mở cho tới khi được đóng, kể cả khi hàm đã trả về, và một job nền hay một daemon khởi chạy trong lúc đó giữ một bản sao của nó: một tệp log vẫn bị giữ mở sau khi đã bị xoay vòng đi, một pipe mà bên đọc không bao giờ thấy điểm kết thúc.

**Nên dùng**

```sh
local log_fd
exec {log_fd}>> "${LOG_FILE}"
printf 'sync started for %s\n' "${name}" >&"${log_fd}"
sync::all >&"${log_fd}" 2>&1
exec {log_fd}>&-
```

**Không nên dùng**

```sh
# Đóng thứ mà một thư viện đã source đang giữ trên 3, và vẫn mở sau khi xong việc
exec 3>> "${LOG_FILE}"
printf 'sync started for %s\n' "${name}" >&3
sync::all >&3 2>&1
```

Một `>>` bên trong vòng lặp mở tệp, ghi một dòng rồi đóng lại ở mỗi lần lặp: với một danh sách mười nghìn host là mười nghìn lần mở cùng một tệp. Chuyển hướng cả vòng lặp, hoặc một nhóm `{ }` bao quanh các dòng ghi, chỉ mở nó một lần; nó cũng có nghĩa là `>` chỉ cắt rỗng tệp một lần, lúc bắt đầu, chứ không phải trước mỗi dòng.

**Nên dùng**

```sh
local host
for host in "${hosts[@]}"; do
  printf '%s\t%s\n' "${host}" "$(inventory::role "${host}")"
done >> "${report}"

{
  printf '# Generated %s\n' "${stamp}"
  printf '%s\n' "${hosts[@]}"
} > "${inventory}"
```

**Không nên dùng**

```sh
local host
for host in "${hosts[@]}"; do
  printf '%s\t%s\n' "${host}" "$(inventory::role "${host}")" >> "${report}"
done
```

### Vòng lặp for

> [!TIP]
>
> - ✔️ NÊN: Duyệt mảng bằng `for item in "${items[@]}"`
> - ✔️ NÊN: Đọc kết quả của lệnh vào một mảng trước, rồi mới lặp trên mảng đó
> - ✔️ NÊN: Đếm bằng brace expansion, `for i in {1..5}`, khi cả hai cận là hằng, và bằng `for ((i = start; i <= end; i++))` khi có một cận là biến
> - ❌ TRÁNH: Không viết `for item in $(command)` khi kết quả có thể chứa dấu cách <kbd>BSG042</kbd>
> - ❌ TRÁNH: Không tạo dãy số bằng `seq` <kbd>BSG124</kbd>

`for item in $(command)` tách theo từng dấu cách, dấu tab và ký tự xuống dòng, rồi còn khai triển ký tự đại diện trên kết quả. Nó chỉ đúng với dữ liệu mà bạn kiểm soát hoàn toàn.

**Nên dùng**

```sh
local -a dependencies=()
readarray -t dependencies < <(dytoy::get_yaml "${name}" "dependencies")
local dependency
for dependency in "${dependencies[@]}"; do
  dybatpho::dry_run dytoy "${method}" -i -t "${dependency}"
done
```

**Không nên dùng**

```sh
# Một tên phụ thuộc có dấu cách sẽ biến thành hai vòng lặp
for dependency in $(dytoy::get_yaml "$name" "dependencies"); do
  dytoy "${method}" -i -t "$dependency"
done
```

`seq` là lệnh bên ngoài, nên mỗi vòng lặp dùng nó đều tạo một tiến trình, và kết quả của nó còn đi qua bước tách từ của `$(...)`. Brace expansion tạo một khoảng cố định ngay trong shell, nhưng nó chạy trước khi biến được khai triển, nên `{1..${count}}` vẫn chỉ là một từ nguyên văn; vòng `for` số học thì nhận được biến.

**Nên dùng**

```sh
local attempt
for attempt in {1..3}; do
  printf 'Attempt %d\n' "${attempt}"
done

local -i index
for ((index = 1; index <= count; index++)); do
  printf 'Worker %d\n' "${index}"
done
```

**Không nên dùng**

```sh
# Một tiến trình để tạo dãy số, và tách từ trên kết quả của nó
for index in $(seq 1 "${count}"); do
  printf 'Worker %d\n' "${index}"
done

# Không phải một khoảng: brace expansion chạy trước khi ${count} được khai triển
for index in {1..${count}}; do
  printf 'Worker %d\n' "${index}"
done
```

### Biến cục bộ

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Khai báo `local` cho mọi biến mà hàm gán: biến lặp, đích của `read`, `mapfile`, `readarray` và `printf -v`, và các phép gán thường <kbd>BSG016</kbd>
> - ✔️ NÊN: Ghi chú một biến toàn cục có chủ đích bằng `@set` trong chú thích hàm, và đặt tên nó bằng `CHỮ HOA`
> - ❌ TRÁNH: Không để biến lặp hay đích của `read` lọt ra ngoài hàm

Một biến mà hàm gán mà không khai báo là biến toàn cục. Nó sống lâu hơn hàm, và ghi đè biến cùng tên ở mọi bên gọi: một helper lặp bằng `for i` sẽ âm thầm làm xê dịch chính vòng lặp `i` của bên gọi. [Tên biến](#t%C3%AAn-bi%E1%BA%BFn) yêu cầu dùng `local`; đây là những phép gán dễ quên nhất.

**Nên dùng**

```sh
function fs::count_lines {
  local file total=0 line
  for file in "$@"; do
    while IFS= read -r line || [[ -n "${line}" ]]; do
      total=$((total + 1))
    done < "${file}"
  done
  local summary
  printf -v summary '%d lines' "${total}"
  printf '%s\n' "${summary}"
}
```

**Không nên dùng**

```sh
function fs::count_lines {
  local total=0
  # `file`, `line` và `summary` giờ là biến toàn cục, và ghi đè biến của bên gọi
  for file in "$@"; do
    while IFS= read -r line || [[ -n "${line}" ]]; do
      total=$((total + 1))
    done < "${file}"
  done
  printf -v summary '%d lines' "${total}"
  printf '%s\n' "${summary}"
}
```

### Trả về giá trị

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Chỉ dùng mã trạng thái của hàm để báo thành công hay thất bại, và ghi chú từng mã bằng `@exitcode`
> - ✔️ NÊN: In dữ liệu mà hàm trả về ra STDOUT, để bên gọi bắt lấy bằng `$(...)`
> - ✔️ NÊN: Ghi vào một biến do bên gọi đặt tên, bằng `local -n`, khi dữ liệu là một mảng hoặc lời gọi nằm trong một vòng lặp nóng, và kiểm tra tên đó bằng `dybatpho::expect_ref`. (dybatpho)
> - ❌ TRÁNH: Không trộn thông điệp log vào STDOUT: chúng sẽ lẫn vào giá trị của bên gọi. Hãy gửi chúng ra STDERR
> - ❌ TRÁNH: Không trả dữ liệu qua mã trạng thái: `return` nhận một số từ 0 đến 255, không bao giờ là một từ hay `$(...)`. (tùy chỉnh) <kbd>BSG148</kbd>

Một hàm có hai cách để trả thứ gì đó về. Mã trạng thái là một số từ 0 đến 255 cho biết nó có chạy được hay không, và là thứ mà `if`, `||` và `set -e` đọc. STDOUT của nó là dữ liệu. Dữ liệu bị nhét vào mã trạng thái sẽ bị lấy modulo 256, nên một số đếm bằng 256 được đọc thành thành công mà không tìm thấy gì, còn `return true` dừng hàm với lỗi "numeric argument required". Một thông điệp in ra STDOUT thì sai theo chiều ngược lại: nó thành một phần của giá trị mà bên gọi bắt được, xem [STDOUT và STDERR](#stdout-v%C3%A0-stderr).

**Nên dùng**

```sh
function fs::count_lines {
  local file count
  dybatpho::expect_args file -- "$@"
  [[ -f "${file}" ]] || return 1
  dybatpho::info "Counting ${file}"
  count="$(wc -l < "${file}")"
  printf '%s\n' "${count// /}"
}

local lines
lines="$(fs::count_lines "${log_file}")" || dybatpho::die "No ${log_file}"
```

**Không nên dùng**

```sh
function fs::count_lines {
  echo "Counting ${1}"
  return $(wc -l < "$1")
}

fs::count_lines "${log_file}"
lines=$?
```

Bắt STDOUT sẽ chạy hàm trong một subshell, tốn một tiến trình mỗi lần gọi, không điền được mảng, và không thay đổi được gì khác cho bên gọi. Khi điều đó quan trọng, hãy nhận tên biến của bên gọi và ghi vào nó qua một nameref. `dybatpho::expect_ref` dừng script khi tên không phải một định danh hoặc là một tên riêng của thư viện, còn tiền tố `__<namespace>_<function>_` giữ cho các biến cục bộ khác của hàm không bắt nhầm tên đó, xem [Tên biến cục bộ trong hàm nameref và hàm callback](#t%C3%AAn-bi%E1%BA%BFn-c%E1%BB%A5c-b%E1%BB%99-trong-h%C3%A0m-nameref-v%C3%A0-h%C3%A0m-callback). Các helper `*_into` của dybatpho, như `dybatpho::math_add_into total "${total}" "${price}"`, theo đúng khuôn này. (dybatpho)

**Nên dùng**

```sh
function fs::read_lines_into {
  local __fs_read_lines_into_var __fs_read_lines_into_file
  dybatpho::expect_args __fs_read_lines_into_var __fs_read_lines_into_file -- "$@"
  dybatpho::expect_ref "${__fs_read_lines_into_var}"
  local -n __fs_read_lines_into_ref="${__fs_read_lines_into_var}"
  mapfile -t __fs_read_lines_into_ref < "${__fs_read_lines_into_file}"
}

local -a hosts
fs::read_lines_into hosts "${hosts_file}"
```

### Số học

> [!TIP]
>
> - ✔️ NÊN: Dùng `(( ... ))` cho điều kiện số học và `$(( ... ))` cho giá trị số học
> - ✔️ NÊN: Bỏ dấu `$` trước tên biến bên trong `(( ... ))`
> - ✔️ NÊN: Khai báo biến đếm bằng `local -i` khi biến đó chỉ chứa số nguyên
> - ✔️ NÊN: Kiểm tra một số lấy từ đầu vào bằng biểu thức chính quy, và ép cơ số 10 trong phép tính: `$((10#${count}))` <kbd>BSG129</kbd>
> - ✔️ NÊN: Kiểm tra một số thập phân bằng `dybatpho::math_is_number`, và một số nguyên bằng `dybatpho::is int`. (dybatpho)
> - ✔️ NÊN: Tăng giá trị bằng `((count += 1))` hoặc `count=$((count + 1))`
> - ✔️ NÊN: Tính toán với số thập phân trong `awk`, truyền giá trị qua `-v`: phép tính của Bash chỉ dùng số nguyên
> - ✔️ NÊN: Tính và so sánh số thập phân bằng `dybatpho::math_add`, `dybatpho::math_compare`, `dybatpho::math_gt` và các helper `math_*` khác, các hàm giữ đủ mọi chữ số thập phân. (dybatpho)
> - ❌ TRÁNH: Không dùng `let`, `expr` hay cú pháp `$[ ... ]` đã lỗi thời
> - ❌ TRÁNH: Không đưa thẳng một số đọc từ đầu vào, tên tệp hay ngày tháng vào `(( ))`: số 0 ở đầu biến nó thành hệ bát phân <kbd>BSG087</kbd>
> - ❌ TRÁNH: Không viết `((count++))` hay `((count--))` như một câu lệnh khi có `set -e` <kbd>BSG088</kbd>
> - ⚠️ CÂN NHẮC: Cẩn thận với `(( ... ))` đứng một mình dưới `set -e`: biểu thức có giá trị `0` sẽ trả về mã thoát `1` và làm dừng script
> - ❌ TRÁNH: Không so sánh số thập phân bằng `[[ < ]]` hay đưa chúng vào `(( ))`: cách đầu so sánh chuỗi, cách sau từ chối dấu chấm

`(( ... ))` là lệnh dựng sẵn, nên nhanh hơn `expr` và không cần tạo tiến trình con, đồng thời coi các toán hạng là số chứ không phải chuỗi.

**Nên dùng**

```sh
if ((${#MAIN_ARGS[@]} > 0)); then
  exec "${BATS_CMD}" "${MAIN_ARGS[@]}"
fi

local -i retries=0
retries=$((retries + 1))

# Không bao giờ bằng 0 sau khi tăng, nên dòng này không thất bại dưới set -e
((count += 1))
```

**Không nên dùng**

```sh
# Tạo tiến trình ngoài cho việc mà shell tự làm được
retries=$(expr "$retries" + 1)

# Cú pháp đã lỗi thời
retries=$[retries + 1]

# Dưới set -e, dòng này dừng script ngay lần count đi từ 0 lên 1
((count++))
```

Bash đọc `010` thành tám, và từ chối thẳng `08`, `09` với lỗi `value too great for base`. Số có số 0 ở đầu xuất hiện khắp nơi trong đầu vào — ngày, giờ, bộ đếm có đệm số 0, hậu tố tên tệp — nên phép tính trên chúng chạy được khi thử nghiệm và hỏng vào ngày mùng tám.

**Nên dùng**

```sh
[[ "${minute}" =~ ^[0-9]+$ ]] || dybatpho::die "Not a minute: ${minute}"
if ((10#${minute} >= 30)); then
  half=second
fi
```

**Không nên dùng**

```sh
minute="$(date +%M)"
# Lúc tám phút: `08: value too great for base`
if ((minute >= 30)); then
  half=second
fi
```

`(( ))` trả về trạng thái theo giá trị của nó, và `count++` cho ra giá trị *trước* khi tăng. Khi giá trị đó là `0`, câu lệnh trả về 1 và `set -e` kết thúc script — ngay ở vòng đầu tiên của một vòng lặp đếm từ không.

**Nên dùng**

```sh
local count=0
((count += 1))
count=$((count + 1))
```

**Không nên dùng**

```sh
local count=0
# Cho ra 0, trả về 1, và set -e kết thúc script tại đây
((count++))
```

`$((10 / 3))` bằng `3`, và `((1.5 > 1))` dừng lại với lỗi cú pháp. Một chỉ số tải, một tỉ lệ phần trăm hay một khoảng thời gian có phần thập phân thuộc về `awk`, công cụ cũng trả lời một phép so sánh bằng mã thoát của nó.

**Nên dùng**

```sh
ratio="$(awk -v used="${used}" -v total="${total}" 'BEGIN { printf "%.2f", used / total }')"
if awk -v value="${load}" 'BEGIN { exit !(value > 1.5) }'; then
  dybatpho::warn "Load is ${load}"
fi
```

**Không nên dùng**

```sh
# So sánh chuỗi: "10.0" < "9.5"
[[ "${load}" > "1.5" ]]
# syntax error: invalid arithmetic operator
((load > 1.5))
```

`awk` tính bằng số thực nhị phân, nơi `0.1 + 0.2` không bằng `0.3`. Các helper `math_*` làm việc trên chữ số thập phân, nên chúng cho ra `0.3`, xếp `1.10` nhỏ hơn `1.9`, và dừng script khi gặp một giá trị không phải số. (dybatpho)

**Nên dùng**

```sh
local total
total="$(dybatpho::math_add "${price}" "${shipping}")" || return 1
if dybatpho::math_gt "${load}" 1.5; then
  dybatpho::warn "Load is ${load}"
fi
```

`dybatpho::is int` chấp nhận một số nguyên có thể có dấu mà không có số 0 ở đầu, thứ mà phép tính sẽ đọc thành hệ bát phân, còn `dybatpho::math_is_number` chấp nhận một số thập phân thông thường như `-12.5`; cả hai đều không nhận khoảng trắng, hệ thập lục phân hay dấu phân cách hàng nghìn. (dybatpho)

**Nên dùng**

```sh
dybatpho::is int "${count}" || dybatpho::die "Not an integer: ${count}"
dybatpho::math_is_number "${ratio}" || dybatpho::die "Not a number: ${ratio}"
```

### Ngày giờ và khoảng thời gian

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Đo thời gian một bước chạy bằng `SECONDS`, hoặc bằng `EPOCHREALTIME` (Bash 5.0) khi đơn vị giây quá thô
> - ⚠️ CÂN NHẮC: Đọc đồng hồ bằng `SECONDS` hoặc `printf '%(%s)T' -1`, không fork `date +%s` <kbd>BSG150</kbd>
> - ✔️ NÊN: Ghi một dấu thời gian đi ra khỏi script theo UTC và ISO 8601: `TZ=UTC printf -v stamp '%(%Y-%m-%dT%H:%M:%SZ)T' -1`
> - ✔️ NÊN: Đo thời gian một bước bằng `dybatpho::timer_start` và `dybatpho::timer_end`, hai hàm ghi log thời gian nó đã chạy, và hiển thị một số giây dưới dạng `H:MM:SS` bằng `dybatpho::date_seconds_to_hms`. (dybatpho)
> - ❌ TRÁNH: Không phân tích ngày chỉ bằng `date -j -f` của BSD: nó thất bại trên Linux y như `date -d` thất bại trên macOS, nên hãy đi qua `dybatpho::date_parse` hoặc giữ cả hai nhánh, như [Tính di động](#t%C3%ADnh-di-%C4%91%E1%BB%99ng) chỉ ra

Bash tự giữ đồng hồ. `SECONDS` đếm số giây từ khi script bắt đầu, `printf '%(%s)T' -1` (Bash 4.2) đọc epoch, còn `EPOCHSECONDS` và `EPOCHREALTIME` (Bash 5.0) chứa epoch tính bằng giây và bằng micro giây. Mỗi lần `$(date +%s)` fork một tiến trình để đọc đúng con số đó, và trong một vòng lặp nó tốn hơn cả công việc nó đo. `dybatpho::date_now` không giúp được ở đây: hàm này cũng chạy `date`.

`EPOCHREALTIME` được viết với dấu thập phân của locale, `1700000000,123456` dưới locale tiếng Đức, nên hãy bỏ dấu phân cách đi thay vì tách theo dấu chấm. Một dấu thời gian đi ra khỏi script, trong một dòng log, một tên tệp hay một báo cáo, sẽ được đọc trên những máy ở múi giờ khác: UTC với chữ `Z` cho biết đó là thời điểm nào, và ISO 8601 sắp xếp theo kiểu chuỗi cũng đúng thứ tự thời gian.

**Nên dùng**

```sh
# Một khoảng thời gian: SECONDS tự đếm, không fork gì cả
local started="${SECONDS}"
backup::run
dybatpho::info "Backup took $((SECONDS - started))s"

# Epoch, và một dấu thời gian UTC cho dòng log hay tên tệp
local now stamp
printf -v now '%(%s)T' -1
TZ=UTC printf -v stamp '%(%Y-%m-%dT%H:%M:%SZ)T' -1

# Micro giây (Bash 5.0): bỏ dấu phân cách, dù locale dùng dấu nào
local start_us="${EPOCHREALTIME//[!0-9]/}"
cache::warm
dybatpho::debug "Warm-up took $(((${EPOCHREALTIME//[!0-9]/} - start_us) / 1000))ms"
```

**Không nên dùng**

```sh
# Hai tiến trình để biết một con số Bash đã có sẵn
local started
started="$(date +%s)"
backup::run
dybatpho::info "Backup took $(($(date +%s) - started))s"

# Giờ địa phương không kèm múi giờ: đó là mấy giờ?
stamp="$(date '+%Y-%m-%d %H:%M')"
```

`dybatpho::timer_start <name>` và `dybatpho::timer_end <name> [level]` ghi log khoảng thời gian giữa hai lời gọi, tính bằng mili giây, với tên và thời lượng là các trường riêng trong log có cấu trúc, và để lại con số đó trong `DYBATPHO_TIMER_LAST_MS`. `dybatpho::date_seconds_to_hms` in một khoảng thời gian dưới dạng `H:MM:SS` mà không quay vòng sau một ngày. (dybatpho)

**Nên dùng**

```sh
dybatpho::timer_start migration
./migrate.sh
dybatpho::timer_end migration

local started="${SECONDS}"
sync::all
dybatpho::info "Sync took $(dybatpho::date_seconds_to_hms "$((SECONDS - started))")"
```

### Tính di động

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dò tính năng trước khi dùng một cờ chỉ GNU có, và giữ một nhánh di động: `date -d`, `sed -i`, `readlink -f`, `stat -c`, `find -printf`, `grep -P`, `xargs -r`, `mktemp --suffix` <kbd>BSG083</kbd>
> - ✔️ NÊN: Phát hiện tính năng bằng cách thử chính cờ đó, không dựa vào tên công cụ hay `--version` của nó
> - ✔️ NÊN: Đọc thời điểm sửa đổi và kích thước của tệp bằng `dybatpho::file_mtime` và `dybatpho::file_size`, và sửa tệp tại chỗ bằng `dybatpho::file_replace`. (dybatpho)
> - ✔️ NÊN: Phân tích và định dạng ngày tháng bằng `dybatpho::date_parse` và `dybatpho::date_format`. (dybatpho)
> - ❌ TRÁNH: Không mặc định có GNU coreutils khi script chạy trên macOS, BSD hay BusyBox
> - ⚠️ CÂN NHẮC: Ưu tiên lệnh dựng sẵn của Bash hoặc dạng POSIX khi chúng làm được việc: `printf '%(%s)T'`, khai triển tham số

macOS dùng công cụ BSD, Alpine dùng BusyBox, và cùng một cờ lại mang nghĩa khác, hoặc không có nghĩa gì, trên mỗi nơi: `sed -i` đòi hậu tố sao lưu trên BSD, `stat -c` ở đó là `stat -f`, còn `date -d` thì không tồn tại. `date --version` thất bại không có nghĩa hệ thống là BSD — BusyBox cũng thất bại ở đó — nên hãy thử chính hành vi cần dùng, một lần, rồi giữ lại kết quả.

**Nên dùng**

<!-- lint: allow BSG083 -->
```sh
function __date_from_epoch {
  local epoch format
  dybatpho::expect_args epoch format -- "$@"
  if date -d @0 +%s &> /dev/null; then
    date -d "@${epoch}" "+${format}"
  else
    date -r "${epoch}" "+${format}"
  fi
}

# Sửa tại chỗ một cách di động: ghi ra bản sao, rồi chuyển đè lên tệp
local staging
staging="$(mktemp "$(dirname -- "${file}")/.staging.XXXXXXXX")"
sed 's/old/new/' "${file}" > "${staging}" && mv -- "${staging}" "${file}"
```

**Không nên dùng**

```sh
# Chỉ GNU có: hỏng trên macOS và BusyBox
date -d "@${epoch}" +%F
sed -i 's/old/new/' "${file}"
target="$(readlink -f "${link}")"
```

`dybatpho::file_mtime` và `dybatpho::file_size` thử `stat -c` của GNU rồi tới `stat -f` của BSD, nên chúng trả lời được trên Linux, macOS và BusyBox. `dybatpho::file_replace` chạy `sed` không có `-i`, ghi kết quả vào một tệp tạm cạnh tệp gốc, rồi chuyển nó vào đúng chỗ, giữ nguyên quyền của tệp. (dybatpho)

**Nên dùng**

```sh
local mtime
mtime="$(dybatpho::file_mtime "${file}")" || return 1
dybatpho::file_replace "${config}" '^debug = true$' 'debug = false'
```

`dybatpho::date_parse` và `dybatpho::date_format` hỏi `date` về đúng cờ mà chúng sắp dùng, `-D` cho BusyBox và `-d` cho GNU, rồi quay về `-j -f` và `-r` của BSD, nên cùng một lời gọi chạy được trên cả ba. (dybatpho)

**Nên dùng**

```sh
local day
day="$(dybatpho::date_format "${epoch}" '%F')" || return 1
```

### So sánh phiên bản

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: So sánh phiên bản bằng một helper semver: `dybatpho::semver_compare`, và `dybatpho::semver_sort` để sắp xếp một danh sách. (dybatpho)
> - ⚠️ CÂN NHẮC: Chỉ dùng `sort -V` cho các số có dấu chấm thuần túy như `1.10.2`, ở nơi có lệnh này
> - ❌ TRÁNH: Không so sánh phiên bản bằng `<` hay `>` trên chuỗi, hoặc bằng phép tính trên chuỗi có dấu chấm <kbd>BSG097</kbd>
> - ❌ TRÁNH: Không sắp xếp các phiên bản có thể mang hậu tố pre-release bằng `sort -V`: nó đặt `2.0.0-rc1` sau `2.0.0`

So sánh chuỗi đi theo từng ký tự, nên `1.10.0` xếp trước `1.9.0`, và `2.0.0-rc1` xếp sau `2.0.0`. Phép tính số học hoàn toàn không dùng được trên chuỗi có dấu chấm. Một bước kiểm tra phiên bản làm sai chuyện này sẽ nâng cấp một bản cài mới hơn, hoặc từ chối một bản đã đủ mới.

`sort -V` sửa được phần số nhưng không sửa được hậu tố: nó đọc `-rc1` như các ký tự nối thêm sau `2.0.0`, nên một bản release candidate lại trông mới hơn chính bản phát hành mà nó đi trước.

**Nên dùng**

```sh
if dybatpho::semver_satisfies "${installed}" ">=1.10.0"; then
  use_new_flag=true
fi

newest="$(dybatpho::semver_max "${a}" "${b}")"

# Khi không có thư viện: sắp xếp số theo từng trường, cho các phiên bản tối đa
# bốn số cách nhau bởi dấu chấm; sort -V cũng làm được, nhưng chỉ có ở bộ GNU
[[ "${a}" =~ ^[0-9]+(\.[0-9]+){0,3}$ && "${b}" =~ ^[0-9]+(\.[0-9]+){0,3}$ ]] \
  || dybatpho::die "Not a plain version: ${a} ${b}"
newest="$(printf '%s\n' "${a}" "${b}" | sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n | tail -n 1)"
```

**Không nên dùng**

```sh
# Theo chuỗi "1.10.0" < "1.9.0", nên bản mới hơn lại trông như cũ hơn
if [[ "${installed}" < "1.9.0" ]]; then
  upgrade
fi

# In ra 2.0.0-rc1: bản release candidate trông mới hơn bản phát hành
newest="$(printf '%s\n' 2.0.0-rc1 2.0.0 | sort -V | tail -n 1)"
```

`dybatpho::semver_compare` in ra `-1`, `0` hoặc `1`, so sánh từng trường số như một con số, và xếp một bản pre-release trước bản phát hành của nó. `dybatpho::semver_sort` sắp xếp một danh sách theo cùng quy tắc, chấp nhận tiền tố `v`, và dừng khi gặp một giá trị không phải phiên bản. (dybatpho)

**Nên dùng**

```sh
local newest
newest="$(dybatpho::semver_sort 2.0.0-rc.1 2.0.0 1.10.0 | tail -n 1)" || return 1
if [[ "$(dybatpho::semver_compare "${installed}" "${newest}")" == -1 ]]; then
  dybatpho::info "Upgrading to ${newest}"
fi
```

## Gọi lệnh

### Kiểm tra giá trị trả về

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Để `set -euo pipefail`, hoặc `dybatpho::register_common_handlers`, dừng script khi có lỗi không được xử lý. (dybatpho)
> - ✔️ NÊN: Kiểm tra trực tiếp trên lệnh: `if ! command; then ... fi`
> - ✔️ NÊN: Thêm `|| true` cho lệnh mà việc thất bại là điều thực sự được dự liệu, và ghi chú lý do
> - ✔️ NÊN: Kết thúc một hàm, hay một script, bằng một câu lệnh mà mã thoát chính là kết quả: viết `if cond; then action; fi` hoặc `cond || return 0`, không phải một `cond && action` trơn
> - ✔️ NÊN: Chỉ tắt tiếng đúng lệnh mà thất bại của nó là đã lường trước, không phải cả hàm hay vòng lặp bao quanh
> - ❌ TRÁNH: Không kiểm tra `$?` trong một câu lệnh riêng <kbd>BSG044</kbd>
> - ❌ TRÁNH: Không dựa vào `PIPESTATUS` <kbd>BSG044</kbd>
> - ❌ TRÁNH: Không kết thúc một hàm bằng `[[ ... ]] && action` hay `((flag)) && action`: khi điều kiện sai, hàm trả về 1 và `set -e` dừng bên gọi <kbd>BSG110</kbd>
> - ❌ TRÁNH: Không chuyển hướng cả một khối vào `/dev/null`, như `} 2> /dev/null` hay `done 2> /dev/null`: nó giấu mọi lỗi bên trong, không chỉ lỗi đã lường trước <kbd>BSG120</kbd>

Đọc `$?` ở dòng kế tiếp chỉ đúng nếu giữa hai dòng đó không có gì chạy, một điều kiện mà không ai giữ được khi script lớn dần. Kiểm tra ngay trên lệnh thì không bao giờ lạc hậu. `|| true` tường minh còn là một dấu hiệu: nó nói với người đọc sau rằng khả năng thất bại đã được cân nhắc, chứ không phải bị bỏ quên.

**Nên dùng**

```sh
if ! command -v sudo &> /dev/null; then
  dybatpho::die "sudo is required"
fi

# grep trả về 1 khi không khớp gì, ở đây đó là một kết quả hợp lệ
expected_hash=$(grep -E "[[:space:]]\*?${asset_name}\$" "${sha256_file}" | awk '{print $1}') || true

# Submodule có thể đã có sẵn, đừng vì thế mà làm hỏng cả lần chạy
git -C "${DYBATPHO_DIR}" submodule update --init --recursive 2> /dev/null || true
```

**Không nên dùng**

```sh
# Mong manh: chỉ cần chèn thêm một dòng vào giữa là phép kiểm tra sai
curl -fsSL "$url" -o "$file"
if [[ $? -ne 0 ]]; then
  echo "download failed"
fi
```

Mã thoát của một hàm là mã thoát của câu lệnh cuối cùng, và `set -e` chỉ bỏ qua vế trái của `&&`. Vì vậy một hàm kết thúc bằng `[[ -n "${verbose}" ]] && log "done"` sẽ trả về 1 mỗi khi `verbose` rỗng, và bên gọi dừng lại vì một hàm đã làm đủ mọi việc được yêu cầu. Dòng cuối của một script cũng vậy, nó trở thành mã thoát của cả script.

**Nên dùng**

```sh
function report::summary {
  local verbose
  dybatpho::expect_args verbose -- "$@"
  if dybatpho::is true "${verbose}"; then
    dybatpho::info "Summary written"
  fi
}

# Chỉ lệnh thăm dò có thể thất bại mới bị tắt tiếng
rmdir -- "${maybe_empty}" 2> /dev/null || true # vẫn còn dữ liệu: một job khác đang dùng nó
```

**Không nên dùng**

```sh
function report::summary {
  # Trả về 1 khi verbose là false, và set -e dừng bên gọi
  [[ "$1" == true ]] && dybatpho::info "Summary written"
}

# Mọi lỗi của mọi lệnh trong hàm đều biến mất
function sync::all {
  cp -- "${src}" "${dst}"
  rmdir -- "${maybe_empty}"
} 2> /dev/null
```

### Errexit trong điều kiện

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Bật `shopt -s inherit_errexit` cạnh `set -euo pipefail`, để một lỗi bên trong `$(...)` dừng lệnh thay thế. (tùy chỉnh) <kbd>BSG104</kbd>
> - ✔️ NÊN: Kết thúc mỗi bước bằng `|| return $?` trong một hàm có thể được gọi từ `if`, `while`, `!`, `&&` hay `||`
> - ❌ TRÁNH: Không dựa vào `set -e` bên trong một hàm mà bên gọi kiểm tra mã thoát của nó: errexit bị tắt cho mọi thứ hàm đó chạy
> - ❌ TRÁNH: Không mong `set -e` dừng tại một lệnh thất bại ở giữa `$(a; b)` khi không có `inherit_errexit`

`set -e` bị tạm ngưng cho toàn bộ lệnh được kiểm tra bởi `if`, `while`, `until`, `!`, `&&` hay `||`, và điều đó bao gồm mọi dòng của một hàm được gọi ở đó. Vì vậy một hàm dựa vào errexit sẽ dừng ở lỗi đầu tiên khi được gọi riêng, nhưng chạy tới cuối khi bên gọi viết `if fn`. Mã thoát của nó khi đó là mã thoát của dòng cuối, rất có thể là `0`. Bên trong `$(...)` errexit cũng bị tắt, cho tới khi `inherit_errexit` (Bash 4.4) truyền nó xuống.

dybatpho bật chế độ nghiêm ngặt khi được source; `inherit_errexit` vẫn do script tự đặt. (dybatpho)

**Nên dùng**

```sh
shopt -s inherit_errexit

# Mỗi bước trả về lỗi của chính nó, bất kể ai gọi hàm
function deploy::upload {
  local archive
  dybatpho::expect_args archive -- "$@"
  tar -czf "${archive}" -C "${BUILD_DIR}" . || return $?
  scp -o ConnectTimeout=10 -- "${archive}" "${HOST}:" || return $?
}

if ! deploy::upload "${archive}"; then
  dybatpho::die "Upload of ${archive} failed"
fi
```

**Không nên dùng**

```sh
function deploy::upload {
  tar -czf "$1" -C "${BUILD_DIR}" .
  # Tải lên một archive hỏng khi tar thất bại: errexit bị tắt bên trong một hàm được `if` gọi
  scp -o ConnectTimeout=10 -- "$1" "${HOST}:"
}

if ! deploy::upload "${archive}"; then
  dybatpho::die "Upload of ${archive} failed"
fi
```

### Xử lý lỗi

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Xử lý lỗi ngay trong hàm nơi nó xảy ra, không đẩy lên cho bên gọi
> - ✔️ NÊN: Dừng bằng `dybatpho::die` khi script không thể tiếp tục, và `return 1` khi bên gọi còn xử lý được. (dybatpho)
> - ✔️ NÊN: Nói rõ cái gì hỏng và người dùng có thể làm gì, trong một thông báo trên `STDERR`
> - ✔️ NÊN: Cài đặt các trình xử lý chung một lần, ở đầu script thực thi, bằng `dybatpho::register_common_handlers`. (dybatpho) <kbd>BSG053</kbd>
> - ✔️ NÊN: Ghi trong thông báo lỗi tên hàm mà bên gọi đã gọi: `FUNCNAME[1]` từ một helper được hàm đó gọi trực tiếp, một tên do hàm đó truyền vào, hoặc hàm public đầu tiên trên stack
> - ✔️ NÊN: Hiển thị một giá trị đến từ bên ngoài — tên tệp, đối số, một dòng input — bằng `${value@Q}` trong thông báo
> - ❌ TRÁNH: Không trả về mã khác `0` trần trụi mà không kèm thông báo
> - ❌ TRÁNH: Không lấy một cấp cố định sâu hơn như `FUNCNAME[2]`, vì nó trỏ sang hàm khác ngay khi độ sâu lời gọi thay đổi <kbd>BSG054</kbd>

Hàm bị lỗi là nơi duy nhất còn biết tên tệp, địa chỉ URL và tùy chọn nào đã dẫn tới lỗi đó. Bên gọi chỉ nhận được số `1` thì hoặc là không báo được gì hữu ích, hoặc là phải bịa ra bối cảnh.

Thông báo cũng phải ghi đúng lời gọi mà script đã thực hiện. `FUNCNAME[2]` chỉ đúng chừng nào helper nằm đúng hai cấp dưới hàm public; khi được gọi trực tiếp, hoặc qua thêm một lớp, nó lại ghi tên bên gọi của script hay một trình chạy test, và chỉ sai chỗ gây lỗi.

**Nên dùng**

```sh
if [[ ! -x "${BATS_CMD}" ]]; then
  dybatpho::die "Bats not found. Install bats, or run: git -C ${DYBATPHO_DIR} submodule update --init --recursive"
fi

function get_dir {
  local config_dir
  dybatpho::expect_args config_dir -- "$@"
  if [[ ! -e "${config_dir}" ]]; then
    dybatpho::error "Configuration directory ${config_dir} does not exist"
    return 1
  fi
  printf '%s\n' "${config_dir}"
}

# Bên gọi truyền tên của chính nó, nên thông báo ghi đúng tên ở mọi độ sâu
function __csv_require_text {
  local caller text
  dybatpho::expect_args caller text -- "$@"
  [[ "${text}" != *$'\x1f'* ]] || dybatpho::die "${caller}: The input contains the unit separator"
}

function csv::read {
  local input
  dybatpho::expect_args input -- "$@"
  __csv_require_text "${FUNCNAME[0]}" "${input}"
}
```

**Không nên dùng**

```sh
# Bên gọi không có cách nào biết chuyện gì đã sai
function get_dir {
  [[ -e "$1" ]] || return 1
  echo "$1"
}

# Ghi tên bên gọi của csv::read, không phải csv::read, khi csv::read gọi nó trực tiếp
function __csv_require_text {
  [[ "$1" != *$'\x1f'* ]] || dybatpho::die "${FUNCNAME[2]}: The input contains the unit separator"
}
```

Một tên tệp có thể chứa ký tự xuống dòng, tab hay một escape sequence của terminal. In ra nguyên trạng, nó tách một bản ghi log làm đôi, giả mạo một dòng trông như một thông báo khác, hoặc vẽ lại terminal. `${value@Q}` (Bash 4.4) đặt giá trị trong nháy theo cách shell sẽ đọc lại, nên mọi ký tự đều nhìn thấy được và không có gì bị diễn giải.

**Nên dùng**

```sh
dybatpho::die "File not found: ${path@Q}"
# File not found: $'report\n2026 INFO all checks passed'
```

**Không nên dùng**

```sh
# Một tên chứa ký tự xuống dòng in ra thêm một dòng log giả mạo
dybatpho::die "File not found: ${path}"
```

### Mã thoát

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Thoát với `0` khi thành công, `1` khi thất bại chung, và `2` khi dùng sai cách, như thiếu hoặc không rõ tùy chọn. (tùy chỉnh)
> - ✔️ NÊN: Ghi lại mọi mã thoát khác mà một hàm hay script trả về bằng `@exitcode`, và giữ ý nghĩa của nó ổn định
> - ✔️ NÊN: Thoát với `128 + n` sau một handler cho tín hiệu `n` kết thúc script: `130` cho `INT`, `143` cho `TERM`
> - ❌ TRÁNH: Không dùng `126`, `127` hay bất cứ số nào trên `128` cho ý nghĩa riêng: shell dùng chúng để báo "không thực thi được", "không tìm thấy" và tín hiệu <kbd>BSG105</kbd>
> - ❌ TRÁNH: Không thoát với mã nằm ngoài `0`–`255`: nó bị lấy modulo 256, nên `256` là thành công <kbd>BSG105</kbd>

Bên gọi chỉ xử lý được một mã thoát mà nó hiểu. `2` cho dùng sai cách là thứ các lệnh dựng sẵn của Bash và hầu hết các công cụ vẫn dùng, `126` và `127` là thứ shell đặt khi một lệnh không chạy được, và mọi số trên `128` được hiểu là "bị một tín hiệu kết liễu". Một mã riêng trùng với chúng đưa bên gọi vào nhánh sai, còn một mã không được ghi lại thì không thể xử lý được.

**Nên dùng**

```sh
#######################################
# @description Download a release asset
# @arg $1 string Name of the asset
# @exitcode 0 Downloaded
# @exitcode 1 The download failed
# @exitcode 2 Wrong usage: no asset name
# @exitcode 3 The asset is not published for this platform
#######################################
function release::fetch {
  (($# == 1)) || return 2
  ...
}

# Ctrl-C: mã thoát mà shell cha mong đợi
trap 'exit 130' INT
```

**Không nên dùng**

```sh
# Được hiểu là "command not found", là 44, và là 255
exit 127
exit 300
exit -1

# Một mã thoát không ai ghi lại, mượn từ một công cụ khác
curl --fail -sS "${url}" || return 22
```

### Lệnh dựng sẵn và lệnh bên ngoài

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Ưu tiên lệnh dựng sẵn hơn lệnh bên ngoài cho cùng một việc: khai triển tham số thay cho `sed`, `(( ... ))` thay cho `expr`, `[[ ... ]]` thay cho `test`
> - ✔️ NÊN: Dùng công cụ bên ngoài như `sed`, `awk` hay `yq` khi nó làm mã ngắn gọn và rõ ràng hơn hẳn
> - ✔️ NÊN: Gọi công cụ bên ngoài qua `command <tool>` khi có thể đang tồn tại một alias hay một hàm cùng tên. (tùy chỉnh)
> - ✔️ NÊN: Đọc cả một tệp bằng `$(< file)`, không phải `$(cat file)` <kbd>BSG108</kbd>
> - ✔️ NÊN: Kết thúc `find -exec` bằng `+`, cách này chạy lệnh một lần cho nhiều tệp, trừ khi lệnh chỉ nhận đúng một tệp <kbd>BSG119</kbd>
> - ✔️ NÊN: Tách một chuỗi thành các trường bằng `read`, `IFS=: read -r user _ uid _ <<< "${record}"`, đặt tên `_` cho mỗi trường bỏ đi <kbd>BSG126</kbd>
> - ✔️ NÊN: Đưa tệp cho lệnh bằng tên, `grep foo "${file}"`, hoặc bằng `< "${file}"`. `useless-use-of-cat` trong [`.shellcheckrc`](.shellcheckrc) kiểm tra điều này
> - ⚠️ CÂN NHẮC: Tách theo một delimiter nhiều ký tự, hoặc giữ một trường rỗng ở cuối, bằng `dybatpho::split` vào một mảng: `mapfile -t parts < <(dybatpho::split "${entry}" ' :: ')`. (dybatpho)
> - ⚠️ CÂN NHẮC: Tách theo một delimiter nhiều ký tự, hoặc giữ một trường rỗng ở cuối, bằng `dybatpho::split` vào một mảng: `mapfile -t parts < <(dybatpho::split "${entry}" ' :: ')`. (dybatpho)
> - ⚠️ CÂN NHẮC: Đưa một lệnh bên ngoài ra khỏi vòng lặp trên nhiều phần tử: một lệnh `sed` trên toàn bộ input thay vì một lệnh cho mỗi dòng
> - ❌ TRÁNH: Không viết khai triển tham số rắc rối tới mức người đọc phải chạy thử mới biết nó làm gì
> - ❌ TRÁNH: Không pipe một chuỗi vào `cut` hay `awk '{print $2}'` chỉ để lấy một trường của nó
> - ❌ TRÁNH: Không viết `cat file | command` cho một lệnh tự đọc được tệp hoặc standard input

Lệnh dựng sẵn không tạo tiến trình con nên nhanh hơn khi nằm trong vòng lặp, và hành xử như nhau trên mọi máy. Ngoại lệ là việc biến đổi văn bản trên nhiều dòng, nơi `sed` hay `awk` nói trong một dòng điều mà khai triển tham số cần cả một vòng lặp.

**Nên dùng**

```sh
# Khai triển dựng sẵn cho các phép cắt chuỗi đơn giản
local asset_name="${url##*/}"
local base_url="${url%/*}"

# Công cụ bên ngoài ở chỗ nó thực sự rõ ràng hơn
function misc::replace_version {
  local version
  dybatpho::expect_args version -- "$@"
  sed -e "s/%v/${version}/g" -e "s/%1v/${version:1}/g"
}

# Đúng tệp nhị phân, không phải alias của người dùng hay một hàm bọc
mapfile -d '' -t files < <(command find "${root}" -type f -print0)

# Không cần tiến trình nào để đọc một tệp
version="$(< "${version_file}")"
```

**Không nên dùng**

```sh
# Một tiến trình cho mỗi dòng để làm điều mà ${url##*/} đã làm
asset_name="$(echo "$url" | rev | cut -d/ -f1 | rev)"

# Không đọc nổi, mà cũng chỉ làm đúng việc của hai dòng sed
result="${input//${a}\/${b}/${c}${d//x/y}}"

# Một tiến trình cho mỗi dòng, cho việc mà một lệnh sed làm một lần
while IFS= read -r line; do
  printf '%s\n' "$(echo "${line}" | sed 's/old/new/')"
done < "${file}"
```

`-exec cmd {} \;` khởi động một tiến trình cho mỗi kết quả, và trên một cây thư mục hàng nghìn tệp, đó là phần lớn thời gian chạy. `-exec cmd {} +` truyền nhiều đường dẫn nhất có thể trên một dòng lệnh.

**Nên dùng**

```sh
command find "${root}" -name '*.log' -mtime +7 -exec gzip -- {} +
```

**Không nên dùng**

```sh
# Mỗi tệp một lần chạy gzip
command find "${root}" -name '*.log' -mtime +7 -exec gzip -- {} \;
```

`read` tách một chuỗi theo các ký tự của `IFS` và đặt mỗi trường vào một tên, nên một bản ghi được tách ngay trong shell, và mỗi trường có một tên để phần mã bên dưới đọc. `_` nhận một trường không cần dùng, còn tên cuối cùng nhận phần còn lại của dòng.

**Nên dùng**

```sh
local user uid home
IFS=: read -r user _ uid _ _ home _ <<< "${record}"
```

**Không nên dùng**

```sh
# Ba tiến trình, và mỗi trường được đọc trong một lượt riêng
user="$(echo "${record}" | cut -d: -f1)"
uid="$(echo "${record}" | cut -d: -f3)"
home="$(echo "${record}" | awk -F: '{print $6}')"
```

`IFS` là một tập các ký tự đơn, nên `IFS=' :: '` tách ở mọi dấu cách và mọi dấu hai chấm, và `read -a` bỏ mất một trường rỗng ở cuối: `a:b:` cho hai trường, không phải ba. `dybatpho::split` coi delimiter là một chuỗi nguyên văn, và giữ mọi trường, kể cả các trường rỗng. (dybatpho)

**Nên dùng**

```sh
local -a parts=()
mapfile -t parts < <(dybatpho::split "${entry}" ' :: ')
```

**Không nên dùng**

```sh
# Tách ở mọi dấu cách và mọi dấu hai chấm, không phải ở " :: "
IFS=' :: ' read -r -a parts <<< "${entry}"
```

`IFS` là một tập các ký tự đơn, nên `IFS=' :: '` tách ở mọi dấu cách và mọi dấu hai chấm, và `read -a` bỏ mất một trường rỗng ở cuối: `a:b:` cho hai trường, không phải ba. `dybatpho::split` coi delimiter là một chuỗi nguyên văn, và giữ mọi trường, kể cả các trường rỗng. (dybatpho)

**Nên dùng**

```sh
local -a parts=()
mapfile -t parts < <(dybatpho::split "${entry}" ' :: ')
```

**Không nên dùng**

```sh
# Tách ở mọi dấu cách và mọi dấu hai chấm, không phải ở " :: "
IFS=' :: ' read -r -a parts <<< "${entry}"
```

`cat` đặt trước một lệnh tự mở được tệp là thêm một tiến trình và một pipe, và còn giấu tên tệp khỏi thông báo lỗi của lệnh đó.

**Nên dùng**

```sh
grep -c -- "${pattern}" "${file}"
```

**Không nên dùng**

```sh
# Một tiến trình và một pipe vô ích, và grep không còn biết tên tệp
cat "${file}" | grep -c -- "${pattern}"
```

### Trình xử lý tín hiệu

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Ghép một handler với các handler đã cài sẵn (`dybatpho::trap`), thay vì thay thế chúng. (dybatpho)
> - ✔️ NÊN: Lưu handler của bên gọi trước một lời gọi có phạm vi, và khôi phục chúng sau đó
> - ✔️ NÊN: Chạy phần dọn dẹp của lời gọi có phạm vi trước handler của bên gọi có gọi `exit`, rồi phát lại tín hiệu, để handler đó và hành động mặc định vẫn diễn ra
> - ✔️ NÊN: Viết lệnh của trap trong nháy đơn, để biến của nó được khai triển khi trap chạy, không phải khi trap được cài
> - ✔️ NÊN: Để handler `EXIT` giữ nguyên mã thoát của script: đọc `$?` trước và kết thúc bằng `exit "${status}"`, hoặc kết thúc mà không có `exit`
> - ❌ TRÁNH: Không cài handler của thư viện bằng `trap '…' SIG` trơn, và không xóa handler bằng `trap - EXIT` <kbd>BSG055</kbd>
> - ❌ TRÁNH: Không kết thúc một handler `EXIT` bằng `exit 0` hay một mã thoát cố định: một script đã thất bại lại báo thành công <kbd>BSG111</kbd>

Một thư viện dùng chung bảng trap với script đã source nó. `trap '…' INT` trong thư viện âm thầm xóa phần xử lý Ctrl-C của chính script, còn `trap - EXIT` xóa phần dọn dẹp do người khác đăng ký. Thứ tự cũng quan trọng không kém: handler của bên gọi có gọi `exit` sẽ kết thúc shell trước khi handler nối sau nó kịp chạy, nên lock không bao giờ được giải phóng và các job con vẫn chạy. Vì vậy một lời gọi có phạm vi cài handler của riêng nó, đặt lại các handler đã lưu khi kết thúc, và phát lại tín hiệu nó đã bắt.

**Nên dùng**

<!-- lint: allow BSG040 -->
```sh
function lib::with_lock {
  local __lib_saved __lib_caught=""
  __lib_saved="$(trap -p INT TERM)"
  trap '__lib_caught=INT' INT
  trap '__lib_caught=TERM' TERM
  "$@" || true
  lib::release
  # Đặt lại những gì bên gọi đã có, rồi để handler của nó và hành động mặc định chạy
  trap - INT TERM
  eval "${__lib_saved}"
  [[ -z "${__lib_caught}" ]] || kill -s "${__lib_caught}" "${BASHPID}"
}
```

**Không nên dùng**

```sh
function lib::with_lock {
  # Thay handler của bên gọi cho đến hết script
  trap 'lib::release; exit 1' INT TERM
  "$@"
  lib::release
  trap - EXIT INT TERM
}
```

Lệnh của trap viết trong nháy kép được khai triển một lần, lúc `trap` chạy: `trap "rm -f ${temp_file}" EXIT` xóa tệp được đặt tên vào lúc đó, không phải tệp mà biến trỏ tới khi script kết thúc, và một đường dẫn chứa dấu nháy sẽ làm hỏng handler. Một handler `EXIT` cũng quyết định mã thoát khi nó gọi `exit`, nên `exit 0` ở đó biến mọi thất bại thành thành công trong mắt bên gọi.

**Nên dùng**

```sh
trap 'rm -f -- "${temp_file}"' EXIT

function _on_exit {
  local status=$?
  rm -rf -- "${work_dir:?}"
  exit "${status}"
}
trap _on_exit EXIT
```

**Không nên dùng**

```sh
# Khai triển ngay: những thay đổi sau đó của temp_file bị bỏ qua, và một dấu nháy trong nó làm hỏng handler
trap "rm -f ${temp_file}" EXIT

# Một lần chạy thất bại lại thoát với 0
trap 'rm -rf -- "${work_dir}"; exit 0' EXIT
```

### Tiến trình con

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Khởi chạy mỗi job nền trong process group riêng, và gửi tín hiệu tới cả group, để tiến trình cháu cũng dừng
> - ✔️ NÊN: Lặp lại tín hiệu tới khi group rỗng, trong một khoảng ân hạn có giới hạn, rồi gửi `KILL`
> - ✔️ NÊN: Kết thúc mọi job mà một hàm đã khởi chạy trước khi nó trả về, kể cả khi nó trả về vì một tín hiệu
> - ✔️ NÊN: Giữ pid của mọi job chạy nền, và đợi từng job, đếm số lần thất bại: `wait "${pid}" || failed=$((failed + 1))`
> - ✔️ NÊN: Khởi chạy job bằng `dybatpho::background_run`, đợi chúng bằng `dybatpho::wait_all`, và kết thúc chúng bằng `dybatpho::kill_children`, các hàm tuân theo mọi điều trên. (dybatpho)
> - ❌ TRÁNH: Không chỉ gửi tín hiệu tới pid của job, và không cho rằng một lần `TERM` là đủ
> - ❌ TRÁNH: Không `wait` lần lượt từng job dưới `set -e` mà không kiểm tra mã thoát: thất bại đầu tiên dừng script và các job còn lại bị bỏ mặc <kbd>BSG112</kbd>

Pid của một job thường là một subshell, còn việc thật chạy trong một tiến trình cháu mà tín hiệu gửi tới pid không bao giờ chạm tới. Ngay cả tín hiệu gửi tới cả group cũng có thể trượt một tiến trình đã fork mà chưa gọi `exec`: nó vẫn chạy các handler của shell cha, và một handler bắt `TERM` sẽ nuốt tín hiệu trước khi `exec` đặt lại nó. Gửi tín hiệu tới khi group rỗng, với `KILL` là bước cuối, là cách duy nhất để biết không còn gì sót lại.

**Nên dùng**

```sh
set -m
worker "${item}" &
local pgid=$!
set +m
...
local tries=0
while kill -0 -- "-${pgid}" 2> /dev/null; do
  tries=$((tries + 1))
  if ((tries <= 50)); then
    kill -TERM -- "-${pgid}" 2> /dev/null
  else
    kill -KILL -- "-${pgid}" 2> /dev/null
  fi
  sleep 0.1
done
```

**Không nên dùng**

```sh
worker "${item}" &
local pid=$!
...
# Các tiến trình con của worker vẫn chạy tiếp
kill "${pid}"
```

`wait "${pid}"` trả về mã thoát của job đó, nên dưới `set -e` một vòng lặp gồm các lời gọi `wait` trơn sẽ dừng ở job đầu tiên thất bại. Những job phía sau không bao giờ được đợi, thất bại của chúng không bao giờ được báo, và chúng tiếp tục chạy sau khi script đã kết thúc.

**Nên dùng**

<!-- lint: allow BSG155 -->
```sh
local -a pids=()
local host pid failed=0
for host in "${hosts[@]}"; do
  deploy::host "${host}" &
  pids+=("$!")
done
for pid in "${pids[@]}"; do
  wait "${pid}" || failed=$((failed + 1))
done
((failed == 0)) || dybatpho::die "${failed} of ${#pids[@]} deployments failed"
```

**Không nên dùng**

```sh
for host in "${hosts[@]}"; do
  deploy::host "${host}" &
done
# Dừng ở thất bại đầu tiên: các job còn lại không được đợi và cũng không được báo
for pid in $(jobs -p); do
  wait "${pid}"
done
```

`dybatpho::background_run` khởi chạy mỗi job trong process group riêng dưới một cái tên, `dybatpho::wait_all` đợi mọi job, ghi lại mã thoát của từng job và thất bại khi có job thất bại, còn `dybatpho::kill_children` gửi `TERM` tới mọi group, đợi cho group rỗng, rồi gửi `KILL` tới những gì còn lại sau `DYBATPHO_TIMEOUT_KILL_AFTER` giây. (dybatpho)

**Nên dùng**

```sh
dybatpho::trap dybatpho::kill_children EXIT INT TERM
dybatpho::background_run api ./serve.sh --port 8080
dybatpho::background_run worker ./worker.sh
dybatpho::wait_all || dybatpho::die "A background job failed"
```

### Song song có giới hạn

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Giới hạn số job chạy cùng lúc: một vòng lặp khởi chạy job bằng `&` phải đợi một job xong trước khi khởi chạy job tiếp theo <kbd>BSG155</kbd>
> - ✔️ NÊN: Đếm số job đang chạy, và `wait -n` (Bash 4.3) cho một job kết thúc khi con số chạm giới hạn, đếm cả thất bại của nó: `wait -n || failed=$((failed + 1))`
> - ✔️ NÊN: Giao một danh sách tệp cho `xargs -0 -P "${jobs}"` khi mỗi job là một chương trình, không phải một hàm shell
> - ✔️ NÊN: Chọn giới hạn theo thứ mà các job tiêu tốn: số CPU cho việc tốn CPU, một con số cố định nhỏ cho các request tới một server hay các lần ghi vào một ổ đĩa
> - ✔️ NÊN: Chạy một hàm trên một danh sách bằng `dybatpho::parallel_map <jobs> <function> <items...>`, và các lệnh khác nhau bằng `dybatpho::parallel_run --argv <jobs> <arrays...>`; `0` job nghĩa là mỗi CPU một job, theo số mà `dybatpho::cpu_count` báo. (dybatpho)

Mỗi mục một job, tất cả cùng lúc, chạy được với năm host của bản thử và thất bại với năm trăm host của production: năm trăm phiên ssh, số tệp được mở của người dùng bị dùng hết, một server giới hạn tốc độ script, một laptop phải swap. Một giới hạn giữ tải như nhau dù danh sách dài bao nhiêu, và công việc cũng không xong muộn hơn, vì đằng nào máy hay server cũng không làm được nhiều hơn cùng lúc.

Mỗi job vẫn có một mã thoát cần thu lại. Một lệnh `wait` trơn không tham số trả về 0 bất kể các job trả về gì, còn `wait` từng pid dưới `set -e` dừng ở thất bại đầu tiên, như [Tiến trình con](#ti%E1%BA%BFn-tr%C3%ACnh-con) giải thích và <kbd>BSG112</kbd> báo: hãy đếm số thất bại, rồi thất bại một lần ở cuối.

**Nên dùng**

```sh
local max_jobs running=0 failed=0 file
max_jobs="$(dybatpho::cpu_count || printf '4')"
for file in "${files[@]}"; do
  if ((running >= max_jobs)); then
    wait -n || failed=$((failed + 1))
    running=$((running - 1))
  fi
  image::convert "${file}" &
  running=$((running + 1))
done
while ((running > 0)); do
  wait -n || failed=$((failed + 1))
  running=$((running - 1))
done
((failed == 0)) || dybatpho::die "${failed} of ${#files[@]} conversions failed"

# Mỗi tệp một chương trình, bốn tệp một lúc
printf '%s\0' "${files[@]}" | xargs -0 -n 1 -P 4 gzip --
```

**Không nên dùng**

```sh
# Năm trăm host: năm trăm phiên ssh cùng lúc, và mọi thất bại đều bị mất
for host in "${hosts[@]}"; do
  check::host "${host}" &
done
wait
```

`dybatpho::parallel_map` chạy một lệnh hay một hàm shell một lần cho mỗi mục, mỗi lúc một số lượng đã cho, phát lại output của từng job theo thứ tự các mục, và thất bại khi có job thất bại; sau đó `dybatpho::parallel_status <index>` cho biết mã thoát của từng job. `dybatpho::parallel_run --argv` làm điều tương tự cho các job khác nhau, mỗi job là một mảng chứa một lệnh và các tham số của nó. Số job `0` dùng `DYBATPHO_PARALLEL_JOBS`, nếu không thì mỗi CPU một job. (dybatpho)

**Nên dùng**

```sh
dybatpho::parallel_map 8 check::host "${hosts[@]}" || dybatpho::die "Some hosts failed the check"

local -a build=(npm run build) vet=(go vet ./...)
dybatpho::parallel_run --argv 0 build vet || dybatpho::die "The build failed"
```

### Hàm trong tiến trình con

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Chạy lại chính script với một lệnh con, như `xargs -n1 "$0" _worker`, thay vì giao một hàm cho tiến trình con bằng `export -f` <kbd>BSG141</kbd>
> - ✔️ NÊN: Chạy một hàm trên nhiều phần tử cùng lúc bằng `dybatpho::parallel_map`, hoặc các lệnh khác nhau bằng `dybatpho::parallel_run --argv`: mỗi job là một subshell của script và thấy mọi hàm và biến của nó. (dybatpho)
> - ✔️ NÊN: Khi một Bash con thật sự cần thư viện, gọi `dybatpho::export_functions`, hàm trỏ `BASH_ENV` tới thư viện để mọi Bash con không tương tác source nó trước tiên. (dybatpho)
> - ❌ TRÁNH: Không trông đợi `dybatpho::export_functions` mang theo những gì script đã thay đổi lúc chạy, như các bí mật đã đăng ký hay các biến không được export, hoặc tới được Bash khởi chạy dưới tên `sh`, vốn bỏ qua `BASH_ENV`. (dybatpho)

`export -f` và `declare -fx` đưa hàm vào môi trường dưới dạng một biến `BASH_FUNC_name%%`. Nó tới mọi tiến trình mà script khởi chạy từ đó trở đi, không chỉ tiến trình cần chạy nó, và tới một mình: không có các biến mà script không export, không có `set -euo pipefail`, và không có các hàm khác mà nó gọi. Một tiến trình con không phải Bash, như `sh -c`, hoàn toàn không thấy nó.

Bản thân script đã có mọi thứ mà worker cần. Khi được khởi chạy lại với một lệnh con, nó source các thư viện của chính nó, đặt các tùy chọn của chính nó rồi chạy đúng một hàm.

**Nên dùng**

```sh
function _worker {
  local file="$1"
  gzip -9 -- "${file}"
}

function main {
  case "${1-}" in
    _worker)
      shift
      _worker "$@"
      ;;
    *)
      printf '%s\0' "${files[@]}" | xargs -0 -P4 -n1 -- "$0" _worker
      ;;
  esac
}

main "$@"
```

**Không nên dùng**

```sh
function _worker {
  local file="$1"
  gzip -9 -- "${file}"
}

# Tới mọi tiến trình con, mà không có các biến, tùy chọn và helper nó dựa vào
export -f _worker
printf '%s\0' "${files[@]}" | xargs -0 -P4 -n1 bash -c '_worker "$1"' _
```

`dybatpho::parallel_map` chạy một lệnh một lần cho mỗi phần tử, mỗi lúc một số lượng cho trước, trong các subshell của shell gọi nó, nên hàm không cần export; nó phát lại output của từng job theo thứ tự và thất bại khi có job thất bại. `dybatpho::export_functions` dành cho một Bash con mà script không tránh được, do `find -exec` hay một chương trình khác khởi chạy: tiến trình con source lại toàn bộ thư viện từ đầu, với cùng các module, và tốn vài chục mili giây cho việc đó. (dybatpho)

**Nên dùng**

```sh
dybatpho::parallel_map 4 _worker "${files[@]}"

dybatpho::export_functions
find "${dir}" -name '*.tar.gz' -exec bash -c 'for file; do dybatpho::file_hash "${file}"; done' _ {} +
```

### Đổi thư mục

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Đổi thư mục bên trong một subshell, `( cd -P -- "${dir}" && make )`, để phần còn lại của script vẫn ở chỗ cũ
> - ✔️ NÊN: Truyền thư mục cho công cụ nào nhận nó, như `git -C`, `make -C` hay `tar -C`, thay vì chuyển thư mục
> - ✔️ NÊN: Viết `cd -P -- "${dir}"`, và dừng lại khi nó thất bại: các lệnh sau một `cd` thất bại sẽ chạy sai chỗ
> - ⚠️ CÂN NHẮC: Đổi thư mục trong một subshell, hoặc truyền thư mục cho công cụ, thay vì dùng `pushd`, `popd` hay `cd -`. (tùy chỉnh) <kbd>BSG147</kbd>

Thư mục hiện tại là trạng thái mà cả script dùng chung. `pushd` và `popd` in ngăn xếp thư mục ra STDOUT, thứ sẽ lẫn vào bất cứ chỗ nào bắt output, và dưới `set -e` một lệnh thất bại giữa `pushd` và `popd` để lại script, cùng trình xử lý `EXIT` của nó, ở sai chỗ. `cd -` cũng in ra thư mục, và quay về nơi `OLDPWD` đang trỏ tới, mà bất kỳ `cd` nào khác ở giữa đều đã làm thay đổi. Một subshell không cần đường quay về: việc chuyển thư mục kết thúc cùng nó.

`-P` phân giải liên kết tượng trưng, để `pwd` và `..` mang đúng nghĩa mà hệ thống tệp nói, còn `--` giữ cho một thư mục tên `-x` không bị đọc thành tùy chọn. Một hàm thư viện cần chuyển thư mục cũng dùng subshell, xem [Tác dụng phụ của thư viện](#t%C3%A1c-d%E1%BB%A5ng-ph%E1%BB%A5-c%E1%BB%A7a-th%C6%B0-vi%E1%BB%87n).

**Nên dùng**

```sh
(cd -P -- "${build_dir}" && make install)

git -C "${repo_dir}" pull --ff-only
tar -C "${dest_dir}" -xzf "${archive}"

cd -P -- "${work_dir}" || dybatpho::die "Cannot enter ${work_dir}"
```

**Không nên dùng**

```sh
pushd "${build_dir}"
make install
popd

cd "${repo_dir}"
git pull --ff-only
cd -
```

### Kết thúc tùy chọn

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Đặt `--` trước các toán hạng lấy từ biến: `rm -- "${file}"`, `grep -- "${pattern}" "${file}"`
> - ❌ TRÁNH: Không truyền một biến làm toán hạng đầu tiên của lệnh mà thiếu `--` khi giá trị của nó có thể bắt đầu bằng `-` <kbd>BSG057</kbd>

Một lệnh đọc mọi tham số bắt đầu bằng `-` là tùy chọn cho tới khi gặp `--`. Khi đó một tệp tên `-rf`, một mẫu như `-v`, hay một đường dẫn do người dùng gõ vào sẽ bị hiểu là cờ: lệnh thất bại, hoặc làm một việc khác. Công cụ BSD trên macOS khắt khe về thứ tự hơn GNU, và đó thường là nơi việc thiếu `--` lộ ra.

**Nên dùng**

```sh
rm -f -- "${file}"
grep -- "${pattern}" "${file}"
chmod 600 -- "${path}"
```

**Không nên dùng**

```sh
# Một tệp tên -rf, hay một mẫu bắt đầu bằng -, bị đọc là tùy chọn
rm -f "${file}"
grep "${pattern}" "${file}"
```

### Request mạng

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dùng `curl --fail` (hoặc kiểm tra HTTP status) trước khi dùng một response <kbd>BSG056</kbd>
> - ✔️ NÊN: Tải về thành tệp, kiểm tra nó với checksum hoặc chữ ký, rồi mới chạy
> - ✔️ NÊN: Giới hạn thời gian của mọi lời gọi mạng: `curl --connect-timeout` và `--max-time`, hoặc `timeout` bao quanh một công cụ không có giới hạn riêng <kbd>BSG107</kbd>
> - ✔️ NÊN: Chỉ thử lại những gì có thể thành công ở lần sau, với số lần có giới hạn: `curl --retry 3` thử lại khi hết thời gian hay gặp lỗi 5xx, không thử lại một lỗi 404
> - ✔️ NÊN: Gửi request bằng `dybatpho::curl_do`, hàm thất bại khi gặp lỗi HTTP và chỉ thử lại những gì có thể thành công, và giới hạn thời gian của nó bằng `dybatpho::curl_timeout`. (dybatpho)
> - ✔️ NÊN: Chờ lâu hơn giữa mỗi lần thử lại, có thêm một phần ngẫu nhiên và một mức trần: `delay=$((2 ** attempt + RANDOM % 3))` <kbd>BSG117</kbd>
> - ⚠️ CÂN NHẮC: Thử lại một lệnh không phải `curl` bằng `dybatpho::retry`, hàm nhân đôi độ trễ tới `DYBATPHO_RETRY_MAX_DELAY`; đặt `DYBATPHO_RETRY_JITTER=true` để có phần ngẫu nhiên. (dybatpho)
> - ✔️ NÊN: Giới hạn cả `ssh`, `-o ConnectTimeout=10 -o BatchMode=yes` dưới `timeout`, và phân biệt hết giờ (mã 124) với thất bại <kbd>BSG118</kbd>
> - ✔️ NÊN: Giới hạn thời gian của một lệnh hay một hàm shell bằng `dybatpho::run_with_timeout`, hàm trả về 124 khi hết giờ và chạy được ở nơi không có `timeout`. (dybatpho)
> - ❌ TRÁNH: Không pipe thứ tải về vào shell: `curl ... | bash`, `wget -O- ... | sh` <kbd>BSG058</kbd>
> - ❌ TRÁNH: Không thử lại trong một vòng lặp sát nút, `until curl ...; do :; done`, hay thử lại mãi mãi

Không có `--fail`, curl thoát với 0 khi gặp 404 hay 500 và trả trang lỗi về như thể đó là nội dung. Khi pipe vào `bash`, trang đó — hoặc một lần tải bị cắt giữa chừng, hoặc bất cứ thứ gì kẻ tấn công trả về — được chạy từng dòng trước khi có gì kiểm tra nó, và một dòng dở dang có thể làm điều mà không script hoàn chỉnh nào làm.

Một request không có giới hạn thời gian sẽ chờ chừng nào server còn giữ kết nối: một job CI khi đó treo cho tới khi runner kết liễu nó, mà không có thông báo nào cho biết lời gọi nào bị kẹt. Một vòng thử lại quanh một request thất bại vĩnh viễn — sai URL, thiếu quyền — chỉ làm thất bại đến chậm hơn.

**Nên dùng**

```sh
local installer
dybatpho::create_temp installer ".sh"
curl --fail -sSL --connect-timeout 10 --max-time 300 --retry 3 "${url}" -o "${installer}"
dybatpho::verify_checksum "${installer}" "sha256:${expected_sha256}"
bash "${installer}"
```

**Không nên dùng**

```sh
# Một trang 404, hay một script bị cắt cụt, được chạy ngay khi nó tới
curl -sSL "${url}" | bash
```

Một dịch vụ đang lỗi nhận lệnh thử lại từ mọi client cùng lúc. Thử lại không nghỉ, hay sau cùng một khoảng chờ cố định ở mọi nơi, sẽ giữ nó tiếp tục sập; nhân đôi thời gian chờ và cộng thêm một phần ngẫu nhiên giúp dàn các client ra, và giới hạn số lần thử biến một sự cố thành một lỗi thay vì một lần treo. `ssh` chờ một host đánh rơi gói tin lâu như kernel chờ, và chờ một lời nhắc mật khẩu mãi mãi, trừ khi được bảo khác đi.

**Nên dùng**

```sh
local attempt=1 delay
until curl --fail -sS --connect-timeout 10 --max-time 60 "${url}" -o "${target}"; do
  ((attempt < 5)) || dybatpho::die "Gave up on ${url} after ${attempt} attempts"
  # Nhân đôi, kèm một phần ngẫu nhiên để các client không thử lại cùng lúc
  delay=$((2 ** attempt + RANDOM % 3))
  ((delay <= 60)) || delay=60
  sleep "${delay}"
  attempt=$((attempt + 1))
done

local status=0
timeout 300 ssh -o ConnectTimeout=10 -o BatchMode=yes -- "${host}" 'systemctl is-active app' || status=$?
case "${status}" in
  0) ;;
  124) dybatpho::die "${host} did not answer within 5 minutes" ;;
  *) dybatpho::die "${host}: the check failed with status ${status}" ;;
esac
```

**Không nên dùng**

```sh
# Dồn dập một dịch vụ vốn đang lỗi, và không bao giờ dừng
until curl --fail -sS "${url}" -o "${target}"; do :; done
# Chờ mật khẩu, hay chờ một host không tới được, mà không có giới hạn
ssh "${host}" 'systemctl is-active app'
```

`dybatpho::curl_do` trả về 3, 4 hay 5 cho một response 3xx, 4xx hay 5xx thay vì 0, thử lại lỗi truyền tải, 5xx, 408, 425 hay 429 với số lần có giới hạn và độ trễ tăng dần có tôn trọng `Retry-After`, và ghi log URL sau khi đã bỏ các bí mật trong đó. Hàm không đặt giới hạn thời gian nào trừ khi được cấu hình: `dybatpho::curl_timeout` nhận timeout kết nối và timeout tổng, tính bằng giây, cho một request. (dybatpho)

**Nên dùng**

```sh
dybatpho::curl_timeout "${url}" "${target}" 10 60 || dybatpho::die "Cannot download ${url}"
```

`dybatpho::retry` chạy một chuỗi lệnh, nên mọi giá trị ghép vào chuỗi đó phải được quote bằng `printf %q`, như [Eval là xấu xa](#eval-l%C3%A0-x%E1%BA%A5u-xa) yêu cầu. Độ trễ của nó không có phần ngẫu nhiên trừ khi `DYBATPHO_RETRY_JITTER=true`, và khi đó nhiều client khởi động cùng lúc sẽ thử lại cùng lúc. (dybatpho)

**Nên dùng**

```sh
DYBATPHO_RETRY_JITTER=true
dybatpho::retry 5 "git fetch --quiet origin" "fetch origin"
dybatpho::retry 3 "$(printf '%q ' rsync -a -- "${source}" "${target}")" "sync files"
```

`dybatpho::run_with_timeout` chạy lệnh trong process group riêng, gửi `TERM` tới cả group khi hết giờ và `KILL` sau `DYBATPHO_TIMEOUT_KILL_AFTER` giây, và chỉ trả về 124 khi chính giới hạn thời gian đã kết thúc nó. Hàm nhận cả hàm shell lẫn chương trình. (dybatpho)

**Nên dùng**

```sh
local status=0
dybatpho::run_with_timeout 30 ssh -o ConnectTimeout=10 -o BatchMode=yes "${host}" 'systemctl is-active app' || status=$?
if ((status == 124)); then
  dybatpho::die "${host} did not answer within 30 seconds"
fi
```

### Chờ một điều kiện

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ⚠️ CÂN NHẮC: Đặt hạn chót cho mọi lần chờ: một vòng lặp ngủ cho tới khi một điều kiện đúng cũng phải dừng sau một khoảng thời gian hoặc một số lần thử <kbd>BSG154</kbd>
> - ✔️ NÊN: Đo hạn chót theo `SECONDS`, `deadline=$((SECONDS + 60))`, thay vì cộng dồn các lần ngủ, cách này bỏ sót thời gian mà các lần kiểm tra tốn
> - ✔️ NÊN: Kiểm tra thưa dần khi lần chờ kéo dài, tới một mức trần: `((delay >= 8)) || delay=$((delay * 2))`
> - ✔️ NÊN: Ưu tiên một lệnh tự chờ, với giới hạn riêng của nó, hơn một vòng lặp hỏi vòng: `kubectl wait --timeout=60s`, `wait "${pid}"`
> - ✔️ NÊN: Chờ một cổng bằng `dybatpho::wait_port <host> <port> [seconds] [interval]`, lặp lại một phép kiểm tra bằng `dybatpho::retry_until <retries> <delay> [description] -- <command>`, và giới hạn thời gian của một lệnh có thể bị treo bằng `dybatpho::run_with_timeout`. (dybatpho)
> - ❌ TRÁNH: Không giữ một dịch vụ chạy mãi, hay lặp lại một việc sau mỗi vài phút, bằng một vòng `while true` trong script: để việc đó cho systemd, cron hoặc chính sách khởi động lại của nền tảng

Một lần chờ không có hạn chót biến mọi thất bại thành một lần treo. Dịch vụ không bao giờ khởi động, tệp không bao giờ được ghi, lock không bao giờ được nhả: script ngủ qua tất cả, một job CI chạy cho tới khi runner kết liễu nó, và không có gì cho biết nó đang chờ cái gì. Một hạn chót biến chính thất bại đó thành một lỗi nêu tên điều kiện, vào thời điểm mà bên gọi đã chọn.

Một phép kiểm tra chạy mỗi giây trong một phút là sáu mươi lần kiểm tra, phần lớn trong lúc chưa có gì thay đổi. Nhân đôi thời gian nghỉ tới một mức trần giúp trả lời nhanh khi điều kiện đến sớm, và thôi dồn dập một database hay một API vẫn đang khởi động khi điều kiện đến muộn.

**Nên dùng**

```sh
# Socket của một dịch vụ vừa khởi chạy: tối đa 60 giây, kiểm tra thưa dần theo thời gian
local deadline=$((SECONDS + 60)) delay=1
until [[ -S "${socket}" ]]; do
  ((SECONDS < deadline)) || dybatpho::die "${socket} did not appear within 60 seconds"
  sleep "${delay}"
  ((delay >= 8)) || delay=$((delay * 2))
done
```

**Không nên dùng**

```sh
# Chờ mãi mãi khi dịch vụ không bao giờ khởi động
until [[ -S "${socket}" ]]; do
  sleep 1
done
```

Một `while true; do sync::all; sleep 300; done` là một bộ lập lịch viết tay. Nó dừng theo terminal hay phiên SSH đã khởi chạy nó, không gì khởi động lại nó sau một lần crash hay một lần reboot, hai bản của nó chạy song song khi nó được khởi chạy hai lần, và output của nó không đi đâu cả. Một systemd timer, một mục cron hay chính sách khởi động lại của container đã làm tất cả những việc đó; script chỉ chạy một lần rồi thoát.

`dybatpho::wait_port` mở một kết nối TCP cho tới khi thành công hoặc hết số giây, và cho mỗi lần thử không nhiều thời gian hơn phần còn lại của lần chờ. `dybatpho::retry_until` chạy một lệnh cho tới khi thành công, tối đa bằng số lần thử lại đã cho, với độ trễ cố định giữa các lần, và trả về mã thoát cuối cùng của lệnh. `dybatpho::run_with_timeout` kết thúc một lệnh vẫn còn chạy khi hết giờ và trả về 124. (dybatpho)

**Nên dùng**

```sh
docker compose up -d
dybatpho::wait_port localhost 5432 60 || dybatpho::die "The database never came up"
dybatpho::retry_until 10 3 "wait for the socket" -- test -S "${socket}" \
  || dybatpho::die "${socket} did not appear"
dybatpho::run_with_timeout 300 ./migrate.sh || dybatpho::die "The migration failed or ran over 5 minutes"
```

### Lệnh trên máy remote

> [!TIP]
>
> - ✔️ NÊN: Chạy một hàm cục bộ trên máy remote bằng cách gửi định nghĩa của nó, do `declare -f` in ra, rồi đến lời gọi hàm, cho `bash -s` qua standard input
> - ✔️ NÊN: Đặt mọi giá trị cục bộ đưa vào lệnh remote trong dấu nháy bằng `${value@Q}`, hoặc `printf %q` <kbd>BSG128</kbd>
> - ✔️ NÊN: Gửi kèm mọi hàm mà phía remote gọi tới, và chỉ dùng những lệnh có trên máy remote
> - ❌ TRÁNH: Không truyền lệnh remote thành các từ rời, như `ssh "${host}" du -sh -- "${dir}"`: ssh nối chúng lại bằng dấu cách, và shell bên remote tách chúng ra lần nữa
> - ❌ TRÁNH: Không chép tay thân của một hàm vào một chuỗi lệnh

`ssh` không trao từng đối số cho lệnh remote. Nó nối chúng bằng dấu cách thành một chuỗi, rồi login shell của người dùng bên remote tách chuỗi đó ra lần nữa, nên một giá trị có dấu cách, dấu `;` hay `$(...)` sẽ thành nhiều từ hơn, hoặc thành một lệnh, ở phía bên kia, kể cả khi nó đã được đặt trong dấu nháy ở máy cục bộ. Một chuỗi lệnh viết tay cũng gặp đúng vấn đề đó, và còn lệch dần khỏi hàm mà nó được chép từ đó.

Hãy gửi một script thay vào đó. `declare -f` in một hàm đúng như nó đã được nạp, nên máy remote chạy đúng đoạn code mà script đã kiểm thử, còn `${value@Q}` viết mỗi đối số ở dạng mà Bash đọc lại ra đúng giá trị đó. Chỉ có `bash -s` đi qua login shell bên remote, nên shell đó là Bash, `sh` hay fish cũng không quan trọng.

`declare -f` chỉ gửi những hàm được nêu tên. Hãy liệt kê mọi hàm mà phía remote gọi tới, và không gọi một thư viện, như dybatpho, mà máy remote không có. Script tới qua standard input, nên phía remote không đọc được gì từ người dùng: hãy truyền những gì nó cần dưới dạng đối số.

**Nên dùng**

```sh
#######################################
# @description Print the disk usage of a directory
# @arg $1 string Directory
#######################################
function report::disk_usage {
  local dir="$1"
  du -sh -- "${dir}"
}

{
  declare -f report::disk_usage
  printf 'report::disk_usage %s\n' "${dir@Q}"
} | timeout 300 ssh -o ConnectTimeout=10 -o BatchMode=yes -- "${host}" bash -s
```

**Không nên dùng**

```sh
# "/srv/my app" tới shell bên remote thành hai từ
timeout 300 ssh -o ConnectTimeout=10 -o BatchMode=yes -- "${host}" du -sh -- "${dir}"
# Một bản sao của hàm, sẽ bị bỏ sót ở lần sửa hàm tiếp theo
timeout 300 ssh -o ConnectTimeout=10 -o BatchMode=yes -- "${host}" "du -sh -- ${dir}"
```

### Xác minh host key

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Ghim khóa của mọi host trong một tệp `known_hosts` đi kèm script, và truyền `-o UserKnownHostsFile=<file> -o StrictHostKeyChecking=yes`
> - ✔️ NÊN: Ghim một host mới một lần: lấy khóa của nó bằng `ssh-keyscan`, rồi so fingerprint mà `ssh-keygen -lf` in ra với fingerprint nhận được qua một kênh tin cậy, như output của bước cấp phát máy hay giao diện quản trị cloud
> - ⚠️ CÂN NHẮC: Chỉ dùng `StrictHostKeyChecking=accept-new` cho lần kết nối đầu tiên tới một host trên mạng bạn tin cậy; nó vẫn từ chối một khóa thay đổi về sau
> - ❌ TRÁNH: Không tắt việc kiểm tra host key bằng `StrictHostKeyChecking=no` hay `UserKnownHostsFile=/dev/null`, dù trên `ssh`, `scp`, `rsync -e`, trong `GIT_SSH_COMMAND` hay trong một ssh config <kbd>BSG158</kbd>

Host key là cách ssh biết nó đã tới đúng host chứ không phải một máy nằm ở giữa. Khi tắt việc kiểm tra, bất kỳ ai trả lời ở địa chỉ đó — một bản ghi DNS bị giả mạo, một access point lạ, một router bị chiếm — sẽ nhận phiên làm việc: nó đọc mọi mật khẩu và khóa được chuyển tiếp qua đó, thấy các lệnh, và trả lời chúng. `UserKnownHostsFile=/dev/null` làm đúng điều đó một cách lặng lẽ, vì một khóa chưa bao giờ được ghi lại thì không bao giờ bị phát hiện là đã thay đổi.

Một tệp `known_hosts` đặt cạnh script, và được review như code, biến sự tin cậy thành thứ nhìn thấy được: khi đó `StrictHostKeyChecking=yes` từ chối một host không có trong tệp thay vì hỏi, một câu hỏi mà script đằng nào cũng không trả lời được. `accept-new` ghi lại khóa đầu tiên nó thấy và từ chối một khóa khác về sau, nên nó bảo vệ mọi kết nối trừ kết nối đầu tiên; hãy dành nó cho một host vừa được tạo trên mạng bạn kiểm soát.

**Nên dùng**

```sh
# Các khóa đi kèm script, được review như code
local -a ssh_opts=(
  -o UserKnownHostsFile="${SCRIPT_DIR}/known_hosts"
  -o StrictHostKeyChecking=yes
  -o ConnectTimeout=10
  -o BatchMode=yes
)
timeout 300 ssh "${ssh_opts[@]}" -- "${host}" 'systemctl is-active app'
GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=${SCRIPT_DIR@Q}/known_hosts -o StrictHostKeyChecking=yes" \
  git fetch --quiet origin
```

```sh
# Một lần, để ghim một host mới: fingerprint đến từ chủ của host, không phải từ mạng
local scanned fingerprint
dybatpho::create_temp scanned ".keys"
timeout 30 ssh-keyscan -t ed25519 -- "${host}" > "${scanned}"
fingerprint="$(ssh-keygen -lf "${scanned}")"
[[ "${fingerprint}" == *" ${expected_fingerprint} "* ]] \
  || dybatpho::die "The key of ${host} does not match ${expected_fingerprint}"
cat -- "${scanned}" >> "${SCRIPT_DIR}/known_hosts"
```

**Không nên dùng**

```sh
# Tin bất kỳ máy nào trả lời ở địa chỉ đó, bây giờ và mọi lần sau
timeout 300 ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
  -o ConnectTimeout=10 -o BatchMode=yes -- "${host}" 'systemctl is-active app'
GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git fetch --quiet origin
```

### Lệnh đã lỗi thời

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dùng lệnh thay thế hiện hành: keyring `signed-by` cho apt, `grep -E` và `grep -F`, `command -v`, `ip`, `mktemp` <kbd>BSG059</kbd>
> - ❌ TRÁNH: Không dùng `apt-key`, `egrep`, `fgrep`, `which`, `ifconfig` hay `tempfile`

Các lệnh này đã lỗi thời, không có trong các image tối giản, hoặc hoạt động khác nhau giữa các hệ thống. `apt-key` tin một khóa cho mọi repository; `egrep` và `fgrep` in cảnh báo trên grep hiện hành; `which` là một chương trình bên ngoài có output và mã thoát khác nhau tùy nơi, còn `command -v` là lệnh dựng sẵn; `ifconfig` và `tempfile` không có trên nhiều bản phân phối.

**Nên dùng**

```sh
# Khóa của nhà cung cấp, được đối chiếu với fingerprint mà họ công bố
local key keys
dybatpho::create_temp key ".asc"
dybatpho::curl_download "${key_url}" "${key}"
keys="$(gpg --show-keys --with-colons -- "${key}")"
[[ "${keys}" == *"fpr:::::::::${VENDOR_FINGERPRINT}:"* ]] \
  || dybatpho::die "Unexpected signing key from ${key_url}"
# Ghi nguyên tử, có tôn trọng DRY_RUN
gpg --dearmor < "${key}" | dybatpho::file_write_atomic /etc/apt/keyrings/vendor.gpg
printf 'deb [signed-by=/etc/apt/keyrings/vendor.gpg] %s stable main\n' "${repo}" \
  | dybatpho::file_write_atomic /etc/apt/sources.list.d/vendor.list

grep -E -- "${pattern}" "${file}"
command -v jq > /dev/null
ip -brief address
dybatpho::create_temp staging ".txt"
```

**Không nên dùng**

```sh
curl -sSL "${key_url}" | apt-key add -
egrep "${pattern}" "${file}"
which jq > /dev/null
ifconfig
staging="$(tempfile)"
```

## Ổn định hóa script

### Viết script chạy lại được

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Làm cho script lũy đẳng: chạy hai lần với cùng tham số thì cho cùng kết quả
> - ✔️ NÊN: Kiểm tra xem việc đó đã làm xong chưa trước khi làm
> - ✔️ NÊN: Thêm một dòng vào tệp đúng một lần bằng `dybatpho::file_ensure_line`, và gỡ nó ra bằng `dybatpho::file_remove_line`, thay vì nối thêm bằng `>>`. (dybatpho)
> - ✔️ NÊN: Ưu tiên lệnh vốn đã lũy đẳng, như `chezmoi apply`, `pacman -S --needed` hay `kubectl apply`, hơn là lệnh thất bại ở lần chạy thứ hai
> - ❌ TRÁNH: Không giả định rằng lần chạy trước đã hoàn tất

Script cài đặt luôn bị ngắt giữa chừng: mạng rớt, máy chủ gương của kho gói hỏng, người dùng bấm Ctrl-C. Nếu lần chạy thứ hai đòi hỏi một cái máy sạch, thì không ai khôi phục được cái máy đang cài dở, và script sẽ bị thay bằng các bước làm tay.

**Nên dùng**

```sh
# Chỉ cài khi chưa có
dybatpho::is command "${name}" || dybatpho::dry_run dytoy -t "${name}"

# Chỉ tải submodule khi nó còn thiếu
if [[ ! -f "${SCRIPT_DIR}/lib/dybatpho/init.sh" ]]; then
  git -C "${REPO_DIR}" submodule update --init "${SCRIPT_DIR}/lib/dybatpho"
fi
```

**Không nên dùng**

```sh
# Thất bại ở lần chạy thứ hai vì công cụ đã được cài rồi
dytoy -t "$name"

# Thất bại ở lần chạy thứ hai vì thư mục đã tồn tại
mkdir "${config_dir}"
```

`dybatpho::file_ensure_line` tìm đúng dòng đó trước và không làm gì khi nó đã có, nên lần chạy thứ hai không thay đổi gì; nếu chưa có, nó nối dòng đó vào qua một tệp tạm, thêm ký tự xuống dòng mà dòng cuối có thể đang thiếu. Cả hai helper đều tôn trọng `DRY_RUN`. (dybatpho)

**Nên dùng**

```sh
dybatpho::file_ensure_line "${profile}" 'export EDITOR=nvim'
```

### Kiểm tra trạng thái trước khi thay đổi

> [!TIP]
>
> - ✔️ NÊN: Kiểm tra rằng đầu vào của một lệnh làm thay đổi trạng thái đúng như bạn mong đợi trước khi chạy nó
> - ✔️ NÊN: Kiểm tra công cụ cần thiết đã có mặt bằng `dybatpho::require` trước khi dùng nó. (dybatpho)
> - ✔️ NÊN: Xác minh thứ vừa tải về trước khi cài đặt nó
> - ❌ TRÁNH: Không đẩy một giá trị vào lệnh có tính phá hủy mà chưa kiểm tra nó khác rỗng

Dưới `set -u`, biến chưa được đặt thì bị bắt lỗi, nhưng biến rỗng thì không. `rm -rf "${prefix}/${name}"` với `name` rỗng sẽ xóa cả thư mục cha, và lệnh vẫn báo là thành công.

**Nên dùng**

```sh
dybatpho::require "rbw"

if dybatpho::string_is_blank "${profile_dir}"; then
  dybatpho::die "Profile directory is empty, refusing to remove"
fi
dybatpho::dry_run rm -rf -- "${profile_dir}"

# Kiểm tra tệp tải về trước khi đặt nó vào chỗ
binary::verify_sha256 "${name}" "${temp_file}" "${url}" "${sha256_asset}"
dybatpho::dry_run mv -- "${temp_file}" "${output_path}"
```

**Không nên dùng**

```sh
# profile_dir rỗng thì lệnh này xóa cả thư mục cha
rm -rf "${profile_dir}"

# Cài bất cứ thứ gì nhận về, kể cả trang báo lỗi của một proxy
curl -fsSL "$url" -o "$output_path"
chmod +x "$output_path"
```

### Tạo tệp tạm an toàn

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Tạo tệp tạm bằng `dybatpho::create_temp <var> <suffix>` và thư mục tạm bằng `dybatpho::create_temp_dir <var>`, chúng tự đăng ký việc dọn dẹp. (dybatpho) <kbd>BSG046</kbd>
> - ✔️ NÊN: Dùng `mktemp` khi không có thư viện, và xóa tệp bằng `trap 'rm -f "${temp_file}"' EXIT`
> - ✔️ NÊN: Đặt cho tệp tạm đúng phần mở rộng mà nội dung cần, để các công cụ phân loại theo đuôi tệp vẫn hoạt động
> - ✔️ NÊN: Chỉ dựng tệp staging cạnh đích từ một đường dẫn đã kiểm tra là không rỗng và không phải thư mục, và tạo nó độc quyền: `set -C`, hoặc `mktemp` trong thư mục của đích
> - ✔️ NÊN: Tạo tệp trong thư mục dùng chung bằng `mktemp`, hoặc tự đặt tên với hậu tố ngẫu nhiên dưới noclobber (`set -C`), để một tên đã tồn tại bị từ chối
> - ❌ TRÁNH: Không tự dựng đường dẫn tạm từ `$$`, từ dấu thời gian hay từ một tên cố định <kbd>BSG045</kbd>
> - ❌ TRÁNH: Không để việc dọn dẹp ở dòng cuối script, nơi mà một lỗi sẽ không bao giờ chạy tới
> - ❌ TRÁNH: Không trap `INT` hay `TERM` bằng một bước dọn dẹp không thoát: script sẽ chạy tiếp sau Ctrl-C <kbd>BSG106</kbd>
> - ❌ TRÁNH: Không để một đường dẫn rỗng hay hỏng biến tệp staging thành một tệp trong thư mục làm việc
> - ❌ TRÁNH: Không mở một tên trong thư mục dùng chung bằng `>` trơn: nó đi theo liên kết tượng trưng được đặt sẵn ở đó, kể cả khi tên có `$$` hay `$BASHPID` <kbd>BSG082</kbd>

Một cái tên đoán trước được trong thư mục ai cũng ghi được vừa dễ đụng nhau vừa mở đường cho tấn công liên kết tượng trưng. Đăng ký việc dọn dẹp ngay lúc tạo là cách duy nhất để nó chạy trên những nhánh quan trọng: nhánh lỗi và nhánh bị ngắt.

Một tệp staging dựng theo kiểu `"$(dirname "${path}")/.staging.$$"` sẽ nằm trong thư mục làm việc khi `path` rỗng hoặc đến từ một lệnh thay thế đã thất bại, và một `>` lên cái tên do ai đó đặt sẵn sẽ đi theo liên kết tượng trưng của họ. Hãy kiểm tra đích trước, rồi tạo tệp staging sao cho một tên đã tồn tại bị từ chối.

**Nên dùng**

```sh
dybatpho::create_temp sha256_file ".txt"
dybatpho::curl_download "${sha256_url}" "${sha256_file}"

dybatpho::create_temp_dir temp_dir
tar -xf "${archive}" -C "${temp_dir}"

# Khi không có thư viện; `--suffix` chỉ GNU có, nên tên tệp không có phần mở rộng
temp_file="$(mktemp)"
# Chỉ EXIT: Bash cũng chạy nó khi Ctrl-C hay TERM, rồi thoát với 130 hoặc 143
trap 'rm -f "${temp_file}"' EXIT

# Tệp staging cho một lần ghi lại nguyên tử: đích đã kiểm tra, tạo độc quyền
[[ -n "${path}" && ! -d "${path}" ]] || dybatpho::die "Not a file path: ${path}"
staging="$(mktemp "$(dirname -- "${path}")/.staging.XXXXXXXX")"
```

**Không nên dùng**

```sh
# Đoán trước được, đụng nhau giữa hai lần chạy, và không bao giờ được dọn khi lỗi
temp_file="/tmp/download-$$.tar.gz"
curl -fsSL "$url" -o "$temp_file"
...
rm -f "$temp_file"

# Đường dẫn rỗng làm tệp staging nằm trong thư mục làm việc, và `>` đi theo liên kết đặt sẵn
staging="$(dirname "${path}")/.staging.$$"
printf '%s\n' "${content}" > "${staging}"

# Ctrl-C chạy bước dọn dẹp rồi script chạy tiếp, sau đó dọn dẹp thêm lần nữa
trap 'rm -f "${temp_file}"' EXIT INT TERM
```

Một handler cho `INT` hay `TERM` thay thế hành động mặc định, vốn là thoát. Vì thế một bước dọn dẹp chỉ xóa tệp sẽ biến Ctrl-C thành "xóa tệp tạm của tôi rồi chạy tiếp": script tiếp tục mà không còn tệp đó, và thoát với mã 0. Trap `EXIT` vốn đã chạy khi Bash chết vì `INT` hay `TERM`; chỉ cần handler cho chính tín hiệu đó khi nó kết thúc bằng `exit`, như trong [Trình xử lý tín hiệu](#tr%C3%ACnh-x%E1%BB%AD-l%C3%BD-t%C3%ADn-hi%E1%BB%87u).

`$$` và `$BASHPID` ai cũng thấy được và dễ đoán trước khi script chạy, nên một cái tên dựng từ chúng có thể bị chiếm trước — bằng một liên kết tượng trưng trỏ tới một tệp mà script được quyền ghi. `>` sẽ đi theo liên kết đó. `mktemp` tạo tệp độc quyền với một tên ngẫu nhiên; khi buộc phải tự chọn tên, noclobber làm `>` từ chối một tên đã tồn tại, dù có là liên kết hay không.

**Nên dùng**

```sh
local report
report="$(mktemp "${TMPDIR:-/tmp}/report.XXXXXXXX")"

# Tự đặt tên: hậu tố ngẫu nhiên, và noclobber từ chối tên đã tồn tại
local name="${dir}/.part.${RANDOM}${RANDOM}"
if (set -C && : > "${name}") 2> /dev/null; then
  write_report > "${name}"
fi
```

**Không nên dùng**

```sh
# Đoán được trước khi script chạy, và `>` đi theo liên kết đặt sẵn ở tên đó
printf '%s\n' "${report}" > "${TMPDIR:-/tmp}/report.${BASHPID}"
```

### Lock

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Chiếm lock bằng một lời gọi nguyên tử đồng thời ghi lại người giữ: `ln -s "<pid>:<host>" "${lock}"`
> - ✔️ NÊN: Thu hồi lock cũ bằng cách đổi tên nó sang chỗ khác rồi kiểm tra bản đã chuyển đúng là người giữ mà bạn đã xác định là chết
> - ✔️ NÊN: Đánh giá người giữ mà bạn đã đọc được, không phải bất kỳ ai đang giữ tên đó vào lúc kiểm tra
> - ✔️ NÊN: Lấy lock bằng `dybatpho::lock_acquire` và `dybatpho::lock_release`, hoặc chạy một lệnh dưới lock bằng `dybatpho::with_lock`, các hàm tuân theo mọi điều trên. (dybatpho)
> - ❌ TRÁNH: Không xóa một lock cũ rồi mới chiếm nó: hai tiến trình có thể cùng làm vậy và cùng giữ lock
> - ❌ TRÁNH: Không tạo lock trước rồi mới ghi chủ sở hữu sau

Mọi khoảng trống giữa hai bước đều là một race. Một lock tạo bằng `mkdir` rồi mới ghi pid sẽ không có chủ trong chốc lát, và một tiến trình khác đọc nó thành lock cũ; xóa lock cũ rồi mới chiếm thì để một tiến trình thu hồi thứ hai xóa mất lock vừa được chiếm. Một liên kết tượng trưng mang theo chủ sở hữu ngay trong cùng lời gọi hệ thống tạo ra nó, và `rename()` chỉ thành công cho đúng một tiến trình thu hồi.

**Nên dùng**

```sh
if ln -s "$$:$(hostname)" "${lock}" 2> /dev/null; then
  holding=true
fi

# Thu hồi: chuyển nó vào một thư mục riêng, rồi kiểm tra thứ đã chuyển đúng là người giữ đã chết
local aside moved
aside="$(mktemp -d "${lock}.stale.XXXXXXXX")"
if mv -- "${lock}" "${aside}/lock" 2> /dev/null; then
  moved="$(readlink -- "${aside}/lock")"
  # Lấy nhầm lock đang được người khác giữ: trả lại cho họ
  [[ "${moved}" == "${dead_holder}" ]] || ln -s "${moved}" "${lock}" 2> /dev/null || true
fi
rm -rf -- "${aside:?}"
```

**Không nên dùng**

```sh
# Không có chủ giữa mkdir và lần ghi: tiến trình khác thu hồi nó
mkdir "${lock}" && echo "$$" > "${lock}/pid"

# Hai tiến trình thu hồi cùng xóa, và cùng chiếm lock
if ! kill -0 "$(cat "${lock}/pid")"; then
  rm -rf -- "${lock}"
  mkdir "${lock}"
fi
```

`dybatpho::lock_acquire` chiếm lock bằng một `ln -s` có target ghi tên người giữ, thu hồi lock cũ bằng cách chuyển nó sang chỗ khác rồi kiểm tra người giữ đã chuyển, và chờ tối đa số giây được truyền vào. `dybatpho::lock_release` chỉ giải phóng lock mà tiến trình hiện tại đang giữ, còn `dybatpho::with_lock` giải phóng nó cả khi lệnh thất bại hay script bị ngắt. (dybatpho)

**Nên dùng**

```sh
dybatpho::with_lock "deploy" 30 -- ./deploy.sh --env prod

dybatpho::lock_acquire "sync" || dybatpho::die "Another sync is running"
dybatpho::trap 'dybatpho::lock_release "sync"' EXIT
```

### Ghi nguyên tử

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Ghi nội dung mới vào một tệp staging trong thư mục của đích, rồi `mv` nó đè lên đích
> - ✔️ NÊN: Công bố các tệp mô tả một tệp — sidecar checksum, chỉ mục — trước chính tệp đó
> - ✔️ NÊN: Cho tệp staging quyền truy cập, và khi có thể cả chủ sở hữu, của tệp mà nó thay thế: `cp -p` tệp cũ đè lên nó trước khi ghi, hoặc dùng `dybatpho::file_write_atomic`. (dybatpho)
> - ❌ TRÁNH: Không ghi lại một tệp tại chỗ bằng `>` hay `>>` khi tiến trình khác có thể đang đọc nó
> - ❌ TRÁNH: Không đặt tệp staging ở thư mục khác: `mv` giữa hai hệ thống tệp là sao chép, không phải đổi tên
> - ❌ TRÁNH: Không chuyển một tệp vừa tạo bằng `mktemp` đè lên một tệp mà người dùng hay dịch vụ khác đọc: nó được tạo với quyền `0600`

Người đọc mở một tệp đang bị ghi lại bằng `>` sẽ thấy nó rỗng hoặc ghi dở, và một lần sập sẽ để nó lại như vậy. `rename()` trong cùng một hệ thống tệp thay tên chỉ trong một bước, nên người đọc thấy hoặc tệp cũ hoặc tệp mới. Thứ tự giữa các tệp cũng quan trọng: một bản sao lưu được chuyển vào chỗ trước khi checksum của nó được ghi, trong chốc lát hoặc mãi mãi, là một bản sao lưu không qua được bước kiểm tra.

Phép đổi tên cũng thay luôn inode, và cùng với nó là quyền truy cập và chủ sở hữu. `mktemp` tạo tệp với quyền `0600` và thuộc người dùng của script, nên một tệp cấu hình vốn là `0644` và được một dịch vụ đọc, sau khi ghi lại, trở thành một tệp mà dịch vụ đó không mở được nữa.

**Nên dùng**

```sh
local staging
staging="$(mktemp "$(dirname -- "${path}")/.staging.XXXXXXXX")"
# Nhận lại quyền truy cập, và chủ sở hữu khi được phép, của tệp bị thay thế
[[ ! -e "${path}" ]] || cp -p -- "${path}" "${staging}"
render_config > "${staging}"
mv -f -- "${staging}" "${path}"

# Sidecar trước, rồi mới tới archive mà nó mô tả
local digest sidecar
digest="$(sha256sum < "${partial}")"
sidecar="$(mktemp "$(dirname -- "${archive}")/.staging.XXXXXXXX")"
# Ghi tên archive, không phải tên tệp staging, để `sha256sum -c` tìm được nó
printf '%s  %s\n' "${digest%% *}" "${archive##*/}" > "${sidecar}"
mv -- "${sidecar}" "${archive}.sha256"
mv -- "${partial}" "${archive}"
```

**Không nên dùng**

```sh
# Người đọc thấy tệp rỗng tới khi lệnh này xong, và mãi mãi nếu nó thất bại
render_config > "${path}"

# Hiện ra mà không có sidecar cho tới khi dòng sau chạy
mv -- "${partial}" "${archive}"
sha256sum "${archive}" > "${archive}.sha256"
```

### Lệnh phá hủy

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Khai triển biến dùng để dựng đường dẫn cho một lệnh phá hủy bằng `${var:?}`, hoặc kiểm tra trước rằng nó không rỗng và nằm trong một thư mục gốc được phép
> - ✔️ NÊN: Phân giải thư mục gốc và đích bằng `cd -P` trước khi so sánh, và dừng lại khi thư mục gốc rỗng
> - ✔️ NÊN: Kiểm tra một đường dẫn dựng từ biến bằng `dybatpho::assert_safe_path`, hàm tuân theo mọi điều trên. (dybatpho)
> - ✔️ NÊN: Ưu tiên một helper có bảo vệ, kiểm tra đường dẫn và xác nhận trước khi hành động: `dybatpho::safe_rm`, `dybatpho::safe_move`, `dybatpho::safe_overwrite`, `dybatpho::safe_system`. (dybatpho)
> - ❌ TRÁNH: Không chạy `rm -r`, `find ... -delete`, `chmod -R`, `chown -R` hay `mv` đè lên một đích có sẵn với đường dẫn dựng từ các biến chưa từng được kiểm tra <kbd>BSG089</kbd>
> - ❌ TRÁNH: Không kiểm tra một đường dẫn có nằm trong thư mục gốc hay không bằng cách so sánh chuỗi như được nhập vào

Một biến chưa đặt hoặc rỗng biến `rm -rf "${BUILD_DIR}/cache"` thành `rm -rf /cache`, và `rm -rf "${prefix}"*` thành thư mục làm việc. `${var:?}` dừng script khi biến chưa đặt hoặc rỗng, trước khi lệnh chạy; kiểm tra thư mục gốc chặn được một giá trị đã đặt nhưng sai.

Kiểm tra thư mục gốc trên chuỗi như được nhập vào yếu hơn vẻ ngoài của nó. Khi thư mục gốc rỗng, `"${target}" == "${WORK_ROOT}"/*` trở thành `== /*`, mọi đường dẫn tuyệt đối đều khớp; còn `${WORK_ROOT}/../etc` hay một liên kết tượng trưng bên trong thư mục gốc vẫn qua được phép so sánh trong khi trỏ tới một thư mục bên ngoài.

**Nên dùng**

```sh
rm -rf -- "${BUILD_DIR:?}/cache"

# Phân giải cả hai phía trước: `..` và liên kết tượng trưng không còn trong thứ được so sánh
local root resolved
root="$(CDPATH='' cd -P -- "${WORK_ROOT:?}" && pwd)" || return 1
resolved="$(CDPATH='' cd -P -- "${target:?}" && pwd)" || return 1
[[ "${resolved}" == "${root}"/* ]] \
  || dybatpho::die "Refusing to delete outside ${root}: ${target}"
dybatpho::safe_rm "${resolved}"
```

**Không nên dùng**

```sh
# BUILD_DIR chưa đặt: lệnh này xóa /cache
rm -rf "${BUILD_DIR}/cache"

# target rỗng: chown duyệt cả thư mục làm việc
chown -R "${owner}" "${target}"

# WORK_ROOT rỗng thì khớp mọi đường dẫn tuyệt đối, và work/../etc cũng khớp
[[ "${target}" == "${WORK_ROOT}"/* ]] && rm -rf -- "${target}"
```

`dybatpho::assert_safe_path` từ chối một đường dẫn rỗng, `/`, các thư mục hệ thống cấp một, `${HOME}` và mọi mục trong `DYBATPHO_PROTECTED_PATHS`, và, khi `DYBATPHO_SAFE_ROOTS` được đặt, một đường dẫn nằm ngoài các thư mục gốc đó. Hàm phân giải các thư mục của đường dẫn qua symlink trước khi so sánh, nên một symlink bên trong thư mục gốc không thể dẫn ra ngoài, và in ra đường dẫn đúng như đã viết. (dybatpho)

**Nên dùng**

```sh
local target
target="$(DYBATPHO_SAFE_ROOTS="${WORK_ROOT:?}" dybatpho::assert_safe_path "${WORK_ROOT}/${name}")" || return 1
```

Mỗi helper có bảo vệ kiểm tra đích của nó bằng `dybatpho::assert_safe_path`, hỏi bằng `dybatpho::confirm` trừ khi được truyền `--force` hay `DYBATPHO_FORCE=true`, và in ra lệnh thay vì chạy nó khi có `DRY_RUN`. `dybatpho::safe_move` và `dybatpho::safe_overwrite` giữ một bản `.bak` khi có `--backup`. (dybatpho)

**Nên dùng**

```sh
DYBATPHO_SAFE_ROOTS="${WORK_ROOT:?}"
dybatpho::safe_rm --recursive "${WORK_ROOT}/${name}"
dybatpho::safe_move --backup "${staged}" "${target}"
dybatpho::safe_system "Restart nginx" -- systemctl restart nginx
```

## Kiểm thử

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Mỗi thư viện có một tệp kiểm thử tương ứng, `scripts/test/<area>.bats` đặt cạnh `scripts/lib/<area>.sh`, viết bằng [bats](https://github.com/bats-core/bats-core). (tùy chỉnh) <kbd>BSG060</kbd>
> - ✔️ NÊN: Thêm bài kiểm thử cho hàm mới trong cùng commit với chính hàm đó. (tùy chỉnh)
> - ✔️ NÊN: Đặt phần chuẩn bị dùng chung của cả bộ kiểm thử vào một tệp trợ giúp, được mọi tệp kiểm thử nạp vào
> - ✔️ NÊN: Đưa cả bộ kiểm thử ra sau một điểm vào duy nhất, để chạy kiểm thử không phải nhớ tham số nào
> - ✔️ NÊN: Chạy trình kiểm lỗi và trình định dạng, `shellcheck` và `shfmt`, từ cùng chỗ với bộ kiểm thử
> - ❌ TRÁNH: Không kiểm thử một hàm bằng cách chạy cả script gọi nó

Một hàm thư viện chỉ kiểm thử được nếu bản thân nó không có tác dụng phụ: nhận tham số qua `dybatpho::expect_args`, ghi kết quả ra `STDOUT` và thông báo ra `STDERR`, và thực hiện thay đổi trạng thái qua `dybatpho::dry_run`. Viết bài kiểm thử cùng lúc với hàm chính là điều giữ cho hình dạng đó không bị phá vỡ.

**Nên dùng**

```sh
# scripts/test/chezmoi_attrs.bats
function setup {
  load test_helper
  setup_dotfiles_test_env
  . "${DOTFILES_DIR}/scripts/lib/chezmoi_attrs.sh"
}

@test "chezmoi_attrs::source_path maps a home path to the home source tree" {
  run run_source_path "${HOME}/.config/foo/bar.txt" ""
  assert_success
  assert_output "home/private_dot_config/foo/bar.txt"
}
```

```sh
bash ./scripts/test.sh --all
```

**Không nên dùng**

```sh
# Kiểm thử cùng lúc điểm vào, phần phân tích tham số và hệ thống tệp,
# nên không biết được cái nào hỏng
run bash ./scripts/setup.sh --all
assert_success
```

### Assertion output nghiêm ngặt

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Truyền `-` khi một assertion đọc giá trị mong đợi từ here-document: `assert_output - << EOF` <kbd>BSG061</kbd>
> - ❌ TRÁNH: Không viết `assert_output << EOF`, `refute_output << EOF`, `assert_stderr << EOF` hay `refute_stderr << EOF` mà thiếu `-`

bats-assert chỉ đọc standard input khi giá trị mong đợi là `-`. Thiếu nó thì here-document bị bỏ qua, và `assert_output` không có tham số chỉ kiểm tra rằng đã có output, nên test qua dù output nói gì đi nữa. Một bộ test xanh suốt nhiều năm có thể chứa hàng chục chỗ như vậy, mỗi chỗ che đi một kỳ vọng đã lỗi thời hoặc một lỗi thật.

**Nên dùng**

```sh
@test "table::print aligns the columns" {
  run table::print "name,count" "apples,3"
  assert_output - << 'EOF'
name    count
apples  3
EOF
}
```

**Không nên dùng**

```sh
@test "table::print aligns the columns" {
  run table::print "name,count" "apples,3"
  # Qua với mọi output không rỗng: here-document không bao giờ được đọc
  assert_output << 'EOF'
name    count
apples  3
EOF
}
```

### Cô lập test

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Xóa trạng thái kế thừa mà bộ test có thể tác động lên, trong helper dùng chung của test: `GIT_DIR`, `GIT_INDEX_FILE`, `GIT_WORK_TREE`, `FORCE_COLOR`, `NO_COLOR` <kbd>BSG062</kbd>
> - ✔️ NÊN: Tạo mọi fixture trong thư mục tạm riêng của test (`BATS_TEST_TMPDIR`)
> - ✔️ NÊN: Khởi chạy shell con từ một tệp script thay vì `bash -c` khi có đo coverage <kbd>BSG062</kbd>
> - ❌ TRÁNH: Không để một test tác động lên repository, thư mục home hay bất kỳ đường dẫn nào ngoài thư mục tạm của nó

Bộ test kế thừa môi trường của thứ đang chạy nó. Một git hook xuất `GIT_DIR` và `GIT_INDEX_FILE`, nên một test chạy `git init` và `git commit` trong thư mục tạm lại ghi vào repository thật — từng có một lần chạy như vậy biến repository thành bare và thay mất remote của nó. Một công cụ đo coverage theo dõi qua `BASH_SOURCE` cũng không thấy gì trong shell con `bash -c`, vì `BASH_SOURCE` của nó rỗng.

**Nên dùng**

```sh
# test/test_helper.bash
unset GIT_DIR GIT_INDEX_FILE GIT_WORK_TREE GIT_COMMON_DIR FORCE_COLOR

@test "release reads the tags of a repository" {
  local repo="${BATS_TEST_TMPDIR}/repo" script="${BATS_TEST_TMPDIR}/run.sh"
  git init -q "${repo}"
  printf '. %q\nrelease::latest %q\n' "${LIB}" "${repo}" > "${script}"
  run bash "${script}"
}
```

**Không nên dùng**

```sh
@test "release reads the tags of a repository" {
  # Trong một git hook, GIT_DIR trỏ tới repository thật
  git init -q "${BATS_TEST_TMPDIR}/repo"
  git -C "${BATS_TEST_TMPDIR}/repo" tag v1.0.0
  run bash -c ". ${LIB}; release::latest ${BATS_TEST_TMPDIR}/repo"
}
```

### Giả lập lệnh

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Giả lập một lệnh bên ngoài bằng một stub thực thi được trong thư mục riêng của test, đặt lên đầu `PATH`, để mọi tiến trình mà code khởi chạy đều tìm thấy bản giả
> - ✔️ NÊN: Giả lập một lệnh bằng `dybatpho::mock_command` hoặc `dybatpho::mock_command_script`, biến môi trường bằng `dybatpho::mock_env`, đồng hồ bằng `dybatpho::mock_time` và một response HTTP bằng `dybatpho::mock_http`, rồi gỡ tất cả bằng `dybatpho::unmock_all` trong `teardown`. (dybatpho)
> - ✔️ NÊN: Kiểm tra bản giả đã được gọi ra sao, bằng `dybatpho::assert_mock_called` hoặc `dybatpho::mock_calls`, chứ không chỉ kiểm tra code đã in ra gì. (dybatpho)
> - ⚠️ CÂN NHẮC: Giả lập một lệnh bên ngoài bằng một stub trên `PATH`, không phải bằng một hàm shell cùng tên <kbd>BSG132</kbd>
> - ✔️ NÊN: Chỉ viết bản giả dưới dạng hàm khi nó phải giữ trạng thái trong chính shell của test, như đếm số lần gọi `sleep` hay đẩy một đồng hồ giả, và ghi lý do ở dòng ngay trước nó: `# dyshellint disable=BSG132 # <lý do>`

Một hàm tên `curl` chỉ tồn tại trong shell đã định nghĩa nó. Code đang được kiểm thử chạm tới chương trình thật ngay khi nó chạy một script con, gọi `command curl`, hay ghi `/usr/bin/curl`, và khi đó test nói chuyện với mạng trong khi trông như không hề làm vậy. Một stub trên `PATH` là một tệp thực thi thật: mọi tiến trình đều tìm thấy nó, và nó có thể ghi lại từng lần gọi để test kiểm tra được cả tham số lẫn output.

dybatpho ghi các stub như vậy vào một thư mục riêng ở đầu `PATH`, ghi lại mọi lần gọi, và xóa bảng hash mà Bash giữ về nơi nó tìm thấy một lệnh lần trước, để một lệnh đã chạy trong shell không đi vòng qua bản giả. `dybatpho::mock_time` đặt vào đó một `date` trả lời theo một thời điểm bị đóng băng, còn `dybatpho::mock_http` thay `curl` bằng một bản trả về response soạn sẵn cho `dybatpho::curl_do` và mọi hàm dựng trên nó. (dybatpho)

**Nên dùng**

```sh
function teardown {
  dybatpho::unmock_all
}

@test "deploy::status lists the pods of the namespace" {
  dybatpho::mock_command_script kubectl 'printf "pod/api Running\n"'
  dybatpho::mock_env KUBE_NAMESPACE=prod
  run deploy::status
  assert_success
  assert_output "pod/api Running"
  dybatpho::assert_mock_called kubectl get pods --namespace prod
}

@test "fetch_status reads the answer of the API" {
  local bin="${BATS_TEST_TMPDIR}/bin"
  mkdir -p -- "${bin}"
  cat > "${bin}/curl" << EOF
#!/usr/bin/env bash
printf '%s\n' "\$*" >> "${bin}/curl.calls"
printf '{"ok":true}\n'
EOF
  chmod +x -- "${bin}/curl"
  PATH="${bin}:${PATH}"
  run fetch_status
  assert_output "ok"
  run cat -- "${bin}/curl.calls"
  assert_output --partial "https://api.example.test/status"
}
```

**Không nên dùng**

```sh
@test "fetch_status reads the answer of the API" {
  # Chỉ shell này thấy nó: `command curl`, một script con và /usr/bin/curl vẫn chạy bản thật
  function curl {
    printf '{"ok":true}\n'
  }
  run fetch_status
  assert_output "ok"
}
```

Có những bản giả không thể là một tiến trình riêng. Một `sleep` giả ghi lại từng độ trễ, hay một bản đẩy đồng hồ giả lên, phải thay đổi một biến trong chính shell của test, thứ mà stub trên `PATH` không bao giờ thấy được. Hãy giữ chúng ở dạng hàm, gọi trực tiếp code đang được kiểm thử thay vì qua `run`, vốn khởi chạy một subshell, và ghi lý do trong chỉ thị, để người đọc sau biết hàm đó không phải là một sơ suất.

**Nên dùng**

```sh
@test "retry::run waits longer before each attempt" {
  local -a waits=()
  # dyshellint disable=BSG132 # ghi lại từng độ trễ trong shell này, nơi stub trên PATH không chạm tới được
  function sleep {
    waits+=("$1")
  }
  dybatpho::mock_command curl 7
  retry::run 3 curl --fail "${url}" || true
  assert_equal "${waits[*]}" "1 2"
}
```

### Ma trận phiên bản Bash

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Chạy toàn bộ bộ test trong CI trên bản Bash cũ nhất mà dự án hỗ trợ và trên bản mới nhất, mỗi bản trong image chính thức `bash:<version>`
> - ✔️ NÊN: Kiểm tra, ngay trong job, rằng `bash` mà nó chạy đúng là phiên bản đặt tên cho job, trước khi chạy bộ test
> - ✔️ NÊN: Giữ bước kiểm tra `BASH_VERSINFO` riêng của dự án khi dùng dybatpho: `dybatpho::doctor_bash_supported`, cũng như bước kiểm tra dybatpho làm khi được source, chỉ biết mức tối thiểu của chính dybatpho, là 4.3. (dybatpho)
> - ⚠️ CÂN NHẮC: Chỉ chạy `/bin/bash` (3.2) của macOS để xem bước kiểm tra dừng lại với thông báo của nó, không phải để chạy bộ test
> - ❌ TRÁNH: Không chỉ kiểm thử trên bản Bash đi kèm image của runner, vốn gần như là bản mới nhất

Một bộ test chạy trên một bản Bash chỉ chứng minh mức tối thiểu ghi trong README cho đúng bản đó. Nameref, `mapfile -d`, `wait -n`, `${var@Q}` và cách `set -u` đối xử với mảng rỗng đều thay đổi giữa 4.3 và 5.1, mà image của runner đi kèm 5.2 hoặc mới hơn, nên một script hỏng ở mức tối thiểu vẫn qua mọi bước kiểm tra cho tới khi người dùng chạy nó. Các image `bash:<version>` build từng bản phát hành từ mã nguồn, với trình thông dịch nằm ở `/usr/local/bin`; một gói cài sau vẫn có thể kéo theo một `bash` khác, nên job hỏi chính `bash` mà nó chạy về phiên bản của nó.

Bash 3.2 không chạy được script viết theo hướng dẫn này, và đó chính là lý do có bước kiểm tra trong [Phiên bản Bash](#phi%C3%AAn-b%E1%BA%A3n-bash). Một job trên macOS chạy entrypoint bằng `/bin/bash` và kiểm tra rằng nó dừng lại với thông báo đó, thay vì với `invalid option` từ sâu bên trong. dybatpho không làm được việc này thay dự án: nó kiểm tra phiên bản mà chính nó cần, và một dự án cần 4.4 không được bảo vệ bởi một bước kiểm tra vẫn qua trên 4.3. (dybatpho)

**Nên dùng**

```yaml
jobs:
  test:
    name: "Bash ${{ matrix.bash }}"
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        bash: ["4.4", "5.3"]
    container:
      image: bash:${{ matrix.bash }}
    steps:
      - uses: actions/checkout@v4
      - name: "Check the Bash under test"
        env:
          WANT: ${{ matrix.bash }}
        run: |
          have="$(bash -c 'printf %s.%s "${BASH_VERSINFO[0]}" "${BASH_VERSINFO[1]}"')"
          [ "${have}" = "${WANT}" ] || { echo "bash is ${have}, expected ${WANT}"; exit 1; }
      - run: bash ./scripts/test.sh --all

  old-bash:
    name: "Bash 3.2 stops with a message"
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - run: |
          if /bin/bash ./bin/deploy.sh --help 2> err.txt; then exit 1; fi
          grep -q 'needs Bash 4.4 or newer' err.txt
```

```sh
#!/usr/bin/env bash
# dybatpho kiểm tra 4.3, mức tối thiểu của riêng nó; dự án này cần 4.4
if ((BASH_VERSINFO[0] < 4 || (BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4))); then
  printf 'deploy.sh needs Bash 4.4 or newer, found %s\n' "${BASH_VERSION}" >&2
  exit 1
fi
. "${SCRIPT_DIR}/lib/dybatpho/init.sh" || exit 1
```

**Không nên dùng**

```sh
#!/usr/bin/env bash
. "${SCRIPT_DIR}/lib/dybatpho/init.sh" --modules doctor || exit 1
# Qua trên Bash 4.3, rồi `mapfile -d` thất bại ở phía dưới
dybatpho::doctor_bash_supported || exit 1
```

### Coverage

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Đo coverage của một thư viện bằng [kcov](https://github.com/SimonKagstrom/kcov) bao quanh bộ test bats, giới hạn trong các tệp của chính thư viện bằng `--include-path`
> - ✔️ NÊN: Đọc báo cáo để tìm những nhánh không test nào chạm tới, như một đường xử lý lỗi, một phương án dự phòng hay một nhánh `case`, rồi viết test chạm tới chúng
> - ✔️ NÊN: Đánh dấu dòng mà trình theo vết không thấy được bằng một chú thích nêu lý do, `# kcov(skip) <lý do>`, và loại nó ra bằng `--exclude-line="# kcov(skip)"`
> - ⚠️ CÂN NHẮC: Chạy kcov một lần cho mỗi nhóm tệp test rồi gộp các phần lại bằng `kcov --merge`, khi một lần chạy trên cả bộ test lớn phình quá sức chứa của máy
> - ❌ TRÁNH: Không biến con số phần trăm thành mục tiêu hay ngưỡng chặn, và không viết test chỉ để chạm tới một dòng

Coverage trả lời một câu hỏi hữu ích: những dòng nào không test nào chạy qua? Câu trả lời là một danh sách chỗ cần xem, và thứ tìm thấy ở đó thường là một đường xử lý lỗi chưa ai thử, hoặc một nhánh không thể xảy ra và nên bỏ đi. Con số ở đầu báo cáo tự nó không trả lời điều gì. Một ngưỡng chặn đặt trên con số đó khuyến khích loại test chạy qua một dòng mà không kiểm tra nó đã làm gì, và một test như vậy giữ con số ở mức cao trong khi hành vi mà nó giả vờ bao phủ đã hỏng.

kcov theo dõi Bash qua output theo vết của nó, nên nó thấy những gì chạy trong một tiến trình con khởi chạy từ một tệp script nhưng không thấy trong `bash -c` (xem [Cô lập test](#c%C3%B4-l%E1%BA%ADp-test)), và nó bỏ sót vài dòng không gán được cho đâu, như dòng đóng của một nhóm lệnh có chuyển hướng. Hãy loại những dòng đó ra theo tên, kèm lý do ngay cạnh, thay vì hạ ngưỡng. kcov cũng giữ trạng thái theo vết cho tới khi thoát, nên một bộ test lớn chạy trong một lần có thể vắt cạn bộ nhớ của runner CI; mỗi nhóm tệp chạy một lần, gộp lại sau, giữ mức đỉnh ở nhóm lớn nhất.

**Nên dùng**

```sh
kcov --clean \
  --include-path="${PROJECT_DIR}/src" \
  --exclude-line="# kcov(skip)" \
  "${PROJECT_DIR}/coverage" \
  bats "${PROJECT_DIR}/test"

kcov --include-path="${PROJECT_DIR}/src" coverage/part0 bats test/cli.bats test/config.bats
kcov --include-path="${PROJECT_DIR}/src" coverage/part1 bats test/network.bats
kcov --merge --include-path="${PROJECT_DIR}/src" coverage/merged coverage/part0 coverage/part1
```

```sh
mkdir -p -- "${dir}" \
  || dybatpho::die "Cannot create ${dir}" # kcov(skip) mkdir chỉ thất bại khi đĩa chỉ đọc hoặc đã đầy
```

**Không nên dùng**

```sh
@test "config::load reads a missing file" {
  # Chạy qua mọi dòng của đường xử lý lỗi, mà không kiểm tra dòng nào
  run config::load "${BATS_TEST_TMPDIR}/missing.yaml"
}
```

### Ghim phiên bản công cụ

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Ghim phiên bản của mọi công cụ đánh giá code, `shellcheck`, `shfmt`, `bats` và `dyshellint`, trong một tệp mà cả máy cá nhân lẫn CI cùng đọc, như `mise.toml`
> - ✔️ NÊN: Ghim `rev` của mọi kho hook trong `.pre-commit-config.yaml`, tệp mà prek đọc, vào một tag
> - ✔️ NÊN: Nâng cấp một công cụ trong một commit riêng, cùng với các bản sửa mà những phát hiện mới của nó đòi hỏi
> - ❌ TRÁNH: Không cài công cụ ở phiên bản mới nhất trong CI, `go install ...@latest` hay tải bản phát hành mới nhất: khi đó bước kiểm tra thay đổi mà không có commit nào
> - ❌ TRÁNH: Không dựa vào phiên bản mà image của runner hay trình quản lý gói tình cờ cung cấp

Một bản phát hành của trình kiểm lỗi thêm một quy tắc, và một bản phát hành của trình định dạng đổi cách ngắt một dòng. Khi CI lấy bất cứ bản nào mới nhất, một pull request chỉ sửa một dòng lại thất bại ở cả trăm dòng nó chưa từng đụng tới, và một máy cá nhân còn bản của tháng trước lại cho qua thứ mà CI từ chối. Khi được ghim trong một tệp nằm dưới quản lý phiên bản, bộ công cụ chỉ thay đổi trong một commit nói rõ điều đó, và commit ấy mang theo các bản sửa cho những gì phiên bản mới phát hiện.

Một tệp được cả hai bên đọc giữ cho chúng giống nhau. `mise install` đọc `mise.toml` trên máy cá nhân, và cũng tệp đó thiết lập job CI; prek đọc `rev` của từng hook từ `.pre-commit-config.yaml`. Một thư viện được vendor dưới dạng git submodule, như bats trong `test/lib`, vốn đã được ghim bởi commit của submodule.

**Nên dùng**

```toml
# mise.toml, được `mise install` đọc trên máy cá nhân và được job CI đọc
[tools]
shellcheck = "0.11.0"
shfmt = "3.14.1"
bats = "1.12.0"
"go:gitlab.com/dynamo-tools/dyshellint/cmd/dyshellint" = "1.2.1"
```

```yaml
# .github/workflows/ci.yaml
steps:
  - uses: actions/checkout@v4
  - uses: jdx/mise-action@v2
  - run: bash ./scripts/test.sh --all

# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v6.0.0
    hooks:
      - id: end-of-file-fixer
```

**Không nên dùng**

```yaml
steps:
  # Bất cứ thứ gì phát hành sáng nay sẽ quyết định build có qua hay không
  - run: go install gitlab.com/dynamo-tools/dyshellint/cmd/dyshellint@latest
  # Bất cứ thứ gì image cung cấp, khác với mọi máy cá nhân
  - run: sudo apt-get install -y shellcheck shfmt bats

repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: main
```

## Tài liệu tham khảo

Hầu hết quy tắc ở đây đều kèm lý do; các trang dưới đây đi sâu hơn vào hành vi đứng sau chúng.

- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) và [icy/bash-coding-style](https://github.com/icy/bash-coding-style), hai hướng dẫn làm nền cho hướng dẫn này
- [BashGuide](https://mywiki.wooledge.org/BashGuide) của wiki Wooledge, hướng dẫn dạy các cách viết an toàn ngay từ đầu
- [BashPitfalls](https://mywiki.wooledge.org/BashPitfalls), các lỗi thường gặp, kèm cách sửa từng lỗi
- [BashFAQ](https://mywiki.wooledge.org/BashFAQ), đặc biệt là [Vì sao không dùng `set -e`](https://mywiki.wooledge.org/BashFAQ/105), [Vị trí của một script](https://mywiki.wooledge.org/BashFAQ/028) và [Vì sao không parse `ls`](https://mywiki.wooledge.org/ParsingLs)
- [ShellCheck wiki](https://www.shellcheck.net/wiki/), mỗi mã `SCxxxx` một trang
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html)
