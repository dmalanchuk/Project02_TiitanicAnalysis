# щоб удалити гіт: 
    rm -rf .git

# щоб запустити базу даних: 
    brew services start postgresql
    pg_ctl -D '/Users/danamarisik/sqlQueries' start

# щоб перевірити чи запущена:
    brew services list
    pg_ctl -D '/Users/danamarisik/sqlQueries' status

# щоб зупинити базу даних: 
    brew services stop postgresql
    pg_ctl -D '/Users/danamarisik/sqlQueries' stop


