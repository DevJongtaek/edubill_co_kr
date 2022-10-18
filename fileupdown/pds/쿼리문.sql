--상품단가----------------------------------------------------------------------------
select top 10 b.pprice as 상품단가,b.pcode as 상품코드, a.* from tb_company a
left outer join
(select * from tb_product) b
on a.idx=b.usercode
where a.flag='1'
order by b.pprice desc

--주문금액----------------------------------------------------------------------------
select top 10 a.rordermoney as 주문금액,c.회원사명, a.* from tb_order a
left outer join
(select idx,comname as 회원사명 from tb_company where flag='1') c
on substring(a.usercode,1,5)=c.idx
order by a.rordermoney desc

--주문수량----------------------------------------------------------------------------
select top 10  b.주문수량,c.회원사명 ,a.* from tb_order a
left outer join
(select idx,count(idx) as 주문수량 from tb_order_product group by idx) b
on a.idx=b.idx
left outer join
(select idx,comname as 회원사명 from tb_company where flag='1') c
on substring(a.usercode,1,5)=c.idx
order by b.주문수량 desc






--[주의]주문 삭제시
delete tb_order where idx=''
delete tb_order_product where idx=''



--[주의]상품 삭제시
delete tb_product where idx=
