--QU?N LÝ TÀI KHO?N
1. Cap nhat mat khau cua tai khoan theo ma tai khoan nhap vao
SET SERVEROUTPUT ON
DECLARE 
    p_MaTaiKhoan NUMBER;
    p_MatKhauMoi NVARCHAR2(20);
BEGIN
    p_MaTaiKhoan :=&p_MaTaiKhoan;
    p_MatKhauMoi :='&p_MatKhauMoi';
    UPDATE TaiKhoan
    SET MatKhau = p_MatKhauMoi
    WHERE MaTaiKhoan = p_MaTaiKhoan;
    
    DBMS_OUTPUT.PUT_LINE('Doi mat khau thành công cho tài khoan có mã: ' || p_MaTaiKhoan);
END;
2. Dua ra danh sách tài khoan theo chuc vu
SET SERVEROUTPUT ON
DECLARE
    p_ChucVu VARCHAR2(10) :='&p_ChucVu';
BEGIN
    FOR rec IN ( SELECT MaTaiKhoan, TenTaiKhoan, Email
                 FROM TaiKhoan
                 WHERE ChucVu=p_ChucVu)
    LOOP
       DBMS_OUTPUT.PUT_LINE(rec.MaTaiKhoan|| rec.TenTaiKhoan|| rec.Email);
    END LOOP;
END;

3. S? l??ng tài kho?n s? d?ng Reddit theo n?m
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE
sum_tk(v_year NUMBER)
AS num_tk NUMBER;
BEGIN
    SELECT COUNT(*) INTO num_tk
    FROM TaiKhoan
    WHERE EXTRACT(YEAR FROM NgayThamGia) = v_year;
   
    DBMS_OUTPUT.PUT_LINE('So tài khoan trong nam ' || v_year || ': ' || num_tk);
END;
EXEC sum_tk(&v_year);


--QU?N LÝ BÀI ??NG
1. Tong so bài dang cua theo tài khoan 
SET SERVEROUTPUT ON
DECLARE
    p_MaTaiKhoan NUMBER;
    sum_MaBaiDang NUMBER;
BEGIN
    p_MaTaiKhoan :=&p_MaTaiKhoan;
    SELECT sum(MaBaiDang) INTO sum_MaBaiDang
    FROM BaiDang
    WHERE MaTaiKhoan=p_MaTaiKhoan;
    DBMS_OUTPUT.PUT_LINE('Tài khoan'||' '||p_MaTaiKhoan||' '||'có'||' '||sum_MaBaiDang||' bài dang');
END;
2. Xóa bài ??ng
SET SERVEROUTPUT ON
DECLARE
    p_MaBaiDang NUMBER;
BEGIN
    p_MaBaiDang := &p_MaBaiDang;
    DELETE FROM BaiDang
    WHERE MaBaiDang=p_MaBaiDang;
END;

--QU?N LÝ H?I NHÓM
1. Lay danh sách các thành viên theo hoi nhóm
SET SERVEROUTPUT ON
DECLARE
    p_MaHoiNhom NUMBER;
    v_count NUMBER;
BEGIN
    p_MaHoiNhom := p_MaHoiNhom;
    SELECT COUNT(*) INTO v_count
    FROM TaiKhoan_ThamGia_HoiNhom
    WHERE MaHoiNhom= p_MaHoiNhom;
    IF v_count <0 THEN
        DBMS_OUTPUT.PUT_LINE('Khong co hoi nhom co ma'||' '||p_MaHoiNhom);
    ELSE
        FOR rec IN (Select MaTaiKhoan 
                    FROM TaiKhoan_ThamGia_HoiNhom
                    WHERE MaHoiNhom= p_MaHoiNhom)
        LOOP
            DBMS_OUTPUT.PUT_LINE(rec.MaTaiKhoan);
        END LOOP;
    END IF;
END;
2. Thêm tài khoan vào hoi nhóm
SET SERVEROUTPUT ON
DECLARE
    p_MaTaiKhoan NUMBER;
    p_MaHoiNhom NUMBER;
    v_count NUMBER;
