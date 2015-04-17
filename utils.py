import pandas as pd
from sqlalchemy import create_engine as ce

dbname = 'cmax'
engine = ce('postgresql:///{0}'.format(dbname), echo=True)
fiaUrl = 'http://apps.fs.fed.us/fiadb-downloads/'


def toDF(state, tname, makelower=True, lowm=False):
    '''
    creates a pandas dataframe from the desired table
    '''
    tab = '{0}_{1}.csv'.format(state, tname)
    df = pd.read_csv(fiaUrl+tab, low_memory=lowm)
    if makelower is True:
        df.columns = [i.lower() for i in df.columns]
        return df
    else:
        return df


def toDB(state, tname, dbname='cmax', if_ex='replace', makelower=True,
         lowm=False):
    '''
    generic tool for migrating csv to the database
    WARNING: Tables can be difficult for pandas to parse data types
    '''
    tab = '{0}_{1}.csv'.format(state, tname)
    df = pd.read_csv(fiaUrl+tab, low_memory=lowm)
    if makelower is True:
        df.columns = [i.lower() for i in df.columns]
    df.to_sql(tname.lower(), engine, if_exists=if_ex)

    
def treeTable(state='CA',
              table='TREE',
              attribs=['INVYR',
                       'PLOT',
                       'BHAGE',
                       'TOTAGE',
                       'PLT_CN',
                       'CN',
                       'DRYBIO_BOLE',
                       'DRYBIO_TOP'],
              if_ex='replace'):
    table_name = state.lower()+table.lower()
    df = toDF(state, table)
    at = [i.lower() for i in attribs]
    mdf = df[at]
    mdf.to_sql(table_name, engine, if_exists=if_ex)
    
