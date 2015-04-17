dbname:= cmax
state:= CA
plotAttrib := ['CN','INVYR', 'PLOT','PLOT_STATUS_CD','ECOSUBCD','LAT','LON','RDDISTCD','MEASYEAR','MEASMON','MEASDAY', 'EMAP_HEX','ECO_UNIT']

db:
	createdb ${dbname}
	psql -d ${dbname} -c 'create extension postgis;'
	mkdir $@

${state}_TREE.csv:
	wget -P db/ http://apps.fs.fed.us/fiadb-downloads/$@

tree:
	wget 
	python -c "import utils as ut; ut.treeTable()"
	touch db/$@
