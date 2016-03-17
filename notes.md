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
id    |   user_id   |   group_id  |  receiver_id   
1     |   1         |   1         |                
2     |   2         |   1         |                
3     |   3         |   1         |                
4     |   4         |   1         |                
5     |   5         |   1         |                
6     |   1         |   2         |                
7     |   2         |   2         |                
8     |   3         |   2         |                

INVITES
id    |   email                 |   group_id  |  membership_status
1     |   lharary@gmail.com     |   1         |   f
2     |   spatel@gmail.com      |   1         |   f


TO DO

4. Add more emails after group creation
5. Edit group name/description

6. paperclip gem
7. amazon products API

11. Include Register link on login page; login page on register page

**** CHANGE LINK IN EMAIL WHEN PUSHED TO HEROKU