BEGIN
    p_MaTaiKhoan := &p_MaTaiKhoan;
    p_MaHoiNhom := &p_MaHoiNhom;
    IF NOT EXISTS (SELECT 1 FROM TaiKhoan WHERE MaTaiKhoan = p_MaTaiKhoan) THEN
        DBMS_OUTPUT.PUT_LINE('MaTaiKhoan không ton tai trong bang TaiKhoan.');
        RETURN;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM HoiNhom WHERE MaHoiNhom = p_MaHoiNhom) THEN
        DBMS_OUTPUT.PUT_LINE('MaHoiNhom không ton tai trong bang HoiNhom.');
        RETURN;
    END IF;
    
    SELECT COUNT(*) INTO v_count
    FROM TaiKhoan_ThamGia_HoiNhom
    WHERE MaHoiNhom= p_MaHoiNhom and MaTaiKhoan= p_MaTaiKhoan;
    IF v_count >0 THEN
    DBMS_OUTPUT.PUT_LINE ('Tai khoan da co trong hoi nhom nay');
    ELSE
        INSERT INTO TaiKhoan_ThamGia_HoiNhom( MaTaiKhoan, MaHoiNhom)
        VALUES (p_MaTaiKhoan, p_MaHoiNhom);
        DBMS_OUTPUT.PUT_LINE('Thêm thành công vào hoi nhóm.');
    END IF;
END;

--QU?N LÝ PHÒNG TIN NH?N
1. Lay danh sách phòng tin nhan mà 1 tài kho?n ?ã tham gia
SET SERVEROUTPUT ON
DECLARE
    v_MaTaiKhoan NUMBER := &v_MaTaiKhoan;
    v_count NUMBER;
    count_rows NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM TaiKhoan
    WHERE MaTaiKhoan= v_MaTaiKhoan;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Không có ma tài khoan nay.');
    ELSE 
        FOR rec IN (SELECT p.MaPhongNhanTin, p.TenPhong, p.ChuDePhong
                    FROM TaiKhoan_NhanTin_PhongNhanTin tp JOIN PhongNhanTin p 
                    ON tp.MaPhongNhanTin = p.MaPhongNhanTin
                    WHERE tp.MaTaiKhoan = v_MaTaiKhoan)
        LOOP
        count_rows:=count_rows+1;
        DBMS_OUTPUT.PUT_LINE('Mã Phòng: ' || rec.MaPhongNhanTin || ' | Tên Phòng: ' || rec.TenPhong || ' | Ch? ?? Phòng: ' || rec.ChuDePhong);
        END LOOP;
        IF count_rows=0 then
        dbms_output.put_line('Tài khoan không tham gia phòng nh?n tin nào.');
        END IF;
    END IF;
END;
2. Gui tin nhan vào phong
SET SERVEROUTPUT ON
DECLARE
    rowtn TaiKhoan_NhanTin_PhongTinNhan%TYPE;
BEGIN
    rowtn.MaTaiKhoan := &MaTaiKhoan;
    rowtn.MaPhongNhanTin := &MaPhongNhanTin;
    rowtn.NoiDungNhanTin := '&NoiDungNhanTin';
    rowtn.ThoiGianNhanTin := '&ThoiGianNhanTin';
    rowtn.TepDinhKem := '&TepDinhKem';
    INSERT INTO TaiKhoan_NhanTin_PhongTinNhan
    VALUES(rowtn.MaTaiKhoan, rowtn.MaPhongNhanTin, rowtn.NoiDungNhanTin, rowtn.ThoiGianNhanTin, rowtn.TepDinhKem);
    DBMS_OUTPUT.PUT_LINE('Gui tin nhan thành công.');
END;

--QU?N LÝ CHI?N D?CH QU?NG CÁO
1. ??a ra danh sách các tài kho?n quang cao ??ng ký chi?n d?ch theo mã chi?n d?ch 
DECLARE
    v_MaChienDich NUMBER := &v_MaChienDich;
    v_count NUMBER;
    count_rows NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM ChienDich
    WHERE MaChienDich=v_MaChienDich;
    IF v_count =0 THEN
        DBMS_OUTPUT.PUT_LINE('Không có mã chien dich dã nhap');
    ELSE
        FOR rec IN ( SELECT tq.MaTaiKhoanQuangCao, tk.TenDoanhNghiep, tk.LinhVuc
                     FROM TaiKhoan_QuangCao_DangKy_ChienDich tq JOIN TaiKhoanQuangCao tk 
                     ON tq.MaTaiKhoanQuangCao = tk.MaTaiKhoanQuangCao
                     WHERE tq.MaChienDich = v_MaChienDich)
        LOOP
        count_rows:=count_rows+1;
        DBMS_OUTPUT.PUT_LINE('Mã Tài Khoan: ' || rec.MaTaiKhoanQuangCao || ' | Tên Doanh Nghiep: ' || rec.TenDoanhNghiep || 
                             ' | Linh vuc: ' || rec.LinhVuc);
        END LOOP;
        IF count_rows=0 then
        dbms_output.put_line('Khong có tài khoan nào dang ký chien dich.');
        END IF;
    END IF;      
