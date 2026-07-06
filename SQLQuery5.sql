-- ============================================================
-- 数据库名称：ShopDB
-- 作者：数据库模块负责人
-- 说明：电商平台完整数据库脚本（含表、约束、索引、初始数据、存储过程、视图）
-- 执行方式：在 SQL Server Management Studio 中按顺序全部执行
-- ============================================================

-- 1. 创建数据库（如果已存在则跳过）
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ShopDB')
BEGIN
    CREATE DATABASE ShopDB;
END;
GO

USE ShopDB;
GO

-- ============================================================
-- 第一部分：删除已存在的对象（便于重复执行，生产环境慎用）
-- ============================================================
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_CancelOrder') DROP PROC sp_CancelOrder;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ConfirmReceive') DROP PROC sp_ConfirmReceive;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_SendOrder') DROP PROC sp_SendOrder;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_PayOrder') DROP PROC sp_PayOrder;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_CreateOrder') DROP PROC sp_CreateOrder;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_UpdateCart') DROP PROC sp_UpdateCart;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_DeleteCart') DROP PROC sp_DeleteCart;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_AddCart') DROP PROC sp_AddCart;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'V' AND name = 'v_OrderDetail') DROP VIEW v_OrderDetail;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'V' AND name = 'v_CartDetail') DROP VIEW v_CartDetail;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'V' AND name = 'v_GoodsList') DROP VIEW v_GoodsList;
GO

-- 删除表（注意外键顺序，先删子表再删主表）
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'OrderItem') DROP TABLE OrderItem;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Cart') DROP TABLE Cart;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'OrderMain') DROP TABLE OrderMain;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Goods') DROP TABLE Goods;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'UserInfo') DROP TABLE UserInfo;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'Admin') DROP TABLE Admin;
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'GoodsType') DROP TABLE GoodsType;
GO

-- ============================================================
-- 第二部分：创建所有表（核心数据结构）
-- ============================================================

-- 2.1 商品分类表
CREATE TABLE GoodsType (
    typeId INT IDENTITY(1,1) PRIMARY KEY,
    typeName NVARCHAR(50) NOT NULL,
    sort INT DEFAULT 0,
    status TINYINT DEFAULT 1 CONSTRAINT CK_GoodsType_Status CHECK (status IN (0,1))
);
EXEC sp_addextendedproperty 'MS_Description', '商品分类表', 'SCHEMA', 'dbo', 'TABLE', 'GoodsType';
EXEC sp_addextendedproperty 'MS_Description', '分类唯一主键', 'SCHEMA', 'dbo', 'TABLE', 'GoodsType', 'COLUMN', 'typeId';
EXEC sp_addextendedproperty 'MS_Description', '分类名称', 'SCHEMA', 'dbo', 'TABLE', 'GoodsType', 'COLUMN', 'typeName';
EXEC sp_addextendedproperty 'MS_Description', '排序权重', 'SCHEMA', 'dbo', 'TABLE', 'GoodsType', 'COLUMN', 'sort';
EXEC sp_addextendedproperty 'MS_Description', '状态 1启用 0禁用', 'SCHEMA', 'dbo', 'TABLE', 'GoodsType', 'COLUMN', 'status';
GO

-- 2.2 管理员表
CREATE TABLE Admin (
    adminId INT IDENTITY(1,1) PRIMARY KEY,
    adminAccount NVARCHAR(50) UNIQUE NOT NULL,
    adminPwd NVARCHAR(255) NOT NULL,
    adminName NVARCHAR(50) NOT NULL,
    createTime DATETIME DEFAULT GETDATE()
);
EXEC sp_addextendedproperty 'MS_Description', '管理员表', 'SCHEMA', 'dbo', 'TABLE', 'Admin';
GO

-- 2.3 用户信息表
CREATE TABLE UserInfo (
    userId INT IDENTITY(1,1) PRIMARY KEY,
    account NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    nickName NVARCHAR(50) NULL,
    phone NVARCHAR(20) NULL,
    address NVARCHAR(200) NULL,
    createTime DATETIME DEFAULT GETDATE(),
    status TINYINT DEFAULT 1 CONSTRAINT CK_UserInfo_Status CHECK (status IN (0,1))
);
EXEC sp_addextendedproperty 'MS_Description', '用户信息表', 'SCHEMA', 'dbo', 'TABLE', 'UserInfo';
GO

