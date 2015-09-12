# cbm_fia

## Gluing FIA, FVS and CBM together

*NOTE* its likely best to do this on a 32-bit installation of Windows

### FVS with ODBC connection to PostgreSQL

This was done on Windows 8

1. Install Postgresql with the ODBC driver from EnterpriseDB setting up the default user/pass as postgres/postgres
2. Create a database for housing FVS data (`fia_fvs'). This can be done using PGAdminIII or using the command line tools which can be accessed by adding the `bin/` directory of the PostgreSQL installation to the `PATH' environment variable.
	A. `$>createdb.exe -U postgres fia_fvs'
	B. `$>createuser -U postgres -s -P fvs`
	C. Then enter the new `fvs` user's new password twice when prompted followed by the default users password.
2. Set up a new *SystemDSN* ODBC connection using the 'Setup ODBC Data Sources' in PC Settings
3. In FVS set the `DSNOut` keyword as follows:
	`DSNOut