END;
    
2. C?p nh?t thông tin chi?n d?ch
BEGIN
    UPDATE ChienDich
    SET TieuDe = 'Chien dich Hè 2024',
        NoiDung = 'Cap nhat noi dung chien dich Hè 2024'
    WHERE MaChienDich = 1;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Cap nhat thông tin chien dich thành công.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Không tìm thay chien dich voi mã tuong ung.');
    END IF;
END;

3. Ki?m tra tài kho?n có tham gia ??ng ký qu?ng cáo c?a 1 chi?n d?ch nào ?ó hay không
CREATE OR REPLACE FUNCTION 
KiemTraTaiKhoanQuangCao(v_MaTaiKhoan NUMBER, v_MaChienDich NUMBER)
RETURN VARCHAR2
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM TaiKhoan tk JOIN TaiKhoan_Lap_TaiKhoanQuangCao tkqc
    ON tk.MaTaiKhoan = tkqc.MaTaiKhoan
    JOIN TaiKhoanQuangCao_DangKy_ChienDich tkcd
    ON tkqc.MaTaiKhoanQuangCao = tkcd.MaTaiKhoanQuangCao 
    WHERE tk.MaTaiKhoan = v_MaTaiKhoan AND tkcd.MaChienDich = v_MaChienDich;

    IF v_count > 0 THEN
        RETURN 'Tài kho?n ?ã tham gia qu?ng cáo c?a chi?n d?ch.';
    ELSE
        RETURN 'Tài kho?n ch?a tham gia qu?ng cáo nào c?a chi?n d?ch.';
    END IF;
END;
SELECT KiemTraTaiKhoanQuangCao(&v_MaTaiKhoan, &v_MaChienDich);

-- BÁO CÁO VÀ TH?NG KÊ
1. Bài ??ng có l??t upvote cao nh?t
CREATE OR REPLACE PROCEDURE BaiDangUpvoteCaoNhat 
AS
    v_MaBaiDang    BaiDang.MaBaiDang%TYPE;
    v_TieuDe       BaiDang.TieuDe%TYPE;
    v_NoiDung      BaiDang.NoiDung%TYPE;
    v_SoUpvote     NUMBER;

BEGIN
    SELECT bd.MaBaiDang, bd.TieuDe, bd.NoiDung, MAX(tt.Upvote)
    INTO v_MaBaiDang, v_TieuDe, v_NoiDung, v_SoUpvote
    FROM BaiDang bd JOIN TaiKhoan_TuongTac_BaiDang tt
    ON bd.MaBaiDang = tt.MaBaiDang
    GROUP BY bd.MaBaiDang, bd.TieuDe, bd.NoiDung
    ORDER BY MAX(tt.Upvote) DESC
    FETCH FIRST 1 ROWS ONLY;

    DBMS_OUTPUT.PUT_LINE('Bài dang có luong upvote cao nhat:');
    DBMS_OUTPUT.PUT_LINE('Mã bài dang: ' || v_MaBaiDang);
    DBMS_OUTPUT.PUT_LINE('Tiêu de: ' || v_TieuDe);
    DBMS_OUTPUT.PUT_LINE('Noi dung: ' || v_NoiDung);
    DBMS_OUTPUT.PUT_LINE('So luong upvote: ' || v_SoUpvote);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Không có bài dang nào trong he thong.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi xay ra: ' || SQLERRM);
END;
EXEC BaiDangUpvoteCaoNhat

2. Th?ng kê v? TOP 5 chi?n d?ch có chi phí qu?ng cáo cao nh?t
CREATE OR REPLACE PROCEDURE TOP5_EXPENSIVE_CAMPAIGNS 
AS
BEGIN
    FOR rec IN (SELECT c.MaChienDich, c.TieuDe, NVL(SUM(qc.ChiPhi), 0) AS TongChiPhi
                FROM ChienDich c
                LEFT JOIN ChienDich_Co_QuangCao tc 
                ON c.MaChienDich = tc.MaChienDich
                LEFT JOIN QuangCao qc 
                ON tc.MaQuangCao = qc.MaQuangCao
                GROUP BY c.MaChienDich, c.TieuDe
                ORDER BY TongChiPhi DESC
                FETCH FIRST 5 ROWS ONLY)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Chien dich: ' || rec.TieuDe || ', Tong chi phí quang cáo: ' || rec.TongChiPhi);
    END LOOP;
END;
EXEC TOP5_EXPENSIVE_CAMPAIGNS 