drop table if exists cbm_cls_summary;

create table cbm_cls_summary as select
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

