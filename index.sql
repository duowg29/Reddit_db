--INDEX
CREATE INDEX IX_TaiKhoan_Email ON TaiKhoan (Email);

CREATE INDEX IX_HoiNhom_NgayThanhLap ON HoiNhom (NgayThanhLap);

CREATE INDEX IX_PhongNhanTin_TenPhong ON PhongNhanTin (TenPhong);

CREATE INDEX IX_BaoCao_ThoiGianBaoCao ON BaoCao (ThoiGianBaoCao);

CREATE INDEX IX_TaiKhoanQuangCao_TenDoanhNghiep ON TaiKhoanQuangCao (TenDoanhNghiep);

CREATE INDEX IX_BaiDang_TieuDe ON BaiDang (TieuDe);

CREATE INDEX IX_HoiNhom_TenNhom ON HoiNhom (TenNhom);

CREATE INDEX IX_MucTieu_TenMucTieu ON MucTieu (TenMucTieu);

CREATE INDEX IX_ChienDich_TieuDe ON ChienDich (TieuDe);

CREATE INDEX IX_TaiKhoan_BinhLuan_BaiDang_ThoiGianBinhLuan ON TaiKhoan_BinhLuan_BaiDang (ThoiGianBinhLuan);
