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
  - [Cách gọi script](#cach-g%E1%BB%8Di-script)
  - [Kiểm soát tham số của script](#ki%E1%BB%83m-soat-tham-s%E1%BB%91-c%E1%BB%A7a-script)
  - [Chế độ gỡ lỗi và chạy thử](#ch%E1%BA%BF-d%E1%BB%99-g%E1%BB%A1-l%E1%BB%97i-va-ch%E1%BA%A1y-th%E1%BB%AD)
  - [STDOUT và STDERR](#stdout-va-stderr)
  - [Hàm sử dụng chung](#ham-s%E1%BB%AD-d%E1%BB%A5ng-chung)
- [Quy ước đặt tên](#quy-%C6%B0%E1%BB%9Bc-d%E1%BA%B7t-ten)
  - [Tên hàm](#ten-ham)
  - [Tên biến](#ten-bi%E1%BA%BFn)
- [Chú thích](#chu-thich)
  - [Phần đầu file](#ph%E1%BA%A7n-d%E1%BA%A7u-file)
  - [Chú thích hàm](#chu-thich-ham)
  - [Chú thích triển khai](#chu-thich-tri%E1%BB%83n-khai)
  - [TODO Comments](#todo-comments)
- [Định dạng](#d%E1%BB%8Bnh-d%E1%BA%A1ng)
  - [Dấu tab và dấu cách](#d%E1%BA%A5u-tab-va-d%E1%BA%A5u-cach)
  - [Độ dài dòng code và chuỗi dài](#d%E1%BB%99-dai-dong-code-va-chu%E1%BB%97i-dai)
  - [Pipelines (Đường ống)](#pipelines-d%C6%B0%E1%BB%9Dng-%E1%BB%91ng)
  - [Luồng điều khiển](#lu%E1%BB%93ng-di%E1%BB%81u-khi%E1%BB%83n)
  - [Câu lệnh case](#cau-l%E1%BB%87nh-case)
  - [Khai triển biến](#khai-tri%E1%BB%83n-bi%E1%BA%BFn)
  - [Dấu nháy](#d%E1%BA%A5u-nhay)
  - [Khai báo hàm](#khai-bao-ham)
- [Tính năng và lỗi](#tinh-nang-va-l%E1%BB%97i)
  - [Sử dụng ShellCheck](#s%E1%BB%AD-d%E1%BB%A5ng-shellcheck)
  - [Thay thế lệnh](#thay-th%E1%BA%BF-l%E1%BB%87nh)
  - [Biểu thức kiểm tra](#bi%E1%BB%83u-th%E1%BB%A9c-ki%E1%BB%83m-tra)
  - [Kiểm tra chuỗi](#ki%E1%BB%83m-tra-chu%E1%BB%97i)
  - [Khai triển ký tự đại diện cho tên tệp](#khai-tri%E1%BB%83n-ky-t%E1%BB%B1-d%E1%BA%A1i-di%E1%BB%87n-cho-ten-t%E1%BB%87p)
  - [Eval là xấu xa](#eval-la-x%E1%BA%A5u-xa)
  - [Mảng](#m%E1%BA%A3ng)
  - [Đường ống vào while](#d%C6%B0%E1%BB%9Dng-%E1%BB%91ng-vao-while)
  - [Vòng lặp for](#vong-l%E1%BA%B7p-for)
  - [Số học](#s%E1%BB%91-h%E1%BB%8Dc)
- [Gọi lệnh](#g%E1%BB%8Di-l%E1%BB%87nh)
  - [Kiểm tra giá trị trả về](#ki%E1%BB%83m-tra-gia-tr%E1%BB%8B-tr%E1%BA%A3-v%E1%BB%81)
  - [Xử lý lỗi](#x%E1%BB%AD-ly-l%E1%BB%97i)
  - [Lệnh dựng sẵn và lệnh bên ngoài](#l%E1%BB%87nh-d%E1%BB%B1ng-s%E1%BA%B5n-va-l%E1%BB%87nh-ben-ngoai)
- [Ổn định hóa script](#%E1%BB%95n-d%E1%BB%8Bnh-hoa-script)
  - [Viết script chạy lại được](#vi%E1%BA%BFt-script-ch%E1%BA%A1y-l%E1%BA%A1i-d%C6%B0%E1%BB%A3c)
  - [Kiểm tra trạng thái trước khi thay đổi](#ki%E1%BB%83m-tra-tr%E1%BA%A1ng-thai-tr%C6%B0%E1%BB%9Bc-khi-thay-d%E1%BB%95i)
  - [Tạo tệp tạm an toàn](#t%E1%BA%A1o-t%E1%BB%87p-t%E1%BA%A1m-an-toan)
- [Kiểm thử](#ki%E1%BB%83m-th%E1%BB%AD)

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

**Nên dùng**

```sh
#!/usr/bin/env bash
set -euo pipefail
# Nếu không dùng dybatpho

#!/usr/bin/env bash
DYBATPHO_DIR=<path to dybatpho>
. "$DYBATPHO_DIR/init.sh"
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
Quy tắc tùy chỉnh

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
Quy tắc tùy chỉnh

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
  dybatpho::is command "$name" || dybatpho::dry_run dytoy -t "$name"
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
Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Để người gọi chọn mức chi tiết của log bằng tùy chọn `--log-level` gắn với `LOG_LEVEL`, kiểm tra bằng `dybatpho::validate_log_level`. (dybatpho)
> - ✔️ NÊN: Bật theo vết lệnh bằng `dybatpho::start_trace` thay vì viết `set -x` trực tiếp, và tắt bằng `dybatpho::end_trace`. (dybatpho)
> - ✔️ NÊN: Chạy mọi lệnh làm thay đổi trạng thái qua `dybatpho::dry_run`, để chế độ chạy thử chỉ in ra lệnh thay vì thực thi nó. (dybatpho)
> - ✔️ NÊN: Ưu tiên chế độ chạy thử do chính công cụ cung cấp, như `chezmoi diff` hay `kubectl --dry-run=server`, hơn là tự in lệnh ra
> - ⚠️ CÂN NHẮC: Đặt chạy thử làm mặc định cho script mà lần chạy thật có tính phá hủy. (tùy chỉnh)

Một script có thể được hỏi rằng nó *sẽ* làm gì là một script mà người ta dám chạy trên máy họ quan tâm. Bọc lệnh thay đổi trạng thái, thay vì rẽ nhánh quanh nó, giúp đường chạy thử và đường chạy thật giống hệt nhau cho tới bước cuối, nên lần chạy thử đi qua đúng những điều kiện và đúng những tham số đó.

**Nên dùng**

```sh
# Hàm bọc tự quyết định là chạy hay chỉ báo cáo
dybatpho::dry_run mv "$temp_file" "$output_path"
dybatpho::dry_run chmod +x "$output_path"

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

### STDOUT và STDERR

> [!NOTE]
> Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Tất cả các thông báo lỗi và nghiêm trọng nên được chuyển đến `STDERR`
> - ✔️ NÊN: Sử dụng biến `LOG_LEVEL` để kiểm soát mức độ ghi log với 6 cấp độ: trace, debug, info, warn, error, fatal. (tùy chỉnh)
> - ✔️ NÊN: Triệt tiêu tất cả các thông báo không cần thiết vào `/dev/null`. (tùy chỉnh)
> - ✔️ NÊN: Sử dụng thư viện ghi log từ [dybatpho](https://github.com/dynamotn/dybatpho) để xuất các thông báo để ghi log tốt hơn. (dybatpho)

**Nên dùng**

```sh
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

**Không nên dùng**

```sh
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

**Nên dùng**

```sh
. "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

**Không nên**

```sh
# Sử dụng source
source "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

## Quy ước đặt tên

### Tên hàm

> [!NOTE]
Quy tắc tùy chỉnh

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
Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Viết tên biến cục bộ và biến thường bằng chữ thường, các từ ngăn cách bằng dấu gạch dưới
> - ✔️ NÊN: Khai báo mọi biến dùng trong hàm bằng `local`, và khai báo mảng cục bộ bằng `local -a name=()`
> - ✔️ NÊN: Dùng `CHỮ HOA` cho biến do bên gọi đặt: tùy chọn của script, biến môi trường được xuất ra và hằng số
> - ✔️ NÊN: Đặt hằng số ở đầu tệp và cho nó thuộc tính chỉ đọc bằng `readonly` hoặc `declare -r`
> - ✔️ NÊN: Đặt tên biến lặp theo tập hợp mà nó duyệt: `for tool in "${tools[@]}"`
> - ❌ TRÁNH: Không khai báo và gán từ một lệnh thay thế trên cùng một dòng

`local name="$(some_command)"` làm mất mã thoát của `some_command`, vì mã thoát của cả dòng là mã thoát của `local`, mà `local` thì luôn thành công. Dưới `set -e`, điều đó biến một lệnh thất bại thành một biến rỗng trong im lặng. Tách làm hai dòng giữ cho lỗi vẫn hiện ra.

**Nên dùng**

```sh
# Hằng số đặt trước, chỉ đọc
readonly SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

function dytoy::install {
  local name
  dybatpho::expect_args name -- "$@"

  # Khai báo trước, gán sau, để lỗi không bị nuốt mất
  local version
  version="$(dytoy::get_yaml "$name" "version")"

  local -a dependencies=()
  readarray -t dependencies < <(dytoy::get_yaml "$name" "dependencies")
  for dependency in "${dependencies[@]}"; do
    dytoy::install "$dependency"
  done
}
```

**Không nên dùng**

```sh
# Mã thoát của lệnh thay thế bị mất
local version="$(dytoy::get_yaml "$name" "version")"

# Vô tình thành biến toàn cục, rò rỉ sang mọi hàm được gọi sau đó
version="1.2.3"

# Chữ hoa cho thứ mà bên gọi không bao giờ đặt
NAME="$1"

# Biến lặp không nói lên điều gì
for i in "${tools[@]}"; do
  install "$i"
done
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
> - ✔️ NÊN: Sử dụng định dạng [shdoc](https://github.com/reconquest/shdoc) để giải thích hàm. (tùy chỉnh)

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

**Nên dùng**

```sh
# TODO: Code này cần được sửa do xử lý lỗi không đầy đủ. Thêm kiểm tra lỗi và thoát với mã 1.
```

## Định dạng

### Dấu tab và dấu cách

> [!NOTE]
Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Thụt lề bằng hai dấu cách. Không sử dụng dấu tab.
> - ✔️ NÊN: Chèn dòng trống giữa các khối mã để tăng tính dễ đọc.
> - ✔️ NÊN: Không bao gồm khoảng trắng ở cuối dòng. (tùy chỉnh)

Thụt lề nên dùng hai dấu cách. Tuyệt đối không được sử dụng dấu tab.

Nhiều trình soạn thảo không thể chuyển đổi giữa thụt lề thực tế và hiển thị dấu cách/tab theo tùy chọn của người dùng. Cài đặt trình soạn thảo của người khác có thể không giống với của bạn. Sử dụng dấu cách đảm bảo rằng mã trông giống nhau trong mọi trình soạn thảo.

### Độ dài dòng code và chuỗi dài

> [!NOTE]
Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Độ dài dòng tối đa là 120 ký tự. (tùy chỉnh)
> - ✔️ NÊN: Cân nhắc sử dụng here document hoặc ký tự xuống dòng trong chuỗi quá dài. (tùy chỉnh)
> - ⚠️ CÂN NHẮC: Tìm cách rút ngắn các chuỗi ký tự.

Không có độ dài dòng tối đa hoặc quy tắc ngắt dòng tại N ký tự. Tuy nhiên, nếu bạn cần viết các chuỗi quá dài, hãy cân nhắc sử dụng here document hoặc ký tự xuống dòng nếu có thể. Mặc dù cho phép sự hiện diện của các chuỗi ký tự không thể chia nhỏ một cách thích hợp, nhưng bạn nên tìm cách rút ngắn chúng.

**Nên dùng**

```sh
# Sử dụng here document
cat <<END
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
> - ⚠️ CÂN NHẮC: Đối với các case lệnh ngắn, hãy cân nhắc đặt pattern, action và `;;` trên một dòng nếu duy trì được tính dễ đọc

Thụt các điều kiện vào một cấp so với `case` và `esac`. Đối với các action nhiều dòng, thụt thêm một cấp nữa. Không nên có dấu ngoặc đơn mở trước biểu thức pattern. Tránh sử dụng `;&` hoặc `;;&`.

**Nên dùng**

```sh
case "${expression}" in
  "--a")
    _VARIABLE_="..."
    ;;
  "--absolute")
    _ACTIONS="relative"
    ;;
  *) shift ;;
esac
```

Đối với các lệnh đơn giản, hãy đặt pattern và `;;` trên cùng một dòng nếu duy trì được tính dễ đọc. Nếu action không vừa trên một dòng, hãy đặt pattern trên dòng riêng của nó, sau đó là action trên dòng tiếp theo và sau đó là `;;` trên dòng riêng của nó. Khi đặt pattern trên cùng dòng với action, hãy thêm một khoảng trắng sau dấu ngoặc đơn đóng của pattern và trước `;;`.

### Khai triển biến

> [!TIP]
>
> - ✔️ NÊN: Sử dụng kiểu khai triển biến nhất quán
> - ✔️ NÊN: Đặt các khai triển biến trong dấu nháy kép. Dấu nháy đơn không khai triển biến
> - ❌ TRÁNH: Tránh đặt các biến đặc biệt/tham số vị trí của shell trong dấu ngoặc nhọn trừ khi thực sự cần thiết hoặc để tránh nhầm lẫn nghiêm trọng

Các biến nên được đặt trong dấu nháy kép. Sử dụng `${var}` thay vì `$var`, trừ khi biến là toàn bộ chuỗi trong dấu nháy kép.
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
echo "$PATH"
while read -r f; do
  echo "file=${f}"
done < <(find /tmp)
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

### Dấu nháy

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
FLAGS=( --foo --bar='baz' )
readonly FLAGS
mybinary "${FLAGS[@]}"

# Được chấp nhận nếu không dùng dấu nháy các biến số nguyên nội bộ.
if (( $# > 3 )); then
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

(set -- 1 "2 two" "3 three tres"; echo $#; set -- "$*"; echo "$#, $@")
(set -- 1 "2 two" "3 three tres"; echo $#; set -- "$@"; echo "$#, $@")
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
. "$SCRIPT_DIR/lib/dybatpho/init.sh" --modules cli
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
> - ✔️ NÊN: Thêm `enable=require-variable-braces` vào tệp `.shellcheckrc`. (tùy chỉnh)
> - ⚠️ CÂN NHẮC: Cân nhắc giải quyết tất cả các cảnh báo ShellCheck với mức độ nghiêm trọng từ "info" trở lên. (tùy chỉnh)
> - ⚠️ CÂN NHẮC: Nếu bạn không thể giải quyết các cảnh báo ShellCheck với mức độ nghiêm trọng "info", hãy cân nhắc thêm các chú thích `# shellcheck disable=SCXXXX` để bỏ qua chúng. (tùy chỉnh)

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

# Việc bỏ qua cảnh báo SC1091 cho đường dẫn nguồn chưa được giải quyết là chấp nhận được.
# shellcheck disable=SC1091
. "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

### Thay thế lệnh

> [!TIP]
>
> - ✔️ NÊN: Dùng `$(command)` để thay thế lệnh
> - ❌ TRÁNH: Không dùng dấu nháy ngược

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

### Biểu thức kiểm tra

> [!TIP]
>
> - ✔️ NÊN: Dùng `[[ ... ]]` để kiểm tra điều kiện
> - ✔️ NÊN: Dùng `dybatpho::is` cho những phép kiểm tra nó đã bao phủ, như `command`, `file`, `dir`, `true` và `blank`. (dybatpho)
> - ❌ TRÁNH: Không dùng `[ ... ]`, `test` hay `/usr/bin/[`

`[[ ... ]]` là từ khóa của shell chứ không phải một lệnh, nên nó không tách từ và không khai triển ký tự đại diện cho các toán hạng, đồng thời hỗ trợ `=~` và `&&`. Thiếu một dấu nháy trong `[ ... ]` là một lỗi; trong `[[ ... ]]` thì thường là không.

**Nên dùng**

```sh
if [[ ! -f "$SCRIPT_DIR/lib/dybatpho/init.sh" ]]; then
  git -C "$REPO_DIR" submodule update --init "$SCRIPT_DIR/lib/dybatpho"
fi

# Một phép kiểm tra có tên dễ đọc hơn là cờ mà nó bọc lại
dybatpho::is command "$name" || dybatpho::dry_run dytoy -t "$name"
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
if [[ "$identity" == "personal" ]]; then
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
> - ⚠️ CÂN NHẮC: Dùng `compgen -G` khi bạn cần các kết quả khớp như dữ liệu và chấp nhận kết quả rỗng. (tùy chỉnh)
> - ❌ TRÁNH: Không truyền `*` trần cho một lệnh

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

### Eval là xấu xa

> [!TIP]
>
> - ❌ TRÁNH: Không dùng `eval`

`eval` khiến ta không thể biết, chỉ bằng cách đọc script, lệnh nào sẽ chạy hay biến nào sẽ được gán. Khi cần thực thi một giá trị, hãy dùng mảng cho lệnh và tham số của nó, hoặc tham chiếu gián tiếp cho biến.

**Nên dùng**

```sh
local -a options=() packages=()
options+=(--noconfirm)
packages+=("$name")
dybatpho::dry_run pacman -S "${options[@]}" "${packages[@]}"
```

**Không nên dùng**

```sh
# Người đọc không biết nó khai triển thành gì, và một dấu cách trong $name sẽ làm hỏng nó
eval "pacman -S ${options} ${packages}"
```

### Mảng

> [!TIP]
>
> - ✔️ NÊN: Dùng mảng mỗi khi bạn giữ nhiều hơn một giá trị, nhất là các cờ dòng lệnh
> - ✔️ NÊN: Khai báo mảng một cách tường minh: `local -a names=()` trong hàm, `declare -a NAMES=()` ở phạm vi tệp
> - ✔️ NÊN: Thêm phần tử bằng `names+=("${value}")`
> - ✔️ NÊN: Khai triển bằng `"${names[@]}"`, và lấy số phần tử bằng `"${#names[@]}"`
> - ❌ TRÁNH: Không giữ nhiều giá trị trong một chuỗi ngăn cách bằng dấu cách

Một chuỗi ngăn cách bằng dấu cách chỉ là mảng chừng nào chưa có phần tử nào chứa dấu cách. Mảng thì luôn đúng dù các phần tử là gì, và `"${names[@]}"` truyền đi đúng bằng số phần tử đang có, kể cả khi không có phần tử nào.

**Nên dùng**

```sh
BUILD_ARGS=()
SECRETS=()
SECRETS+=(--secret "id=age_passphrases,env=AGE_PASSPHRASES")
BUILD_ARGS+=(--build-arg IDENTITIES="personal")
dybatpho::dry_run docker build "${BUILD_ARGS[@]}" "${SECRETS[@]}" .
```

**Không nên dùng**

```sh
# Hỏng ngay khi một giá trị chứa dấu cách, và dấu nháy không cứu được
BUILD_ARGS="--build-arg IDENTITIES=personal"
docker build $BUILD_ARGS .
```

### Đường ống vào while

> [!TIP]
>
> - ✔️ NÊN: Cấp dữ liệu cho vòng lặp `while read` bằng thay thế tiến trình: `while read -r line; do ...; done < <(command)`
> - ✔️ NÊN: Dùng `readarray -t` hoặc `mapfile -t` khi cần lấy toàn bộ kết quả thành một mảng
> - ✔️ NÊN: Dùng `read -r`, và dùng `mapfile -d ''` cùng `-print0` khi giá trị có thể chứa ký tự xuống dòng
> - ❌ TRÁNH: Không đưa đường ống vào vòng lặp `while`

Vế phải của đường ống chạy trong một shell con, nên mọi biến mà vòng lặp gán đều bị vứt đi khi vòng lặp kết thúc. Thay thế tiến trình giữ vòng lặp ở lại trong shell hiện tại.

**Nên dùng**

```sh
local -a files=()
mapfile -d '' -t files < <(command find "${root}" -type f -print0 | sort -z)

local -a tools=()
readarray -t tools < <(dytoy::get_yaml "$name" "tools")

local count=0
while read -r line; do
  count=$((count + 1))
done < <(command grep -c "" "${file}")
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
readarray -t dependencies < <(dytoy::get_yaml "$name" "dependencies")
for dependency in "${dependencies[@]}"; do
  dybatpho::dry_run dytoy "${method}" -i -t "$dependency"
done
```

**Không nên dùng**

```sh
# Một tên phụ thuộc có dấu cách sẽ biến thành hai vòng lặp
for dependency in $(dytoy::get_yaml "$name" "dependencies"); do
  dytoy "${method}" -i -t "$dependency"
done
```

### Số học

> [!TIP]
>
> - ✔️ NÊN: Dùng `(( ... ))` cho điều kiện số học và `$(( ... ))` cho giá trị số học
> - ✔️ NÊN: Bỏ dấu `$` trước tên biến bên trong `(( ... ))`
> - ✔️ NÊN: Khai báo biến đếm bằng `local -i` khi biến đó chỉ chứa số nguyên
> - ❌ TRÁNH: Không dùng `let`, `expr` hay cú pháp `$[ ... ]` đã lỗi thời
> - ⚠️ CÂN NHẮC: Cẩn thận với `(( ... ))` đứng một mình dưới `set -e`: biểu thức có giá trị `0` sẽ trả về mã thoát `1` và làm dừng script

`(( ... ))` là lệnh dựng sẵn, nên nhanh hơn `expr` và không cần tạo tiến trình con, đồng thời coi các toán hạng là số chứ không phải chuỗi.

**Nên dùng**

```sh
if ((${#MAIN_ARGS[@]} > 0)); then
  exec "${BATS_CMD}" "${MAIN_ARGS[@]}"
fi

local -i retries=0
retries=$((retries + 1))

# An toàn dưới set -e: phép tăng không quyết định mã thoát của cả dòng
((count++)) || true
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
## Gọi lệnh

### Kiểm tra giá trị trả về

> [!NOTE]
Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Để `set -Eeuo pipefail`, hoặc `dybatpho::register_common_handlers`, dừng script khi có lỗi không được xử lý. (dybatpho)
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
Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Xử lý lỗi ngay trong hàm nơi nó xảy ra, không đẩy lên cho bên gọi
> - ✔️ NÊN: Dừng bằng `dybatpho::die` khi script không thể tiếp tục, và `return 1` khi bên gọi còn xử lý được. (dybatpho)
> - ✔️ NÊN: Nói rõ cái gì hỏng và người dùng có thể làm gì, trong một thông báo trên `STDERR`
> - ✔️ NÊN: Cài đặt các trình xử lý chung một lần, ở đầu script thực thi, bằng `dybatpho::register_common_handlers`. (dybatpho)
> - ❌ TRÁNH: Không trả về mã khác `0` trần trụi mà không kèm thông báo

Hàm bị lỗi là nơi duy nhất còn biết tên tệp, địa chỉ URL và tùy chọn nào đã dẫn tới lỗi đó. Bên gọi chỉ nhận được số `1` thì hoặc là không báo được gì hữu ích, hoặc là phải bịa ra bối cảnh.

**Nên dùng**

```sh
if [[ ! -x "${BATS_CMD}" ]]; then
  dybatpho::die "Bats test runner not found. Install bats, or run: git -C ${DYBATPHO_DIR} submodule update --init --recursive"
fi

function get_dir {
  local config_dir
  dybatpho::expect_args config_dir -- "$@"
  if [[ ! -e "$config_dir" ]]; then
    dybatpho::error "Configuration directory ${config_dir} does not exist"
    return 1
  fi
  echo "${config_dir}"
}
```

**Không nên dùng**

```sh
# Bên gọi không có cách nào biết chuyện gì đã sai
function get_dir {
  [[ -e "$1" ]] || return 1
  echo "$1"
}
```

### Lệnh dựng sẵn và lệnh bên ngoài

> [!NOTE]
Quy tắc tùy chỉnh

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
## Ổn định hóa script

### Viết script chạy lại được

> [!NOTE]
Quy tắc tùy chỉnh

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
dybatpho::is command "$name" || dybatpho::dry_run dytoy -t "$name"

# Chỉ tải submodule khi nó còn thiếu
if [[ ! -f "$SCRIPT_DIR/lib/dybatpho/init.sh" ]]; then
  git -C "$REPO_DIR" submodule update --init "$SCRIPT_DIR/lib/dybatpho"
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
dybatpho::dry_run rm -rf "${profile_dir}"

# Kiểm tra tệp tải về trước khi đặt nó vào chỗ
binary::verify_sha256 "${name}" "${temp_file}" "${url}" "${sha256_asset}"
dybatpho::dry_run mv "$temp_file" "$output_path"
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
Quy tắc tùy chỉnh

> [!TIP]
>
> - ✔️ NÊN: Tạo tệp tạm bằng `dybatpho::create_temp <var> <suffix>` và thư mục tạm bằng `dybatpho::create_temp_dir <var>`, chúng tự đăng ký việc dọn dẹp. (dybatpho)
> - ✔️ NÊN: Dùng `mktemp` khi không có thư viện, và xóa tệp bằng `trap 'rm -f "${temp_file}"' EXIT`
> - ✔️ NÊN: Đặt cho tệp tạm đúng phần mở rộng mà nội dung cần, để các công cụ phân loại theo đuôi tệp vẫn hoạt động
> - ❌ TRÁNH: Không tự dựng đường dẫn tạm từ `$$`, từ dấu thời gian hay từ một tên cố định
> - ❌ TRÁNH: Không để việc dọn dẹp ở dòng cuối script, nơi mà một lỗi sẽ không bao giờ chạy tới

Một cái tên đoán trước được trong thư mục ai cũng ghi được vừa dễ đụng nhau vừa mở đường cho tấn công liên kết tượng trưng. Đăng ký việc dọn dẹp ngay lúc tạo là cách duy nhất để nó chạy trên những nhánh quan trọng: nhánh lỗi và nhánh bị ngắt.

**Nên dùng**

```sh
dybatpho::create_temp sha256_file ".txt"
dybatpho::curl_download "${sha256_url}" "${sha256_file}"

dybatpho::create_temp_dir temp_dir
tar -xf "${archive}" -C "${temp_dir}"

# Khi không có thư viện
temp_file="$(mktemp --suffix=.json)"
trap 'rm -f "${temp_file}"' EXIT INT TERM
```

**Không nên dùng**

```sh
# Đoán trước được, đụng nhau giữa hai lần chạy, và không bao giờ được dọn khi lỗi
temp_file="/tmp/download-$$.tar.gz"
curl -fsSL "$url" -o "$temp_file"
...
rm -f "$temp_file"
```
## Kiểm thử

> [!NOTE]
Quy tắc tùy chỉnh

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
setup() {
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
