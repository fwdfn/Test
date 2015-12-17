if exists(select * from sysdatabases where name='awst')
begin
drop database awst
end

create database awst
on primary
(
  name='awst.mdf',
  filename='D:\DataBases\awst.mdf',
  size=50Mb,
  maxsize=unlimited,
  filegrowth=10%
)
log on
(
  name='awst.ldf',
  filename='D:\DataBases\awst.ldf',
  size=20Mb,
  maxsize=unlimited,
  filegrowth=10% 
)
go

--����Ա��
if exists(select * from sysobjects where name='tb_admin')
begin
drop table tb_admin
end

create table tb_admin
(
 id int identity,
 name nvarchar(10) not null,  --����
 pwd nvarchar(10) not null,   --����
 loginTime datetime default getdate(),   --datetimeʱ����������   ��½ʱ��
 loginCount int default 0,    --��½����
 note nvarchar(100)           --��ע 
)
select * from tb_admin
insert into tb_admin(name,pwd,loginTime) values('aaa','123',GETDATE())

--��Ŀ��
--�ֶΣ������,�Ƿ�����,���,ͼƬ·��,����,��Ŀ��ַ,����ʱ��
if exists(select * from sysobjects where name='tb_menu')
begin
drop table tb_menu
end
create table tb_menu
(
 id int identity primary key,   --���
 title nvarchar(10) not null,   --����
 pid int not null,              --�����  
 isHide bit default 0,          --�Ƿ�����       0Ϊ��ʾ��1Ϊ����
 sort int not null,             --���
 picPath nvarchar(100),         --ͼƬ·�� 
 content nvarchar(max),         --����
 linkUrl nvarchar(100),         --��Ŀ��ַ
 cdate datetime default getdate() --����ʱ��
)
go
select * from tb_menu
select * from tb_backgroundMenu
select * from tb_menu

insert into tb_menu values('��������',0,0,1,'','','AboutUS.aspx?id=1&pid=0',GETDATE())
insert into tb_menu values('��˾����',1,0,1,'','','AboutUS.aspx?id=2&pid=1',GETDATE())
insert into tb_menu values('��˾���',1,0,2,'','','AboutUS.aspx?id=3&pid=1',GETDATE())
insert into tb_menu values('��ҵ�Ļ�',1,0,3,'','','AboutUS.aspx?id=4&pid=1',GETDATE())
select * from tb_menu
insert into tb_menu values('��������',0,0,2,'','','News.aspx?id=5&pid=0',GETDATE())
insert into tb_menu values('��ҵ����',5,0,1,'','','News.aspx?id=6&pid=5',GETDATE())
insert into tb_menu values('��˾����',5,0,2,'','','News.aspx?id=7&pid=5',GETDATE())
insert into tb_menu values('���´���',5,0,3,'','','News.aspx?id=8&pid=5',GETDATE())

insert into tb_menu values('��Ʒ����',0,0,3,'','','Product.aspx?id=9&pid=0',GETDATE())
insert into tb_menu values('�ۺ������',0,0,4,'','','AboutUS.aspx?id=10&pid=0',GETDATE())
insert into tb_menu values('�˲���Ƹ',0,0,5,'','','AboutUS.aspx?id=11&pid=0',GETDATE())
insert into tb_menu values('���԰�',0,0,6,'','','Message.aspx?id=12&pid=0',GETDATE())
insert into tb_menu values('��ϵ����',0,0,7,'','','AboutUS.aspx?id=13&pid=0',GETDATE())
insert into tb_menu values('',0,0,1,'','','',GETDATE())
update tb_menu set linkUrl='AboutUS.aspx?node=service' where id=10
select * from tb_menu where pid=5
TRUNCATE TABLE tb_menu

