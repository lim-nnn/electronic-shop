USE ShopDB;
GO

-- 清理所有依赖数据，清空商品表
DELETE FROM Cart;
DELETE FROM OrderItem;
DELETE FROM OrderMain;
DELETE FROM Goods;
DBCC CHECKIDENT ('Goods', RESEED, 0);
GO

-- =====================================================
-- 逐个插入 50 件商品（不包含图片，后续统一更新）
-- 每条语句都明确：coverImg 为 ''，goodsDesc 为描述
-- =====================================================

-- 品类1：手机数码
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, 'iPhone 15 Pro Max', 9999.00, 100, 0, '', 'A17 Pro芯片，钛金属边框，4800万主摄，USB-C接口', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, 'iPhone 15 Pro', 7999.00, 120, 0, '', 'A17 Pro芯片，钛金属边框，三摄系统', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, 'iPhone 15', 5999.00, 150, 0, '', 'A16芯片，灵动岛设计，双摄系统', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, '小米14 Ultra', 5999.00, 80, 0, '', '骁龙8 Gen3，徕卡光学，5000mAh电池', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, '小米14 Pro', 4999.00, 100, 0, '', '骁龙8 Gen3，徕卡三摄，120W快充', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, '华为Mate 60 Pro', 6999.00, 60, 0, '', '麒麟9000S，卫星通话，昆仑玻璃', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, '华为P60 Pro', 4988.00, 70, 0, '', '超聚光影像，昆仑玻璃，双向北斗', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, '三星S24 Ultra', 9699.00, 50, 0, '', '骁龙8 Gen3，Galaxy AI，S Pen手写笔', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, 'OPPO Find X7 Ultra', 5999.00, 90, 0, '', '骁龙8 Gen3，双潜望长焦，哈苏影像', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (1, 'vivo X100 Pro', 4999.00, 85, 0, '', '天玑9300，蔡司影像，蓝海电池', 1);

-- 品类2：电脑办公
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '联想ThinkPad X1 Carbon', 9499.00, 50, 0, '', '13代酷睿i7，32GB内存，1TB SSD，4K屏', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '联想小新Pro 16', 5999.00, 80, 0, '', '锐龙R7-7840HS，32GB内存，2.5K高刷屏', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '戴尔XPS 16', 15999.00, 30, 0, '', 'Ultra 9处理器，RTX 4070，64GB内存', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '戴尔XPS 13', 8999.00, 60, 0, '', 'Ultra 7处理器，16GB内存，OLED触控屏', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '苹果MacBook Air 15', 10999.00, 40, 0, '', 'M3芯片，16GB内存，15.3英寸，18小时续航', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '苹果MacBook Pro 14', 16999.00, 35, 0, '', 'M3 Pro芯片，18GB内存，120Hz XDR屏', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '华硕ROG枪神7', 11999.00, 45, 0, '', 'i9-13980HX，RTX 4070，240Hz电竞屏', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '华为MateBook X Pro', 11999.00, 55, 0, '', '酷睿Ultra 9，32GB内存，OLED全面屏', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '惠普暗影精灵10', 8999.00, 70, 0, '', 'i7-14700HX，RTX 4060，2.5K高刷屏', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (2, '机械革命无界14X', 3999.00, 100, 0, '', '锐龙R7-8845HS，32GB内存，2.8K 120Hz', 1);

