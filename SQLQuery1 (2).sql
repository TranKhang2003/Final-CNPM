create database QLLHNA;
go
use QLLHNA;
go
-- Roles Table
	CREATE TABLE Users (
		id int IDENTITY(1,1) PRIMARY KEY,        -- Mã người dùng (PK)
		HoTen NVARCHAR(255) unique,            -- Họ và tên người dùng
		MatKhau NVARCHAR(255)        -- Mật khẩu người dùng
	);

	-- Bảng Roles
	CREATE TABLE Roles (
		id int IDENTITY(1,1) PRIMARY KEY,        -- Mã vai trò (PK)
		RoleName NVARCHAR(255)              -- Tên vai trò
	);

	-- Bảng User_Role: Bảng trung gian quản lý mối quan hệ nhiều-nhiều giữa User và Roles
	CREATE TABLE User_Role (
		UserId int,                -- Mã người dùng (FK)
		RoleId int,                -- Mã vai trò (FK)
		PRIMARY KEY (UserId, RoleId),       -- Khóa chính kết hợp giữa UserId và RoleId
		FOREIGN KEY (UserId) REFERENCES Users(id) ON DELETE CASCADE,  -- FK tham chiếu tới bảng User
		FOREIGN KEY (RoleId) REFERENCES Roles(id) ON DELETE CASCADE  -- FK tham chiếu tới bảng Roles
		)
	-- Giáo Viên (Teacher) Table
	CREATE TABLE GiaoVien (
		id int IDENTITY(1,1) PRIMARY KEY,
		user_id int,
		HoTen NVARCHAR(255),
		NgaySinh DATE,
		GioiTinh BIT,
		ChuyenMon NVARCHAR(255),
		SoNamKinhNghiem INT check (SoNamKinhNghiem > 0),
		Sdt NVARCHAR(20),
		Email NVARCHAR(255),
		Luong DECIMAL(18,2) check (Luong > 0),
		foreign key (user_id) references Users(id) on delete cascade
	);

	-- Món Ăn Table
	CREATE TABLE MonAn (
		TenMon NVARCHAR(255) PRIMARY KEY,
		HinhAnhMon nvarchar(255),
		LoaiMon NVARCHAR(255)
	);

	-- Lớp Học Nấu Ăn (Cooking Class) Table
	CREATE TABLE LopHocNauAn (
		MaLopHoc int IDENTITY(1,1) PRIMARY KEY,
		MonAn NVARCHAR(255), -- Tên món ăn
		GiaoVienId int, -- ID giáo viên
		DiaDiem NVARCHAR(255), -- Địa điểm lớp học
		SoNguoiDangKy INT CHECK (SoNguoiDangKy >= 0) default 0, -- Số người đăng kí	
		SoNguoiDangKyToiDA INT CHECK (SoNguoiDangKyToiDA >= 0),
		ThongTin nvarchar(400),
		GhiChu NVARCHAR(255), -- Ghi chú thêm
		FOREIGN KEY (MonAn) REFERENCES MonAn(TenMon) on delete cascade, -- Khóa ngoại tham chiếu đến bảng món ăn
		FOREIGN KEY (GiaoVienId) REFERENCES GiaoVien(id) on delete cascade -- Khóa ngoại tham chiếu đến bảng giáo viên
	);
	create table ChiTietLopHoc (
		MaLopHocChiTiet int identity(1,1),
		MaLopHoc int,
		PhiDiaDiem decimal(18,2),
		TongThu DECIMAL(18,2) CHECK (TongThu >= 0), -- Tổng thu nhập
		GiamGia DECIMAL(18,2) CHECK (GiamGia >= 0), -- Tổng giảm giá
		TienHoanLai DECIMAL(18,2) CHECK (TienHoanLai >= 0), -- Chiết khấu
		NguyenLieu DECIMAL(18,2) CHECK (NguyenLieu >= 0), -- tiền mua nguyên liệu
		PhiKhac DECIMAL(18,2) CHECK (PhiKhac >= 0),
		ThucThu DECIMAL(18,2) CHECK (ThucThu >= 0), -- Số tiền thực thu
		TrangThai NVARCHAR(50), -- Trạng thái lớp học: 'Đang diễn ra', 'Đã hủy', 'Hoàn thành'
		primary key (MaLopHocChiTiet,MaLopHoc),
		FOREIGN KEY (MaLopHoc) REFERENCES LopHocNauAn(MaLopHoc) on delete cascade
	)
	create table ThongTinQuangCaoLopHoc (
		 MaThongTin int identity(1,1),
		 MaLopHoc int ,
		 IdNguoiViet int,
		 TrangThaiBaiDang bit,
		 ChayADS bit,
		 primary key(MaThongTin,MaLopHoc),
		 FOREIGN KEY (MaLopHoc) REFERENCES LopHocNauAn(MaLopHoc) on delete cascade
	)

	create Table LichHoc (
		MaLichHoc int identity(1,1),
		MaLopHoc int,
		Ngay DATETIME,
		ChiPhi DECIMAL(18,2) CHECK (ChiPhi >= 0), -- Chi phí lớp học
		ThoiGianBatDau TIME,
		ThoiGianKetThuc TIME,
		primary key(MaLichHoc,MaLopHoc),
		FOREIGN KEY (MaLopHoc) REFERENCES LopHocNauAn(MaLopHoc) on delete cascade,
	)

	-- Lớp Học Có Phí (Paid Cooking Class) Table
	CREATE TABLE LopHocCoPhi (
		MaLopHoc int IDENTITY(1,1) PRIMARY KEY,
		LopHocNauAnId int,
		FOREIGN KEY (LopHocNauAnId) REFERENCES LopHocNauAn(MaLopHoc) on delete cascade
	);

	-- Lớp Học Miễn Phí (Free Cooking Class) Table
	CREATE TABLE LopHocMienPhi (
		MaLopHoc int IDENTITY(1,1) PRIMARY KEY,
		NhanHangHocTac NVARCHAR(255),
		LopHocNauAnId int ,
		FOREIGN KEY (LopHocNauAnId) REFERENCES LopHocNauAn(MaLopHoc) on delete cascade
	);

	-- Mã Giảm Giá (Discount Codes) Table
	CREATE TABLE MaGiamGia (
		Ma int IDENTITY(1,1) PRIMARY KEY,
		GiaTri DECIMAL(18,2),
		Loai nvarchar(255),
		PhanTramGiamGia int default 0 check ( PhanTramGiamGia < 100),
		code int  check ( code < 100)
	);

	-- Học Viên (Student) Table
	CREATE TABLE HocVien (
		id int IDENTITY(1,1) PRIMARY KEY,
		user_id int ,
		HoTen NVARCHAR(255),
		GioiTinh BIT,
		NgaySinh DATE,
		NgayDangKy DATE,
		GhiChu NVARCHAR(255),
		Mail NVARCHAR(255),
		Sdt char(10),
		foreign key (user_id) references Users(id) on delete cascade,
	);

	-- Join Table for Lớp Học Nấu Ăn and Học Viên (Many-to-Many Relationship)
	CREATE TABLE LopHocNauAn_HocVien (
    LopHocNauAnId int ,
    HocVienId int ,
    NgayGioDangKy DATETIME, -- Ghi nhận ngày giờ học viên đăng ký
    TrangThaiDangKy NVARCHAR(50), -- Trạng thái: 'Đăng ký', 'Đã hủy', 'Hoàn tiền', 'Bảo lưu'
    SoTienDaThanhToan DECIMAL(18,2),
    HinhThucThanhToan BIT, -- '1': Chuyển khoản, '0': Tiền mặt
    TrangThaiThanhToan nvarchar(255),
    MaGiamGia int,
    PRIMARY KEY (LopHocNauAnId, HocVienId),
    FOREIGN KEY (MaGiamGia) REFERENCES MaGiamGia(Ma),
    FOREIGN KEY (LopHocNauAnId) REFERENCES LopHocNauAn(MaLopHoc),
    FOREIGN KEY (HocVienId) REFERENCES HocVien(id) 
);

	-- Hoàn Tiền và Bảo Lưu (Refunds and Transfers) Table
	CREATE TABLE HoanTienBaoLuu (
		Id int IDENTITY(1,1) PRIMARY KEY,
		HocVienId int ,
		LopHocNauAnId int ,
		SoTienHoanLai DECIMAL(18,2),
		TrangThai NVARCHAR(50),  -- 'Hoàn tiền' hoặc 'Bảo lưu'
		LopHocChuyenSangId int ,  -- Mã lớp học nếu chuyển tiếp
	);

	-- Bảng đánh giá lớp học
	CREATE TABLE DanhGiaLopHoc (
		Id int IDENTITY(1,1) PRIMARY KEY,
		MaLopHoc int,                  -- Khóa ngoại tham chiếu đến bảng LopHocNauAn
		HocVienId int,                 -- Khóa ngoại tham chiếu đến bảng HocVien
		DiemDanhGia int CHECK (DiemDanhGia >= 1 AND DiemDanhGia <= 10), -- Điểm đánh giá từ 1 đến 10
		NhanXet NVARCHAR(500),         -- Nhận xét của học viên về lớp học
		NgayDanhGia DATE DEFAULT GETDATE(), -- Ngày đánh giá
	);

	-- Bảng đánh giá học viên
	CREATE TABLE DanhGiaHocVien (
		Id int IDENTITY(1,1) PRIMARY KEY,
		MaLopHoc int,                  -- Khóa ngoại tham chiếu đến bảng LopHocNauAn
		HocVienId int,                 -- Khóa ngoại tham chiếu đến bảng HocVien
		GiaoVienId int,                -- Khóa ngoại tham chiếu đến bảng GiaoVien
		NhanXet NVARCHAR(500),         -- Nhận xét của giảng viên về học viên
		NgayDanhGia DATE DEFAULT GETDATE(), -- Ngày đánh giá
	);

