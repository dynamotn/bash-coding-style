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
  - [Chế độ gỡ lỗi và chạy thử](#ch%E1%BA%BF-%C4%91%E1%BB%99-g%E1%BB%A1-l%E1%BB%97i-v%C3%A0-ch%E1%BA%A1y-th%E1%BB%AD)
  - [STDOUT và STDERR](#stdout-v%C3%A0-stderr)
  - [Hàm sử dụng chung](#h%C3%A0m-s%E1%BB%AD-d%E1%BB%A5ng-chung)
  - [Môi trường kế thừa](#m%C3%B4i-tr%C6%B0%E1%BB%9Dng-k%E1%BA%BF-th%E1%BB%ABa)
  - [Tác dụng phụ của thư viện](#t%C3%A1c-d%E1%BB%A5ng-ph%E1%BB%A5-c%E1%BB%A7a-th%C6%B0-vi%E1%BB%87n)
  - [Nhập liệu tương tác](#nh%E1%BA%ADp-li%E1%BB%87u-t%C6%B0%C6%A1ng-t%C3%A1c)
- [Quy ước đặt tên](#quy-%C6%B0%E1%BB%9Bc-%C4%91%E1%BA%B7t-t%C3%AAn)
  - [Tên hàm](#t%C3%AAn-h%C3%A0m)
  - [Tên biến](#t%C3%AAn-bi%E1%BA%BFn)
  - [Tên biến cục bộ trong hàm nameref và hàm callback](#t%C3%AAn-bi%E1%BA%BFn-c%E1%BB%A5c-b%E1%BB%99-trong-h%C3%A0m-nameref-v%C3%A0-h%C3%A0m-callback)
- [Chú thích](#ch%C3%BA-th%C3%ADch)
  - [Phần đầu file](#ph%E1%BA%A7n-%C4%91%E1%BA%A7u-file)
  - [Chú thích hàm](#ch%C3%BA-th%C3%ADch-h%C3%A0m)
  - [Chú thích triển khai](#ch%C3%BA-th%C3%ADch-tri%E1%BB%83n-khai)
  - [TODO Comments](#todo-comments)
- [Định dạng](#%C4%91%E1%BB%8Bnh-d%E1%BA%A1ng)
  - [Dấu tab và dấu cách](#d%E1%BA%A5u-tab-v%C3%A0-d%E1%BA%A5u-c%C3%A1ch)
  - [Độ dài dòng code và chuỗi dài](#%C4%91%E1%BB%99-d%C3%A0i-d%C3%B2ng-code-v%C3%A0-chu%E1%BB%97i-d%C3%A0i)
  - [Pipelines (Đường ống)](#pipelines-%C4%91%C6%B0%E1%BB%9Dng-%E1%BB%91ng)
  - [Luồng điều khiển](#lu%E1%BB%93ng-%C4%91i%E1%BB%81u-khi%E1%BB%83n)
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
  - [Khai triển ký tự đại diện cho tên tệp](#khai-tri%E1%BB%83n-k%C3%BD-t%E1%BB%B1-%C4%91%E1%BA%A1i-di%E1%BB%87n-cho-t%C3%AAn-t%E1%BB%87p)
  - [Locale và thứ tự sắp xếp](#locale-v%C3%A0-th%E1%BB%A9-t%E1%BB%B1-s%E1%BA%AFp-x%E1%BA%BFp)
  - [Eval là xấu xa](#eval-l%C3%A0-x%E1%BA%A5u-xa)
  - [Bí mật và thông tin xác thực](#b%C3%AD-m%E1%BA%ADt-v%C3%A0-th%C3%B4ng-tin-x%C3%A1c-th%E1%BB%B1c)
  - [Dựng output có cấu trúc](#d%E1%BB%B1ng-output-c%C3%B3-c%E1%BA%A5u-tr%C3%BAc)
  - [In dữ liệu](#in-d%E1%BB%AF-li%E1%BB%87u)
  - [Here document](#here-document)
  - [Mảng](#m%E1%BA%A3ng)
  - [Đường ống vào while](#%C4%91%C6%B0%E1%BB%9Dng-%E1%BB%91ng-v%C3%A0o-while)
  - [Thay thế tiến trình](#thay-th%E1%BA%BF-ti%E1%BA%BFn-tr%C3%ACnh)
  - [Vòng lặp for](#v%C3%B2ng-l%E1%BA%B7p-for)
  - [Biến cục bộ](#bi%E1%BA%BFn-c%E1%BB%A5c-b%E1%BB%99)
  - [Số học](#s%E1%BB%91-h%E1%BB%8Dc)
  - [Tính di động](#t%C3%ADnh-di-%C4%91%E1%BB%99ng)
  - [So sánh phiên bản](#so-s%C3%A1nh-phi%C3%AAn-b%E1%BA%A3n)
- [Gọi lệnh](#g%E1%BB%8Di-l%E1%BB%87nh)
  - [Kiểm tra giá trị trả về](#ki%E1%BB%83m-tra-gi%C3%A1-tr%E1%BB%8B-tr%E1%BA%A3-v%E1%BB%81)
  - [Xử lý lỗi](#x%E1%BB%AD-l%C3%BD-l%E1%BB%97i)
  - [Lệnh dựng sẵn và lệnh bên ngoài](#l%E1%BB%87nh-d%E1%BB%B1ng-s%E1%BA%B5n-v%C3%A0-l%E1%BB%87nh-b%C3%AAn-ngo%C3%A0i)
  - [Trình xử lý tín hiệu](#tr%C3%ACnh-x%E1%BB%AD-l%C3%BD-t%C3%ADn-hi%E1%BB%87u)
  - [Tiến trình con](#ti%E1%BA%BFn-tr%C3%ACnh-con)
  - [Kết thúc tùy chọn](#k%E1%BA%BFt-th%C3%BAc-t%C3%B9y-ch%E1%BB%8Dn)
  - [Request mạng](#request-m%E1%BA%A1ng)
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

<!-- tocstop -->

## Giới thiệu

Phong cách này cung cấp các hướng dẫn để viết kịch bản Bash. Nó được lập nên dựa trên [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) và [icy/bash-coding-style](https://github.com/icy/bash-coding-style) với một vài quy tắc được điều chỉnh.
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

Mỗi quy tắc có một mã: `BSG###` cho quy tắc của hướng dẫn này, `SC####` cho phát hiện của ShellCheck, và `FMT001` cho khác biệt định dạng. Có thể tắt bất kỳ mã nào cho một lần chạy bằng `--exclude-rules`, và có thể tắt tại chỗ một phát hiện của ShellCheck bằng chú thích `# shellcheck disable=SCXXXX` kèm lý do.

[`.shellcheckrc`](.shellcheckrc) và [`.editorconfig`](.editorconfig) trong kho này là cấu hình mà hướng dẫn yêu cầu, và được dùng để sao chép vào dự án của bạn. `dyshellint` đọc `.shellcheckrc` của dự án mà nó kiểm tra, và cũng kèm sẵn một định nghĩa [nvim-lint](https://github.com/mfussenegger/nvim-lint) cho Neovim.

## Bối cảnh

### Nên sử dụng shell nào

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng Bash cho tất cả các script
> - ✔️ NÊN: Viết `#!/usr/bin/env bash` ở đầu script. (tùy chỉnh)
> - ✔️ NÊN: Sử dụng `set -euo pipefail` cho các cài đặt tùy chọn shell. (tùy chỉnh)
> - ✔️ NÊN: Sau khi source [dybatpho](https://github.com/dynamotn/dybatpho), bạn có thể bỏ qua `set -euo pipefail`. (dybatpho)
> - ⚠️ CÂN NHẮC: Nếu sử dụng các shell khác, hãy giải thích lý do trong phần nhận xét. (tùy chỉnh)

Sử dụng Bash. Hạn chế tất cả các script shell có thể thực thi đối với `bash` đảm bảo một shell nhất quán được cài đặt trên tất cả các máy.

Các tệp thực thi phải bắt đầu bằng `#!/usr/bin/env bash` và các cờ tối thiểu. Sử dụng `#!/usr/bin/env bash` cung cấp một số lợi thế đáng chú ý: hoạt động trên các môi trường (như Fedora hoặc Termux), mặc dù có một chút ảnh hưởng đến hiệu suất từ việc gọi env để tìm kiếm PATH.

Sử dụng `set` cho cài đặt tùy chọn shell đảm bảo rằng ngay cả khi script được gọi bằng `bash script_name`, chức năng của nó không bị suy giảm. `set -euo pipefail` tự động phát hiện lỗi sớm và kết thúc script nếu xảy ra lỗi. `set -e` kết thúc script nếu xảy ra lỗi. `set -u` kích hoạt lỗi khi tham chiếu đến các biến không xác định. `set -o pipefail` kết thúc script nếu xảy ra lỗi ở giữa pipeline. Chỉ thêm `-E` khi script tự cài trap `ERR`, để các hàm và subshell kế thừa nó; `dybatpho::register_common_handlers` tự bật cờ này.

**Nên dùng**

```sh
#!/usr/bin/env bash
set -euo pipefail
# Nếu không dùng dybatpho

#!/usr/bin/env bash
DYBATPHO_DIR="<path to dybatpho>"
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
> - ✔️ NÊN: Kiểm tra `BASH_VERSINFO` ở đầu một entrypoint, trước mọi thứ cần một tính năng mới hơn, và dừng lại với một thông báo nêu phiên bản đang có
> - ✔️ NÊN: Ghi phiên bản đã giới thiệu một tính năng bên cạnh quy tắc phụ thuộc vào nó, khi phiên bản đó mới hơn mục tiêu
> - ❌ TRÁNH: Không cho rằng `bash` trên `PATH` là bản mới: macOS vẫn đi kèm Bash 3.2 ở `/bin/bash`

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

Shell là một lựa chọn phù hợp cho các tác vụ chủ yếu liên quan đến việc gọi các tiện ích khác và thực hiện tương đối ít thao tác dữ liệu. Mặc dù shell script không phải là một ngôn ngữ phát triển, chúng được sử dụng để tạo ra các script tiện ích khác nhau trong CI hoặc triển khai tới máy người dùng. Hướng dẫn về phong cách này không khuyến nghị triển khai rộng rãi các shell script, nhưng thừa nhận việc sử dụng chúng.

Sử dụng shell script cho các tiện ích nhỏ hoặc các script wrapper đơn giản. Đặc biệt, sử dụng shell script cho "xử lý đa dòng" hoặc "xử lý có thể tái sử dụng trong nhiều workflow" trong GitHub Actions hay Gitlab CI. Mặc dù Bash giúp dễ dàng xử lý văn bản, nhưng nó không phù hợp cho việc xử lý quá phức tạp hoặc xử lý dành riêng cho ngôn ngữ/ứng dụng. Hãy cân nhắc sử dụng một ngôn ngữ có cấu trúc trong những trường hợp như vậy.

## Tệp shell và cách thực thi trình thông dịch

### Phần mở rộng tệp

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng phần mở rộng `.sh` cho các script là thư viện và `chmod -x` cho chúng.
> - ✔️ NÊN: Không sử dụng phần mở rộng cho các script trong PATH và `chmod -x` cho chúng.
> - ✔️ NÊN: Sử dụng phần mở rộng `.sh` cho các script không ở trong PATH và có thể gọi từ CLI. `chmod +x` cho chúng. (tùy chỉnh)

Các tệp thực thi nên có phần mở rộng `.sh` (rất khuyến khích) hoặc không có phần mở rộng. Các script được source từ bên ngoài phải có phần mở rộng `.sh` và không nên được đánh dấu là có thể thực thi.

### SUID/SGID

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng `sudo` nếu bạn cần nâng quyền
> - ❌ TRÁNH: SUID và SGID bị cấm
> - ❌ TRÁNH: `sudo` cũng bị cấm trong các script CI (tùy chỉnh).

SUID và SGID bị cấm trong shell script. Shell có nhiều vấn đề bảo mật, khiến cho việc đảm bảo an toàn đầy đủ để cho phép SUID/SGID là gần như không thể. Mặc dù bash gây khó khăn cho việc thực thi SUID, nhưng nó vẫn có thể xảy ra trên một số nền tảng, vì vậy nó bị cấm. Nếu cần nâng quyền, hãy sử dụng `sudo`.

Miễn là các script được thực thi trong CI, `sudo`, SUID và SGID là không cần thiết và do đó bị cấm.

**Nên dùng**

```sh
# Sử dụng sudo khi gọi (Trừ trong CI)
sudo ./foo.sh
```

**Không nên dùng**

```sh
# Chuyển sang người dùng su hoặc root bên trong script
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
> - ✔️ NÊN: Khai báo giao diện của script trong hàm `_spec_<entrypoint>` bằng `dybatpho::opts::*`, rồi chạy nó với `dybatpho::generate_from_spec "_spec_<entrypoint>" "$@"`. (dybatpho)
> - ✔️ NÊN: Đặt tên biến nhận giá trị tùy chọn bằng `CHỮ HOA`, và cho mọi tùy chọn không bắt buộc một giá trị mặc định qua `init:=`. (tùy chỉnh)
> - ✔️ NÊN: Gom các tham số vị trí còn lại vào một mảng duy nhất, khai báo ở `dybatpho::opts::setup`
> - ✔️ NÊN: Khai báo tham số của hàm bằng `dybatpho::expect_args name... -- "$@"` thay vì tự đọc `$1`, `$2`. (dybatpho)
> - ✔️ NÊN: Luôn cung cấp `--help` thông qua `dybatpho::opts::disp` và `dybatpho::generate_help`. (dybatpho)
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

### Chế độ gỡ lỗi và chạy thử

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Để người gọi chọn mức chi tiết của log bằng tùy chọn `--log-level` gắn với `LOG_LEVEL`, kiểm tra bằng `dybatpho::validate_log_level`. (dybatpho)
> - ✔️ NÊN: Bật theo vết lệnh bằng `dybatpho::start_trace` thay vì viết `set -x` trực tiếp, và tắt bằng `dybatpho::end_trace`. (dybatpho)
> - ✔️ NÊN: Chạy mọi lệnh làm thay đổi trạng thái qua `dybatpho::dry_run`, để chế độ chạy thử chỉ in ra lệnh thay vì thực thi nó. (dybatpho)
> - ✔️ NÊN: Ưu tiên chế độ chạy thử do chính công cụ cung cấp, như `chezmoi diff` hay `kubectl --dry-run=server`, hơn là tự in lệnh ra
> - ✔️ NÊN: Đưa mọi tác dụng phụ qua wrapper chạy thử trong một script có hỗ trợ chạy thử: tải về, ghi, xóa, thay đổi gói và dịch vụ. (dybatpho)
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

### STDOUT và STDERR

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Tất cả các thông báo lỗi và nghiêm trọng nên được chuyển đến `STDERR`
> - ✔️ NÊN: Sử dụng biến `LOG_LEVEL` để kiểm soát mức độ ghi log với 6 cấp độ: trace, debug, info, warn, error, fatal. (tùy chỉnh)
> - ✔️ NÊN: Triệt tiêu tất cả các thông báo không cần thiết vào `/dev/null`. (tùy chỉnh)
> - ✔️ NÊN: Sử dụng thư viện ghi log từ [dybatpho](https://github.com/dynamotn/dybatpho) để xuất các thông báo để ghi log tốt hơn. (dybatpho)
> - ✔️ NÊN: Giữ standard output của một hàm bị bắt output chỉ cho kết quả của nó: gửi tiến độ, đường dẫn và thông báo sang `STDERR` hoặc `/dev/null`
> - ❌ TRÁNH: Không gọi một helper in ra `STDOUT` từ một hàm mà output của nó bị bên gọi bắt lại hoặc pipe vào một tệp

**Nên dùng**

```sh
# thông báo lỗi đến stderr
echo "Error: Không thể thực hiện do_something" >&2

# mức log mặc định là info
LOG_LEVEL=info

# triệt tiêu các thông báo không cần thiết
curl -fsSL "${url}" 2> /dev/null

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

### Hàm sử dụng chung

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng `.` để gọi các hàm chung
> - ✔️ NÊN: Các hàm chung nên được để chung dưới dạng library trong thư mục con `lib`
> - ✔️ NÊN: Chặn việc một thư viện bị source lần thứ hai trước khi nó khai báo các hằng `readonly`
> - ✔️ NÊN: Xác định vị trí một thư viện từ bên trong nó bằng `${BASH_SOURCE[0]}`
> - ✔️ NÊN: Kiểm tra đường dẫn thư viện được tính ra có tồn tại trước khi source, và nói cách lấy thư viện khi nó không có
> - ❌ TRÁNH: Không khai báo `readonly` ở cấp cao nhất của một thư viện có thể bị source hai lần
> - ❌ TRÁNH: Không dùng `$0` trong thư viện: nó là tên của script đã source thư viện
> - ❌ TRÁNH: Không source một đường dẫn tính ra mà không kiểm tra

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
> - ❌ TRÁNH: Không cho rằng một biến bạn chưa từng đặt thì chưa được đặt

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

### Tác dụng phụ của thư viện

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Trả về một trạng thái từ hàm thư viện, hoặc dừng qua helper die của thư viện, thứ báo rõ lỗi. (dybatpho)
> - ✔️ NÊN: Đổi thư mục bên trong một subshell, `( cd -- "${dir}" && ... )`, hoặc khôi phục thư mục cũ trước khi trả về
> - ✔️ NÊN: Giới hạn phạm vi một tùy chọn shell mà hàm cần: một subshell, `local -` cho tùy chọn của `set`, tiền tố `IFS=` trên đúng lệnh cần tách, `local IFS`, hoặc lưu và khôi phục nó trên mọi nhánh trả về
> - ❌ TRÁNH: Không gọi `exit` trong hàm thư viện: nó kết thúc script đã source thư viện
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
  curl --fail -sS -- "${url}" || return $?
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
> - ❌ TRÁNH: Không gọi `read` hay một lời nhắc vô điều kiện trong script có thể chạy trong CI, cron hay một pipe

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

## Quy ước đặt tên

### Tên hàm

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dùng từ khóa `function` để khai báo hàm
> - ✔️ NÊN: Viết tên hàm bằng chữ thường, các từ ngăn cách bằng dấu gạch dưới
> - ✔️ NÊN: Ngăn cách không gian tên với tên hàm bằng `::`, và đặt tên không gian tên theo tên tệp thư viện: `scripts/lib/package_manager.sh` định nghĩa `package_manager::install`
> - ✔️ NÊN: Thêm tiền tố `__<namespace>_` cho hàm riêng tư của thư viện, và tiền tố `_` cho hàm riêng tư của một script thực thi. (tùy chỉnh)
> - ❌ TRÁNH: Không viết `()` sau tên hàm khi đã dùng từ khóa `function`. (tùy chỉnh)
> - ❌ TRÁNH: Không dùng PascalCase hay camelCase

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
> - ✔️ NÊN: Khai báo mọi biến dùng trong hàm bằng `local`, và khai báo mảng cục bộ bằng `local -a name=()`
> - ✔️ NÊN: Dùng `CHỮ HOA` cho biến do bên gọi đặt: tùy chọn của script, biến môi trường được xuất ra và hằng số
> - ✔️ NÊN: Đặt hằng số ở đầu tệp và cho nó thuộc tính chỉ đọc bằng `readonly` hoặc `declare -r`
> - ✔️ NÊN: Đặt tên biến lặp theo tập hợp mà nó duyệt: `for tool in "${tools[@]}"`
> - ❌ TRÁNH: Không khai báo và gán từ một lệnh thay thế trên cùng một dòng

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
> - ✔️ NÊN: Thêm tiền tố cho mọi biến cục bộ khác của một hàm gắn `local -n` với một tên do bên gọi chọn: `__<namespace>_<function>_<name>`
> - ✔️ NÊN: Thêm tiền tố cho các biến cục bộ của một hàm chạy code của bên gọi — `"$@"`, `eval`, tên một callback, handler hay producer — khi chúng còn được dùng sau lần gọi đó
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
> - ✔️ NÊN: Thêm một comment ở đầu file để giải thích ngắn gọn mục đích hoặc nội dung của file. Tuy nhiên, không thêm comment trước dòng shebang.
> - ✔️ NÊN: Sử dụng định dạng [sh-docs](https://github.com/dynamotn/sh-docs) ([GitLab](https://gitlab.com/dynamo-tools/sh-docs)) bao gồm: `@file`, `@brief`, `@description` để giải thích file. (tùy chỉnh)

Tất cả các file nên có một comment cấp cao nhất mô tả ngắn gọn nội dung của chúng.

**Nên dùng**

```sh
#!/usr/bin/env bash
# @file backup.sh
# @brief Thực hiện backup nóng cho các database Oracle
# @description Thực hiện backup nóng cho các database Oracle
```

### Chú thích hàm

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Sử dụng định dạng [sh-docs](https://github.com/dynamotn/sh-docs) ([GitLab](https://gitlab.com/dynamo-tools/sh-docs)) để giải thích hàm. (tùy chỉnh)

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
> - ❌ TRÁNH: Không bao gồm tên của người viết comment TODO. (tùy chỉnh)

Sử dụng comment TODO cho các giải pháp tạm thời, ngắn hạn hoặc code đủ tốt nhưng chưa hoàn hảo. Comment TODO nên bao gồm chuỗi viết hoa `TODO`. Không cần thiết phải bao gồm tên của cá nhân, vì có thể xác định bằng `git blame`. Mục đích của comment TODO là cung cấp một marker `TODO` nhất quán và dễ tìm kiếm, có thể được tra cứu để biết thêm chi tiết khi cần. Vì người được tham chiếu trong TODO không nhất thiết phải cam kết sửa lỗi, nên việc bao gồm giải pháp dự kiến là hữu ích.

**Nên dùng**

```sh
# TODO: Code này cần được sửa do xử lý lỗi không đầy đủ. Thêm kiểm tra lỗi và thoát với mã 1.
```

## Định dạng

### Dấu tab và dấu cách

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Thụt lề bằng hai dấu cách. Không sử dụng dấu tab.
> - ✔️ NÊN: Chèn dòng trống giữa các khối mã để tăng tính dễ đọc.
> - ✔️ NÊN: Không bao gồm khoảng trắng ở cuối dòng. (tùy chỉnh)

Thụt lề nên dùng hai dấu cách. Tuyệt đối không được sử dụng dấu tab.

Nhiều trình soạn thảo không thể chuyển đổi giữa thụt lề thực tế và hiển thị dấu cách/tab theo tùy chọn của người dùng. Cài đặt trình soạn thảo của người khác có thể không giống với của bạn. Sử dụng dấu cách đảm bảo rằng mã trông giống nhau trong mọi trình soạn thảo.

### Độ dài dòng code và chuỗi dài

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Độ dài dòng tối đa là 120 ký tự. (tùy chỉnh)
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

Vòng lặp shell hơi khác một chút, nhưng tuân theo nguyên tắc dấu ngoặc nhọn khi khai báo hàm, hãy đặt `; then` và `; do` trên cùng dòng với `if/for/while`. `else` nên được đặt trên dòng riêng của nó, và các cấu trúc đóng cũng nên ở trên dòng riêng của chúng. Chúng nên được căn chỉnh theo chiều dọc với các cấu trúc mở của chúng.

**Nên dùng**

```sh
if [[ -n "${name}" ]]; then
  dybatpho::info "Installing ${name}"
else
  dybatpho::die "No tool name given"
fi

for tool in "${tools[@]}"; do
  echo "${tool}"
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
  echo "${tool}"
done
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
> - ✔️ NÊN: Đọc một biến môi trường có thể chưa được đặt kèm giá trị mặc định khi có `set -u`: `${NO_COLOR-}`, `${TMPDIR:-/tmp}`
> - ❌ TRÁNH: Tránh đặt các biến đặc biệt/tham số vị trí của shell trong dấu ngoặc nhọn trừ khi thực sự cần thiết hoặc để tránh nhầm lẫn nghiêm trọng
> - ❌ TRÁNH: Không đọc trơn một biến môi trường tùy chọn khi có `set -u`

Các biến nên được đặt trong dấu nháy kép. Sử dụng `${var}` thay vì `$var`, kể cả khi biến là toàn bộ chuỗi trong dấu nháy kép: một dạng duy nhất ở mọi nơi dễ đọc và dễ kiểm tra hơn một quy tắc có ngoại lệ.
Đây là một hướng dẫn được khuyến nghị mạnh mẽ nhưng không phải là một quy định tuyệt đối. Tuy nhiên, mặc dù nó không bắt buộc, đừng bỏ qua nó.

Tất cả các biến khác nên được đặt trong dấu ngoặc nhọn.

**Nên dùng**

```sh
# Kiểu ưu tiên cho các biến 'đặc biệt':
echo "Positional: $1" "$5" "$3"
echo "Specials: !=$!, -=$-, _=$_. ?=$?, #=$# *=$* @=$@ \$=$$ …"

# Dấu ngoặc nhọn là cần thiết:
echo "many parameters: ${10}"

# Dấu ngoặc nhọn tránh nhầm lẫn:
# Đầu ra là "a0b0c0"
set -- a b c
echo "${1}0${2}0${3}0"

# Kiểu ưu tiên cho các biến khác:
echo "PATH=${PATH}, PWD=${PWD}, mine=${some_var}"
echo "${PATH}"
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
> - ✔️ NÊN: Luôn luôn đặt các biến, command substitution, các chuỗi chứa dấu cách hoặc các ký tự meta của shell trong dấu nháy kép, trừ khi cần một khai triển không được đặt trong nháy kép hoặc shell internal là một số nguyên
> - ✔️ NÊN: Sử dụng mảng để trích dẫn an toàn nhiều phần tử, đặc biệt là cho các flag dòng lệnh
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
echo "${flag}"

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
grep -li Hugo /dev/null "$1"

# Các ví dụ ít đơn giản hơn
# "dùng dấu nháy biến, trừ khi được chứng minh là sai": ccs có thể trống
git send-email --to "${reviewers}" ${ccs:+"--cc" "${ccs}"}

# Các biện pháp phòng ngừa tham số vị trí: $1 có thể không được set
# Dấu ngoặc đơn để regex như cũ.
grep -cP '([Ss]pecial|\|?characters*)$' ${1:+"$1"}

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
> - ❌ TRÁNH: Không đặt mã thực thi xen giữa các khai báo hàm

Một tệp chỉ gồm các khai báo và kết thúc bằng một lời gọi thì có thể đọc theo thứ tự bất kỳ, và việc `source` nó để kiểm thử không gây tác dụng phụ nào. Mã nằm rải rác giữa các hàm sẽ chạy ngay lúc nạp tệp, khiến script không thể `source` được và rất khó lần ra khi nó hỏng giữa chừng.

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

dybatpho::generate_from_spec _spec_main "$@"
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
> - ✔️ NÊN: Chỉ cho ShellCheck biết thư viện được source qua một đường dẫn tính ra bằng `# shellcheck source=<path>`, thay vì tắt SC1091
> - ⚠️ CÂN NHẮC: Cân nhắc giải quyết tất cả các cảnh báo ShellCheck với mức độ nghiêm trọng từ "info" trở lên. (tùy chỉnh)
> - ⚠️ CÂN NHẮC: Nếu bạn không thể giải quyết các cảnh báo ShellCheck với mức độ nghiêm trọng "info", hãy cân nhắc thêm các chú thích `# shellcheck disable=SCXXXX` để bỏ qua chúng, kèm lý do trên cùng dòng. (tùy chỉnh)

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
ssh "${host}" 'printf "%s\n" "$HOSTNAME"'
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
> - ❌ TRÁNH: Không gọi một hàm có thể dừng script, qua `dybatpho::die` hay `exit`, bên trong `$(...)` rồi chạy tiếp vô điều kiện
> - ❌ TRÁNH: Không gọi hàm như vậy bên trong `$(...)`: mọi thay đổi nó tạo ra đều mất cùng subshell

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
    if date --version > /dev/null 2>&1; then __DATE_FLAVOR=gnu; else __DATE_FLAVOR=bsd; fi
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

### Khai triển ký tự đại diện cho tên tệp

> [!TIP]
>
> - ✔️ NÊN: Thêm tiền tố `./` cho mẫu đại diện khi nó được khai triển thành tham số của lệnh
> - ✔️ NÊN: Kiểm tra từng kết quả có tồn tại bằng `[[ -e "${file}" || -L "${file}" ]]`, hoặc bật `nullglob` trong một phạm vi kết thúc cùng vòng lặp
> - ⚠️ CÂN NHẮC: Dùng `compgen -G` khi bạn cần các kết quả khớp như dữ liệu và chấp nhận kết quả rỗng. (tùy chỉnh)
> - ❌ TRÁNH: Không truyền `*` trần cho một lệnh
> - ❌ TRÁNH: Không cho rằng một glob không khớp gì sẽ khai triển thành rỗng: nó vẫn giữ nguyên là mẫu

Một tệp tên `-rf` trong thư mục sẽ biến `rm *` thành `rm -rf`. `./*` khai triển thành các đường dẫn bắt đầu bằng `./`, không lệnh nào nhầm chúng với tùy chọn được.

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
> - ✔️ NÊN: Đặt mọi giá trị ghép vào một chuỗi cho `eval`, hay cho `dybatpho::dry_run` một chuỗi, trong `printf %q`; tốt hơn nữa là truyền một danh sách tham số
> - ❌ TRÁNH: Không dùng `eval`
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
> - ✔️ NÊN: Che URL trước khi nó vào một thông báo hay một log: giữ scheme và host, bỏ thông tin người dùng, đường dẫn và query
> - ✔️ NÊN: Đăng ký một bí mật để che ngay khi đọc nó, trong shell của bên gọi. (dybatpho)
> - ❌ TRÁNH: Không đặt bí mật trong tham số của một lệnh, nơi mọi người dùng trên máy đọc được nó qua `ps` và `/proc`
> - ❌ TRÁNH: Không ghi nguyên vẹn URL hay body của request vào log khi nó có thể mang token

Tham số của một tiến trình đang chạy là công khai trên máy, và log sống lâu hơn lần chạy đã ghi ra nó. Một URL webhook thường chính là thông tin xác thực, nên in URL của một request thất bại cũng làm lộ nó y như in một token. Vì vậy bí mật đi theo đường khác — một tệp cấu hình riêng mà curl đọc, standard input, một biến được kế thừa — và một thông báo chỉ gọi tên request bằng host của nó.

**Nên dùng**

```sh
local config
dybatpho::create_temp config ".curl"
printf 'header = "Authorization: Bearer %s"\n' "${TOKEN}" > "${config}"
curl --config "${config}" --fail-with-body "${url}"

# Chỉ có scheme và host vào log: https://hooks.slack.com/[redacted]
dybatpho::error "Request to ${redacted_url} failed"
```

**Không nên dùng**

```sh
# Token nằm trong `ps` suốt thời gian request chạy
curl -H "Authorization: Bearer ${TOKEN}" "${url}"

# URL webhook chính là bí mật, và giờ nó nằm trong log
dybatpho::error "Request to ${WEBHOOK_URL} failed"
```

### Dựng output có cấu trúc

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dựng JSON và YAML bằng `jq` hoặc `yq` với `--arg`, hoặc qua một helper escape duy nhất mà mọi module dùng chung
> - ✔️ NÊN: Ghi các trường CSV qua một helper duy nhất, nhân đôi dấu nháy và đặt trong nháy những trường chứa dấu phân cách, dấu nháy hay ký tự xuống dòng
> - ❌ TRÁNH: Không ghép một giá trị vào văn bản có cấu trúc bằng `printf '{"key":"%s"}'`

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

### In dữ liệu

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: In dữ liệu — một biến, một đường dẫn, bất cứ thứ gì đến từ bên ngoài — bằng `printf '%s\n' "${value}"`
> - ✔️ NÊN: Đặt các phần thay đổi vào đối số của `printf`, không bao giờ đặt vào chuỗi định dạng
> - ⚠️ CÂN NHẮC: `echo` vẫn ổn cho một thông báo cố định không chứa biến và không bắt đầu bằng `-`
> - ❌ TRÁNH: Không dùng `echo -e` hay `echo -n`, và không `echo` một giá trị có thể bắt đầu bằng `-` hoặc chứa dấu gạch chéo ngược

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
> - ❌ TRÁNH: Không dùng `<<-` để thụt lề một here document: nó chỉ bỏ ký tự tab, thứ mà hướng dẫn này không cho phép
> - ❌ TRÁNH: Không escape từng dấu `$` của một văn bản không khai triển gì: hãy đặt dấu phân cách trong nháy

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
> - ✔️ NÊN: Khai triển một mảng có thể rỗng bằng `${names[@]+"${names[@]}"}` khi script hỗ trợ Bash 4.3 dưới `set -u`
> - ✔️ NÊN: Duyệt các chỉ số mà mảng thật sự có bằng `"${!names[@]}"`
> - ❌ TRÁNH: Không giữ nhiều giá trị trong một chuỗi ngăn cách bằng dấu cách
> - ❌ TRÁNH: Không duyệt từ `0` đến `${#names[@]} - 1` trên một mảng mà hàm không tự dựng

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

### Đường ống vào while

> [!TIP]
>
> - ✔️ NÊN: Cấp dữ liệu cho vòng lặp `while read` bằng thay thế tiến trình: `while read -r line; do ...; done < <(command)`
> - ✔️ NÊN: Dùng `readarray -t` hoặc `mapfile -t` khi cần lấy toàn bộ kết quả thành một mảng
> - ✔️ NÊN: Dùng `read -r`, và dùng `mapfile -d ''` cùng `-print0` khi giá trị có thể chứa ký tự xuống dòng
> - ✔️ NÊN: Đọc mọi dòng, kể cả dòng cuối không có ký tự xuống dòng: `while IFS= read -r line || [[ -n "${line}" ]]`
> - ❌ TRÁNH: Không đưa đường ống vào vòng lặp `while`
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
echo "${count}"
```

**Không nên dùng**

```sh
# count ở đây luôn bằng 0: vòng lặp đã chạy trong một shell con
local count=0
command find "${root}" -type f | while read -r line; do
  count=$((count + 1))
done
echo "${count}"
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
> - ✔️ NÊN: Lưu output của một producer có thể thất bại vào một biến trước, kiểm tra mã thoát của nó, rồi mới đọc biến đó: `listing="$(cmd)" || return $?`
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

### Vòng lặp for

> [!TIP]
>
> - ✔️ NÊN: Duyệt mảng bằng `for item in "${items[@]}"`
> - ✔️ NÊN: Đọc kết quả của lệnh vào một mảng trước, rồi mới lặp trên mảng đó
> - ❌ TRÁNH: Không viết `for item in $(command)` khi kết quả có thể chứa dấu cách

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

### Biến cục bộ

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Khai báo `local` cho mọi biến mà hàm gán: biến lặp, đích của `read`, `mapfile`, `readarray` và `printf -v`, và các phép gán thường
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

### Số học

> [!TIP]
>
> - ✔️ NÊN: Dùng `(( ... ))` cho điều kiện số học và `$(( ... ))` cho giá trị số học
> - ✔️ NÊN: Bỏ dấu `$` trước tên biến bên trong `(( ... ))`
> - ✔️ NÊN: Khai báo biến đếm bằng `local -i` khi biến đó chỉ chứa số nguyên
> - ✔️ NÊN: Kiểm tra một số lấy từ đầu vào bằng biểu thức chính quy, và ép cơ số 10 trong phép tính: `$((10#${count}))`
> - ✔️ NÊN: Tăng giá trị bằng `((count += 1))` hoặc `count=$((count + 1))`
> - ❌ TRÁNH: Không dùng `let`, `expr` hay cú pháp `$[ ... ]` đã lỗi thời
> - ❌ TRÁNH: Không đưa thẳng một số đọc từ đầu vào, tên tệp hay ngày tháng vào `(( ))`: số 0 ở đầu biến nó thành hệ bát phân
> - ❌ TRÁNH: Không viết `((count++))` hay `((count--))` như một câu lệnh khi có `set -e`
> - ⚠️ CÂN NHẮC: Cẩn thận với `(( ... ))` đứng một mình dưới `set -e`: biểu thức có giá trị `0` sẽ trả về mã thoát `1` và làm dừng script

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

### Tính di động

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dò tính năng trước khi dùng một cờ chỉ GNU có, và giữ một nhánh di động: `date -d`, `sed -i`, `readlink -f`, `stat -c`, `find -printf`, `grep -P`, `xargs -r`, `mktemp --suffix`
> - ✔️ NÊN: Phát hiện tính năng bằng cách thử chính cờ đó, không dựa vào tên công cụ hay `--version` của nó
> - ❌ TRÁNH: Không mặc định có GNU coreutils khi script chạy trên macOS, BSD hay BusyBox
> - ⚠️ CÂN NHẮC: Ưu tiên lệnh dựng sẵn của Bash hoặc dạng POSIX khi chúng làm được việc: `printf '%(%s)T'`, khai triển tham số

macOS dùng công cụ BSD, Alpine dùng BusyBox, và cùng một cờ lại mang nghĩa khác, hoặc không có nghĩa gì, trên mỗi nơi: `sed -i` đòi hậu tố sao lưu trên BSD, `stat -c` ở đó là `stat -f`, còn `date -d` thì không tồn tại. `date --version` thất bại không có nghĩa hệ thống là BSD — BusyBox cũng thất bại ở đó — nên hãy thử chính hành vi cần dùng, một lần, rồi giữ lại kết quả.

**Nên dùng**

```sh
function __date_from_epoch {
  local epoch format
  dybatpho::expect_args epoch format -- "$@"
  if date -d @0 +%s > /dev/null 2>&1; then
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

### So sánh phiên bản

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: So sánh phiên bản bằng một helper semver
> - ⚠️ CÂN NHẮC: Chỉ dùng `sort -V` cho các số có dấu chấm thuần túy như `1.10.2`, ở nơi có lệnh này
> - ❌ TRÁNH: Không so sánh phiên bản bằng `<` hay `>` trên chuỗi, hoặc bằng phép tính trên chuỗi có dấu chấm
> - ❌ TRÁNH: Không sắp xếp các phiên bản có thể mang hậu tố pre-release bằng `sort -V`: nó đặt `2.0.0-rc1` sau `2.0.0`

So sánh chuỗi đi theo từng ký tự, nên `1.10.0` xếp trước `1.9.0`, và `2.0.0-rc1` xếp sau `2.0.0`. Phép tính số học hoàn toàn không dùng được trên chuỗi có dấu chấm. Một bước kiểm tra phiên bản làm sai chuyện này sẽ nâng cấp một bản cài mới hơn, hoặc từ chối một bản đã đủ mới.

`sort -V` sửa được phần số nhưng không sửa được hậu tố: nó đọc `-rc1` như các ký tự nối thêm sau `2.0.0`, nên một bản release candidate lại trông mới hơn chính bản phát hành mà nó đi trước.

**Nên dùng**

```sh
if dybatpho::semver_satisfies "${installed}" ">=1.10.0"; then
  use_new_flag=true
fi

newest="$(dybatpho::semver_max "${a}" "${b}")"

# Khi không có thư viện: sort -V, cho các phiên bản chỉ gồm số và dấu chấm
[[ "${a}" =~ ^[0-9]+(\.[0-9]+)*$ && "${b}" =~ ^[0-9]+(\.[0-9]+)*$ ]] \
  || dybatpho::die "Not a plain version: ${a} ${b}"
newest="$(printf '%s\n' "${a}" "${b}" | sort -V | tail -n 1)"
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

## Gọi lệnh

### Kiểm tra giá trị trả về

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Để `set -euo pipefail`, hoặc `dybatpho::register_common_handlers`, dừng script khi có lỗi không được xử lý. (dybatpho)
> - ✔️ NÊN: Kiểm tra trực tiếp trên lệnh: `if ! command; then ... fi`
> - ✔️ NÊN: Thêm `|| true` cho lệnh mà việc thất bại là điều thực sự được dự liệu, và ghi chú lý do
> - ✔️ NÊN: Thoát với mã có ý nghĩa: `0` khi thành công, khác `0` khi thất bại
> - ❌ TRÁNH: Không kiểm tra `$?` trong một câu lệnh riêng
> - ❌ TRÁNH: Không dựa vào `PIPESTATUS`

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

### Xử lý lỗi

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Xử lý lỗi ngay trong hàm nơi nó xảy ra, không đẩy lên cho bên gọi
> - ✔️ NÊN: Dừng bằng `dybatpho::die` khi script không thể tiếp tục, và `return 1` khi bên gọi còn xử lý được. (dybatpho)
> - ✔️ NÊN: Nói rõ cái gì hỏng và người dùng có thể làm gì, trong một thông báo trên `STDERR`
> - ✔️ NÊN: Cài đặt các trình xử lý chung một lần, ở đầu script thực thi, bằng `dybatpho::register_common_handlers`. (dybatpho)
> - ✔️ NÊN: Ghi trong thông báo lỗi tên hàm mà bên gọi đã gọi: `FUNCNAME[1]` từ một helper được hàm đó gọi trực tiếp, một tên do hàm đó truyền vào, hoặc hàm public đầu tiên trên stack
> - ❌ TRÁNH: Không trả về mã khác `0` trần trụi mà không kèm thông báo
> - ❌ TRÁNH: Không lấy một cấp cố định sâu hơn như `FUNCNAME[2]`, vì nó trỏ sang hàm khác ngay khi độ sâu lời gọi thay đổi

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
  echo "${config_dir}"
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

### Lệnh dựng sẵn và lệnh bên ngoài

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Ưu tiên lệnh dựng sẵn hơn lệnh bên ngoài cho cùng một việc: khai triển tham số thay cho `sed`, `(( ... ))` thay cho `expr`, `[[ ... ]]` thay cho `test`
> - ✔️ NÊN: Dùng công cụ bên ngoài như `sed`, `awk` hay `yq` khi nó làm mã ngắn gọn và rõ ràng hơn hẳn
> - ✔️ NÊN: Gọi công cụ bên ngoài qua `command <tool>` khi có thể đang tồn tại một alias hay một hàm cùng tên. (tùy chỉnh)
> - ❌ TRÁNH: Không viết khai triển tham số rắc rối tới mức người đọc phải chạy thử mới biết nó làm gì

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
```

**Không nên dùng**

```sh
# Một tiến trình cho mỗi dòng để làm điều mà ${url##*/} đã làm
asset_name="$(echo "$url" | rev | cut -d/ -f1 | rev)"

# Không đọc nổi, mà cũng chỉ làm đúng việc của hai dòng sed
result="${input//${a}\/${b}/${c}${d//x/y}}"
```

### Trình xử lý tín hiệu

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Ghép một handler với các handler đã cài sẵn (`dybatpho::trap`), thay vì thay thế chúng. (dybatpho)
> - ✔️ NÊN: Lưu handler của bên gọi trước một lời gọi có phạm vi, và khôi phục chúng sau đó
> - ✔️ NÊN: Chạy phần dọn dẹp của lời gọi có phạm vi trước handler của bên gọi có gọi `exit`, rồi phát lại tín hiệu, để handler đó và hành động mặc định vẫn diễn ra
> - ❌ TRÁNH: Không cài handler của thư viện bằng `trap '…' SIG` trơn, và không xóa handler bằng `trap - EXIT`

Một thư viện dùng chung bảng trap với script đã source nó. `trap '…' INT` trong thư viện âm thầm xóa phần xử lý Ctrl-C của chính script, còn `trap - EXIT` xóa phần dọn dẹp do người khác đăng ký. Thứ tự cũng quan trọng không kém: handler của bên gọi có gọi `exit` sẽ kết thúc shell trước khi handler nối sau nó kịp chạy, nên lock không bao giờ được giải phóng và các job con vẫn chạy. Vì vậy một lời gọi có phạm vi cài handler của riêng nó, đặt lại các handler đã lưu khi kết thúc, và phát lại tín hiệu nó đã bắt.

**Nên dùng**

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

### Tiến trình con

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Khởi chạy mỗi job nền trong process group riêng, và gửi tín hiệu tới cả group, để tiến trình cháu cũng dừng
> - ✔️ NÊN: Lặp lại tín hiệu tới khi group rỗng, trong một khoảng ân hạn có giới hạn, rồi gửi `KILL`
> - ✔️ NÊN: Kết thúc mọi job mà một hàm đã khởi chạy trước khi nó trả về, kể cả khi nó trả về vì một tín hiệu
> - ❌ TRÁNH: Không chỉ gửi tín hiệu tới pid của job, và không cho rằng một lần `TERM` là đủ

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

### Kết thúc tùy chọn

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Đặt `--` trước các toán hạng lấy từ biến: `rm -- "${file}"`, `grep -- "${pattern}" "${file}"`
> - ❌ TRÁNH: Không truyền một biến làm toán hạng đầu tiên của lệnh mà thiếu `--` khi giá trị của nó có thể bắt đầu bằng `-`

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
> - ✔️ NÊN: Dùng `curl --fail` (hoặc kiểm tra HTTP status) trước khi dùng một response
> - ✔️ NÊN: Tải về thành tệp, kiểm tra nó với checksum hoặc chữ ký, rồi mới chạy
> - ❌ TRÁNH: Không pipe thứ tải về vào shell: `curl ... | bash`, `wget -O- ... | sh`

Không có `--fail`, curl thoát với 0 khi gặp 404 hay 500 và trả trang lỗi về như thể đó là nội dung. Khi pipe vào `bash`, trang đó — hoặc một lần tải bị cắt giữa chừng, hoặc bất cứ thứ gì kẻ tấn công trả về — được chạy từng dòng trước khi có gì kiểm tra nó, và một dòng dở dang có thể làm điều mà không script hoàn chỉnh nào làm.

**Nên dùng**

```sh
local installer
dybatpho::create_temp installer ".sh"
curl --fail -sSL "${url}" -o "${installer}"
dybatpho::verify_checksum "${installer}" "sha256:${expected_sha256}"
bash "${installer}"
```

**Không nên dùng**

```sh
# Một trang 404, hay một script bị cắt cụt, được chạy ngay khi nó tới
curl -sSL "${url}" | bash
```

### Lệnh đã lỗi thời

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Dùng lệnh thay thế hiện hành: keyring `signed-by` cho apt, `grep -E` và `grep -F`, `command -v`, `ip`, `mktemp`
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
> - ✔️ NÊN: Tạo tệp tạm bằng `dybatpho::create_temp <var> <suffix>` và thư mục tạm bằng `dybatpho::create_temp_dir <var>`, chúng tự đăng ký việc dọn dẹp. (dybatpho)
> - ✔️ NÊN: Dùng `mktemp` khi không có thư viện, và xóa tệp bằng `trap 'rm -f "${temp_file}"' EXIT`
> - ✔️ NÊN: Đặt cho tệp tạm đúng phần mở rộng mà nội dung cần, để các công cụ phân loại theo đuôi tệp vẫn hoạt động
> - ✔️ NÊN: Chỉ dựng tệp staging cạnh đích từ một đường dẫn đã kiểm tra là không rỗng và không phải thư mục, và tạo nó độc quyền: `set -C`, hoặc `mktemp` trong thư mục của đích
> - ✔️ NÊN: Tạo tệp trong thư mục dùng chung bằng `mktemp`, hoặc tự đặt tên với hậu tố ngẫu nhiên dưới noclobber (`set -C`), để một tên đã tồn tại bị từ chối
> - ❌ TRÁNH: Không tự dựng đường dẫn tạm từ `$$`, từ dấu thời gian hay từ một tên cố định
> - ❌ TRÁNH: Không để việc dọn dẹp ở dòng cuối script, nơi mà một lỗi sẽ không bao giờ chạy tới
> - ❌ TRÁNH: Không trap `INT` hay `TERM` bằng một bước dọn dẹp không thoát: script sẽ chạy tiếp sau Ctrl-C
> - ❌ TRÁNH: Không để một đường dẫn rỗng hay hỏng biến tệp staging thành một tệp trong thư mục làm việc
> - ❌ TRÁNH: Không mở một tên trong thư mục dùng chung bằng `>` trơn: nó đi theo liên kết tượng trưng được đặt sẵn ở đó, kể cả khi tên có `$$` hay `$BASHPID`

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

### Ghi nguyên tử

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Ghi nội dung mới vào một tệp staging trong thư mục của đích, rồi `mv` nó đè lên đích
> - ✔️ NÊN: Công bố các tệp mô tả một tệp — sidecar checksum, chỉ mục — trước chính tệp đó
> - ❌ TRÁNH: Không ghi lại một tệp tại chỗ bằng `>` hay `>>` khi tiến trình khác có thể đang đọc nó
> - ❌ TRÁNH: Không đặt tệp staging ở thư mục khác: `mv` giữa hai hệ thống tệp là sao chép, không phải đổi tên

Người đọc mở một tệp đang bị ghi lại bằng `>` sẽ thấy nó rỗng hoặc ghi dở, và một lần sập sẽ để nó lại như vậy. `rename()` trong cùng một hệ thống tệp thay tên chỉ trong một bước, nên người đọc thấy hoặc tệp cũ hoặc tệp mới. Thứ tự giữa các tệp cũng quan trọng: một bản sao lưu được chuyển vào chỗ trước khi checksum của nó được ghi, trong chốc lát hoặc mãi mãi, là một bản sao lưu không qua được bước kiểm tra.

**Nên dùng**

```sh
local staging
staging="$(mktemp "$(dirname -- "${path}")/.staging.XXXXXXXX")"
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
> - ✔️ NÊN: Ưu tiên một helper có bảo vệ, kiểm tra đường dẫn và xác nhận trước khi hành động. (dybatpho)
> - ❌ TRÁNH: Không chạy `rm -r`, `find ... -delete`, `chmod -R`, `chown -R` hay `mv` đè lên một đích có sẵn với đường dẫn dựng từ các biến chưa từng được kiểm tra
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

## Kiểm thử

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Mỗi thư viện có một tệp kiểm thử tương ứng, `scripts/test/<area>.bats` đặt cạnh `scripts/lib/<area>.sh`, viết bằng [bats](https://github.com/bats-core/bats-core). (tùy chỉnh)
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
> - ✔️ NÊN: Truyền `-` khi một assertion đọc giá trị mong đợi từ here-document: `assert_output - << EOF`
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
> - ✔️ NÊN: Xóa trạng thái kế thừa mà bộ test có thể tác động lên, trong helper dùng chung của test: `GIT_DIR`, `GIT_INDEX_FILE`, `GIT_WORK_TREE`, `FORCE_COLOR`, `NO_COLOR`
> - ✔️ NÊN: Tạo mọi fixture trong thư mục tạm riêng của test (`BATS_TEST_TMPDIR`)
> - ✔️ NÊN: Khởi chạy shell con từ một tệp script thay vì `bash -c` khi có đo coverage
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
