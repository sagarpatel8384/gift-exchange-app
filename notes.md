USERS
--------------------
id  |   first_name    |   last_name   |   email                 |   password_digest
1   |   Justin        |   Curhan      |   jcurhan@gmail.com     |    *********
2   |   Leon          |   Harary      |   lharary@gmail.com     |    ****
3   |   Sagar         |   Patel       |   spatel@gmail.com      |    *********
4   |   Jeff          |   Katz        |   jkatz@gmail.com       |    ********
5   |   Ian           |   Candy       |   icandy@gmail.com      |    *******
6   |                 |               |   icandy@gmail.com      |   


GROUPS
--------------------
id    |   name          |   description                         |    exchange_date   |   max_price   |   admin_id
1     |   Flatiron      |   Junior Developer Gift Exchange      |    2016-12-15      |   50          |   4
2     |   Secret Santa  |   Friends Secret Santa                |    2016-12-15      |   100         |   1


MEMBERSHIPS(USER_GROUPS)
--------------------
id    |   user_id   |   group_id  |  receiver_id   |  joined
1     |   1         |   1         |                |    f
2     |   2         |   1         |                |    f           
3     |   3         |   1         |                |    f           
4     |   4         |   1         |                |    f           
5     |   5         |   1         |                |    f           
6     |   1         |   2         |                |    f           
7     |   2         |   2         |                |    f           
8     |   3         |   2         |                |    f
