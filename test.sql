use QLLHNA
DECLARE @UserId INT;
	
-- User 1
EXEC P_AddUser
    @HoTen = N'Nguyễn Văn A',
    @MatKhau = N'password123',
    @UserId = @UserId OUTPUT;
PRINT 'User ID mới tạo cho Nguyễn Văn A: ' + CAST(@UserId AS NVARCHAR(10));

-- User 2
EXEC P_AddUser
    @HoTen = N'Trần Thị B',
    @MatKhau = N'password456',
    @UserId = @UserId OUTPUT;
PRINT 'User ID mới tạo cho Trần Thị B: ' + CAST(@UserId AS NVARCHAR(10));

-- User 3
EXEC P_AddUser
    @HoTen = N'Lê Văn C',
    @MatKhau = N'password789',
    @UserId = @UserId OUTPUT;
PRINT 'User ID mới tạo cho Lê Văn C: ' + CAST(@UserId AS NVARCHAR(10));

-- User 4
EXEC P_AddUser
    @HoTen = N'Phạm Thị D',
    @MatKhau = N'password321',
    @UserId = @UserId OUTPUT;
PRINT 'User ID mới tạo cho Phạm Thị D: ' + CAST(@UserId AS NVARCHAR(10));

-- User 5
EXEC P_AddUser
    @HoTen = N'Hoàng Văn E',
    @MatKhau = N'password654',
    @UserId = @UserId OUTPUT;
PRINT 'User ID mới tạo cho Hoàng Văn E: ' + CAST(@UserId AS NVARCHAR(10));
exec P_ViewUser;
exec P_ViewUserByUsername N'Nguyễn Văn A';
exec P_UpdatePassword 1,'123123';
insert into Roles
values ('Admin'),
		('HocVien'),
		('GiaoVien');
exec P_AddRoleForUser 1, 1;
exec P_AddRoleForUser 2, 3;
exec P_AddRoleForUser 3, 2;
exec P_AddRoleForUser 4, 2;
exec P_AddRoleForUser 5, 2;
select * from User_Role;
select * from Roles;
print dbo.fn_xacthuc(1);
print dbo.fn_xacthuc(2);
print dbo.fn_xacthuc(3);
print dbo.fn_xacthuc(4);
print dbo.fn_xacthuc(5);
EXEC P_AddGiaoVien
    @UserId = 2,
    @HoTen = N'Trần Thị B',
    @NgaySinh = '1985-03-15',
    @GioiTinh = 0,                     -- 0 là nữ, 1 là nam
    @ChuyenMon = N'Nấu ăn',
    @SoNamKinhNghiem = 10,             -- Số năm kinh nghiệm > 0
    @Sdt = N'0912345678',
    @Email = N'tranthib@example.com',
    @Luong = 15000000.00;              -- Lương > 0
exec P_ViewGiaoVien;
exec P_ViewGiaoVienByName N'Thị'
exec P_UpdateGiaoVien 1, N'Lê Thị Tuyết A', @sdt = '0123445567';
EXEC P_AddMonAn @TenMon = N'Phở Gà', @HinhAnhMon = N'pho_ga.jpg', @LoaiMon = N'Món chính';
EXEC P_AddMonAn @TenMon = N'Bún Chả', @HinhAnhMon = N'bun_cha.jpg', @LoaiMon = N'Món chính';
EXEC P_AddMonAn @TenMon = N'Gỏi Cuốn', @HinhAnhMon = N'goi_cuon.jpg', @LoaiMon = N'Món khai vị';
EXEC P_AddMonAn @TenMon = N'Nem Rán', @HinhAnhMon = N'nem_ran.jpg', @LoaiMon = N'Món khai vị';
EXEC P_AddMonAn @TenMon = N'Bánh Xèo', @HinhAnhMon = N'banh_xeo.jpg', @LoaiMon = N'Món chính';
EXEC P_AddMonAn @TenMon = N'Chè Ba Màu', @HinhAnhMon = N'che_ba_mau.jpg', @LoaiMon = N'Món tráng miệng';
EXEC P_AddMonAn @TenMon = N'Bánh Cuốn', @HinhAnhMon = N'banh_cuon.jpg', @LoaiMon = N'Món chính';
EXEC P_AddMonAn @TenMon = N'Cà Phê Sữa Đá', @HinhAnhMon = N'ca_phe_sua_da.jpg', @LoaiMon = N'Đồ uống';
exec P_ViewMonAn;
exec P_ViewMonAnByName N'Cà';
DECLARE @MaLopHoc INT;

