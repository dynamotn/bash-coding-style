<!-- vim: set nospell: -->
# bash-coding-style

[English](README.md) | [Tiếng Việt](README.vi.md)

Phong cách lập trình Bash này không phải là tuyệt đối, bạn có thể không tuân thủ nó nếu cần thiết. Mục đích của tôi khi lập phong cách này là giảm bớt các rào cản tâm lý để viết các kịch bản (script) Bash và cung cấp câu trả lời cho các vấn đề phổ biến gặp phải khi viết các kịch bản Bash. Các kịch bản Bash thường gây khó xử, khó duy trì và có thể dễ dàng trở nên bị ghét. Tuy nhiên, việc viết kịch bản Bash đôi khi là cần thiết, vì vậy tài liệu phong cách này đã được viết ra.

Khi cảm thấy không chắc chắn thì hãy ưu tiên tính nhất quán trước. Bằng cách sử dụng một kiểu duy nhất một cách nhất quán trong suốt các đoạn mã, bạn có thể tập trung vào các vấn đề khác quan trọng hơn. Tính nhất quán cũng cho phép tự động hóa. Trong nhiều trường hợp, quy tắc `duy trì tính nhất quán` có nghĩa là `chọn một thứ và ngừng lo lắng về nó`. Giá trị tiềm năng của việc cho phép sự linh hoạt này vượt trội so với chi phí để mọi người tranh cãi về chúng. Tuy nhiên, có những giới hạn cần thống nhất. Tính nhất quán là một yếu tố tốt để đưa ra quyết định khi không có lập luận kỹ thuật rõ ràng hoặc định hướng dài hạn. Mặt khác, tính nhất quán không nên được sử dụng để biện minh cho việc tiếp tục với một phong cách lỗi thời khi có những lợi thế rõ ràng cho người mới.

## Mục lục

<!-- toc -->