go
--PROCEDURE
---PROCEDURE về User
----PROCEDURE về việc tạo người dùng
CREATE PROCEDURE P_AddUser
(
    @HoTen NVARCHAR(255),
    @MatKhau NVARCHAR(255),
    @UserId INT OUTPUT  -- Biến OUTPUT để trả về id của người dùng
)
AS
BEGIN
    BEGIN TRY
        -- Thêm người dùng mới
        INSERT INTO Users (HoTen, MatKhau)
        VALUES (@HoTen, @MatKhau);

        -- Lấy id của người dùng mới tạo
        SET @UserId = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        SET @UserId = NULL;
    END CATCH;
END;

go
----PROCEDURE về xem người dùng
CREATE PROCEDURE P_ViewUser
AS
BEGIN
    select * from Users;
END;
go
----PROCEDURE về tìm kiếm người dùng
CREATE PROCEDURE P_ViewUserByUsername
@Username nvarchar(255)
AS
BEGIN
    select * from Users where HoTen like @Username
END;
go
----PROCEDURE về việc cập nhật mật khẩu
CREATE PROCEDURE P_UpdatePassword
(
    @UserId INT,                  -- ID của người dùng cần cập nhật
    @NewPassword NVARCHAR(255)    -- Mật khẩu mới
)
AS
BEGIN
        -- Cập nhật mật khẩu cho người dùng
        UPDATE Users
        SET MatKhau = @NewPassword
        WHERE id = @UserId
END;
go
----PROCEDURE về việc xóa người dùng
create procedure P_DeleteUser
( @userId int )
as
begin 
delete from Users where Users.id = @userId
end;
go
----PROCEDURE về việc thêm vai trò cho user 
create procedure P_AddRoleForUser
	 @userId int , @roleId int
as
begin
	insert into User_Role
	values (@userId,@roleId)
end;
go
---PROCEDURE về GiaoVien
----PROCEDURE thêm giáo viên 
CREATE PROCEDURE P_AddGiaoVien
	@UserId int,
    @HoTen NVARCHAR(255),              -- Họ và Tên
    @NgaySinh DATE,                    -- Ngày sinh
    @GioiTinh BIT,                     -- Giới tính
    @ChuyenMon NVARCHAR(255),          -- Chuyên môn
    @SoNamKinhNghiem INT,              -- Số năm kinh nghiệm (phải > 0)
    @Sdt NVARCHAR(20),                 -- Số điện thoại
    @Email NVARCHAR(255),              -- Email
    @Luong DECIMAL(18, 2)              -- Lương (phải > 0)
AS
BEGIN
    INSERT INTO GiaoVien (user_id,HoTen, NgaySinh, GioiTinh, ChuyenMon, SoNamKinhNghiem, Sdt, Email, Luong)
    VALUES (@UserId,@HoTen, @NgaySinh, @GioiTinh, @ChuyenMon, @SoNamKinhNghiem, @Sdt, @Email, @Luong);
END;
----PROCEDURE sửa giáo viên 
go
CREATE PROCEDURE P_UpdateGiaoVien
    @Id INT,                           -- ID của giáo viên cần cập nhật
    @HoTen NVARCHAR(255) = NULL,       -- Họ và Tên
    @NgaySinh DATE = NULL,             -- Ngày sinh 
    @GioiTinh BIT = NULL,              -- Giới tính 
    @ChuyenMon NVARCHAR(255) = NULL,   -- Chuyên môn 
    @SoNamKinhNghiem INT = NULL,       -- Số năm kinh nghiệm 
    @Sdt NVARCHAR(20) = NULL,          -- Số điện thoại 
    @Email NVARCHAR(255) = NULL,       -- Email 
    @Luong DECIMAL(18, 2) = NULL       -- Lương
