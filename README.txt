##Overview##
A PostgreSQL database schema to store the game matches between players.

Python module to rank the players and pair them up in matches 
in a Swiss Pairings tournament.

- PostgreSQL database and table definitions in a file (tournament.sql)
- Python functions filling out a template of an API (tournament.py)


##Requirements##
1) Make sure these files are in the same directory
- tournament.sql
- tournament.py
- tournament_test.py
2) Install Vagrant and VirtualBox
3) Clone the fullstack-nanodegree-vm repository
4) Have Python 2.7.9 Shell installed

##How To##
1) Startup Vagrant VM instance
2) Run SQL statements via ‘tournament.sql’ to create required DB, tables, and views
3) Run ‘tournament_test.py’. All tests should pass.