-- 品类3：服装鞋帽
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, '耐克Air Force 1 经典板鞋', 899.00, 200, 0, '', '纯白皮革，Air缓震，复古百搭', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, '耐克Dunk Low 熊猫配色', 1099.00, 150, 0, '', '经典熊猫配色，皮革材质，街头潮流', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, '阿迪达斯UltraBoost 23', 1299.00, 120, 0, '', 'Boost中底，轻便缓震，马拉松跑鞋', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, '阿迪达斯Samba OG', 899.00, 130, 0, '', '经典复古足球鞋，翻毛皮材质，德训风', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, 'New Balance 327', 799.00, 180, 0, '', '复古跑鞋，麂皮拼接，休闲百搭', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, 'New Balance 2002R', 1099.00, 110, 0, '', '千系复古，ABZORB缓震，舒适支撑', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, '李宁飞电4 Ultra', 1299.00, 90, 0, '', '䨻科技中底，碳板竞速，马拉松PB利器', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, '安踏C202 6代', 899.00, 100, 0, '', '氮科技中底，滚动形态，竞速跑鞋', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, '始祖鸟Atom LT Hoody', 3200.00, 60, 0, '', 'Coreloft保暖，防风透气，户外中层王', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (3, '北面1996 Retro Nuptse', 2899.00, 70, 0, '', '经典羽绒服，700蓬松度，复古箱式设计', 1);

-- 品类4：图书文具
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, '三体（全三册）', 93.00, 300, 0, '', '刘慈欣科幻巨著，典藏版，中国科幻里程碑', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, '三体III：死神永生', 40.00, 250, 0, '', '刘慈欣著，雨果奖作品，硬科幻巅峰', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, '深入理解Java虚拟机', 128.00, 80, 0, '', '周志明著，JVM必读经典，面试进阶神书', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, 'Java并发编程实战', 99.00, 100, 0, '', 'Java并发领域圣经，线程安全最佳实践', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, '凤凰架构', 118.00, 70, 0, '', '周志明著，从代码到架构，企业级实战', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, 'Redis深度历险', 79.00, 120, 0, '', '核心原理与应用实践，缓存面试必读', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, '人类群星闪耀时', 42.00, 200, 0, '', '茨威格经典传记文学，14个历史决定性瞬间', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, '活着', 28.00, 350, 0, '', '余华代表作，讲述一个人历经磨难的一生', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, '百年孤独', 55.00, 180, 0, '', '马尔克斯魔幻现实主义经典，诺奖之作', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (4, '三体II：黑暗森林', 45.00, 220, 0, '', '刘慈欣著，黑暗森林法则，科幻史诗第二部', 1);

-- 品类5：食品饮料
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '三只松鼠坚果大礼包', 99.00, 500, 0, '', '每日坚果混合装，1.5kg，健康零食', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '三只松鼠每日坚果', 79.00, 600, 0, '', '30天独立包装，科学搭配，营养均衡', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '星巴克深度烘焙咖啡豆', 78.00, 60, 0, '', '100%阿拉比卡，深度烘焙，黑巧克力风味', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '星巴克中度烘焙咖啡豆', 78.00, 55, 0, '', '100%阿拉比卡，中度烘焙，焦糖坚果风味', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '农夫山泉24瓶装', 25.00, 1000, 0, '', '550ml*24瓶，天然矿泉水，弱碱性', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '百草味每日坚果', 89.00, 400, 0, '', 'A+B混合坚果，小袋包装，新鲜烘焙', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '良品铺子零食大礼包', 129.00, 300, 0, '', '肉类+坚果+果干，12款组合，年货必备', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '伊利纯牛奶250ml*24盒', 68.00, 200, 0, '', '优质牧场奶源，原生高钙，早餐好搭档', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '蒙牛特仑苏纯牛奶', 78.00, 180, 0, '', '专属牧场，3.6g乳蛋白，高端纯牛奶', 1);
INSERT INTO Goods (typeId, goodsName, price, stock, lockedStock, coverImg, goodsDesc, status) VALUES (5, '好时巧克力礼盒', 99.00, 150, 0, '', '臻仁牛奶巧克力，丝滑浓郁，精美礼盒装', 1);

PRINT '✅ 50件商品基本信息插入成功（图片暂时为空）';
GO

-- =====================================================
-- 现在为每件商品设置真实的图片 URL（使用 picsum.photos）
-- =====================================================