AS
BEGIN
    UPDATE GiaoVien
    SET 
        HoTen = ISNULL(@HoTen, HoTen),
        NgaySinh = ISNULL(@NgaySinh, NgaySinh),
        GioiTinh = ISNULL(@GioiTinh, GioiTinh),
        ChuyenMon = ISNULL(@ChuyenMon, ChuyenMon),
        SoNamKinhNghiem = ISNULL(@SoNamKinhNghiem, SoNamKinhNghiem),
        Sdt = ISNULL(@Sdt, Sdt),
        Email = ISNULL(@Email, Email),
        Luong = ISNULL(@Luong, Luong)
    WHERE id = @Id;
END;
go
----PROCEDURE xem giáo viên
create procedure P_ViewGiaoVien
as
begin
select * from GiaoVien;
end;
go
----PROCEDURE xem giáo viên
create procedure P_ViewGiaoVienByName
@TenGiaoVien nvarchar(255)
as
begin
select * from GiaoVien where GiaoVien.HoTen like '%'+@TenGiaoVien+'%';
end;
go
---PROCEDURE về MonAn
----PROCEDURE thêm món ăn
CREATE PROCEDURE P_AddMonAn
    @TenMon NVARCHAR(255),           -- Tên món ăn (khóa chính)
    @HinhAnhMon NVARCHAR(255),       -- Hình ảnh món ăn
    @LoaiMon NVARCHAR(255)           -- Loại món ăn
AS
BEGIN
    INSERT INTO MonAn (TenMon, HinhAnhMon, LoaiMon)
    VALUES (@TenMon, @HinhAnhMon, @LoaiMon);
END;
go
----PROCEDURE cập nhật món ăn
CREATE PROCEDURE P_UpdateMonAn
    @TenMon NVARCHAR(255),           -- Tên món ăn (khóa chính)
    @HinhAnhMon NVARCHAR(255)     -- Hình ảnh món ăn
AS
BEGIN
	update MonAn set HinhAnhMon = @HinhAnhMon where MonAn.TenMon = @TenMon;
END;
go
----PROCEDURE xóa món ăn
CREATE PROCEDURE P_DeleteMonAn
    @TenMon NVARCHAR(255)         -- Tên món ăn (khóa chính)
AS
BEGIN
	delete from MonAn where MonAn.TenMon = @TenMon;
END;
go
----PROCEDURE xem món ăn
CREATE PROCEDURE P_ViewMonAn
AS
BEGIN
	select * from MonAn;
END;
go
----PROCEDURE tìm món ăn
CREATE PROCEDURE P_ViewMonAnByName
@Name nvarchar(255)
AS
BEGIN
	select * from MonAn where TenMon like '%' + @Name + '%'
END;
go
---PROCEDURE về LopHoc
----PROCEDURE về thêm LopHoc
CREATE PROCEDURE P_AddLopHocNauAn
    @MonAn NVARCHAR(255),           -- Tên món ăn
    @GiaoVienId INT,                -- ID giáo viên
    @DiaDiem NVARCHAR(255),         -- Địa điểm lớp học
	@SoNguoiDangKyToiDA INT ,
    @ThongTin NVARCHAR(400) = NULL, -- Thông tin lớp học
    @GhiChu NVARCHAR(255) = NULL,   -- Ghi chú thêm
    @MaLopHoc INT OUTPUT             -- Tham số đầu ra để trả về mã lớp học
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO LopHocNauAn (MonAn, GiaoVienId, DiaDiem, ThongTin, GhiChu, SoNguoiDangKyToiDA)
    VALUES (@MonAn, @GiaoVienId, @DiaDiem, @ThongTin, @GhiChu, @SoNguoiDangKyToiDA);
    SET @MaLopHoc = SCOPE_IDENTITY();
END;
go
----PROCEDURE về sửa LopHoc
CREATE PROCEDURE P_UpdateLopHocNauAn
    @MaLopHoc INT,                   -- Mã lớp học cần cập nhật
    @MonAn NVARCHAR(255) = NULL,     -- Tên món ăn (NULL nếu không cập nhật)
    @GiaoVienId INT = NULL,          -- ID giáo viên (NULL nếu không cập nhật)
    @DiaDiem NVARCHAR(255) = NULL,   -- Địa điểm lớp học (NULL nếu không cập nhật)
	@SoNguoiDangKyToiDA INT = null,
    @ThongTin NVARCHAR(400) = NULL,  -- Thông tin lớp học (NULL nếu không cập nhật)
    @GhiChu NVARCHAR(255) = NULL      -- Ghi chú thêm (NULL nếu không cập nhật)
AS
BEGIN
    UPDATE LopHocNauAn
    SET 
        MonAn = ISNULL(@MonAn, MonAn),
        GiaoVienId = ISNULL(@GiaoVienId, GiaoVienId),
        DiaDiem = ISNULL(@DiaDiem, DiaDiem),
        ThongTin = ISNULL(@ThongTin, ThongTin),
        GhiChu = ISNULL(@GhiChu, GhiChu),
		SoNguoiDangKyToiDA = ISNULL(@SoNguoiDangKyToiDA,SoNguoiDangKyToiDA)
    WHERE MaLopHoc = @MaLopHoc;
END;
go
----PROCEDURE về xóa LopHoc
CREATE PROCEDURE P_DeleteLopHocNauAn
    @MaLopHoc INT                    -- Mã lớp học cần xóa
AS
BEGIN
    DELETE FROM LopHocNauAn
    WHERE MaLopHoc = @MaLopHoc;
END;
go
----PROCEDURE về xem LopHoc
CREATE PROCEDURE P_ViewLopHocNauAn            
AS
BEGIN
    select * from LopHocNauAn;
END;
go
---PROCEDURE về Chi tiết lớp học
----PROCEDURE thêm chi tiết lớp học 
CREATE PROCEDURE P_AddChiTietLopHoc
    @MaLopHoc INT,                   -- Mã lớp học
    @PhiDiaDiem DECIMAL(18, 2),      -- Phí địa điểm
    @TongThu DECIMAL(18, 2) = NULL,  -- Tổng thu nhập (có thể NULL)
    @GiamGia DECIMAL(18, 2) = NULL,  -- Tổng giảm giá (có thể NULL)
    @TienHoanLai DECIMAL(18, 2) = NULL, -- Chiết khấu (có thể NULL)
    @NguyenLieu DECIMAL(18, 2) = NULL, -- Tiền mua nguyên liệu (có thể NULL)
    @PhiKhac DECIMAL(18, 2) = NULL,  -- Phí khác (có thể NULL)
    @ThucThu DECIMAL(18, 2) = NULL,  -- Số tiền thực thu (có thể NULL)
    @TrangThai NVARCHAR(50)          -- Trạng thái lớp học
AS
BEGIN
    INSERT INTO ChiTietLopHoc (MaLopHoc, PhiDiaDiem, TongThu, GiamGia, TienHoanLai, NguyenLieu, PhiKhac, ThucThu, TrangThai)
    VALUES (@MaLopHoc, @PhiDiaDiem, @TongThu, @GiamGia, @TienHoanLai, @NguyenLieu, @PhiKhac, @ThucThu, @TrangThai);