-- Lớp học Phở Gà
EXEC P_AddLopHocNauAn 
    @MonAn = N'Phở Gà', 
    @GiaoVienId = 1, 
    @DiaDiem = N'Tầng 1, Nhà A', 
    @SoNguoiDangKyToiDA = 20, 
    @ThongTin = N'Hướng dẫn nấu phở gà truyền thống', 
    @GhiChu = N'Lớp học cấp độ cơ bản', 
    @MaLopHoc = @MaLopHoc OUTPUT;
PRINT 'Mã lớp học Phở Gà: ' + CAST(@MaLopHoc AS NVARCHAR);
DECLARE @MaLopHoc INT;
-- Lớp học Bún Chả
EXEC P_AddLopHocNauAn 
    @MonAn = N'Bún Chả', 
    @GiaoVienId = 1, 
    @DiaDiem = N'Tầng 2, Nhà B', 
    @SoNguoiDangKyToiDA = 15, 
    @ThongTin = N'Học cách làm bún chả đặc sản Hà Nội', 
    @GhiChu = N'Lớp học nâng cao', 
    @MaLopHoc = @MaLopHoc OUTPUT;
PRINT 'Mã lớp học Bún Chả: ' + CAST(@MaLopHoc AS NVARCHAR);
exec P_ViewLopHocNauAn;
-- Lớp học Gỏi Cuốn
exec P_UpdateLopHocNauAn @MaLopHoc  = 1, @DiaDiem = N'Tòa Nhà 3A, Quận 7'
EXEC P_AddChiTietLopHoc 
    @MaLopHoc = 1, 
    @PhiDiaDiem = 500000, 
    @TongThu = 0, 
    @GiamGia = 0, 
    @TienHoanLai = 0, 
    @NguyenLieu = 300000, 
    @TrangThai = N'Chưa diễn ra';

-- Chi tiết lớp học cho lớp có mã lớp học 2
EXEC P_AddChiTietLopHoc 
    @MaLopHoc = 2, 
    @PhiDiaDiem = 450000, 
    @TongThu = 0, 
    @GiamGia = 0, 
    @TienHoanLai = 0, 
    @NguyenLieu = 250000,  
    @TrangThai = N'Chưa diễn ra';
exec P_ViewThongTinLopHoc 1;
EXEC P_AddThongTinQuangCao 
    @MaLopHoc = 1, 
    @IdNguoiViet = 1,          -- Giả sử người viết có ID là 2
    @TrangThaiBaiDang = 1,     -- Đã đăng
    @ChayADS = 1;              -- Đang chạy quảng cáo

-- Thêm thông tin quảng cáo cho lớp học có mã lớp học 2
EXEC P_AddThongTinQuangCao 
    @MaLopHoc = 2, 
    @IdNguoiViet = 2,          -- Giả sử người viết có ID là 3
    @TrangThaiBaiDang = 0,     -- Chưa đăng
    @ChayADS = 0;              -- Không chạy quảng cáo
	exec P_ViewThongTinQuangCao
	-- Thêm lịch học cho lớp học có mã lớp học 1
EXEC P_AddLichHoc 
    @MaLopHoc = 1, 
    @Ngay = '2024-11-01',           -- Ngày diễn ra lớp học
    @ChiPhi = 300000,               -- Chi phí lớp học
    @ThoiGianBatDau = '09:00:00',  -- Thời gian bắt đầu
    @ThoiGianKetThuc = '11:00:00';  -- Thời gian kết thúc

-- Thêm lịch học cho lớp học có mã lớp học 2
EXEC P_AddLichHoc 
    @MaLopHoc = 2, 
    @Ngay = '2024-11-02',           -- Ngày diễn ra lớp học
    @ChiPhi = 350000,               -- Chi phí lớp học
    @ThoiGianBatDau = '14:00:00',  -- Thời gian bắt đầu
    @ThoiGianKetThuc = '16:00:00';  -- Thời gian kết thúc
