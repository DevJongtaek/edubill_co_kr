--��ǰ�ܰ�----------------------------------------------------------------------------
select top 10 b.pprice as ��ǰ�ܰ�,b.pcode as ��ǰ�ڵ�, a.* from tb_company a
left outer join
(select * from tb_product) b
on a.idx=b.usercode
where a.flag='1'
order by b.pprice desc

--�ֹ��ݾ�----------------------------------------------------------------------------
select top 10 a.rordermoney as �ֹ��ݾ�,c.ȸ�����, a.* from tb_order a
left outer join
(select idx,comname as ȸ����� from tb_company where flag='1') c
on substring(a.usercode,1,5)=c.idx
order by a.rordermoney desc

--�ֹ�����----------------------------------------------------------------------------
select top 10  b.�ֹ�����,c.ȸ����� ,a.* from tb_order a
left outer join
(select idx,count(idx) as �ֹ����� from tb_order_product group by idx) b
on a.idx=b.idx
left outer join
(select idx,comname as ȸ����� from tb_company where flag='1') c
on substring(a.usercode,1,5)=c.idx
order by b.�ֹ����� desc






--[����]�ֹ� ������
delete tb_order where idx=''
delete tb_order_product where idx=''



--[����]��ǰ ������
delete tb_product where idx=
