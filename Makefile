dbname:= cmax
state:= CA
plotAttrib := ['CN','INVYR', 'PLOT','PLOT_STATUS_CD','ECOSUBCD','LAT','LON','RDDISTCD','MEASYEAR','MEASMON','MEASDAY', 'EMAP_HEX','ECO_UNIT']
drif := 3311

db:
	createdb ${dbname}
	psql -d ${dbname} -c 'create extension postgis;'
	mkdir $@

tree:
# for some reason this doesnt work in the makefile only in python
	python - c "import utils as ut; ut.treeTable()"
	touch db/$@

cond:
	python -c "import utils as ut; toDB(${state},$@)"
	touch db/$@

plot:
	python -c "import utils as ut; toDB(${state},$@)"
	touch db/$@

ref_forest_type_group:
	python -c "import utils as ut; toDB(${state},$@, is_ref=True)"
	touch db/$@

ecosub:
	wget http://data.fs.usda.gov/geodata/edw/edw_resources/shp/S_USA.EcomapSubsections.zip
	unzip S_USA.EcomapSubsections.zip
	shp2pgsql -s '4269:3311' -I S_USA.EcomapSubsections.shp $@ | psql -d cmax
	rm S_USA.EcomapSubsections.*
	touch db/$@

.PHONY: inputs
inputs: plot cond ecosub ref ref_forest_type_group