exec P_ViewLichHoc;
-- Thêm mã giảm giá 1
EXEC P_AddMaGiamGia 
    @GiaTri = 50000,                     -- Giá trị giảm giá
    @Loai = 'Tiền mặt',    -- Loại giảm giá
    @PhanTramGiamGia = 0,                 -- Phần trăm giảm giá
    @code = NULL;                         -- Mã code

-- Thêm mã giảm giá 2
EXEC P_AddMaGiamGia 
    @GiaTri = 0,                          -- Giá trị giảm giá
    @Loai = 'Giảm giá',     -- Loại giảm giá
    @PhanTramGiamGia = 10,                -- Phần trăm giảm giá
    @code = NULL;                         -- Mã code

-- Thêm mã giảm giá 3
EXEC P_AddMaGiamGia 
    @GiaTri = 100000,                     -- Giá trị giảm giá
    @Loai = 'Giảm giá đặc biệt',          -- Loại giảm giá
    @PhanTramGiamGia = 0,                 -- Phần trăm giảm giá
    @code = NULL;                         -- Mã code

-- Thêm mã giảm giá 4
EXEC P_AddMaGiamGia 
    @GiaTri = 0,                          -- Giá trị giảm giá
    @Loai = 'Giảm giá theo học viên',     -- Loại giảm giá
    @PhanTramGiamGia = 15,                -- Phần trăm giảm giá
    @code = 80;                         -- Mã code

-- Thêm mã giảm giá 5
EXEC P_AddMaGiamGia 
    @GiaTri = 20000,                      -- Giá trị giảm giá
    @Loai = 'Giảm giá ',  -- Loại giảm giá
    @PhanTramGiamGia = 0,                 -- Phần trăm giảm giá
    @code = NULL;                         -- Mã code
exec P_ViewMaGiamGia
-- Thêm học viên với user_id = 3
EXEC P_AddHocVien 
    @user_id = 3,
    @HoTen = 'Nguyễn Văn A',
    @GioiTinh = 1,  -- 1: Nam, 0: Nữ
    @NgaySinh = '1995-05-10',
    @NgayDangKy = '2024-10-28',
    @GhiChu = 'Học viên mới đăng ký',
    @Mail = 'nguyenvana@example.com',
    @Sdt = '0123456789';

-- Thêm học viên với user_id = 4
EXEC P_AddHocVien 
    @user_id = 4,
    @HoTen = 'Trần Thị B',
    @GioiTinh = 0,  -- 1: Nam, 0: Nữ
    @NgaySinh = '1990-12-15',
    @NgayDangKy = '2024-10-28',
    @GhiChu = 'Học viên tham gia lớp học nấu ăn',
    @Mail = 'tranthib@example.com',
    @Sdt = '0987654321';

-- Thêm học viên với user_id = 5
EXEC P_AddHocVien 
    @user_id = 5,
    @HoTen = 'Lê Văn C',
    @GioiTinh = 1,  -- 1: Nam, 0: Nữ
    @NgaySinh = '1992-08-20',
    @NgayDangKy = '2024-10-28',
    @GhiChu = 'Học viên tham gia khóa học nâng cao',
    @Mail = 'levanc@example.com',
    @Sdt = '0123987654';

exec P_ViewHocVien;
DECLARE @CurrentDate DATE;
SET @CurrentDate = GETDATE();
-- Thêm học viên vào lớp học nấu ăn với LopHocNauAnId = 1 và HocVienId = 3
EXEC P_AddLopHocNauAn_HocVien 
    @LopHocNauAnId = 1,                     -- ID lớp học nấu ăn
    @HocVienId = 3,                          -- ID học viên
    @NgayGioDangKy = @CurrentDate,             -- Ngày giờ đăng ký hiện tại
    @TrangThaiDangKy = 'Đang chờ',           -- Trạng thái đăng ký
    @SoTienDaThanhToan = 500000,            -- Số tiền đã thanh toán
    @HinhThucThanhToan = 1,                  -- 1: Thanh toán qua thẻ, 0: Thanh toán tiền mặt
    @TrangThaiThanhToan = 'Thành công',     -- Trạng thái thanh toán
    @MaGiamGia = NULL;                       -- Không sử dụng mã giảm giá
