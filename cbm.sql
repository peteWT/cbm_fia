select
	t.bhage,
	t.totage,
	drybio_top,
	t.drybio_bole,
	p.ecosubcd,
	e.map_unit_n,
	o.desc,
	r.meaning
from catree t
join cond c
     using(plt_cn)
join plot p
     on (c.plt_cn=p.cn)
join ref_forest_type_group r
     on(fortypcd=r.value)
join owncd o
     using(owncd)
join ecosub e
     on (p.ecosubcd=e.map_unit_s)
;
