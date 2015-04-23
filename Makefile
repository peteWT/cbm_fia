dbname:= cmax
state:= CA
plotAttrib := ['CN','INVYR', 'PLOT','PLOT_STATUS_CD','ECOSUBCD','LAT','LON','RDDISTCD','MEASYEAR','MEASMON','MEASDAY', 'EMAP_HEX','ECO_UNIT']
drif := 3311

db:
	createdb ${dbname}
	psql -d ${dbname} -c 'create extension postgis;'
	mkdir $@

db/tree:
	python -c "import utils as ut; ut.treeTable()"
	touch db/$@

db/ref_unit:
	python -c "import utils as ut; ut.toDB('${state}','ref_unit', isref=True)"
	touch $@

db/cond:
	python -c "import utils as ut; ut.toDB(${state},cond)"
	touch $@

db/plot:
	python -c "import utils as ut; ut.toDB(${state},plot)"
	touch $@

db/ref_forest_type_group:
# Includes both forest_type_group and forest_type
	python -c "import utils as ut; ut.toDB(${state},ref_forest_type_group, isref=True)"
	touch $@

db/ecosub:
	wget http://data.fs.usda.gov/geodata/edw/edw_resources/shp/S_USA.EcomapSubsections.zip
	unzip S_USA.EcomapSubsections.zip
	shp2pgsql -s '4269:3311' -I S_USA.EcomapSubsections.shp $@ | psql -d cmax
	rm S_USA.EcomapSubsections.*
	touch $@

.PHONY: inputs
inputs: db/plot db/cond db/ecosub db/ref_forest_type_group

output/cbmtrees.csv:
	psql -d cmax -f cbm.sql
	psql -d cmax -c "copy (select * from cbm_trees) to stdout with csv header" > $@	