END;
go
----PROCEDURE sửa chi tiết lớp học
CREATE PROCEDURE P_UpdateChiTietLopHoc
    @MaLopHocChiTiet INT,            -- Mã chi tiết lớp học cần cập nhật
    @MaLopHoc INT = NULL,             -- Mã lớp học
    @PhiDiaDiem DECIMAL(18, 2) = NULL, -- Phí địa điểm 
    @TongThu DECIMAL(18, 2) = NULL,  -- Tổng thu nhập 
    @GiamGia DECIMAL(18, 2) = NULL,  -- Tổng giảm giá 
    @TienHoanLai DECIMAL(18, 2) = NULL, -- Chiết khấu 
    @NguyenLieu DECIMAL(18, 2) = NULL, -- Tiền mua nguyên liệu 
    @PhiKhac DECIMAL(18, 2) = NULL,   -- Phí khác 
    @ThucThu DECIMAL(18, 2) = NULL,   -- Số tiền thực thu 
    @TrangThai NVARCHAR(50) = NULL     -- Trạng thái lớp học
	as
BEGIN
    UPDATE ChiTietLopHoc
    SET 
        MaLopHoc = ISNULL(@MaLopHoc, MaLopHoc),
        PhiDiaDiem = ISNULL(@PhiDiaDiem, PhiDiaDiem),
        TongThu = ISNULL(@TongThu, TongThu),
        GiamGia = ISNULL(@GiamGia, GiamGia),
        TienHoanLai = ISNULL(@TienHoanLai, TienHoanLai),
        NguyenLieu = ISNULL(@NguyenLieu, NguyenLieu),
        PhiKhac = ISNULL(@PhiKhac, PhiKhac),
        ThucThu = ISNULL(@ThucThu, ThucThu),
        TrangThai = ISNULL(@TrangThai, TrangThai)
    WHERE MaLopHocChiTiet = @MaLopHocChiTiet;
END;
go
----PROCEDURE về xem tất cả ChiTietLopHoc
CREATE PROCEDURE P_ViewChiTietLopHoc
AS
BEGIN
    select * from ChiTietLopHoc
END;
go
----PROCEDURE về xem ChiTietLopHoc
CREATE PROCEDURE P_ViewChiTietLopHocById
	@Id int
AS
BEGIN
    select * from ChiTietLopHoc where ChiTietLopHoc.MaLopHocChiTiet = @id
END;
go
----PROCEDURE về xem ThongTinLopHoc
CREATE PROCEDURE P_ViewThongTinLopHoc
	@Id int
AS
BEGIN
    select * from LopHocNauAn,ChiTietLopHoc where LopHocNauAn.MaLopHoc = ChiTietLopHoc.MaLopHoc and ChiTietLopHoc.MaLopHocChiTiet = @Id
END;
go
---PROCEDURE về Việc quảng cáo lớp học
----PROCEDURE về thêm quảng cáo lớp học
CREATE PROCEDURE P_AddThongTinQuangCao
    @MaLopHoc INT,
    @IdNguoiViet INT,
    @TrangThaiBaiDang BIT,
    @ChayADS BIT
AS
BEGIN
    INSERT INTO ThongTinQuangCaoLopHoc (MaLopHoc, IdNguoiViet, TrangThaiBaiDang, ChayADS)
    VALUES (@MaLopHoc, @IdNguoiViet, @TrangThaiBaiDang, @ChayADS);
END;
go
----PROCEDURE về sửa quảng cáo lớp học
CREATE PROCEDURE P_UpdateThongTinQuangCao
    @MaThongTin INT,
    @MaLopHoc INT,
    @IdNguoiViet INT = NULL,
    @TrangThaiBaiDang BIT = NULL,
    @ChayADS BIT = NULL
AS
BEGIN
    UPDATE ThongTinQuangCaoLopHoc
    SET 
        IdNguoiViet = ISNULL(@IdNguoiViet, IdNguoiViet),
        TrangThaiBaiDang = ISNULL(@TrangThaiBaiDang, TrangThaiBaiDang),
        ChayADS = ISNULL(@ChayADS, ChayADS)
    WHERE MaThongTin = @MaThongTin AND MaLopHoc = @MaLopHoc;
END;
go
----PROCEDURE về xóa quảng cáo lớp học
CREATE PROCEDURE P_DeleteThongTinQuangCao
    @MaLopHoc INT
AS
BEGIN
    DELETE FROM ThongTinQuangCaoLopHoc
    WHERE MaLopHoc = @MaLopHoc;
END;
go
----PROCEDURE về xem quảng cáo lớp học
CREATE PROCEDURE P_ViewThongTinQuangCao
AS
BEGIN
   select * from ThongTinQuangCaoLopHoc;
END;
go
----PROCEDURE về tìm quảng cáo lớp học
CREATE PROCEDURE P_ViewThongTinQuangCaoByMaLop
@Id int
AS
BEGIN
   select * from ThongTinQuangCaoLopHoc where ThongTinQuangCaoLopHoc.MaLopHoc = @Id;
END;
go
---PROCEDURE về Lịch học 
----PROCEDURE thêm lịch học
CREATE PROCEDURE P_AddLichHoc
    @MaLopHoc INT,                    -- Mã lớp học
    @Ngay DATETIME,                   -- Ngày diễn ra lớp học
    @ChiPhi DECIMAL(18,2),            -- Chi phí lớp học
    @ThoiGianBatDau TIME,             -- Thời gian bắt đầu
    @ThoiGianKetThuc TIME              -- Thời gian kết thúc
AS
BEGIN
    INSERT INTO LichHoc (MaLopHoc, Ngay, ChiPhi, ThoiGianBatDau, ThoiGianKetThuc)
    VALUES (@MaLopHoc, @Ngay, @ChiPhi, @ThoiGianBatDau, @ThoiGianKetThuc);
END;
go
--- PROCEDURE về sửa LichHoc
CREATE PROCEDURE P_UpdateLichHoc
    @MaLichHoc INT,                   -- Mã lịch học cần cập nhật
    @MaLopHoc INT,                    -- Mã lớp học (khóa ngoại)
    @Ngay DATETIME = NULL,            -- Ngày diễn ra lớp học (NULL nếu không cập nhật)
    @ChiPhi DECIMAL(18,2) = NULL,     -- Chi phí lớp học (NULL nếu không cập nhật)
    @ThoiGianBatDau TIME = NULL,      -- Thời gian bắt đầu (NULL nếu không cập nhật)
    @ThoiGianKetThuc TIME = NULL       -- Thời gian kết thúc (NULL nếu không cập nhật)
