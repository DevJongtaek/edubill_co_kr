--스크립트 생성할때 서식에서 확장속성포함, 옵션에서 가운데 네개 (테이블스크립팅 옵션) 모두 체크해주세요^^

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_pckind]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_pckind]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_adminuser]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_adminuser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_bank]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_bank]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_cart]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_cart]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_cominfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_cominfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_copyright]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_copyright]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_member]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_member]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_member_mileage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_member_mileage]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_ment]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_ment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_order]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_order]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_order_product]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_order_product]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_pbkind]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_pbkind]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_pds]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_pds]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_product]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_product]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_pskind]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_pskind]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_pyoung]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_pyoung]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_wish]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb_wish]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[visit_COUNTER]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[visit_COUNTER]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zip_code]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zip_code]
GO

CREATE TABLE [dbo].[tb_pckind] (
	[ccode] [varchar] (2) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[bcode] [varchar] (2) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[cname] [varchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[cnum] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_adminuser] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[mem_id] [varchar] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[mem_pwd] [varchar] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[mem_name] [varchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[mem_tel] [varchar] (14) COLLATE Korean_Wansung_CI_AS NULL ,
	[mem_level] [varchar] (8) COLLATE Korean_Wansung_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_bank] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[flag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[bankname] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[bankno] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[bankman] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[cardurl] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[cardid] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[cardpwd] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_cart] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[sessionid] [varchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[m_id] [varchar] (12) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pcode] [varchar] (13) COLLATE Korean_Wansung_CI_AS NULL ,
	[pname] [varchar] (200) COLLATE Korean_Wansung_CI_AS NULL ,
	[pcomcode] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[pcolor] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[psize] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[sryang] [int] NULL ,
	[pprice] [int] NULL ,
	[wdate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_cominfo] (
	[cname] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[cno] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[caddr] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[chomepage] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[coner] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[cuptae] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[cjongmok] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[ctel] [varchar] (14) COLLATE Korean_Wansung_CI_AS NULL ,
	[cfax] [varchar] (14) COLLATE Korean_Wansung_CI_AS NULL ,
	[cemail] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[cunyounginfo] [varchar] (2000) COLLATE Korean_Wansung_CI_AS NULL ,
	[caccountinfo] [varchar] (2000) COLLATE Korean_Wansung_CI_AS NULL ,
	[baesonginfo] [varchar] (2000) COLLATE Korean_Wansung_CI_AS NULL ,
	[baninfo] [varchar] (2000) COLLATE Korean_Wansung_CI_AS NULL ,
	[cyak] [text] COLLATE Korean_Wansung_CI_AS NULL ,
	[cperboho] [text] COLLATE Korean_Wansung_CI_AS NULL ,
	[cpopflag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[cpopwidth] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[cpopheight] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[cpopday1] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[cpopday2] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[cpopcontent] [text] COLLATE Korean_Wansung_CI_AS NULL ,
	[millage] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[title] [varchar] (500) COLLATE Korean_Wansung_CI_AS NULL ,
	[cpch] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[ctongsinno] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[bmoney] [int] NOT NULL ,
	[omoney] [int] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_copyright] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[email] [varchar] (200) COLLATE Korean_Wansung_CI_AS NULL ,
	[title] [varchar] (200) COLLATE Korean_Wansung_CI_AS NULL ,
	[content] [text] COLLATE Korean_Wansung_CI_AS NULL ,
	[wdate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_member] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[m_id] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_pwd] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_name] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_jumin] [varchar] (14) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_post] [varchar] (7) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_addr] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_addr_2] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_tel_1] [varchar] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_tel_2] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_tel_3] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_tel2_1] [varchar] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_tel2_2] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_tel2_3] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_email] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_date] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[procount] [int] NOT NULL ,
	[procountmoney] [varchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[m_news] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_sm] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_bymd] [varchar] (8) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_level] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[m_mileage] [int] NOT NULL ,
	[m_delgubun] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_member_mileage] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[userid] [varchar] (12) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[flag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[usemoney] [int] NOT NULL ,
	[ordernum] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[usetitle] [varchar] (60) COLLATE Korean_Wansung_CI_AS NULL ,
	[wdate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_ment] (
	[midx] [int] IDENTITY (1, 1) NOT NULL ,
	[idx] [int] NOT NULL ,
	[userid] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[username] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[wdate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[mcontent] [varchar] (4000) COLLATE Korean_Wansung_CI_AS NULL ,
	[pwd] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_order] (
	[ordernum] [varchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[userid] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[buymoney] [varchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[ordermoney] [varchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[milieagemoney] [varchar] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[deliverymoney] [varchar] (10) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[payflag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[banknogubun] [int] NULL ,
	[banknipname] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_name] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_post] [varchar] (7) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_addr] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_addr2] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_tel_1] [varchar] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_tel_2] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_tel_3] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_tel2_1] [varchar] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_tel2_2] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_tel2_3] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[o_email] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_name] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_post] [varchar] (7) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_addr] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_addr2] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_tel_1] [varchar] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_tel_2] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_tel_3] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_tel2_1] [varchar] (3) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_tel2_2] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_tel2_3] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[d_email] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[content] [varchar] (2000) COLLATE Korean_Wansung_CI_AS NULL ,
	[deliveryflag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[orderday] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[ingflag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[deliverynum] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[admincontent] [varchar] (1000) COLLATE Korean_Wansung_CI_AS NULL ,
	[orderendday] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[ordercacleday] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[cardday] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[cardoknum] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[carderrormsg] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_order_product] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[ordernum] [varchar] (30) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pcode] [varchar] (13) COLLATE Korean_Wansung_CI_AS NULL ,
	[pname] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[pcomcode] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[pcolor] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[psize] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[sryang] [int] NOT NULL ,
	[pprice] [int] NOT NULL ,
	[wdate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[milleage] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_pbkind] (
	[bcode] [varchar] (2) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[bname] [varchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[bnum] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_pds] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[email] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[pwd] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[title] [varchar] (150) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[nows] [varchar] (25) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[readnum] [int] NOT NULL ,
	[ref] [int] NOT NULL ,
	[re_level] [smallint] NOT NULL ,
	[re_step] [smallint] NOT NULL ,
	[content] [ntext] COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[user_ip] [varchar] (15) COLLATE Korean_Wansung_CI_AS NULL ,
	[uid] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[b_file1] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[b_file1_width] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[b_file2] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[b_file2_width] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
	[userid] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[chuchun] [int] NOT NULL ,
	[hflag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[areaddate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_product] (
	[pcode] [varchar] (13) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pname] [varchar] (200) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pcomcode] [varchar] (40) COLLATE Korean_Wansung_CI_AS NULL ,
	[pcomcodesee] [varchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pcolor] [varchar] (300) COLLATE Korean_Wansung_CI_AS NULL ,
	[pcolorsee] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[psize] [varchar] (300) COLLATE Korean_Wansung_CI_AS NULL ,
	[psizesee] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pstock] [int] NOT NULL ,
	[pseecount] [int] NOT NULL ,
	[pprice] [int] NOT NULL ,
	[sprice] [int] NOT NULL ,
	[petcname1] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[petcname2] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[petcname3] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[petcname4] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[petcname5] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[petccon1] [varchar] (150) COLLATE Korean_Wansung_CI_AS NULL ,
	[petccon2] [varchar] (150) COLLATE Korean_Wansung_CI_AS NULL ,
	[petccon3] [varchar] (150) COLLATE Korean_Wansung_CI_AS NULL ,
	[petccon4] [varchar] (150) COLLATE Korean_Wansung_CI_AS NULL ,
	[petccon5] [varchar] (150) COLLATE Korean_Wansung_CI_AS NULL ,
	[pdetailcon] [text] COLLATE Korean_Wansung_CI_AS NULL ,
	[pdetailcon2] [text] COLLATE Korean_Wansung_CI_AS NULL ,
	[simage] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[mimage] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[limage] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[limage2] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[limage3] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[limage4] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
	[userid] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[pwdate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[euserid] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
	[pewdate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[pnum] [int] NOT NULL ,
	[piconimg] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pbuycount] [int] NOT NULL ,
	[pbuytotalmoney] [varchar] (20) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pmgubun] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[seeflag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pgbn_1] [varchar] (3) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pgbn_2] [varchar] (3) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pgbn_3] [varchar] (3) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pgbn_4] [varchar] (3) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[keyword] [varchar] (200) COLLATE Korean_Wansung_CI_AS NULL ,
	[htmlflag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[htmlflag2] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[ptflag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_pskind] (
	[scode] [varchar] (5) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[bcode] [varchar] (2) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[ccode] [varchar] (2) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[sname] [varchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[snum] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_pyoung] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[userid] [varchar] (12) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[username] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
	[pcode] [varchar] (13) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[title] [varchar] (150) COLLATE Korean_Wansung_CI_AS NULL ,
	[content] [text] COLLATE Korean_Wansung_CI_AS NULL ,
	[pyoung] [varchar] (1) COLLATE Korean_Wansung_CI_AS NULL ,
	[wdate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL ,
	[startflag] [varchar] (1) COLLATE Korean_Wansung_CI_AS NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tb_wish] (
	[idx] [int] IDENTITY (1, 1) NOT NULL ,
	[userid] [varchar] (12) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[pcode] [varchar] (13) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[imsicn] [varchar] (4) COLLATE Korean_Wansung_CI_AS NULL ,
	[wdate] [varchar] (30) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[visit_COUNTER] (
	[vNum] [int] IDENTITY (1, 1) NOT NULL ,
	[vIP] [varchar] (15) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[vYY] [smallint] NOT NULL ,
	[vMM] [tinyint] NOT NULL ,
	[vDD] [tinyint] NOT NULL ,
	[vHH] [tinyint] NOT NULL ,
	[vMT] [tinyint] NOT NULL ,
	[vSeason] [tinyint] NOT NULL ,
	[vDW] [tinyint] NOT NULL ,
	[vBrowser] [varchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[vOS] [varchar] (50) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[vReferer] [varchar] (200) COLLATE Korean_Wansung_CI_AS NOT NULL ,
	[vTarget] [varchar] (200) COLLATE Korean_Wansung_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[zip_code] (
	[ZIP_CODE] [nvarchar] (255) COLLATE Korean_Wansung_CI_AS NULL ,
	[s1] [nvarchar] (255) COLLATE Korean_Wansung_CI_AS NULL ,
	[s2] [nvarchar] (255) COLLATE Korean_Wansung_CI_AS NULL ,
	[s3] [nvarchar] (255) COLLATE Korean_Wansung_CI_AS NULL ,
	[s4] [nvarchar] (255) COLLATE Korean_Wansung_CI_AS NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_adminuser] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_adminuser] PRIMARY KEY  CLUSTERED 
	(
		[idx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_cart] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_cart] PRIMARY KEY  CLUSTERED 
	(
		[idx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_copyright] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_copyright] PRIMARY KEY  CLUSTERED 
	(
		[idx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_member] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_member] PRIMARY KEY  CLUSTERED 
	(
		[idx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_member_mileage] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_member_mileage] PRIMARY KEY  CLUSTERED 
	(
		[idx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_ment] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_ment] PRIMARY KEY  CLUSTERED 
	(
		[midx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_order] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_order] PRIMARY KEY  CLUSTERED 
	(
		[ordernum]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_order_product] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_order_product] PRIMARY KEY  CLUSTERED 
	(
		[idx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_pbkind] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_pbkind] PRIMARY KEY  CLUSTERED 
	(
		[bcode]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_pds] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_pds] PRIMARY KEY  CLUSTERED 
	(
		[idx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_product] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_product] PRIMARY KEY  CLUSTERED 
	(
		[pcode]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_pskind] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_pskind] PRIMARY KEY  CLUSTERED 
	(
		[scode]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_pyoung] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_pyoung] PRIMARY KEY  CLUSTERED 
	(
		[idx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_wish] WITH NOCHECK ADD 
	CONSTRAINT [PK_tb_wish] PRIMARY KEY  CLUSTERED 
	(
		[idx]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tb_pckind] ADD 
	CONSTRAINT [DF_tb_pckind_cnum] DEFAULT (99) FOR [cnum]
GO

ALTER TABLE [dbo].[tb_cominfo] ADD 
	CONSTRAINT [DF_tb_cominfo_bmoney] DEFAULT (0) FOR [bmoney],
	CONSTRAINT [DF_tb_cominfo_omoney] DEFAULT (0) FOR [omoney]
GO

ALTER TABLE [dbo].[tb_member] ADD 
	CONSTRAINT [DF_tb_member_procount] DEFAULT (0) FOR [procount],
	CONSTRAINT [DF_tb_member_procountmoney] DEFAULT (0) FOR [procountmoney],
	CONSTRAINT [DF_tb_member_m_mileage] DEFAULT (0) FOR [m_mileage],
	CONSTRAINT [DF_tb_member_m_delgubun] DEFAULT (0) FOR [m_delgubun]
GO

ALTER TABLE [dbo].[tb_member_mileage] ADD 
	CONSTRAINT [DF_tb_member_mileage_usemoney] DEFAULT (0) FOR [usemoney]
GO

ALTER TABLE [dbo].[tb_order] ADD 
	CONSTRAINT [DF_tb_order_buymoney] DEFAULT (0) FOR [buymoney],
	CONSTRAINT [DF_tb_order_ordermoney] DEFAULT (0) FOR [ordermoney],
	CONSTRAINT [DF_tb_order_milieagemoney] DEFAULT (0) FOR [milieagemoney],
	CONSTRAINT [DF_tb_order_deliverymoney] DEFAULT (0) FOR [deliverymoney]
GO

ALTER TABLE [dbo].[tb_order_product] ADD 
	CONSTRAINT [DF_tb_order_product_milleage] DEFAULT ('y') FOR [milleage]
GO

ALTER TABLE [dbo].[tb_pbkind] ADD 
	CONSTRAINT [DF_tb_pbkind_bnum] DEFAULT (99) FOR [bnum]
GO

ALTER TABLE [dbo].[tb_pds] ADD 
	CONSTRAINT [DF_tb_pds_chuchun] DEFAULT (0) FOR [chuchun],
	CONSTRAINT [DF_tb_pds_hflag] DEFAULT (0) FOR [hflag]
GO

ALTER TABLE [dbo].[tb_product] ADD 
	CONSTRAINT [DF_tb_product_pcomcodesee_1] DEFAULT ('y') FOR [pcomcodesee],
	CONSTRAINT [DF_tb_product_pcolorsee_1] DEFAULT ('y') FOR [pcolorsee],
	CONSTRAINT [DF_tb_product_psizesee_1] DEFAULT ('y') FOR [psizesee],
	CONSTRAINT [DF_tb_product_pstock] DEFAULT (0) FOR [pstock],
	CONSTRAINT [DF_tb_product_pseecount] DEFAULT (0) FOR [pseecount],
	CONSTRAINT [DF_tb_product_pprice_1] DEFAULT (0) FOR [pprice],
	CONSTRAINT [DF_tb_product_sprice] DEFAULT (0) FOR [sprice],
	CONSTRAINT [DF_tb_product_pnum] DEFAULT (9999) FOR [pnum],
	CONSTRAINT [DF_tb_product_piconimg_1] DEFAULT (0) FOR [piconimg],
	CONSTRAINT [DF_tb_product_pbuycount] DEFAULT (0) FOR [pbuycount],
	CONSTRAINT [DF_tb_product_pbuytotalmoney] DEFAULT (0) FOR [pbuytotalmoney],
	CONSTRAINT [DF_tb_product_pmgubun] DEFAULT ('y') FOR [pmgubun],
	CONSTRAINT [DF_tb_product_seeflag_1] DEFAULT ('y') FOR [seeflag],
	CONSTRAINT [DF_tb_product_pgbn_1_1] DEFAULT ('nnn') FOR [pgbn_1],
	CONSTRAINT [DF_tb_product_pgbn_2_1] DEFAULT ('nnn') FOR [pgbn_2],
	CONSTRAINT [DF_tb_product_pgbn_3_1] DEFAULT ('nnn') FOR [pgbn_3],
	CONSTRAINT [DF_tb_product_pgbn_4_1] DEFAULT ('nnn') FOR [pgbn_4],
	CONSTRAINT [DF_tb_product_htmlflag] DEFAULT (0) FOR [htmlflag],
	CONSTRAINT [DF_tb_product_htmlflag2] DEFAULT (0) FOR [htmlflag2],
	CONSTRAINT [DF_tb_product_ptflag] DEFAULT (0) FOR [ptflag]
GO

ALTER TABLE [dbo].[tb_pskind] ADD 
	CONSTRAINT [DF_tb_pskind_scode] DEFAULT (10000) FOR [scode]
GO

