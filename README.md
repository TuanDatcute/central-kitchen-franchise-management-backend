# Hệ thống Quản lý Bếp Trung Tâm và Cửa hàng Franchise  
## Central Kitchen and Franchise Store Management System – Backend

---

##  Thông tin đề tài
- **Tên đề tài:**  
  Hệ thống Quản lý Bếp Trung Tâm và Cửa hàng Franchise  
  (Central Kitchen and Franchise Store Management System)
- **Nhóm thực hiện:**   
- **Repository:** Backend

---

##  Mô tả tổng quan
Backend của hệ thống chịu trách nhiệm xử lý **nghiệp vụ cốt lõi**, **luồng dữ liệu**, **phân quyền**, và **kết nối cơ sở dữ liệu** giữa bếp trung tâm và các cửa hàng franchise.

Hệ thống backend đóng vai trò:
- Trung tâm xử lý logic nghiệp vụ
- Đảm bảo tính nhất quán dữ liệu
- Cung cấp API cho Frontend
- Kiểm soát bảo mật và phân quyền người dùng

---

##  Mục tiêu Backend
- Xây dựng hệ thống xử lý nghiệp vụ tập trung
- Đảm bảo dữ liệu chính xác, đồng bộ theo thời gian thực
- Hỗ trợ nhiều vai trò người dùng với phân quyền rõ ràng
- Cung cấp API ổn định, dễ mở rộng
- Hỗ trợ báo cáo và phân tích dữ liệu vận hành

---

##  Đối tượng sử dụng (Actors)
- Franchise Store Staff
- Central Kitchen Staff
- Supply Coordinator
- Manager
- Admin

---

##  Chức năng nghiệp vụ chính

###  Quản lý người dùng & phân quyền
- Đăng nhập, xác thực và phân quyền theo vai trò
- Quản lý tài khoản người dùng
- Kiểm soát truy cập theo chức năng

---

###  Quản lý đơn đặt hàng nội bộ
- Tạo và xử lý đơn đặt hàng từ cửa hàng franchise
- Theo dõi trạng thái đơn hàng
- Hỗ trợ hủy, điều chỉnh và phản hồi đơn hàng
- Lưu lịch sử giao dịch và trạng thái

---

###  Quản lý sản xuất (Bếp trung tâm)
- Tổng hợp nhu cầu từ các cửa hàng
- Lập kế hoạch sản xuất
- Quản lý lô sản xuất, hạn sử dụng
- Cập nhật trạng thái sản xuất

---

###  Quản lý tồn kho
- Quản lý tồn kho bếp trung tâm và cửa hàng
- Theo dõi nhập – xuất – tồn
- Cảnh báo tồn kho thấp hoặc quá hạn
- Hỗ trợ truy xuất nguồn gốc nguyên liệu

---

###  Điều phối và phân phối
- Lập lịch giao hàng
- Theo dõi tiến độ vận chuyển
- Ghi nhận giao nhận hàng hóa
- Xử lý sự cố trong quá trình phân phối

---

###  Báo cáo & thống kê
- Báo cáo sản xuất, tồn kho, phân phối
- Thống kê chi phí, hao hụt
- Phân tích hiệu quả vận hành
- Cung cấp dữ liệu cho dashboard frontend

---

##  Công nghệ sử dụng
- **Ngôn ngữ:** Java
- **Framework:** Spring Boot
- **Database:**  SQL Server
- **ORM:** JPA / Hibernate
- **Authentication:** JWT / Session-based
- **API:** RESTful API
- **Build Tool:** Maven / Gradle / npm

---

## 🗄️ Thiết kế hệ thống
- Kiến trúc: Layered Architecture / MVC
- Phân tách rõ:
  - Controller
  - Service
  - Repository / DAO
  - Entity / Model
- Hỗ trợ mở rộng và bảo trì lâu dài

---

## 📁 Cấu trúc thư mục
src/
├── controller/ # Xử lý request từ frontend
├── service/ # Logic nghiệp vụ
├── repository/ # Truy cập cơ sở dữ liệu
├── entity/ # Định nghĩa bảng dữ liệu
├── dto/ # Data Transfer Object
├── config/ # Cấu hình hệ thống
└── Application.java
