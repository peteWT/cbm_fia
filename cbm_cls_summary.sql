drop table if exists cbm_cls_summary;

create table cbm_cls_summary as select
	sum(case when c.prop_basis='MACR'
	     then psm.expns * c.condprop_unadj * psm.adj_factor_macr
	     else psm.expns * c.condprop_unadj * psm.adj_factor_subp
	     end) as estimate,
	rcd.cbm_cd reserve_group,
	ogc.cbm_ogcd owner_group,
	fg.cbm_spcd forest_group,
	ru.meaning ref_unit,
	case when stdage = 0 then 'AGEID0'
	     when stdage < 200 then 'AGEID'||ceil(stdage/10)
	     when stdage >= 200 then 'AGEID999'
	     else 'NOAGE'
	end as agerange
FROM cond c
left join plot p on (c.plt_cn = p.cn)
left join pop_plot_stratum_assgn ppsa on (ppsa.plt_cn = p.cn)
left join pop_stratum psm on (ppsa.stratum_cn = psm.cn)
left join pop_estn_unit peu on (peu.cn = psm.estn_unit_cn)
left join pop_eval pev on (pev.cn = peu.eval_cn)
left join pop_eval_typ pet on (pev.cn = pet.eval_cn)
left join pop_eval_grp peg on(pet.eval_grp_cn = peg.cn)
left join reservcd rcd using(reservcd)
left join owngrpcd ogc using(owngrpcd)
left join ref_forest_type ftc on (c.fortypcd=ftc.value)
left join cbm_fgroup fg on (ftc.typgrpcd=fg.typgrpcd)
left join ref_unit ru on p.unitcd=ru.value and p.statecd=ru.statecd
WHERE p.cn = c.plt_cn
AND pet.eval_typ = 'EXPCURR'
AND c.cond_status_cd = 1
AND c.siteclcd IN (1, 2, 3, 4, 5, 6)
AND peg.eval_grp = 62013
group by reserve_group, owner_group, forest_group, ref_unit, agerange;