--��̨��Ŀ��
if exists(select * from sysobjects where name='tb_backgroundMenu')
begin 
drop table tb_backgroundMenu
end 
create table tb_backgroundMenu
(
 id int identity primary key,
 title nvarchar(20) not null,
 pid int not null,
 sort int not null,
 linkurl nvarchar(50),
 cdate datetime default getdate()
)
go
select * from tb_backgroundMenu
select * from tb_menu
--��������
insert into tb_backgroundMenu(title,pid,sort) values('��������',0,1)
insert into tb_backgroundMenu values('������',1,1,'column.aspx?id=1',getdate())
insert into tb_backgroundMenu(title,pid,sort) values('��˾����',1,2)
insert into tb_backgroundMenu(title,pid,sort) values('��˾���',1,3)
insert into tb_backgroundMenu(title,pid,sort) values('��ҵ�Ļ�',1,4)
--��������
insert into tb_backgroundMenu(title,pid,sort) values('��������',0,2)
insert into tb_backgroundMenu values('������',6,1,'column.aspx?id=5',getdate())
insert into tb_backgroundMenu values('��Ϣ����',6,2,'NewsFile/News.aspx?id=5',getdate())
insert into tb_backgroundMenu(title,pid,sort) values('��ҵ����',6,3)
--��Ʒ����
insert into tb_backgroundMenu(title,pid,sort) values('��Ʒ����',0,3)
insert into tb_backgroundMenu values('������',10,1,'ProductFile/ProductType.aspx',getdate())
insert into tb_backgroundMenu values('��Ϣ����',10,2,'ProductFile/Product.aspx',getdate())
select * from tb_backgroundMenu
--���λ����
insert into tb_backgroundMenu values('���λ����',0,4,'',getdate())
insert into tb_backgroundMenu values('��ҳ���λ',13,1,'AdvertisingFile/Advertising.aspx',getdate())
insert into tb_backgroundMenu values('��ҳ���λ',13,2,'AdvertisingFile/Advertising.aspx',getdate())
--�汾��Ϣ
insert into tb_backgroundMenu values('������Ϣ����',0,5,'',getdate())
insert into tb_backgroundMenu values('��վ����',16,1,'CopyRight.aspx',getdate())
insert into tb_backgroundMenu values('��ҳ��Ŀ',0,6,'',getdate())
insert into tb_backgroundMenu values('��ҳ��Ŀ����',18,1,'column.aspx',getdate())
select * from tb_backgroundMenu
update tb_backgroundMenu set pid=18 where id =19


select * from tb_product
select * from tb_backgroundMenu

select * from tb_menu where pid=5 order by sort
select * from tb_backgroundMenu
select * from tb_menu

if exists(select * from sysobjects where name='tb_newsInfo')
begin
drop table tb_newsInfo
end
create table tb_newsInfo
(
 id int identity primary key,    --���
 title nvarchar(200) not null,   --����
 pid int constraint FK_ID foreign key references tb_menu(id),  --��id
 ishide bit default 0,      --�Ƿ�����    
 isrecommand bit default 0,  --�Ƿ��Ƽ�
 ishot bit default 0,   --�Ƿ��ȵ�
 isverify bit default 0,  --�Ƿ����
 isindex bit default 0,   --�Ƿ���ҳ
 sort int default 1,    --����
 content nvarchar(max) null,  --����
 titlecolor nvarchar(20),  --������ɫ
 picpath nvarchar(200),  --ͼƬ·��               
 source nvarchar(30),   --������Դ
 clicks int default 0,   --�����
 cdate datetime default getdate() --����ʱ��
)
select * from tb_backgroundMenu
select * from tb_newsInfo
select * from tb_menu where pid=5
insert into tb_newsInfo(title,pid,sort,content) values('�����ҵ�ṹ1',6,1,'asdfas')
insert into tb_newsInfo(title,pid,sort,content) values('�����ҵ�ṹ2',6,1,'asdfas')
insert into tb_newsInfo(title,pid,sort,content) values('�����ҵ�ṹ3',21,1,'asdfas')
insert into tb_newsInfo(title,pid,sort,content) values('��ҵ�ṹ4',20,1,'asdfas')
update tb_newsInfo set isrecommand=1 where id=1
update tb_newsInfo set source='�ⲿ����' where id=3
delete tb_newsInfo where id in(3)
update tb_backgroundMenu set linkurl='News.aspx?id=5' where title='��Ϣ����'
update tb_backgroundMenu set linkurl='ProductFile/ProductType.aspx' where id=11
select * from tb_backgroundMenu


select * from tb_newsInfo where isverify=1 and pid=6 order by id
select * from tb_newsInfo
select * from tb_menu
--6:��ҵ����   20��˾����  21�����´���
select * from tb_newsInfo where isverify=0 and pid=20 and title like '%4%' order by id
update tb_newsInfo set picpath='../../Upload/a.jpg' where id=10
update tb_newsInfo set picpath='' where id=2

if exists(select * from sysobjects where name='tb_productColumn')
begin
drop table tb_productColumn
end
create table tb_productColumn
(
 id int identity primary key,
 title nvarchar(30) not null,
 pid int not null,
 sort int default 0,
 ishide bit default 0,
 cdate datetime default getdate(),
 note nvarchar(100)
)
go
select * from tb_backgroundMenu
select * from tb_productColumn
insert into tb_productColumn(title,pid,sort) values('ø���Ǻ�ϴ���ϵ��',0,1)
insert into tb_productColumn(title,pid,sort) values('��΢���ֹ��ȼ�ϵ��',0,2)
insert into tb_productColumn(title,pid,sort) values('ø����ϵ��',1,1)
insert into tb_productColumn(title,pid,sort) values('ϴ���ϵ��',1,2)
insert into tb_productColumn(title,pid,sort) values('��΢���ֹ��ȼ�',2,1)
insert into tb_productColumn(title,pid,sort) values('��΢�����������',2,2)
insert into tb_productColumn(title,pid,sort) values('��΢�����������2',2,3)
insert into tb_productColumn(title,pid,sort) values('��΢�����������3',2,4)