UPDATE Goods SET coverImg = ' WHERE goodsId = 1;
UPDATE Goods SET coverImg = ' WHERE goodsId = 2;
UPDATE Goods SET coverImg = ' WHERE goodsId = 3;
UPDATE Goods SET coverImg = ' WHERE goodsId = 4;
UPDATE Goods SET coverImg = ' WHERE goodsId = 5;
UPDATE Goods SET coverImg = ' WHERE goodsId = 6;
UPDATE Goods SET coverImg = ' WHERE goodsId = 7;
UPDATE Goods SET coverImg = ' WHERE goodsId = 8;
UPDATE Goods SET coverImg = ' WHERE goodsId = 9;
UPDATE Goods SET coverImg = ' WHERE goodsId = 10;
UPDATE Goods SET coverImg = ' WHERE goodsId = 11;
UPDATE Goods SET coverImg = ' WHERE goodsId = 12;
UPDATE Goods SET coverImg = ' WHERE goodsId = 13;
UPDATE Goods SET coverImg = ' WHERE goodsId = 14;
UPDATE Goods SET coverImg = ' WHERE goodsId = 15;
UPDATE Goods SET coverImg = ' WHERE goodsId = 16;
UPDATE Goods SET coverImg = ' WHERE goodsId = 17;
UPDATE Goods SET coverImg = ' WHERE goodsId = 18;
UPDATE Goods SET coverImg = ' WHERE goodsId = 19;
UPDATE Goods SET coverImg = ' WHERE goodsId = 20;
UPDATE Goods SET coverImg = ' WHERE goodsId = 21;
UPDATE Goods SET coverImg = ' WHERE goodsId = 22;
UPDATE Goods SET coverImg = ' WHERE goodsId = 23;
UPDATE Goods SET coverImg = ' WHERE goodsId = 24;
UPDATE Goods SET coverImg = ' WHERE goodsId = 25;
UPDATE Goods SET coverImg = ' WHERE goodsId = 26;
UPDATE Goods SET coverImg = ' WHERE goodsId = 27;
UPDATE Goods SET coverImg = ' WHERE goodsId = 28;
UPDATE Goods SET coverImg = ' WHERE goodsId = 29;
UPDATE Goods SET coverImg = ' WHERE goodsId = 30;
UPDATE Goods SET coverImg = ' WHERE goodsId = 31;
UPDATE Goods SET coverImg = ' WHERE goodsId = 32;
UPDATE Goods SET coverImg = ' WHERE goodsId = 33;
UPDATE Goods SET coverImg = ' WHERE goodsId = 34;
UPDATE Goods SET coverImg = ' WHERE goodsId = 35;
UPDATE Goods SET coverImg = ' WHERE goodsId = 36;
UPDATE Goods SET coverImg = ' WHERE goodsId = 37;
UPDATE Goods SET coverImg = ' WHERE goodsId = 38;
UPDATE Goods SET coverImg = ' WHERE goodsId = 39;
UPDATE Goods SET coverImg = ' WHERE goodsId = 40;
UPDATE Goods SET coverImg = ' WHERE goodsId = 41;
UPDATE Goods SET coverImg = ' WHERE goodsId = 42;
UPDATE Goods SET coverImg = ' WHERE goodsId = 43;
UPDATE Goods SET coverImg = ' WHERE goodsId = 44;
UPDATE Goods SET coverImg = ' WHERE goodsId = 45;
UPDATE Goods SET coverImg = ' WHERE goodsId = 46;
UPDATE Goods SET coverImg = ' WHERE goodsId = 47;
UPDATE Goods SET coverImg = ' WHERE goodsId = 48;
UPDATE Goods SET coverImg = ' WHERE goodsId = 49;
UPDATE Goods SET coverImg = ' WHERE goodsId = 50;

PRINT '✅ 所有商品的图片 URL 已更新完成！';
GO

-- =====================================================
-- 验证数据
-- =====================================================

SELECT COUNT(*) AS 商品总数 FROM Goods;
SELECT typeId, COUNT(*) AS 数量 FROM Goods GROUP BY typeId ORDER BY typeId;
SELECT TOP 5 goodsId, goodsName, coverImg, goodsDesc FROM Goods ORDER BY goodsId;
GO