-- Thêm học viên vào lớp học nấu ăn với LopHocNauAnId = 2 và HocVienId = 4
DECLARE @CurrentDate DATE;
SET @CurrentDate = GETDATE();
EXEC P_AddLopHocNauAn_HocVien 
    @LopHocNauAnId = 2,
    @HocVienId = 1,
    @NgayGioDangKy = @CurrentDate,
    @TrangThaiDangKy = 'Đang chờ',
    @SoTienDaThanhToan = 300000,
    @HinhThucThanhToan = 0,
    @TrangThaiThanhToan = 'Chưa thanh toán',
    @MaGiamGia = 5;                    -- Sử dụng mã giảm giá với mã là 1

-- Thêm học viên vào lớp học nấu ăn với LopHocNauAnId = 3 và HocVienId = 5
DECLARE @CurrentDateD DATE;
SET @CurrentDateD = GETDATE();
EXEC P_AddLopHocNauAn_HocVien 
    @LopHocNauAnId = 1,
    @HocVienId = 2,
    @NgayGioDangKy = @CurrentDateD,
    @TrangThaiDangKy = 'Đã xác nhận',
    @SoTienDaThanhToan = NULL,              -- Chưa thanh toán
    @HinhThucThanhToan = NULL,               -- Hình thức thanh toán không cập nhật
    @TrangThaiThanhToan = 'Chưa thanh toán', -- Trạng thái thanh toán
    @MaGiamGia = 2;                         -- Sử dụng mã giảm giá với mã là 2
select * from LopHocNauAn_HocVien
exec P_ViewLopHocNauAn

EXEC P_AddHoanTienBaoLuu 
    @HocVienId = 3,                         -- ID học viên
    @LopHocNauAnId = 1,                     -- ID lớp học nấu ăn
    @SoTienHoanLai = 250000.00,             -- Số tiền hoàn lại
    @TrangThai = 'Hoàn tiền',                -- Trạng thái: 'Hoàn tiền' hoặc 'Bảo lưu'
    @LopHocChuyenSangId = NULL;              -- Không có lớp học chuyển tiếp

	EXEC P_AddDanhGiaLopHoc 
    @MaLopHoc = 1,               -- Mã lớp học
    @HocVienId = 3,              -- ID học viên
    @DiemDanhGia = 5,            -- Điểm đánh giá (0-10)
    @NhanXet = N'Rất tốt, tôi rất hài lòng với lớp học!';  -- Nhận xét

	EXEC P_AddDanhGiaHocVien 
    @MaLopHoc = 1,               -- Mã lớp học
    @HocVienId = 3,              -- ID học viên
    @GiaoVienId = 1,             -- ID giáo viên
    @NhanXet = N'Học viên chăm chỉ và có nhiều tiến bộ!';  -- Nhận xét

EXEC P_ViewDanhGiaHocVien 
    @HocVienId = 3;   -- ID học viê


DECLARE @MaLopHoc INT;
SET @MaLopHoc = 1; 

SELECT dbo.fn_TinhTongTienDuKien(@MaLopHoc) AS TongTienDuKien;

exec P_DeleteThongTinQuangCao 1;
delete from LopHocNauAn_HocVien where LopHocNauAnId = 1
exec P_ViewLopHocNauAn
select * from LopHocNauAn_HocVien
update LopHocNauAn_HocVien set LopHocNauAn_HocVien.MaGiamGia = 5 where LopHocNauAn_HocVien.HocVienId = 1
update LopHocNauAn_HocVien set LopHocNauAn_HocVien.SoTienDaThanhToan+=330000 where LopHocNauAn_HocVien.HocVienId = 1
select * from MaGiamGia

exec P_DeleteLopHocNauAn 1;
exec P_ViewLopHocNauAn;
exec P_ViewLichHoc;
delete from HoanTienBaoLuu where LopHocNauAnId  = 1
delete from DanhGiaLopHoc where DanhGiaLopHoc.MaLopHoc = 1;
delete from DanhGiaHocVien where DanhGiaHocVien.MaLopHoc = 1
DECLARE @DoanhThuThucTe DECIMAL(18,2);

