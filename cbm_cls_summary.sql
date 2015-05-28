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

FROM cond c,
     plot p,
     pop_plot_stratum_assgn ppsa,
     pop_stratum psm,
     pop_estn_unit peu,
     pop_eval pev,
     pop_eval_typ pet,
     pop_eval_grp peg,
     ref_forest_type ftc,
     ref_forest_type_group fgc,
     cbm_fgroup fg,
     owngrpcd ogc,
     reservcd rcd,
     ref_unit ru
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
and c.fortypcd=ftc.value
and ftc.typgrpcd=fg.typgrpcd
and c.reservcd=rcd.reservcd
and c.owngrpcd=ogc.owngrpcd
and p.unitcd=ru.value
and p.statecd=ru.statecd
group by rcd.cbm_cd, fg.cbm_spcd, ru.meaning, ogc.cbm_ogcd, agerange;

