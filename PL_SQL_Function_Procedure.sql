--QUAN LY TAI KHOAN
--1. Cap nhat mat khau cua tai khoan theo ma tai khoan nhap vao
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
    
    DBMS_OUTPUT.PUT_LINE('Cap nhat mat khau thanh cong cho tai khoan co ma: ' || p_MaTaiKhoan);
END;

--2. Dua ra danh sach tai khoan theo chuc vu
SET SERVEROUTPUT ON
DECLARE
    p_ChucVu VARCHAR2(10) :='&p_ChucVu';
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM TaiKhoan
    WHERE ChucVu=p_ChucVu;
    IF v_count=0 THEN
        DBMS_OUTPUT.PUT_LINE('Khong co chuc vu nay trong CSDL');
    ELSE
        FOR rec IN ( SELECT MaTaiKhoan, TenTaiKhoan, Email
                 FROM TaiKhoan
                 WHERE ChucVu=p_ChucVu)
        LOOP
           DBMS_OUTPUT.PUT_LINE(rec.MaTaiKhoan||' |'|| rec.TenTaiKhoan||' |'|| rec.Email);
        END LOOP;
    END IF;
END;

--3. So luong tai khoan su dung Reddit theo nam
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE
sum_tk(v_year NUMBER)
AS num_tk NUMBER;
BEGIN
    SELECT COUNT(*) INTO num_tk
    FROM TaiKhoan
    WHERE EXTRACT(YEAR FROM NgayThamGia) = v_year;
   
    DBMS_OUTPUT.PUT_LINE('So tai khoan trong nam ' || v_year || ': ' || num_tk);
END;
EXEC sum_tk(&v_year);


--QUAN LY BAI DANG
--4. Tong so bai dang cua theo tai khoan 
SET SERVEROUTPUT ON
DECLARE
    p_MaTaiKhoan NUMBER :=&p_MaTaiKhoan;
    sum_MaBaiDang NUMBER;
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM TaiKhoan
    WHERE MaTaiKhoan=p_MaTaiKhoan;
    IF v_count=0 THEN
        DBMS_OUTPUT.PUT_LINE('Khong co ma tai khoan vua nhap vao');
    ELSE
        SELECT COUNT(MaBaiDang) INTO sum_MaBaiDang
        FROM BaiDang
        WHERE MaTaiKhoan=p_MaTaiKhoan;
        
        DBMS_OUTPUT.PUT_LINE('So bai dang cua tai khoan '||p_MaTaiKhoan||': '||sum_MaBaiDang);
    END IF;
END;

--5. Cap nhat trang thai bai dang
SET SERVEROUTPUT ON
DECLARE
    p_MaBaiDang NUMBER;
BEGIN
    p_MaBaiDang := &p_MaBaiDang;

    -- Cap nhat trang thai bai đang thanh locked
    UPDATE BaiDang
    SET TrangThai = 'Locked'
    WHERE MaBaiDang = p_MaBaiDang;

    -- Thông báo thành công
    DBMS_OUTPUT.PUT_LINE('Cap nhat trang thai thanh cong');
END;
/

--QUAN LY HOI NHOM
--6. Lay danh sach cac thanh vien theo hoi nhom
SET SERVEROUTPUT ON
DECLARE
    p_MaHoiNhom NUMBER := &p_MaHoiNhom;
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM HoiNhom
    WHERE MaHoiNhom= p_MaHoiNhom;
    IF v_count =0 THEN
        DBMS_OUTPUT.PUT_LINE('Khong co hoi nhom co ma'||' '||p_MaHoiNhom);
    ELSE
        FOR rec IN (Select MaTaiKhoan 
                    FROM TaiKhoan_ThamGia_HoiNhom
                    WHERE MaHoiNhom= p_MaHoiNhom)
        LOOP
            DBMS_OUTPUT.PUT_LINE('Ma tai khoan: ' || rec.MaTaiKhoan);
        END LOOP;
    END IF;
END;

--7. Them tai khoan vao hoi nhom
SET SERVEROUTPUT ON
DECLARE
    p_MaTaiKhoan NUMBER;
    p_MaHoiNhom NUMBER;
    v_count NUMBER;
BEGIN
    p_MaTaiKhoan := &p_MaTaiKhoan;
    p_MaHoiNhom := &p_MaHoiNhom;
    
    SELECT COUNT(*) INTO v_count
    FROM TaiKhoan_ThamGia_HoiNhom
    WHERE MaHoiNhom= p_MaHoiNhom and MaTaiKhoan= p_MaTaiKhoan;
    IF v_count >0 THEN
    DBMS_OUTPUT.PUT_LINE ('Tai khoan da co trong hoi nhom nay');
    ELSE
        INSERT INTO TaiKhoan_ThamGia_HoiNhom( MaTaiKhoan, MaHoiNhom)
        VALUES (p_MaTaiKhoan, p_MaHoiNhom);
        DBMS_OUTPUT.PUT_LINE('Them thanh cong vao hoi nhom.');
    END IF;
END;