SET @DoanhThuThucTe = dbo.fn_CalculateActualRevenue(2 );--Gọi hàm với mã lớp học

SELECT @DoanhThuThucTe AS DoanhThuThucTe;  -- Hiển thị doanh thu thực tế
330000

CREATE FUNCTION tinhtien (@LopHocNauAnId INT, @HocVienId INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @SoTienDaThanhToan DECIMAL(18, 2),
            @HinhThucThanhToan BIT, 
            @TrangThaiThanhToan NVARCHAR(255),
            @MaGiamGia INT, 
            @Code INT = 0, 
            @ChiPhi DECIMAL(18,2), 
            @PhanTramGiamGia INT,
            @DiscountAmount DECIMAL(18,2), 
            @CodeDiscount DECIMAL(18,2),
            @GiaTri DECIMAL(18,2), 
            @FixedDiscount DECIMAL(18,2);

    -- Lấy các giá trị từ bảng LopHocNauAn_HocVien
    SELECT @SoTienDaThanhToan = SoTienDaThanhToan,
           @HinhThucThanhToan = HinhThucThanhToan,
           @TrangThaiThanhToan = TrangThaiThanhToan,
           @MaGiamGia = MaGiamGia
    FROM LopHocNauAn_HocVien
    WHERE LopHocNauAnId = @LopHocNauAnId AND HocVienId = @HocVienId;

    -- Lấy ChiPhi từ bảng LichHoc
    SELECT @ChiPhi = lh.ChiPhi
    FROM LichHoc lh
    WHERE lh.MaLopHoc = @LopHocNauAnId;

    -- Lấy PhanTramGiamGia và GiaTri từ bảng MaGiamGia (nếu có)
    IF (@MaGiamGia IS NOT NULL)
    BEGIN
        SELECT @PhanTramGiamGia = mg.PhanTramGiamGia,
               @GiaTri = mg.GiaTri
        FROM MaGiamGia mg
        WHERE mg.Ma = @MaGiamGia;
    END
    ELSE
    BEGIN
        SET @PhanTramGiamGia = 0;
        SET @GiaTri = 0;
    END;

    -- Tính giá trị giảm giá
    SET @DiscountAmount = (@PhanTramGiamGia / 100.0) * @ChiPhi; -- Giảm giá phần trăm từ PhanTramGiamGia
    SET @CodeDiscount = (@Code / 100.0) * @ChiPhi;              -- Giảm giá phần trăm từ code
    SET @FixedDiscount = @GiaTri;                               -- Giá trị giảm giá cố định từ GiaTri

    -- Kiểm tra điều kiện tổng chi phí
    IF (@SoTienDaThanhToan + @DiscountAmount + @CodeDiscount + @FixedDiscount - @ChiPhi >= 0)
    BEGIN
        RETURN @SoTienDaThanhToan + @DiscountAmount + @CodeDiscount + @FixedDiscount - @ChiPhi;
    END;
	return 0;
END;

go
drop function tinhtien;
DECLARE @SoTienThanhToan DECIMAL(18,2);
set @SoTienThanhToan = dbo.tinhtien(2,1);
SELECT @SoTienThanhToan AS Sotienthanhtoan;

select * from LopHocNauAn_HocVien where LopHocNauAn_HocVien.HocVienId = 1 and LopHocNauAn_HocVien.LopHocNauAnId = 2
select * from LopHocNauAn_HocVien

@SoTienDaThanhToan + @FixedDiscount - @ChiPhi

drop trigger trg_UpdateTrangThaiThanhToan
INSERT INTO LopHocNauAn 
VALUES (3, '2024-10-28', 1000, '08:00:00', '12:00:00');
-- Bước 1: Thêm lớp học và mã giảm giá mẫu
INSERT INTO LichHoc (MaLopHoc, Ngay, ChiPhi, ThoiGianBatDau, ThoiGianKetThuc)
VALUES (1, '2024-10-28', 1000, '08:00:00', '12:00:00');

INSERT INTO MaGiamGia (GiaTri, Loai, PhanTramGiamGia, code)
VALUES (100, 'Giảm cố định', 10, 5);

-- Bước 2: Thêm học viên
INSERT INTO HocVien (user_id, HoTen, GioiTinh, NgaySinh, NgayDangKy, Mail, Sdt)
VALUES (1, N'Trần Văn A', 1, '2000-01-01', GETDATE(), 'vana@example.com', '0912345678');
select * from HocVien;
-- Bước 3: Thêm bản ghi vào LopHocNauAn_HocVien để kích hoạt trigger
INSERT INTO LopHocNauAn_HocVien 
    (LopHocNauAnId, HocVienId, NgayGioDangKy, TrangThaiDangKy, SoTienDaThanhToan, HinhThucThanhToan, MaGiamGia)
VALUES 
    (1, 1, GETDATE(), N'Đăng ký', 900, 1, 1);

-- Bước 4: Kiểm tra xem trigger đã cập nhật `TrangThaiThanhToan` chưa
SELECT * FROM LopHocNauAn_HocVien WHERE LopHocNauAnId = 1 AND HocVienId = 1;

INSERT INTO LichHoc (MaLopHoc, Ngay, ChiPhi, ThoiGianBatDau, ThoiGianKetThuc)
VALUES 
    (3, '2024-11-01', 500000, '09:00', '11:00')
   
   INSERT INTO MaGiamGia (GiaTri, Loai, PhanTramGiamGia, code)
VALUES 
    (50000, 'Khuyến mãi', 10, 20),
    (75000, 'Mã đặc biệt', 15, 25),
    (100000, 'Giảm giá lớn', 20, 30);
	update LopHocNauAn_HocVien set LopHocNauAn_HocVien.SoTienDaThanhToan=330000 where LopHocNauAn_HocVien.HocVienId = 1

	INSERT INTO LopHocNauAn_HocVien (LopHocNauAnId, HocVienId, NgayGioDangKy, TrangThaiDangKy, SoTienDaThanhToan, HinhThucThanhToan, TrangThaiThanhToan, MaGiamGia)
VALUES 
    (3, 4, '2024-10-28 09:00', 'Đăng ký', 450000, 1, 'Chưa thanh toán', 1)
  select * from LopHocNauAn_HocVien
  select * from MaGiamGia;

  DECLARE @SoTienThanhToan DECIMAL(18,2)
set @SoTienThanhToan = dbo.tinhtien(2,1);
SELECT @SoTienThanhToan AS Sotienthanhtoan;
CREATE TRIGGER trg_Update
ON LopHocNauAn_HocVien
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @LopHocNauAnId INT, @HocVienId INT, @SoTienDaThanhToan DECIMAL(18, 2),
            @HinhThucThanhToan BIT, @TrangThaiThanhToan NVARCHAR(255),
            @MaGiamGia INT, @Code INT, @ChiPhi DECIMAL(18,2), @PhanTramGiamGia INT,
            @DiscountAmount DECIMAL(18,2), @CodeDiscount DECIMAL(18,2),
            @GiaTri DECIMAL(18,2), @FixedDiscount DECIMAL(18,2);

    -- Lấy các giá trị từ bảng `inserted`
    SELECT @LopHocNauAnId = i.LopHocNauAnId, 
           @HocVienId = i.HocVienId,
           @SoTienDaThanhToan = i.SoTienDaThanhToan,
           @HinhThucThanhToan = i.HinhThucThanhToan,
           @TrangThaiThanhToan = i.TrangThaiThanhToan,
           @MaGiamGia = i.MaGiamGia
    FROM inserted i;

    -- Lấy ChiPhi từ bảng LichHoc
    SELECT @ChiPhi = lh.ChiPhi
    FROM LichHoc lh
    WHERE lh.MaLopHoc = @LopHocNauAnId;

    -- Lấy PhanTramGiamGia và GiaTri từ bảng MaGiamGia (nếu có)
    IF (@MaGiamGia IS NOT NULL)
    BEGIN
        SELECT @PhanTramGiamGia = mg.PhanTramGiamGia,
               @GiaTri = mg.GiaTri
        FROM MaGiamGia mg
        WHERE mg.Ma = @MaGiamGia;
    END
    ELSE
    BEGIN
        SET @PhanTramGiamGia = 0;
        SET @GiaTri = 0;
    END;

    -- Tính giá trị giảm giá phần trăm từ PhanTramGiamGia và code, và giá trị giảm giá cố định từ GiaTri
    SET @DiscountAmount = (@PhanTramGiamGia / 100.0) * @ChiPhi; -- Giảm giá phần trăm từ PhanTramGiamGia
    SET @CodeDiscount = (@Code / 100.0) * @ChiPhi; -- Giảm giá phần trăm từ code
    SET @FixedDiscount = @GiaTri; -- Giá trị giảm giá cố định từ GiaTri

    -- Kiểm tra điều kiện tổng chi phí và cập nhật `TrangThaiThanhToan` nếu thỏa mãn
	CREATE TRIGGER trg_Update
ON LopHocNauAn_HocVien
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @LopHocNauAnId INT, @HocVienId INT, @SoTienDaThanhToan DECIMAL(18, 2),
            @HinhThucThanhToan BIT, @TrangThaiThanhToan NVARCHAR(255),
            @MaGiamGia INT, @Code INT, @ChiPhi DECIMAL(18,2), @PhanTramGiamGia INT,
            @DiscountAmount DECIMAL(18,2), @CodeDiscount DECIMAL(18,2),
            @GiaTri DECIMAL(18,2), @FixedDiscount DECIMAL(18,2);

    -- Lấy các giá trị từ bảng `inserted`
    SELECT @LopHocNauAnId = i.LopHocNauAnId, 
           @HocVienId = i.HocVienId,
           @SoTienDaThanhToan = i.SoTienDaThanhToan,
           @HinhThucThanhToan = i.HinhThucThanhToan,
           @TrangThaiThanhToan = i.TrangThaiThanhToan,
           @MaGiamGia = i.MaGiamGia
    FROM inserted i;

    -- Lấy ChiPhi từ bảng LichHoc
    SELECT @ChiPhi = lh.ChiPhi
    FROM LichHoc lh
    WHERE lh.MaLopHoc = @LopHocNauAnId;

    -- Lấy PhanTramGiamGia và GiaTri từ bảng MaGiamGia (nếu có)
    -- Lấy PhanTramGiamGia và GiaTri từ bảng MaGiamGia (nếu có)
IF (@MaGiamGia IS NOT NULL)
BEGIN
    SELECT 
        @PhanTramGiamGia = ISNULL(mg.PhanTramGiamGia, 0),
        @GiaTri = ISNULL(mg.GiaTri, 0),
        @Code = ISNULL(mg.code, 0)
    FROM MaGiamGia mg
    WHERE mg.Ma = @MaGiamGia;
END
ELSE
BEGIN
    SET @PhanTramGiamGia = 0;
    SET @GiaTri = 0;
    SET @Code = 0;
END;


    -- Tính giá trị giảm giá phần trăm từ PhanTramGiamGia và code, và giá trị giảm giá cố định từ GiaTri
    SET @DiscountAmount = (@PhanTramGiamGia / 100.0) * @ChiPhi; -- Giảm giá phần trăm từ PhanTramGiamGia
    SET @CodeDiscount = (@Code / 100.0) * @ChiPhi; -- Giảm giá phần trăm từ code
    SET @FixedDiscount = @GiaTri; -- Giá trị giảm giá cố định từ GiaTri

    -- Kiểm tra điều kiện tổng chi phí và cập nhật `TrangThaiThanhToan` nếu thỏa mãn
        UPDATE LopHocNauAn_HocVien
        SET  LopHocNauAn_HocVien.SoTienDaThanhToan =  @PhanTramGiamGia + @Code + @GiaTri
		 WHERE LopHocNauAnId = @LopHocNauAnId AND HocVienId = @HocVienId
END;
drop TRIGGER trg_Update
select * from LopHocNauAn_HocVien
update LopHocNauAn_HocVien set LopHocNauAn_HocVien.SoTienDaThanhToan = 330000 where LopHocNauAn_HocVien.HocVienId = 1;
select * from MaGiamGia;