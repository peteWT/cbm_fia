drop table if exists cbm_trees;

create table cbm_trees as
select
	t.bhage,
	t.totage,
	drybio_top,
	t.drybio_bole,
	p.lat,
	p.lon,
	p.cn,
	p.ecosubcd,
	e.map_unit_n,
	o.desc,
	r.meaning
from catree t
left join cond c
     using(plt_cn, condid)
left join plot p
     on (c.plt_cn=p.cn)
left join ref_forest_type r
     on(fortypcd=r.value)
left join owncd o
     using(owncd)
left join ecosub e
     on (p.ecosubcd=e.map_unit_s)
where t.drybio_bole>0
;