AS
BEGIN
    UPDATE LichHoc
    SET 
        Ngay = ISNULL(@Ngay, Ngay),
        ChiPhi = ISNULL(@ChiPhi, ChiPhi),
        ThoiGianBatDau = ISNULL(@ThoiGianBatDau, ThoiGianBatDau),
        ThoiGianKetThuc = ISNULL(@ThoiGianKetThuc, ThoiGianKetThuc)
    WHERE MaLichHoc = @MaLichHoc;
END;
go
--- PROCEDURE về xem LichHoc
CREATE PROCEDURE P_ViewLichHoc
as
begin
select * from LichHoc;
end;
go
--- PROCEDURE về tìm LichHoc
CREATE PROCEDURE P_ViewLichHocByMaLop
@Id int
as
begin
select * from LichHoc where MaLopHoc = @Id;
end;
go
--- PROCEDURE về LopHocCoPhi
--- PROCEDURE về thêm LopHocCoPhi
CREATE PROCEDURE P_AddLopHocCoPhi
    @LopHocNauAnId INT                   -- Mã lớp học nấu ăn
AS
BEGIN
    INSERT INTO LopHocCoPhi (LopHocNauAnId)
    VALUES (@LopHocNauAnId);
END;
go
--- PROCEDURE về LopHocMienPhi
--- PROCEDURE về thêm LopHocMienPhi
CREATE PROCEDURE P_AddLopHocMienPhi
    @NhanHangHocTac NVARCHAR(255),        -- Nhận hàng học tác
    @LopHocNauAnId INT                    -- Mã lớp học nấu ăn
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO LopHocMienPhi (NhanHangHocTac, LopHocNauAnId)
    VALUES (@NhanHangHocTac, @LopHocNauAnId);
END;
go
--- PROCEDURE về sửa LopHocMienPhi
CREATE PROCEDURE P_UpdateLopHocMienPhi
    @NhanHangHocTac NVARCHAR(255) = NULL, 
    @LopHocNauAnId INT = NULL           
AS
BEGIN
    UPDATE LopHocMienPhi
    SET 
        NhanHangHocTac = ISNULL(@NhanHangHocTac, NhanHangHocTac)
    WHERE LopHocMienPhi.LopHocNauAnId = @LopHocNauAnId;
END;
go
--- PROCEDURE về xem LopHocMienPhi
CREATE PROCEDURE P_ViewLopHocMienPhi
                     
AS
BEGIN
    SELECT NhanHangHocTac
    FROM LopHocMienPhi;
END;
go
--- PROCEDURE về MaGiamGia
---- PROCEDURE về thêm MaGiamGia
CREATE PROCEDURE P_AddMaGiamGia
    @GiaTri DECIMAL(18,2),                    -- Giá trị giảm giá
    @Loai NVARCHAR(255) = NULL,               -- Loại giảm giá (NULL nếu không cung cấp)
    @PhanTramGiamGia INT = 0,                 -- Phần trăm giảm giá (mặc định là 0)
    @code INT = NULL                          -- Mã code (NULL nếu không cung cấp)
AS
BEGIN
    INSERT INTO MaGiamGia (GiaTri, Loai, PhanTramGiamGia, code)
    VALUES (@GiaTri, @Loai, @PhanTramGiamGia, @code);
END;
go
--- PROCEDURE về xem MaGiamGia
CREATE PROCEDURE P_ViewMaGiamGia
AS
BEGIN
    SELECT *
    FROM MaGiamGia
END;
go
--- PROCEDURE về HocVien
--- PROCEDURE về thêm HocVien
CREATE PROCEDURE P_AddHocVien
    @user_id INT,                             -- ID người dùng
    @HoTen NVARCHAR(255),                     -- Họ tên học viên
    @GioiTinh BIT,                            -- Giới tính
    @NgaySinh DATE,                           -- Ngày sinh
    @NgayDangKy DATE,                         -- Ngày đăng ký
    @GhiChu NVARCHAR(255) = NULL,             -- Ghi chú (NULL nếu không cung cấp)
    @Mail NVARCHAR(255) = NULL,               -- Email (NULL nếu không cung cấp)
    @Sdt CHAR(10) = NULL                     -- Số điện thoại (NULL nếu không cung cấp)
AS
BEGIN
    INSERT INTO HocVien (HocVien.user_id, HoTen, GioiTinh, NgaySinh, NgayDangKy, GhiChu, Mail, Sdt)
    VALUES (@user_id, @HoTen, @GioiTinh, @NgaySinh,@NgayDangKy, @GhiChu, @Mail, @Sdt);
END;
go
--- PROCEDURE về sửa HocVien
CREATE PROCEDURE P_UpdateHocVien
    @id INT,                                  -- ID học viên cần cập nhật
    @HoTen NVARCHAR(255) = NULL,             -- Họ tên học viên (NULL nếu không cập nhật)
    @GioiTinh BIT = NULL,                    -- Giới tính (NULL nếu không cập nhật)
    @NgaySinh DATE = NULL,                   -- Ngày sinh (NULL nếu không cập nhật)
 
    @NgayDangKy DATE = NULL,                 -- Ngày đăng ký (NULL nếu không cập nhật)
   
    @GhiChu NVARCHAR(255) = NULL,             -- Ghi chú (NULL nếu không cập nhật)
    @Mail NVARCHAR(255) = NULL,               -- Email (NULL nếu không cập nhật)
    @Sdt CHAR(10) = NULL                     -- Số điện thoại (NULL nếu không cập nhật)
AS
BEGIN
    UPDATE HocVien
    SET 
        HoTen = ISNULL(@HoTen, HoTen),
        GioiTinh = ISNULL(@GioiTinh, GioiTinh),
        NgaySinh = ISNULL(@NgaySinh, NgaySinh),
      
        NgayDangKy = ISNULL(@NgayDangKy, NgayDangKy),
     
        GhiChu = ISNULL(@GhiChu, GhiChu),
        Mail = ISNULL(@Mail, Mail),
        Sdt = ISNULL(@Sdt, Sdt)

    WHERE id = @id;
END;
go
--- PROCEDURE về xem HocVien
CREATE PROCEDURE P_ViewHocVien
AS
BEGIN
    SELECT *
    FROM HocVien
END;
go
--- PROCEDURE về xem HocVien
CREATE PROCEDURE P_ViewHocVienById
@Id nvarchar(255)
AS
BEGIN
    SELECT *
    FROM HocVien where id = @Id;
END;
go
--- PROCEDURE về xem HocVien theo ten
CREATE PROCEDURE P_ViewHocVienByname
@HoTen nvarchar(255)
AS
BEGIN
    SELECT *
    FROM HocVien where HoTen like @HoTen 
