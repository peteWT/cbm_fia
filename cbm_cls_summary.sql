drop table if exists cbm_cls_summary;

create table cbm_cls_summary as select
	p.unitcd,
	c.reservcd,
	c.fortypcd,
	c.owngrpcd,
	case when stdage = 0 then 'AGEID0'
	     when stdage < 100 then 'AGEID'||ceil(stdage/10)
	     when stdage >= 100 then 'AGEID10'
	     else 'err'||stdage
	end as agerange,
--	'AGEID'||floor(stdage/10)*10 || '_'||floor(stdage/10)*10+9 as agerange,
--	'AGEID'||ceil(stdage/10) as agerange,
	sum(expns) acres
from plot p
left join cond c
     on (p.cn=c.plt_cn)
join pop_plot_stratum_assgn a on(p.cn=a.plt_cn)
join pop_stratum s on(a.stratum_cn=s.cn)
where p.invyr=2013 and fortypcd >0 and c.condid=1
group by
      p.unitcd,
      c.reservcd,
      c.fortypcd,
      c.owngrpcd,
      agerange
order by
      agerange
;

select
	sum(case when c.prop_basis='MACR'
	     then psm.expns * c.condprop_unadj * psm.adj_factor_macr
	     else psm.expns * c.condprop_unadj * psm.adj_factor_subp
	     end) as estimate,
	c.reservcd,
	c.owngrpcd,
	rft.meaning,
	p.unitcd,
	case when stdage = 0 then 'AGEID0'
	     when stdage < 200 then 'AGEID'||ceil(stdage/10)
	     when stdage >= 200 then 'AGEID20'
	     else 'NOAGE'
	end as agerange

FROM cond c,
     plot p,
     pop_plot_stratum_assgn ppsa,
     pop_stratum psm,
     pop_estn_unit peu,
     pop_eval pev,
     pop_eval_typ pet,
     pop_eval_grp peg,
     ref_forest_type rft
WHERE p.cn = c.plt_cn
AND pet.eval_typ = 'EXPCURR'
AND c.cond_status_cd = 1
AND c.siteclcd IN (1, 2, 3, 4, 5, 6)
AND ppsa.plt_cn = p.cn
AND ppsa.stratum_cn = psm.cn
AND peu.cn = psm.estn_unit_cn
AND pev.cn = peu.eval_cn
AND pev.cn = pet.eval_cn
AND pet.eval_grp_cn = peg.cn
AND peg.eval_grp = 62013
and rft.value = c.fortypcd
group by c.reservcd, rft.meaning, p.unitcd, c.owngrpcd, agerange;