- [Giới thiệu](#gi%E1%BB%9Bi-thi%E1%BB%87u)
  - [Thư viện hỗ trợ](#th%C6%B0-vi%E1%BB%87n-h%E1%BB%97-tr%E1%BB%A3)
- [Bối cảnh](#b%E1%BB%91i-c%E1%BA%A3nh)
  - [Nên sử dụng shell nào](#nen-s%E1%BB%AD-d%E1%BB%A5ng-shell-nao)
  - [Khi nào nên sử dụng shell](#khi-nao-nen-s%E1%BB%AD-d%E1%BB%A5ng-shell)
- [Tệp shell và cách thực thi trình thông dịch](#t%E1%BB%87p-shell-va-cach-th%E1%BB%B1c-thi-trinh-thong-d%E1%BB%8Bch)
  - [Phần mở rộng tệp](#ph%E1%BA%A7n-m%E1%BB%9F-r%E1%BB%99ng-t%E1%BB%87p)
  - [SUID/SGID](#suidsgid)
- [Môi trường](#moi-tr%C6%B0%E1%BB%9Dng)
  - [STDOUT và STDERR](#stdout-va-stderr)
  - [Hàm sử dụng chung](#ham-s%E1%BB%AD-d%E1%BB%A5ng-chung)
- [Chú thích](#chu-thich)
  - [Phần đầu file](#ph%E1%BA%A7n-d%E1%BA%A7u-file)
  - [Chú thích hàm](#chu-thich-ham)
  - [Chú thích triển khai](#chu-thich-tri%E1%BB%83n-khai)
  - [TODO Comments](#todo-comments)

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
DYBATPHO_DIR=<path to dybatpho>
. "$DYBATPHO_DIR/init.sh"
```

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

Sử dụng `set` cho cài đặt tùy chọn shell đảm bảo rằng ngay cả khi script được gọi bằng `bash script_name`, chức năng của nó không bị suy giảm. `set -euo pipefail` tự động phát hiện lỗi sớm và kết thúc script nếu xảy ra lỗi. `set -e` kết thúc script nếu xảy ra lỗi. `set -u` kích hoạt lỗi khi tham chiếu đến các biến không xác định. `set -o pipefail` kết thúc script nếu xảy ra lỗi ở giữa pipeline.

**Kiến nghị**

```shell
#!/usr/bin/env bash
set -euo pipefail
# Nếu không dùng dybatpho

#!/usr/bin/env bash
DYBATPHO_DIR=<path to dybatpho>
. "$DYBATPHO_DIR/init.sh"
# Nếu dùng dybatpho
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

### Khi nào nên sử dụng shell

> [!NOTE]
Quy tắc tùy chỉnh

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

**Được khuyến nghị**

```shell
# Sử dụng sudo khi gọi (Trừ trong CI)
sudo ./foo.sh
```

**Không khuyến nghị**

```shell
# Chuyển sang người dùng su hoặc root bên trong script
```

## Môi trường

### STDOUT và STDERR

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Tất cả các thông báo lỗi và nghiêm trọng nên được chuyển đến `STDERR`
> - ✔️ NÊN: Sử dụng biến `LOG_LEVEL` để kiểm soát mức độ ghi log với 6 cấp độ: trace, debug, info, warn, error, fatal. (tùy chỉnh)
> - ✔️ NÊN: Triệt tiêu tất cả các thông báo không cần thiết vào `/dev/null`. (tùy chỉnh)
> - ✔️ NÊN: Sử dụng thư viện ghi log từ [dybatpho](https://github.com/dynamotn/dybatpho) để xuất các thông báo để ghi log tốt hơn. (dybatpho)

**Được khuyến nghị**

```shell
# thông báo lỗi đến stderr
echo "Error: Không thể thực hiện do_something" >&2

# mức log mặc định là info
LOG_LEVEL=info

# triệt tiêu các thông báo không cần thiết
curl -fsSL "$url" 2> /dev/null

# sử dụng dybatpho
dybatpho::error "Không thể thực hiện do_something"
dybatpho::debug "var_1 là ${var_1}"
dybatpho::start_trace
do_something
```

**Không nên**

```shell
# thông báo lỗi đến stdout
echo "LỖI: Không thể thực hiện do_something"

# hiển thị các thông báo không cần thiết
grep -rn "abc" README.md || echo "LỖI: README.md không có từ `abc`"
```

### Hàm sử dụng chung

> [!NOTE]
Quy tắc mới

> [!TIP]
>
> - ✔️ NÊN: Sử dụng `.` để gọi các hàm chung
> - ✔️ NÊN: Các hàm chung nên được để chung dưới dạng library trong thư mục con `lib`

Khi gọi các hàm chung, hãy sử dụng `.` thay vì `source`. Điều này là do `.` tuân thủ POSIX.

**Được khuyến nghị**

```shell
. "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

**Không nên**

```shell
# Sử dụng source
source "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

## Chú thích

### Phần đầu file

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Thêm một comment ở đầu file để giải thích ngắn gọn mục đích hoặc nội dung của file. Tuy nhiên, không thêm comment trước dòng shebang.
> - ✔️ NÊN: Sử dụng định dạng [shdoc](https://github.com/reconquest/shdoc) bao gồm: `@file`, `@brief`, `@description` để giải thích file. (tùy chỉnh)

Tất cả các file nên có một comment cấp cao nhất mô tả ngắn gọn nội dung của chúng.

**Đề xuất**

```shell
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
> - ✔️ NÊN: Sử dụng định dạng [shdoc](https://github.com/reconquest/shdoc) để giải thích hàm. (tùy chỉnh)

Người khác có thể học cách sử dụng chương trình của bạn hoặc sử dụng một hàm trong thư viện của bạn bằng cách đọc các comment (và tự tìm hiểu, nếu có) mà không cần đọc code.

Tất cả các comment header của hàm nên mô tả hành vi API dự kiến bằng cách sử dụng:

- `@description`: Mô tả về hàm.
- `@set`: Danh sách các biến toàn cục bị sửa đổi.
- `@arg`: Các tham số đầu vào. Nếu không có tham số, sử dụng `@noargs`.
- `@option`: Các option được sử dụng.
- `@stdout` và `@stderr`: Output ra STDOUT hoặc STDERR.
- `@exitcode`: Giá trị trả về của lệnh cuối cùng được chạy.

**Đề xuất**

```sh
#######################################
# @description Lấy đường dẫn thư mục cấu hình.
# @arg $1 string Đường dẫn của thư mục cấu hình
# @stdout Vị trí của thư mục cấu hình
# @stderr In ra 'Không có thư mục cấu hình' nếu lỗi
# @exitcode 0 Nếu thành công
# @exitcode 1 Nếu thư mục cấu hình không tồn tại
#######################################
function get_dir() {
  local config_dir=${1:-"$HOME/.config/abc"}
  if [ -e "$config_dir" ]; then
    echo "${config_dir}"
  else
    echo "Không có thư mục cấu hình" >&2 && return 1
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

**Đề xuất**

```shell
# TODO: Code này cần được sửa do xử lý lỗi không đầy đủ. Thêm kiểm tra lỗi và thoát với mã 1.
```
