# Hệ thống Quản lý Bếp Trung Tâm và Cửa hàng Franchise

## Central Kitchen and Franchise Store Management System – BackendBackend

---

## Thông tin đề tài

-   **Mã đề tài:** SP26SWP07
-   **Tên đề tài:**  
    Hệ thống Quản lý Bếp Trung Tâm và Cửa hàng Franchise  
    (Central Kitchen and Franchise Store Management System)
-   **Nhóm thực hiện:**
-   **Repository:** Frontend

---

## Mô tả tổng quan

Trong mô hình kinh doanh chuỗi (franchise), **bếp trung tâm** đóng vai trò sản xuất, sơ chế và cung ứng nguyên liệu hoặc thành phẩm cho nhiều cửa hàng nhượng quyền.

Việc quản lý **đơn hàng nội bộ, tồn kho, sản xuất, phân phối và kiểm soát chất lượng** giữa bếp trung tâm và các cửa hàng đòi hỏi một **hệ thống phần mềm tập trung**, hoạt động **chính xác và theo thời gian thực** nhằm:

-   Đảm bảo đồng bộ vận hành
-   Giảm lãng phí
-   Duy trì chất lượng sản phẩm
-   Nâng cao hiệu quả quản lý toàn chuỗi franchise

---

## Vấn đề thực tế

Trong thực tế, nhiều chuỗi franchise hiện nay vẫn quản lý bếp trung tâm và cửa hàng bằng các **công cụ rời rạc** như Excel, giấy tờ hoặc phần mềm đơn lẻ, dẫn đến nhiều hạn chế:

-   Thiếu đồng bộ thông tin tồn kho, đơn đặt hàng và kế hoạch sản xuất
-   Dự báo nhu cầu kém chính xác, gây thiếu hoặc dư nguyên liệu
-   Khó kiểm soát chất lượng, hạn sử dụng và truy xuất nguồn gốc
-   Quy trình giao nhận giữa bếp trung tâm và cửa hàng thiếu minh bạch
-   Nhà quản lý khó theo dõi hiệu quả vận hành toàn hệ thống

Những vấn đề này ảnh hưởng trực tiếp đến **chi phí**, **chất lượng dịch vụ** và **khả năng mở rộng hệ thống franchise**.

---

## Mục tiêu hệ thống

-   Xây dựng hệ thống quản lý tập trung cho bếp trung tâm và cửa hàng franchise
-   Hỗ trợ vận hành theo thời gian thực
-   Tăng tính minh bạch trong sản xuất, phân phối và tồn kho
-   Cung cấp giao diện quản lý trực quan, dễ sử dụng
-   Hỗ trợ báo cáo và ra quyết định cho nhà quản lý

---

## Đối tượng sử dụng (Actors)

-   **Franchise Store Staff** – Nhân viên cửa hàng
-   **Central Kitchen Staff** – Nhân viên bếp trung tâm
-   **Supply Coordinator** – Điều phối cung ứng
-   **Manager** – Quản lý vận hành
-   **Admin** – Quản trị hệ thống

---

## Chức năng theo vai trò

### Franchise Store Staff (Nhân viên cửa hàng)

-   Tạo đơn đặt hàng nguyên liệu / bán thành phẩm từ bếp trung tâm
-   Theo dõi trạng thái xử lý và giao hàng
-   Xác nhận đã nhận hàng và phản hồi chất lượng
-   Xem tồn kho hiện tại tại cửa hàng

---

### Central Kitchen Staff (Nhân viên bếp trung tâm)

-   Tiếp nhận và xử lý đơn đặt hàng từ các cửa hàng franchise
-   Lập kế hoạch sản xuất theo nhu cầu tổng hợp
-   Cập nhật trạng thái sản xuất và xuất kho
-   Quản lý nguyên liệu đầu vào, hạn sử dụng và lô sản xuất

---

### Supply Coordinator (Điều phối cung ứng)

-   Tổng hợp và phân loại đơn đặt hàng
-   Điều phối sản xuất và phân phối hàng hóa
-   Lập lịch giao hàng và theo dõi tiến độ vận chuyển
-   Xử lý các vấn đề phát sinh (thiếu hàng, giao trễ, hủy đơn)

---

### Manager (Quản lý vận hành)

-   Quản lý danh mục sản phẩm, công thức và định mức nguyên liệu
-   Quản lý tồn kho bếp trung tâm và cửa hàng
-   Theo dõi hiệu suất sản xuất, phân phối và bán hàng
-   Thống kê và báo cáo chi phí, hao hụt và hiệu quả vận hành

---

### Admin (Quản trị hệ thống)

-   Quản lý người dùng và phân quyền theo vai trò
-   Cấu hình hệ thống (đơn vị tính, quy trình, tham số vận hành)
-   Quản lý danh mục cửa hàng franchise và bếp trung tâm
-   Xem báo cáo tổng hợp toàn hệ thống

---

## Phạm vi Frontend

-   Giao diện đăng nhập và phân quyền
-   Dashboard tổng quan
-   Quản lý đơn đặt hàng
-   Quản lý tồn kho
-   Theo dõi trạng thái sản xuất và giao hàng
-   Giao diện báo cáo, thống kê
-   Thiết kế responsive, thân thiện người dùng

---