-- 2.4 商品表
CREATE TABLE Goods (
    goodsId INT IDENTITY(1,1) PRIMARY KEY,
    typeId INT NOT NULL,
    goodsName NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL CONSTRAINT CK_Goods_Price CHECK (price >= 0),
    stock INT NOT NULL DEFAULT 0 CONSTRAINT CK_Goods_Stock CHECK (stock >= 0),
    lockedStock INT NOT NULL DEFAULT 0 CONSTRAINT CK_Goods_LockedStock CHECK (lockedStock >= 0),
    coverImg NVARCHAR(200) NULL,
    goodsDesc NVARCHAR(MAX) NULL,
    status TINYINT DEFAULT 1 CONSTRAINT CK_Goods_Status CHECK (status IN (0,1)),
    createTime DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Goods_GoodsType FOREIGN KEY (typeId) REFERENCES GoodsType(typeId)
);
EXEC sp_addextendedproperty 'MS_Description', '商品表', 'SCHEMA', 'dbo', 'TABLE', 'Goods';
GO

-- 2.5 订单主表
CREATE TABLE OrderMain (
    orderId INT IDENTITY(1,1) PRIMARY KEY,
    orderNo NVARCHAR(50) UNIQUE NOT NULL,
    userId INT NOT NULL,
    totalMoney DECIMAL(10,2) NOT NULL CONSTRAINT CK_OrderMain_TotalMoney CHECK (totalMoney >= 0),
    receiveAddress NVARCHAR(200) NOT NULL,
    orderStatus TINYINT DEFAULT 0 CONSTRAINT CK_OrderMain_Status CHECK (orderStatus IN (0,1,2,3,4)),
    payTime DATETIME NULL,
    sendTime DATETIME NULL,
    createTime DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_OrderMain_UserInfo FOREIGN KEY (userId) REFERENCES UserInfo(userId)
);
EXEC sp_addextendedproperty 'MS_Description', '订单主表', 'SCHEMA', 'dbo', 'TABLE', 'OrderMain';
GO

-- 2.6 购物车表
CREATE TABLE Cart (
    cartId INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    goodsId INT NOT NULL,
    buyNum INT NOT NULL CONSTRAINT CK_Cart_BuyNum CHECK (buyNum > 0),
    createTime DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_Cart_UserGoods UNIQUE (userId, goodsId),
    CONSTRAINT FK_Cart_UserInfo FOREIGN KEY (userId) REFERENCES UserInfo(userId),
    CONSTRAINT FK_Cart_Goods FOREIGN KEY (goodsId) REFERENCES Goods(goodsId)
);
EXEC sp_addextendedproperty 'MS_Description', '购物车表', 'SCHEMA', 'dbo', 'TABLE', 'Cart';
GO

-- 2.7 订单明细表
CREATE TABLE OrderItem (
    itemId INT IDENTITY(1,1) PRIMARY KEY,
    orderId INT NOT NULL,
    goodsId INT NOT NULL,
    buyNum INT NOT NULL CONSTRAINT CK_OrderItem_BuyNum CHECK (buyNum > 0),
    goodsPrice DECIMAL(10,2) NOT NULL CONSTRAINT CK_OrderItem_Price CHECK (goodsPrice >= 0),
    CONSTRAINT FK_OrderItem_OrderMain FOREIGN KEY (orderId) REFERENCES OrderMain(orderId),
    CONSTRAINT FK_OrderItem_Goods FOREIGN KEY (goodsId) REFERENCES Goods(goodsId)
);
EXEC sp_addextendedproperty 'MS_Description', '订单明细表', 'SCHEMA', 'dbo', 'TABLE', 'OrderItem';
GO

-- ============================================================
-- 第三部分：创建所有索引（性能优化）
-- ============================================================
CREATE INDEX IX_Goods_TypeId ON Goods(typeId);
CREATE INDEX IX_Goods_Status ON Goods(status);
CREATE INDEX IX_Goods_Price ON Goods(price);
CREATE INDEX IX_OrderMain_UserId ON OrderMain(userId);
CREATE INDEX IX_OrderMain_OrderStatus ON OrderMain(orderStatus);
CREATE INDEX IX_OrderMain_CreateTime ON OrderMain(createTime);
CREATE INDEX IX_OrderMain_OrderNo ON OrderMain(orderNo);
CREATE INDEX IX_Cart_UserId ON Cart(userId);
CREATE INDEX IX_Cart_GoodsId ON Cart(goodsId);
CREATE INDEX IX_OrderItem_OrderId ON OrderItem(orderId);
CREATE INDEX IX_OrderItem_GoodsId ON OrderItem(goodsId);
GO

