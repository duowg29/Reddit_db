# NHÓM 5 - HỆ QUẢN TRỊ CƠ SỞ DỮ LIỆU

# Hướng dẫn sử dụng:

**Bước 1**: Kết nối tới CSDL bằng tài khoản SYSTEM

**Bước 2**: Chuyển Session hiện tại sang PDB: REDDITDBPDB1 (tệp `tablespaces_and_profiles.sql`) (Không cần nữa, bỏ qua bước này nếu đã thiết lập kết nối thẳng đến pdb)

- **Lưu ý**: Có thể bôi đen hết Tablespaces hoặc Profiles để chạy nhưng không thể bôi đen cả file

**Bước 3**: Tạo Tablespace (tệp `tablespaces_and_profiles.sql`)

**Bước 4**: Tạo Profile (tệp `tablespaces_and_profiles.sql`)

**Bước 5**: Tạo User (tệp `privilages_and_users.sql`)

- **Lưu ý**: Bắt buộc chạy từng user và lệnh alter user

**Bước 6**: Tạo Role (tệp `privilages_and_users.sql`)

**Bước 7**: Gán Role cho User (tệp `privilages_and_users.sql`)

**Bước 8**: Tạo bảng:

- **Bước 8.1**: Đăng nhập với tài khoản (là thông tin của User).
- **Bước 8.2**: Chạy lệnh tạo bảng (tương ứng với Tablespace của User).

  **Lưu ý**: Mỗi User đều có bảng riêng nên khi đăng nhập phải tự tạo bảng cho User đó

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

**Bước 9**: Insert dữ liệu (Nhớ kéo hết phần `SELECT * FROM dual;`).

**Bước 10**: Thực hiện các thao tác khác.

# Trường hợp DB không Open (Lỗi ORA-01109: database not open)

**NOTE**: Lỗi này xảy ra do khi mình tắt máy thì DB sẽ về chế độ MOUNT, ta cần chuyển nó về OPEN mới có thể sử dụng. 1 Phần nữa là do mình đang sử dụng PDB thay cho CDB nên sẽ phải chuyển Session về PDB (Bước 2).
B1: Mở CMD
B2: Paste lệnh: sqlplus / as sysdba
B3: Paste lệnh: ALTER SESSION SET CONTAINER = "REDDITDBPDB1";
B4: Paste lệnh: ALTER DATABASE OPEN;
B5: Kiểm tra lại xem đã OPEN chưa bằng lệnh: ALTER DATABASE OPEN;
