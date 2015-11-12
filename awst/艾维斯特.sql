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
insert into tb_menu values('��������',0,0,1,'','','',GETDATE())
insert into tb_menu(title,pid,sort) values('��˾����',1,1)
insert into tb_menu(title,pid,sort) values('��˾���',1,2)
insert into tb_menu(title,pid,sort) values('��ҵ�Ļ�',1,3)
insert into tb_menu(title,pid,sort) values('��˾����',5,2)
insert into tb_menu(title,pid,sort) values('���´���',5,3)
update tb_menu set isHide=1 where id=4
update tb_menu set pid=5 where title='��ҵ����'
select * from tb_menu where pid=5

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
 linkurl nvarchar(30),
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
insert into tb_backgroundMenu values('��Ϣ����',6,2,'News.aspx?id=5',getdate())
insert into tb_backgroundMenu(title,pid,sort) values('��ҵ����',6,3)
--��Ʒ����
insert into tb_backgroundMenu(title,pid,sort) values('��Ʒ����',0,3)
insert into tb_backgroundMenu values('������',10,1,'ProductFile/ProductList.aspx',getdate())
select * from tb_backgroundMenu
update tb_backgroundMenu set linkurl='ProductFile/ProductList.aspx' where id=11


select * from tb_menu where pid=5 order by sort
select * from tb_backgroundMenu


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


select * from tb_newsInfo where isverify=1 and pid=6 order by id
select * from tb_newsInfo
select * from tb_menu
--6:��ҵ����   20��˾����  21�����´���
select * from tb_newsInfo where isverify=0 and pid=20 and title like '%4%' order by id
update tb_newsInfo set picpath='../Upload/a.jpg' where id=10
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
insert into tb_productColumn(title,pid) values('ø���Ǻ�ϴ���ϵ��',0)
insert into tb_productColumn(title,pid) values('��΢���ֹ��ȼ�ϵ��',0)
insert into tb_productColumn(title,pid) values('ø����ϵ��',1)
insert into tb_productColumn(title,pid) values('ϴ���ϵ��',1)
insert into tb_productColumn(title,pid) values('��΢���ֹ��ȼ�',2)
insert into tb_productColumn(title,pid) values('��΢�����������',2)