--QUAN LY PHONG TIN NHAN
--8. Lay danh sach phong tin nhan ma 1 tai khoan da tham gia.
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
        DBMS_OUTPUT.PUT_LINE('Khong co ma tai khoan nay.');
    ELSE 
        FOR rec IN (SELECT p.MaPhongNhanTin, p.TenPhong, p.ChuDePhong
                    FROM TaiKhoan_NhanTin_PhongNhanTin tp JOIN PhongNhanTin p 
                    ON tp.MaPhongNhanTin = p.MaPhongNhanTin
                    WHERE tp.MaTaiKhoan = v_MaTaiKhoan)
        LOOP
        count_rows:=count_rows+1;
        DBMS_OUTPUT.PUT_LINE('Ma Phong: ' || rec.MaPhongNhanTin || ' | Ten Phong: ' || rec.TenPhong || ' | Chu de Phong: ' || rec.ChuDePhong);
        END LOOP;
        IF count_rows=0 then
        dbms_output.put_line('Tai khoan khong tham gia phong nhan tin nao.');
        END IF;
    END IF;
END;

-- 9. Dua ra danh sach tin nhan theo ma tai khoan
SET SERVEROUTPUT ON;
DECLARE
    v_MaTaiKhoan NUMBER := &v_MaTaiKhoan;
    v_count NUMBER;
BEGIN
    -- Kiem tra tai khoan co ton tai khong
    SELECT COUNT(*) INTO v_count 
    FROM TaiKhoan 
    WHERE MaTaiKhoan = v_MaTaiKhoan;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Tai khoan khong ton tai.');
    ELSE
        FOR rec IN (SELECT MaPhongNhanTin, NoiDungNhanTin
                    FROM TaiKhoan_NhanTin_PhongNhanTin
                    WHERE MaTaiKhoan=v_MaTaiKhoan)
        LOOP 
            DBMS_OUTPUT.PUT_LINE(rec.MaPhongNhanTin||' |'||rec.NoiDungNhanTin);
        END LOOP;
    END IF;
END;
--QUAN LY CHIEN DICH QUANG CAO
--10. Cap nhat thong tin chien dich
BEGIN
    UPDATE ChienDich
    SET TieuDe = 'Chien dich He 2024',
        NoiDung = 'Cap nhat noi dung chien dich He 2024'
    WHERE MaChienDich = 1;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Cap nhat thong tin chien dich thanh cong.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Khong tim thay chien dich voi ma tuong ung.');
    END IF;
END;

--11. �?ua ra so luong tai khoan dang ky tai khoan quang cao
CREATE OR REPLACE FUNCTION
SoluongTKQC
RETURN NUMBER
AS Soluong NUMBER;
BEGIN
    SELECT COUNT(MaTaiKhoan) INTO Soluong
    FROM TaiKhoan_Lap_TaiKhoanQuangCao;
    RETURN Soluong;
END;
SELECT SoluongTKQC FROM DUAL;

--12. Kiem tra tai khoan co tham gia dang ky quang cao cua 1 chien dich nao do hay khong?
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
        RETURN 'Tai khoan da tham gia quang cao cua chien dich.';
    ELSE
        RETURN 'Tai khoan chua tham gia quang cao nao cua chien dich.';
    END IF;
END;
SELECT KiemTraTaiKhoanQuangCao(&v_MaTaiKhoan, &v_MaChienDich) FROM DUAL;

-- BAO CAO VA THONG KE
--13. Bai dang co luot upvote cao nhat
CREATE OR REPLACE PROCEDURE BaiDangUpvoteCaoNhat 
AS
    v_MaBaiDang    BaiDang.MaBaiDang%TYPE;
    v_TieuDe       BaiDang.TieuDe%TYPE;
    v_SoUpvote     NUMBER;

BEGIN
    -- Tim bai dang co so luong upvote cao nhat
    SELECT bd.MaBaiDang, bd.TieuDe, MAX(tt.Upvote)
    INTO v_MaBaiDang, v_TieuDe, v_SoUpvote
    FROM BaiDang bd 
    JOIN TaiKhoan_TuongTac_BaiDang tt
    ON bd.MaBaiDang = tt.MaBaiDang
    GROUP BY bd.MaBaiDang, bd.TieuDe
    ORDER BY MAX(tt.Upvote) DESC
    FETCH FIRST 1 ROWS ONLY;

    -- Xuat thong tin bai dang co so luong upvote cao nhat
    DBMS_OUTPUT.PUT_LINE('Bai dang co luong upvote cao nhat:');
    DBMS_OUTPUT.PUT_LINE('Ma bai dang: ' || v_MaBaiDang);
    DBMS_OUTPUT.PUT_LINE('Tieu de: ' || v_TieuDe);
    DBMS_OUTPUT.PUT_LINE('So luong upvote: ' || v_SoUpvote);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Khong co bai dang nao trong he thong.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi xay ra: ' || SQLERRM);
END;
EXEC BaiDangUpvoteCaoNhat;

--14. Thong ke TOP 5 chien dich có chi phi quang cao cao nhat
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
        DBMS_OUTPUT.PUT_LINE('Chien dich: ' || rec.TieuDe || ', Tong chi phi quang cao: ' || rec.TongChiPhi);
    END LOOP;
END;
EXEC TOP5_EXPENSIVE_CAMPAIGNS;