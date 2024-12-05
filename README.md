# NHÓM 5 - HỆ QUẢN TRỊ CƠ SỞ DỮ LIỆU

# Hướng dẫn sử dụng:

**Bước 0**: Kết nối tới CSDL bằng tài khoản SYSTEM

**Bước 1**: Tạo Tablespace (tệp `tablespaces_and_profiles.sql`)

**Bước 2**: Tạo Profile (tệp `tablespaces_and_profiles.sql`)

**Bước 3**: Tạo User (tệp `privilages_and_users.sql`)

**Bước 4**: Tạo Role (tệp `privilages_and_users.sql`)

**Bước 5**: Gán Role cho User (tệp `privilages_and_users.sql`)

**Bước 6**: Tạo bảng:

- **Bước 6.1**: Đăng nhập với tài khoản (là thông tin của User).
- **Bước 6.2**: Chạy lệnh tạo bảng (tương ứng với Tablespace của User).

  **VD**: Đăng nhập bằng tài khoản `db_admin`, sau đó thực hiện tạo bảng ứng với tablespace `tb_internal`.

**Cụ thể các bảng gắn với tablespace:**

- **tb_internal**:

  - TaiKhoan (Thông tin người dùng)
  - BaiDang (Bài đăng)
  - HoiNhom (Nhóm)
  - PhongNhanTin (Tin nhắn)
  - BaoCao (Báo cáo)
  - TaiKhoanQuangCao (Quảng cáo của tài khoản)
  - ChienDich (Chiến dịch quảng cáo)
  - MucTieu (Mục tiêu chiến dịch)

- **tb_index**:

  - TaiKhoan_Dang_BaiDang (Quan hệ giữa người dùng và bài đăng)
  - TaiKhoan_TuongTac_BaiDang (Quan hệ giữa người dùng và bài đăng mà họ tương tác)
  - TaiKhoan_BinhLuan_BaiDang (Bình luận của người dùng trên bài đăng)
  - TaiKhoan_QuanLy_BaiDang (Quan hệ giữa người dùng và bài đăng mà họ quản lý)
  - TaiKhoan_Lap_HoiNhom (Quan hệ giữa người dùng và nhóm họ lập ra)
  - TaiKhoan_ThamGia_HoiNhom (Tham gia nhóm)
  - TaiKhoan_Lap_PhongNhanTin (Quan hệ giữa người dùng và phòng nhắn tin họ lập ra)
  - TaiKhoan_NhanTin_PhongNhanTin (Tin nhắn người dùng gửi trong phòng nhắn tin)
  - TaiKhoan_NapTien_TaiKhoan (Giao dịch nạp tiền của người dùng)
  - TaiKhoan_Lap_TaiKhoanQuangCao (Thông tin tài khoản quảng cáo)
  - TaiKhoanQuangCao_DangKy_ChienDich (Đăng ký chiến dịch quảng cáo)
  - ChienDich_Co_MucTieu (Thông tin mục tiêu chiến dịch quảng cáo)
  - ChienDich_Co_QuangCao (Chiến dịch quảng cáo có liên kết với quảng cáo)
  - BaiDang_Thuoc_HoiNhom (Bài đăng thuộc nhóm)
  - TaiKhoan_Gui_BaoCao (Thông tin báo cáo người dùng gửi)

- **tb_user_temp**: Không cần gán.

**Bước 7**: Insert dữ liệu (Nhớ kéo hết phần `SELECT * FROM dual;`).

**Bước 8**: Thực hiện các thao tác khác.