END;
go
--- PROCEDURE về LopHocNauAn_HocVien
--- PROCEDURE về thêm HocVien vào LopHocNauAn
-- Thủ tục thêm mới học viên đăng ký lớp học nấu ăn
CREATE PROCEDURE P_AddLopHocNauAn_HocVien
    @LopHocNauAnId INT,                     -- ID lớp học nấu ăn
    @HocVienId INT,                          -- ID học viên
    @NgayGioDangKy DATETIME,                -- Ngày giờ đăng ký
    @TrangThaiDangKy NVARCHAR(50),           -- Trạng thái đăng ký
    @SoTienDaThanhToan DECIMAL(18,2) = NULL, -- Số tiền đã thanh toán (NULL nếu không cập nhật)
    @HinhThucThanhToan BIT = NULL,           -- Hình thức thanh toán (NULL nếu không cập nhật)
    @TrangThaiThanhToan NVARCHAR(255) = NULL, -- Trạng thái thanh toán (NULL nếu không cập nhật)
    @MaGiamGia INT = NULL                    -- Mã giảm giá (NULL nếu không cung cấp)
AS
BEGIN
    INSERT INTO LopHocNauAn_HocVien
    VALUES (@LopHocNauAnId, @HocVienId, @NgayGioDangKy, @TrangThaiDangKy, @SoTienDaThanhToan, @HinhThucThanhToan, @TrangThaiThanhToan, @MaGiamGia);
END;
GO

-- Thủ tục cập nhật thông tin học viên đăng ký lớp học nấu ăn
CREATE PROCEDURE P_UpdateLopHocNauAn_HocVien
    @LopHocNauAnId INT,                     -- ID lớp học nấu ăn
    @HocVienId INT,                          -- ID học viên
    @NgayGioDangKy DATETIME = NULL,         -- Ngày giờ đăng ký (NULL nếu không cập nhật)
    @TrangThaiDangKy NVARCHAR(50) = NULL ,  -- Trạng thái đăng ký (NULL nếu không cập nhật)
    @SoTienDaThanhToan DECIMAL(18,2) = NULL, -- Số tiền đã thanh toán (NULL nếu không cập nhật)
    @HinhThucThanhToan BIT = NULL,           -- Hình thức thanh toán (NULL nếu không cập nhật)
    @TrangThaiThanhToan NVARCHAR(255) = NULL, -- Trạng thái thanh toán (NULL nếu không cập nhật)
    @MaGiamGia INT = NULL                    -- Mã giảm giá (NULL nếu không cập nhật)
AS
BEGIN
    UPDATE LopHocNauAn_HocVien
    SET 
        NgayGioDangKy = ISNULL(@NgayGioDangKy, NgayGioDangKy),
        TrangThaiDangKy = ISNULL(@TrangThaiDangKy, TrangThaiDangKy),
        SoTienDaThanhToan = ISNULL(@SoTienDaThanhToan, SoTienDaThanhToan),
        HinhThucThanhToan = ISNULL(@HinhThucThanhToan, HinhThucThanhToan),
        TrangThaiThanhToan = ISNULL(@TrangThaiThanhToan, TrangThaiThanhToan),
        MaGiamGia = ISNULL(@MaGiamGia, MaGiamGia)
    WHERE LopHocNauAnId = @LopHocNauAnId AND HocVienId = @HocVienId;
END;
GO
--- PROCEDURE về xem thông tin HocVien trong LopHocNauAn
CREATE PROCEDURE P_ViewLopHocNauAn_HocVien_LopHocId
    @LopHocNauAnId INT                                          
AS
BEGIN
    SET NOCOUNT ON;

    -- Lấy thông tin học viên đăng ký lớp học
    SELECT *
    FROM LopHocNauAn_HocVien
    WHERE LopHocNauAnId = @LopHocNauAnId;
END;
go
CREATE PROCEDURE P_ViewLopHocNauAn_HocVien_HocVienId
    @HocVienId int                                      
AS
BEGIN

    SELECT *
    FROM LopHocNauAn_HocVien
    WHERE HocVienId = @HocVienId;
END;
go
--PROCEDURE về hủy HocVien trong LopHocNauAn
create procedure P_DeleteLopHocNauAn_HocVien_HocVienId
 @HocVienId int  ,  
 @LopHocId int
AS
BEGIN

    delete
    FROM LopHocNauAn_HocVien
    WHERE HocVienId = @HocVienId and LopHocNauAn_HocVien.LopHocNauAnId = @LopHocId
END;
go
--- PROCEDURE về HoanTienBaoLuu
--- PROCEDURE về thêm Hoàn Tiền hoặc Bảo Lưu
CREATE PROCEDURE P_AddHoanTienBaoLuu
    @HocVienId INT,                           -- ID học viên
    @LopHocNauAnId INT,                      -- ID lớp học nấu ăn
    @SoTienHoanLai DECIMAL(18,2),            -- Số tiền hoàn lại
    @TrangThai NVARCHAR(50),                  -- Trạng thái: 'Hoàn tiền' hoặc 'Bảo lưu'
    @LopHocChuyenSangId INT = NULL            -- Mã lớp học chuyển tiếp (NULL nếu không có)
AS
BEGIN
    INSERT INTO HoanTienBaoLuu (HocVienId, LopHocNauAnId, SoTienHoanLai, TrangThai, LopHocChuyenSangId)
    VALUES (@HocVienId, @LopHocNauAnId, @SoTienHoanLai, @TrangThai, @LopHocChuyenSangId)
END;
go
---- PROCEDURE về sửa thông tin Hoàn Tiền hoặc Bảo Lưu
CREATE PROCEDURE P_UpdateHoanTienBaoLuu
    @Id INT,                                  -- ID hoàn tiền/bảo lưu cần cập nhật
    @SoTienHoanLai DECIMAL(18,2) = NULL,     -- Số tiền hoàn lại (NULL nếu không cập nhật)
    @TrangThai NVARCHAR(50) = NULL,          -- Trạng thái (NULL nếu không cập nhật)
    @LopHocChuyenSangId INT = NULL            -- Mã lớp học chuyển tiếp (NULL nếu không cập nhật)
AS
BEGIN
    UPDATE HoanTienBaoLuu
    SET 
        SoTienHoanLai = ISNULL(@SoTienHoanLai, SoTienHoanLai),
        TrangThai = ISNULL(@TrangThai, TrangThai),
        LopHocChuyenSangId = ISNULL(@LopHocChuyenSangId, LopHocChuyenSangId)
    WHERE Id = @Id;
END;
go
--- PROCEDURE về xem thông tin Hoàn Tiền hoặc Bảo Lưu 
CREATE PROCEDURE P_ViewHoanTienBaoLuu_ByHocVienId
    @HocVienId INT                                   -- ID hoàn tiền/bảo lưu cần xem
AS
BEGIN
    SELECT *
    FROM HoanTienBaoLuu
    WHERE HocVienId = @HocVienId;
END;
go
--- PROCEDURE về xem tất cả thông tin Hoàn Tiền hoặc Bảo Lưu 
CREATE PROCEDURE P_GetHoanTienBaoLuu
AS
BEGIN
    SELECT *
    FROM HoanTienBaoLuu