-- ============================================================
-- 第四部分：初始化基础数据（含测试数据）
-- ============================================================

-- 4.1 商品分类
INSERT INTO GoodsType (typeName, sort, status) VALUES 
('手机数码', 1, 1),
('电脑办公', 2, 1),
('服装鞋帽', 3, 1),
('图书文具', 4, 1),
('食品饮料', 5, 1);
GO

-- 4.2 管理员（密码统一为 123456 的 MD5 加密值）
INSERT INTO Admin (adminAccount, adminPwd, adminName) VALUES 
('admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员'),
('manager', 'e10adc3949ba59abbe56e057f20f883e', '运营经理');
GO

-- 4.3 测试用户（密码统一为 123456）
INSERT INTO UserInfo (account, password, nickName, phone, address, status) VALUES 
('zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '张三', '13800000001', '北京市朝阳区望京SOHO 1-101', 1),
('lisi', 'e10adc3949ba59abbe56e057f20f883e', '李四', '13800000002', '上海市浦东新区陆家嘴环路1000号', 1),
('wangwu', 'e10adc3949ba59abbe56e057f20f883e', '王五', '13800000003', '广州市天河区珠江新城华厦路10号', 1);
GO

-- 4.4 测试商品
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES 
(1, 'iPhone 15 Pro Max', 9999.00, 100, 0, '/images/iphone15.jpg', 'A17 Pro芯片，钛金属边框，4800万主摄', 1),
(1, '小米14 Ultra', 5999.00, 150, 0, '/images/mi14.jpg', '骁龙8 Gen3，徕卡光学，5000mAh电池', 1),
(2, '联想ThinkPad X1 Carbon', 9499.00, 50, 0, '/images/thinkpad.jpg', '第13代英特尔酷睿，32GB内存，1TB固态', 1),
(2, '戴尔XPS 16', 15999.00, 30, 0, '/images/xps16.jpg', 'Ultra 9处理器，RTX 4070独显，4K屏', 1),
(3, '耐克Air Force 1', 899.00, 200, 0, '/images/af1.jpg', '经典百搭板鞋，皮革材质', 1),
(3, '阿迪达斯UltraBoost 23', 1299.00, 120, 0, '/images/boost.jpg', 'Boost中底，轻便缓震跑鞋', 1),
(4, '三体（全三册）', 93.00, 300, 0, '/images/santi.jpg', '刘慈欣科幻巨著，典藏版', 1),
(4, '深入理解Java虚拟机', 128.00, 80, 0, '/images/jvm.jpg', '周志明著，JVM必读经典', 1),
(5, '三只松鼠坚果大礼包', 99.00, 500, 0, '/images/nuts.jpg', '每日坚果混合装，1.5kg', 1),
(5, '星巴克咖啡豆（深度烘焙）', 78.00, 60, 0, '/images/coffee.jpg', '阿拉比卡，200g袋装', 1);
GO

-- ============================================================
-- 第五部分：创建视图（方便开发查询）
-- ============================================================

-- 5.1 商品列表视图（含分类名称）
CREATE VIEW v_GoodsList AS
SELECT 
    g.goodsId, g.goodsName, g.price, g.stock, 
    (g.stock - g.lockedStock) AS availableStock,
    g.coverImg, g.goodsDesc, g.status, g.createTime,
    t.typeId, t.typeName
FROM Goods g
INNER JOIN GoodsType t ON g.typeId = t.typeId;
GO

-- 5.2 购物车明细视图
CREATE VIEW v_CartDetail AS
SELECT 
    c.cartId, c.userId, c.buyNum, c.createTime,
    g.goodsId, g.goodsName, g.price, g.coverImg,
    (g.price * c.buyNum) AS subtotal,
    (g.stock - g.lockedStock) AS availableStock
FROM Cart c
INNER JOIN Goods g ON c.goodsId = g.goodsId;
GO

-- 5.3 订单详情视图（含用户和商品信息）
CREATE VIEW v_OrderDetail AS
SELECT 
    o.orderId, o.orderNo, o.totalMoney, o.receiveAddress, 
    o.orderStatus, o.payTime, o.sendTime, o.createTime,
    u.userId, u.account, u.nickName, u.phone,
    i.itemId, i.buyNum, i.goodsPrice,
    g.goodsId, g.goodsName, g.coverImg
FROM OrderMain o
INNER JOIN UserInfo u ON o.userId = u.userId
INNER JOIN OrderItem i ON o.orderId = i.orderId
INNER JOIN Goods g ON i.goodsId = g.goodsId;
GO

-- ============================================================
-- 第六部分：存储过程（全部业务逻辑）
-- ============================================================

-- 6.1 生成订单编号（格式：日期 + 随机数）
CREATE PROCEDURE sp_GenerateOrderNo @orderNo NVARCHAR(50) OUTPUT
AS
BEGIN
    SET @orderNo = 'ORD' + CONVERT(NVARCHAR(8), GETDATE(), 112) + 
                   RIGHT('0000' + CONVERT(NVARCHAR(4), ABS(CHECKSUM(NEWID())) % 10000), 4);
END;
GO

-- 6.2 添加商品到购物车（若已存在则增加数量）
CREATE PROCEDURE sp_AddCart
    @userId INT,
    @goodsId INT,
    @buyNum INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- 检查商品是否存在且上架
        IF NOT EXISTS (SELECT 1 FROM Goods WHERE goodsId = @goodsId AND status = 1)
        BEGIN
            RAISERROR('商品不存在或已下架', 16, 1);
            RETURN;
        END;
        
        -- 检查库存是否足够
        DECLARE @available INT;
        SELECT @available = stock - lockedStock FROM Goods WHERE goodsId = @goodsId;
        IF @available < @buyNum
        BEGIN
            RAISERROR('库存不足', 16, 1);
            RETURN;
        END;
        
        -- 如果购物车已有该商品，更新数量
        IF EXISTS (SELECT 1 FROM Cart WHERE userId = @userId AND goodsId = @goodsId)
        BEGIN
            UPDATE Cart SET buyNum = buyNum + @buyNum 
            WHERE userId = @userId AND goodsId = @goodsId;
        END
        ELSE
        BEGIN
            INSERT INTO Cart (userId, goodsId, buyNum) VALUES (@userId, @goodsId, @buyNum);
        END;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- 6.3 修改购物车商品数量
CREATE PROCEDURE sp_UpdateCart
    @cartId INT,
    @newBuyNum INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @newBuyNum <= 0
    BEGIN
        RAISERROR('数量必须大于0', 16, 1);
        RETURN;
    END;
    
    UPDATE Cart SET buyNum = @newBuyNum WHERE cartId = @cartId;
END;
GO

-- 6.4 删除购物车商品
CREATE PROCEDURE sp_DeleteCart
    @cartId INT,
    @userId INT = NULL  -- 如果传入userId则同时验证归属
AS
BEGIN
    SET NOCOUNT ON;
    IF @userId IS NOT NULL
        DELETE FROM Cart WHERE cartId = @cartId AND userId = @userId;
    ELSE
        DELETE FROM Cart WHERE cartId = @cartId;
END;
GO

-- 6.5 清空用户购物车
CREATE PROCEDURE sp_ClearCart
    @userId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM Cart WHERE userId = @userId;
END;
GO

-- 6.6 创建订单（下单核心流程：锁定库存 + 生成订单 + 清空购物车）
CREATE PROCEDURE sp_CreateOrder
    @userId INT,
    @address NVARCHAR(200),
    @orderId INT OUTPUT,
    @orderNo NVARCHAR(50) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- 生成订单号
        EXEC sp_GenerateOrderNo @orderNo OUTPUT;
        
        -- 声明临时表存放购物车数据
        CREATE TABLE #CartTemp (goodsId INT, buyNum INT, price DECIMAL(10,2));
        
        -- 获取用户购物车数据，并检查库存
        INSERT INTO #CartTemp (goodsId, buyNum, price)
        SELECT c.goodsId, c.buyNum, g.price
        FROM Cart c
        INNER JOIN Goods g ON c.goodsId = g.goodsId
        WHERE c.userId = @userId AND g.status = 1;
        
        -- 判断购物车是否为空
        IF NOT EXISTS (SELECT 1 FROM #CartTemp)
        BEGIN
            RAISERROR('购物车为空，无法下单', 16, 1);
            RETURN;
        END;
        
        -- 逐行检查库存并锁定库存（悲观锁）
        DECLARE @gid INT, @num INT, @available INT;
        DECLARE cur CURSOR FOR SELECT goodsId, buyNum FROM #CartTemp;
        OPEN cur;
        FETCH NEXT FROM cur INTO @gid, @num;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- 加行锁查询可用库存
            SELECT @available = stock - lockedStock FROM Goods WITH (ROWLOCK, XLOCK) WHERE goodsId = @gid;
            IF @available < @num
            BEGIN
                CLOSE cur; DEALLOCATE cur;
                RAISERROR('商品库存不足，请调整购物车', 16, 1);
                RETURN;
            END;
            -- 锁定库存（lockedStock += buyNum）
            UPDATE Goods SET lockedStock = lockedStock + @num WHERE goodsId = @gid;
            FETCH NEXT FROM cur INTO @gid, @num;
        END;
        CLOSE cur; DEALLOCATE cur;
        
        -- 计算订单总金额
        DECLARE @total DECIMAL(10,2);
        SELECT @total = SUM(buyNum * price) FROM #CartTemp;
        
        -- 插入订单主表
        INSERT INTO OrderMain (orderNo, userId, totalMoney, receiveAddress, orderStatus)
        VALUES (@orderNo, @userId, @total, @address, 0);  -- 待付款
        
        SET @orderId = SCOPE_IDENTITY();
        
        -- 插入订单明细
        INSERT INTO OrderItem (orderId, goodsId, buyNum, goodsPrice)
        SELECT @orderId, goodsId, buyNum, price FROM #CartTemp;
        
        -- 清空购物车
        DELETE FROM Cart WHERE userId = @userId;
        
        DROP TABLE #CartTemp;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        IF EXISTS (SELECT 1 FROM sys.objects WHERE name = '#CartTemp') DROP TABLE #CartTemp;
        THROW;
    END CATCH;
END;
GO

-- 6.7 支付订单（扣减实际库存 + 释放锁定库存 + 更新状态）
CREATE PROCEDURE sp_PayOrder
    @orderId INT,
    @userId INT = NULL  -- 可验证归属
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- 检查订单状态是否为待付款(0)
        DECLARE @curStatus TINYINT, @curUserId INT;
        SELECT @curStatus = orderStatus, @curUserId = userId FROM OrderMain WHERE orderId = @orderId;
        IF @curStatus IS NULL
        BEGIN
            RAISERROR('订单不存在', 16, 1);
            RETURN;
        END;
        IF @curStatus != 0
        BEGIN
            RAISERROR('订单已支付或已取消，无法重复支付', 16, 1);
            RETURN;
        END;
        IF @userId IS NOT NULL AND @curUserId != @userId
        BEGIN
            RAISERROR('无权操作此订单', 16, 1);
            RETURN;
        END;
        
        -- 更新订单状态为待发货(1)，记录支付时间
        UPDATE OrderMain SET orderStatus = 1, payTime = GETDATE() WHERE orderId = @orderId;
        
        -- 扣减实际库存，释放锁定库存
        UPDATE g
        SET g.stock = g.stock - i.buyNum,
            g.lockedStock = g.lockedStock - i.buyNum
        FROM Goods g
        INNER JOIN OrderItem i ON g.goodsId = i.goodsId
        WHERE i.orderId = @orderId;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- 6.8 发货
CREATE PROCEDURE sp_SendOrder
    @orderId INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @curStatus TINYINT;
    SELECT @curStatus = orderStatus FROM OrderMain WHERE orderId = @orderId;
    IF @curStatus IS NULL
    BEGIN
        RAISERROR('订单不存在', 16, 1);
        RETURN;
    END;
    IF @curStatus != 1
    BEGIN
        RAISERROR('订单不是待发货状态', 16, 1);
        RETURN;
    END;
    UPDATE OrderMain SET orderStatus = 2, sendTime = GETDATE() WHERE orderId = @orderId;
END;
GO

-- 6.9 确认收货
CREATE PROCEDURE sp_ConfirmReceive
    @orderId INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @curStatus TINYINT;
    SELECT @curStatus = orderStatus FROM OrderMain WHERE orderId = @orderId;
    IF @curStatus IS NULL
    BEGIN
        RAISERROR('订单不存在', 16, 1);
        RETURN;
    END;
    IF @curStatus != 2
    BEGIN
        RAISERROR('订单不是已发货状态', 16, 1);
        RETURN;
    END;
    UPDATE OrderMain SET orderStatus = 3 WHERE orderId = @orderId;  -- 已完成
END;
GO

-- 6.10 取消订单（释放锁定库存，仅限待付款状态）
CREATE PROCEDURE sp_CancelOrder
    @orderId INT,
    @userId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DECLARE @curStatus TINYINT, @curUserId INT;
        SELECT @curStatus = orderStatus, @curUserId = userId FROM OrderMain WHERE orderId = @orderId;
        IF @curStatus IS NULL
        BEGIN
            RAISERROR('订单不存在', 16, 1);
            RETURN;
        END;
        IF @userId IS NOT NULL AND @curUserId != @userId
        BEGIN
            RAISERROR('无权操作此订单', 16, 1);
            RETURN;
        END;
        -- 只有待付款(0)或待发货(1)可以取消（待发货取消需要额外处理，这里限制仅待付款取消）
        IF @curStatus != 0
        BEGIN
            RAISERROR('只有待付款订单可以取消', 16, 1);
            RETURN;
        END;
        
        -- 释放锁定库存
        UPDATE g
        SET g.lockedStock = g.lockedStock - i.buyNum
        FROM Goods g
        INNER JOIN OrderItem i ON g.goodsId = i.goodsId
        WHERE i.orderId = @orderId;
        
        -- 更新订单状态为已取消(4)
        UPDATE OrderMain SET orderStatus = 4 WHERE orderId = @orderId;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- 6.11 获取用户订单列表（分页，带总数）
CREATE PROCEDURE sp_GetUserOrders
    @userId INT,
    @pageIndex INT = 1,
    @pageSize INT = 10,
    @status TINYINT = NULL  -- 不传则查全部
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @offset INT = (@pageIndex - 1) * @pageSize;
    
    SELECT 
        o.orderId, o.orderNo, o.totalMoney, o.receiveAddress, 
        o.orderStatus, o.payTime, o.sendTime, o.createTime,
        COUNT(*) OVER() AS TotalCount
    FROM OrderMain o
    WHERE o.userId = @userId 
      AND (@status IS NULL OR o.orderStatus = @status)
    ORDER BY o.createTime DESC
    OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
END;
GO

-- ============================================================
-- 第七部分：触发器（自动更新订单总金额，确保数据一致性）
-- ============================================================
-- 当订单明细插入或更新时，自动重算订单主表的 totalMoney
CREATE TRIGGER trg_OrderItem_UpdateTotal
ON OrderItem
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @affectedOrders TABLE (orderId INT);
    
    INSERT INTO @affectedOrders (orderId)
    SELECT orderId FROM inserted
    UNION
    SELECT orderId FROM deleted;
    
    UPDATE om
    SET om.totalMoney = ISNULL((SELECT SUM(buyNum * goodsPrice) FROM OrderItem WHERE orderId = om.orderId), 0)
    FROM OrderMain om
    INNER JOIN @affectedOrders a ON om.orderId = a.orderId;
END;
GO

-- ============================================================
-- 第八部分：测试数据交互（模拟一次完整购物流程，可注释掉）
-- ============================================================
/*
-- 测试：张三（userId=1）将iPhone加入购物车2件
EXEC sp_AddCart 1, 1, 2;

-- 查看购物车
SELECT * FROM v_CartDetail WHERE userId = 1;

-- 下单
DECLARE @oid INT, @ono NVARCHAR(50);
EXEC sp_CreateOrder @userId = 1, @address = '北京市朝阳区望京SOHO 1-101', @orderId = @oid OUTPUT, @orderNo = @ono OUTPUT;
PRINT '订单ID: ' + CAST(@oid AS NVARCHAR) + ', 订单号: ' + @ono;

-- 支付
EXEC sp_PayOrder @orderId = @oid;

-- 查看订单
SELECT * FROM v_OrderDetail WHERE orderId = @oid;

-- 发货
EXEC sp_SendOrder @orderId = @oid;

-- 确认收货
EXEC sp_ConfirmReceive @orderId = @oid;
*/
GO

-- ============================================================
-- 全部执行完毕！
-- ============================================================
PRINT '===== 电商平台数据库部署完成！=====';
PRINT '管理员账号：admin / 密码：123456';
PRINT '测试用户：zhangsan / 密码：123456';
PRINT '=========================================';
GO