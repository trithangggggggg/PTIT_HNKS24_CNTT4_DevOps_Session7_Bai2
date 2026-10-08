# PTIT_HNKS24_CNTT4_DevOps_Session7_Bai2

## Bài 2: Quản trị Tường lửa UFW cho Cụm Dịch vụ Multi-port

## 1. Mục tiêu & Bối cảnh
- Thiết lập tường lửa **UFW** (Uncomplicated Firewall) trên Ubuntu/Debian để bảo vệ hệ thống chạy nhiều dịch vụ:
  - **SSH** (port 22/tcp): Cho phép truy cập quản trị máy chủ từ xa.
  - **Nginx Web** (port 80/tcp): Cho phép truy cập web từ Internet.
  - **Spring Boot** (port 8082/tcp): Cho phép kiểm thử ứng dụng từ bên ngoài.
  - **MySQL** (port 3306/tcp): Cô lập hoàn toàn, không mở ra Internet để đảm bảo an toàn dữ liệu.

---

## 2. Các bước cấu hình

### Bước 1: Khai báo chính sách mặc định
Chặn toàn bộ lưu lượng đến (incoming) và cho phép lưu lượng đi ra (outgoing):
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### Bước 2: Cho phép các cổng dịch vụ cần thiết
```bash
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 8082/tcp
```
> *Lưu ý: Không tạo rule cho port 3306 (MySQL), do chính sách mặc định là `deny incoming` nên port này sẽ tự động bị chặn từ bên ngoài.*

### Bước 3: Kích hoạt UFW
```bash
sudo ufw enable
```

---

## 3. Kiểm tra kết quả

Chạy lệnh kiểm tra trạng thái chi tiết của tường lửa:
```bash
sudo ufw status verbose
```

### Output thực tế:
```text
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere                  
80/tcp                     ALLOW IN    Anywhere                  
8082/tcp                   ALLOW IN    Anywhere                  
22/tcp (v6)                ALLOW IN    Anywhere (v6)             
80/tcp (v6)                ALLOW IN    Anywhere (v6)             
8082/tcp (v6)              ALLOW IN    Anywhere (v6)             
```

---

## 4. Đánh giá & Kết luận
- **Trạng thái**: Tường lửa đang ở trạng thái `active`.
- **Lưu lượng vào**: Mặc định bị từ chối (`Default: deny (incoming)`).
- **Các cổng được phép**: Cổng 22, 80 và 8082 được phép truy cập từ mọi nguồn (`Anywhere`).
- **Bảo mật cơ sở dữ liệu**: Cổng 3306 (MySQL) không có trong danh sách cho phép, hoàn toàn được cô lập khỏi Internet, bảo vệ hệ thống trước các cuộc tấn công quét cổng (port scanning).