END;
go
-- Thủ tục thêm một đánh giá lớp học
CREATE PROCEDURE P_AddDanhGiaLopHoc
    @MaLopHoc INT,          -- Mã lớp học
    @HocVienId INT,         -- ID học viên
    @DiemDanhGia INT,       -- Điểm đánh giá
    @NhanXet NVARCHAR(500)  -- Nhận xét
AS
BEGIN
    INSERT INTO DanhGiaLopHoc (MaLopHoc, HocVienId, DiemDanhGia, NhanXet)
    VALUES (@MaLopHoc, @HocVienId, @DiemDanhGia, @NhanXet);
END;
go
-- Thủ tục cập nhật đánh giá lớp học
CREATE PROCEDURE P_UpdateDanhGiaLopHoc
    @Id INT,                -- ID của đánh giá
    @MaLopHoc INT,          -- Mã lớp học
    @HocVienId INT,         -- ID học viên
    @DiemDanhGia INT,       -- Điểm đánh giá
    @NhanXet NVARCHAR(500)  -- Nhận xét
AS
BEGIN
    UPDATE DanhGiaLopHoc
    SET MaLopHoc = @MaLopHoc,
        HocVienId = @HocVienId,
        DiemDanhGia = @DiemDanhGia,
        NhanXet = @NhanXet
    WHERE Id = @Id;
END;
go
-- Thủ tục cập nhật đánh giá lớp học
-- Thủ tục thêm một đánh giá học viên
CREATE PROCEDURE P_AddDanhGiaHocVien
    @MaLopHoc INT,          -- Mã lớp học
    @HocVienId INT,         -- ID học viên
    @GiaoVienId INT,        -- ID giáo viên
    @NhanXet NVARCHAR(500)  -- Nhận xét
AS
BEGIN
    INSERT INTO DanhGiaHocVien (MaLopHoc, HocVienId, GiaoVienId, NhanXet)
    VALUES (@MaLopHoc, @HocVienId, @GiaoVienId, @NhanXet);
END;
go
-- Thủ tục cập nhật đánh giá học viên
CREATE PROCEDURE P_UpdateDanhGiaHocVien
    @Id INT,                -- ID của đánh giá
    @MaLopHoc INT,          -- Mã lớp học
    @HocVienId INT,         -- ID học viên
    @GiaoVienId INT,        -- ID giáo viên
    @NhanXet NVARCHAR(500)  -- Nhận xét
AS
BEGIN
    UPDATE DanhGiaHocVien
    SET MaLopHoc = @MaLopHoc,
        HocVienId = @HocVienId,
        GiaoVienId = @GiaoVienId,
        NhanXet = @NhanXet
    WHERE Id = @Id;
END;
go

CREATE PROCEDURE P_ViewAllDanhGiaLopHoc
AS
BEGIN
    SELECT 
        MaLopHoc, 
        HocVienId, 
        DiemDanhGia, 
        NhanXet
    FROM 
        DanhGiaLopHoc;
END;
GO

CREATE PROCEDURE P_ViewAllDanhGiaHocVien
AS
BEGIN
    SELECT 
        MaLopHoc, 
        HocVienId, 
        GiaoVienId, 
        NhanXet
    FROM 
        DanhGiaHocVien;
END;
GO

CREATE PROCEDURE P_ViewDanhGiaLopHocByHocVienId
    @HocVienId INT       -- ID học viên
as
BEGIN
    SELECT 
        MaLopHoc, 
        HocVienId, 
        DiemDanhGia, 
        NhanXet
    FROM 
        DanhGiaLopHoc
    WHERE 
        HocVienId = @HocVienId 
END;
GO

CREATE PROCEDURE P_ViewDanhGiaLopHocByLopHocId
    @LopHocId INT       -- ID học viên
as
BEGIN
    SELECT 
        MaLopHoc, 
        HocVienId, 
        DiemDanhGia, 
        NhanXet
    FROM 
        DanhGiaLopHoc
    WHERE 
       DanhGiaLopHoc.MaLopHoc = @LopHocId 
END;
GO
CREATE PROCEDURE P_ViewDanhGiaHocVien
    @HocVienId INT     
AS
BEGIN
    SELECT 
        MaLopHoc, 
        HocVienId, 
        GiaoVienId, 
        NhanXet
    FROM 
        DanhGiaHocVien
    WHERE 
        HocVienId = @HocVienId
    end;
GO
--thủ tục bảo lưu 
CREATE PROCEDURE P_BaoLuuHocVien
    @HocVienId INT,                          -- ID học viên
    @LopHocNauAnId INT,                     -- ID lớp học nấu ăn cũ
    @LopHocChuyenSangId INT,                -- ID lớp học nấu ăn mới
    @SoTienHoanLai DECIMAL(18, 2)           -- Số tiền hoàn lại
AS
BEGIN
  
    -- Cập nhật trạng thái bảo lưu và ID lớp học mới trong bảng LopHocNauAn_HocVien
    UPDATE LopHocNauAn_HocVien
    SET 
        TrangThaiDangKy = N'Bảo lưu',     -- Cập nhật trạng thái
        LopHocNauAnId = @LopHocChuyenSangId -- Cập nhật ID lớp học mới
    WHERE HocVienId = @HocVienId
      AND LopHocNauAnId = @LopHocNauAnId;

    -- Thêm dòng mới vào bảng HoanTienBaoLuu
    INSERT INTO HoanTienBaoLuu (HocVienId, LopHocNauAnId, SoTienHoanLai, TrangThai, LopHocChuyenSangId)
    VALUES (@HocVienId,@LopHocNauAnId, @SoTienHoanLai, N'Bảo lưu', @LopHocChuyenSangId);
END;
GO

--Trigger
-- Trigger về giáo viên 
-- Trigger kiểm tra dữ liệu giáo viên trước khi thêm vào bảng 
CREATE TRIGGER trg_check_GiaoVien_data
ON GiaoVien
AFTER INSERT
AS
BEGIN
    DECLARE @Sdt NVARCHAR(20), @Email NVARCHAR(255);

    -- Lấy dữ liệu từ bản ghi vừa chèn vào
    SELECT @Sdt = Sdt, @Email = Email
    FROM inserted;

    -- Kiểm tra định dạng số điện thoại (chỉ chấp nhận số)
    IF @Sdt IS NOT NULL AND @Sdt NOT LIKE '[0-9]%'
    BEGIN
        ROLLBACK;
        RETURN;
    END

    -- Kiểm tra định dạng email (yêu cầu phải có ký tự @)
    IF @Email IS NOT NULL AND CHARINDEX('@', @Email) = 0
    BEGIN
        ROLLBACK;
        RETURN;
    END