if exists(select * from sysobjects where name='tb_product')
begin 
drop table tb_product
end
create table tb_product
(
 id int identity primary key,
 name nvarchar(50) not null,
 pid int constraint FK_PRODUCT_ID foreign key references tb_productColumn(id),
 sort int,
 hots int default 0,         --Ҫ��Ҫ����ȵ�
 picpath nvarchar(100),       --����ϴ�����ͼ
 cdate datetime default getdate(),
 remark nvarchar(100)        --��Ʒ��Ҫ��Ҫ��ӱ�ע
)
go
select * from tb_productColumn
select * from tb_product
insert into tb_product values('��Ʒ1',3,1,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ2',3,2,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',3,3,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',4,1,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',4,2,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',5,1,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',6,1,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',6,2,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',6,3,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',6,4,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',6,5,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',6,6,0,'',GETDATE(),'')
insert into tb_product values('��Ʒ3',6,7,0,'',GETDATE(),'')
select * from tb_product where pid in(select id from tb_productColumn where pid=2)
select * from tb_product where pid in(3,4)
select * from tb_product where  name  like '%1%'
--��˾������Ϣ��
if exists(select * from sysobjects where name='tb_companyInfo')
begin 
drop table tb_companyInfo
end
create table tb_companyInfo
( 
 id int identity not null,
 name nvarchar(20) not null,
 title nvarchar(20) not null,
 website nvarchar(50),
 address nvarchar(40),
 cellphone nvarchar(20),
 phone nvarchar(20), 
 fax varchar(20),
 qq varchar(20),
 email nvarchar(20),
 support nvarchar(15),
 copyright nvarchar(20),
 keywords nvarchar(100),
 webdescription nvarchar(300)
)
go
select * from tb_companyInfo
insert into tb_companyInfo values('�人��ά˹�ؿƼ����޹�˾','�人��ά˹�ؿƼ����޹�˾','http://www.avist.com.cn/','�人�к�ɽ���۳����450��','137-07128722','027-87166527','027-87530722','1740864522','avist_wh@163.com','�����Ա�','�人��ά˹�ؿƼ����޹�˾','��ά˹�ء��人��ά˹�ؿơ�����������ʵ���豸��������������ѧ�豸','�人��ά˹�ؿƼ����޹�˾�Ǿ�Ӫ����������ʵ���豸��������������ѧ�豸�����ּ�������豸�Լ���Ӧ������ͺĲĵ�רҵ��˾���ҹ�˾�Ǻ��ݰ�ʢ�������޹�˾���а��´���...')

--��ҳͼƬ��
if exists(select * from sysobjects where name='tb_img')
begin 
drop table tb_img
end
create table tb_img
(
 id int identity primary key,
 title nvarchar(20),
 pid int,    
 sort int,
 ishide bit default 0,
 picpath nvarchar(100),
 cdate datetime default getdate() ,
)
go
--pidΪ0ʱΪ��ҳͼƬ,pidΪ1ʱΪ��ҳͼƬ
select * from tb_img
insert into tb_img values('Upload/1.jpg',0,1,0,'../../Upload/1.jpg',GETDATE())
insert into tb_img values('Upload/2.jpg',0,2,0,'../../Upload/2.jpg',GETDATE())
insert into tb_img values('Upload/3.jpg',0,3,0,'../../Upload/3.jpg',GETDATE())
insert into tb_img values('Upload/4.jpg',0,4,0,'../../Upload/4.jpg',GETDATE())
insert into tb_img values('Upload/5.jpg',0,5,0,'../../Upload/5.jpg',GETDATE())

delete tb_img where id in(1,2)
select * from tb_img where pid=0 and ishide=0

if exists(select * from sysobjects where name='tb_message')
begin 
drop table tb_message
end
create table tb_message
(
 id int identity,
 title nvarchar(30),
 username nvarchar(10),
 companyName nvarchar(20),
 phone nvarchar(20),
 email nvarchar(20),
 content nvarchar(100)
)
insert into tb_message values('����1','����','��ά˹��','110','abc@qq.com','��԰')
select * from tb_message