END;
go
-- Trigger về học viên
-- Trigger kiểm tra dữ liệu học viên trước khi thêm vào bảng 
CREATE TRIGGER trg_check_HocVien_data
ON HocVien
AFTER INSERT
AS
BEGIN
    DECLARE @Sdt NVARCHAR(20), @Email NVARCHAR(255);

    -- Lấy dữ liệu từ bản ghi vừa chèn vào
    SELECT @Sdt = Sdt, @Email = mail
    FROM inserted;

    -- Kiểm tra định dạng số điện thoại (chỉ chấp nhận số)
    IF @Sdt IS NOT NULL AND @Sdt NOT LIKE '[0-9]%'
    BEGIN
        ROLLBACK;
        RETURN;
    END

    -- Kiểm tra định dạng email (yêu cầu phải có ký tự @)
    IF @Email IS NOT NULL AND CHARINDEX('@', @Email) = 0
    BEGIN
        ROLLBACK;
        RETURN;
    END
END;
go
-- Tăng SoNguoiDangKy khi có học viên đăng ký
CREATE TRIGGER trg_IncreaseSoNguoiDangKy 
ON LopHocNauAn_HocVien
AFTER INSERT
AS
BEGIN
    UPDATE LopHocNauAn
    SET SoNguoiDangKy = SoNguoiDangKy + 1
    WHERE MaLopHoc = (SELECT LopHocNauAnId FROM INSERTED);
END;
go
-- Giảm SoNguoiDangKy khi học viên hủy đăng ký
CREATE TRIGGER trg_DecreaseSoNguoiDangKy 
ON LopHocNauAn_HocVien
AFTER DELETE
AS
BEGIN
    UPDATE LopHocNauAn
    SET SoNguoiDangKy = SoNguoiDangKy - 1
    WHERE MaLopHoc = (SELECT distinct LopHocNauAnId FROM DELETED);
END;
go
---TRIGGER update trạng thái thanh toán khi học viên thanh toán đủ tiền 
CREATE TRIGGER trg_UpdateTrangThaiThanhToan
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
    IF (@SoTienDaThanhToan + @DiscountAmount + @CodeDiscount + @FixedDiscount - @ChiPhi) >= 0
    BEGIN
        UPDATE LopHocNauAn_HocVien
        SET TrangThaiThanhToan = N'Đã thanh toán'
        WHERE LopHocNauAnId = @LopHocNauAnId AND HocVienId = @HocVienId;
    END
END;
GO
---Trggier cập nhật thông tin quảng cáo lớp học
CREATE TRIGGER trg_UpdateChayADSTrongThongTinQuangCao
ON ChiTietLopHoc
AFTER UPDATE
AS
BEGIN
    -- Khai báo các biến để lưu thông tin cần thiết
    DECLARE @LopHocId INT, @TrangThai NVARCHAR(50);

    -- Lấy thông tin lớp học và trạng thái từ bảng `inserted` sau khi cập nhật
    SELECT @LopHocId = i.MaLopHoc, 
           @TrangThai = i.TrangThai
    FROM inserted i;

    -- Kiểm tra nếu trạng thái là 'Đã hủy'
    IF (@TrangThai = N'Đã hủy')
    BEGIN
        -- Cập nhật ChayADS trong bảng ThongTinQuangCaoLopHoc thành 0
        UPDATE ThongTinQuangCaoLopHoc
        SET ChayADS = 0
        WHERE MaLopHoc = @LopHocId;
    END
END;
go
--Trigger tự động cập nhật số tiền hoàn lại hoặc bảo lưu khi lớp bị hủy
CREATE TRIGGER trg_UpdateRefundOnCancel
ON ChiTietLopHoc
AFTER UPDATE
AS
BEGIN
    IF (UPDATE(TrangThai) AND EXISTS(SELECT * FROM inserted WHERE TrangThai = N'Đã hủy'))
    BEGIN
        INSERT INTO HoanTienBaoLuu (HocVienId, LopHocNauAnId, SoTienHoanLai, TrangThai)
        SELECT hv.HocVienId,-i.MaLopHoc, hv.SoTienDaThanhToan + 20000, N'Hoàn tiền'
        FROM LopHocNauAn_HocVien AS hv
        INNER JOIN inserted AS i ON hv.LopHocNauAnId = i.MaLopHoc
    END
END;
go
--Function tính doanh thu thực tế của một lớp học
CREATE FUNCTION fn_CalculateActualRevenue (@MaLopHoc INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);
    
    SELECT @TotalRevenue = SUM(SoTienDaThanhToan)
    FROM LopHocNauAn_HocVien
    WHERE LopHocNauAnId = @MaLopHoc
    
    RETURN ISNULL(@TotalRevenue, 0);
END;
go
-- Function tính tổng tiền dự kiến của lớp học
CREATE FUNCTION fn_TinhTongTienDuKien (@MaLopHoc INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @SoNguoiDangKy INT;
    DECLARE @ChiPhi DECIMAL(18, 2);
    DECLARE @TongTienDuKien DECIMAL(18, 2);

    -- Lấy số người đăng ký và chi phí lớp học từ bảng LopHocNauAn và LichHoc
    SELECT 
        @SoNguoiDangKy = SoNguoiDangKy,
        @ChiPhi = ChiPhi
    FROM 
        LopHocNauAn LA
    JOIN 
        LichHoc LH ON LA.MaLopHoc = LH.MaLopHoc
    WHERE 
        LA.MaLopHoc = @MaLopHoc;

    -- Tính tổng tiền dự kiến
    SET @TongTienDuKien = @SoNguoiDangKy * @ChiPhi;

    RETURN @TongTienDuKien;
END;
go
--hàm lấy quyền người dùng 
create function fn_xacthuc (@userId int)
returns nvarchar(50)
as
begin
	declare @tenquyen nvarchar(50)
	set @tenquyen = (select Roles.RoleName from Roles join
													User_Role on Roles.id = User_Role.RoleId
													join Users on Users.id = User_Role.UserId
													where Users.id = @userId);
	return @tenquyen;
end;
go
CREATE TRIGGER trg_HoanTienBaoLuu
ON LopHocNauAn
AFTER DELETE
AS
BEGIN
    -- Chèn dữ liệu từ bảng LopHocNauAn_HocVien vào HoanTienBaoLuu
    INSERT INTO HoanTienBaoLuu (HocVienId, LopHocNauAnId, SoTienHoanLai, TrangThai, LopHocChuyenSangId)
    SELECT 
        lh.HocVienId,
        -d.MaLopHoc,  -- Gán ID âm của lớp học đã xóa
        lh.SoTienDaThanhToan + 20000,
        CASE 
            WHEN lh.TrangThaiDangKy = N'Đã hủy' THEN N'Hoàn tiền'
            ELSE N'Bảo lưu'
        END AS TrangThai,
        NULL  -- Nếu không chuyển lớp, gán là NULL
    FROM DELETED d
    JOIN LopHocNauAn_HocVien lh ON lh.LopHocNauAnId = d.MaLopHoc;
END;

----------------------------------------------------------------
----------------------------------------------------------------
