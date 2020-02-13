<img src="https://s3.amazonaws.com/devmountain/readme-logo.png" width="250" align="right">

# Project Summary

In this project, we'll continue to use <a href="https://postgres.devmountain.com/">postgres.devmountain.com</a> to practice joins, nested queries, updating rows, group by, distinct, and foreign keys.

Any new tables or records that you add into the database will be removed after you refresh the page.

## Practice joins

### Instructions

<details>

<summary> <code> Syntax Hint </code> </summary>

```sql
SELECT [Column names] 
FROM [table] [abbv]
JOIN [table2] [abbv2] ON abbv.prop = abbv2.prop WHERE [Conditions];

SELECT a.name, b.name FROM some_table a JOIN another_table b ON a.some_id = b.some_id;
SELECT a.name, b.name FROM some_table a JOIN another_table b ON a.some_id = b.some_id WHERE b.email = 'e@mail.com';
```

</details>

<br />

1. Get all invoices where the `unit_price` on the `invoice_line` is greater than $0.99.

SELECT * FROM invoice AS i
JOIN invoice_line AS il
ON il.invoice_id = i.invoice_id
WHERE il.unit_price > .99

2. Get the `invoice_date`, customer `first_name` and `last_name`, and `total` from all invoices.

SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice AS i
JOIN customer AS c 
ON i.customer_id = c.customer_id

3. Get the customer `first_name` and `last_name` and the support rep's `first_name` and `last_name` from all customers. 
    * Support reps are on the employee table.

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer AS c
JOIN employee AS e
ON c.support_rep_id = e.employee_id

4. Get the album `title` and the artist `name` from all albums.

SELECT album.title, artist.name
FROM album
JOIN artist 
ON album.artist_id = artist.artist_id

5. Get all playlist_track track_ids where the playlist `name` is Music.

SELECT playlist_track.track_id
FROM playlist_track
JOIN playlist
ON playlist.playlist_id = playlist_track.playlist_id
WHERE playlist.name = 'Music'

6. Get all track `name`s for `playlist_id` 5.

SELECT t.name
FROM track AS t
JOIN playlist_track
ON playlist_track.track_id = t.track_id
WHERE playlist_track.playlist_id = 5

7. Get all track `name`s and the playlist `name` that they're on ( 2 joins ).

SELECT t.name, p.name
FROM track AS t
JOIN playlist_track AS pt 
ON t.track_id = pt.track_id
JOIN playlist AS p 
ON pt.playlist_id = p.playlist_id

8. Get all track `name`s and album `title`s that are the genre `Alternative & Punk` ( 2 joins ).

SELECT t.name, a.title
FROM track AS t
JOIN album AS a 
ON t.album_id = a.album_id
JOIN genre AS g 
ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk'


### Black Diamond

* Get all tracks on the playlist(s) called Music and show their name, genre name, album name, and artist name.
  * At least 5 joins.


## Practice nested queries

### Summary

Complete the instructions without using any joins. Only use nested queries to come up with the solution.

### Instructions

<details>

<summary> <code> Syntax Hint </code> </summary>

```sql
SELECT [column names] 
FROM [table] 
WHERE column_id IN ( SELECT column_id FROM [table2] WHERE [Condition] );

SELECT name, Email FROM Athlete WHERE AthleteId IN ( SELECT PersonId FROM PieEaters WHERE Flavor='Apple' );
```

</details>

<br />

1. Get all invoices where the `unit_price` on the `invoice_line` is greater than $0.99.

SELECT * FROM invoice
WHERE invoice_id 
IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99)

2. Get all playlist tracks where the playlist name is Music.

SELECT * FROM playlist_track
WHERE playlist_id 
IN (SELECT playlist_id FROM playlist WHERE name = 'Music')

3. Get all track names for `playlist_id` 5.

SELECT name FROM track
WHERE track_id 
IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5)

4. Get all tracks where the `genre` is Comedy.

SELECT * FROM track
WHERE genre_id 
IN (SELECT genre_id FROM genre WHERE name = 'Comedy')

5. Get all tracks where the `album` is Fireball.

SELECT * FROM track
WHERE album_id 
IN (SELECT album_id FROM album WHERE title = 'Fireball')

6. Get all tracks for the artist Queen ( 2 nested subqueries ).

SELECT * FROM track
WHERE album_id 
IN (SELECT album_id FROM album WHERE artist_id 
IN (SELECT artist_id FROM artist WHERE name = 'Queen')
)

## Practice updating Rows

### Instructions

<details>

<summary> <code> Syntax Hint </code> </summary>

```sql
UPDATE [table] 
SET [column1] = [value1], [column2] = [value2] 
WHERE [Condition];

UPDATE athletes SET sport = 'Picklball' WHERE sport = 'pockleball';
```

</details>

<br />

1. Find all customers with fax numbers and set those numbers to `null`.

UPDATE customer SET fax = null
WHERE fax IS NOT null

2. Find all customers with no company (null) and set their company to `"Self"`.

UPDATE customer SET company = 'Self'
WHERE company IS null

3. Find the customer `Julia Barnett` and change her last name to `Thompson`.

UPDATE customer SET last_name = 'Thompson' 
WHERE first_name = 'Julia' 
AND last_name = 'Barnett'

4. Find the customer with this email `luisrojas@yahoo.cl` and change his support rep to `4`.

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'

5. Find all tracks that are the genre `Metal` and have no composer. Set the composer to `"The darkness around us"`.

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null

6. Refresh your page to remove all database changes.

## Group by

### Instructions

<details>

<summary> <code> Syntax Hint </code> </summary>

```sql
SELECT [column1], [column2]
FROM [table] [abbr]
GROUP BY [column];
```

</details>

<br />

1. Find a count of how many tracks there are per genre. Display the genre name with the count.

SELECT COUNT (*), g.name
FROM track AS t
JOIN genre AS g 
ON t.genre_id = g.genre_id
GROUP BY g.name

2. Find a count of how many tracks are the `"Pop"` genre and how many tracks are the `"Rock"` genre.

SELECT COUNT(*), g.name
FROM track AS t
JOIN genre AS g 
ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name

3. Find a list of all artists and how many albums they have.

SELECT COUNT (*), artist.name
FROM album
JOIN artist 
ON artist.artist_id = album.artist_id
GROUP BY artist.name

## Use Distinct

<details>

<summary> <code> Syntax Hint </code> </summary>

```sql
SELECT DISTINCT [column]
FROM [table];
```

</details>

<br />

1. From the `track` table find a unique list of all `composer`s.

SELECT DISTINCT composer FROM track

2. From the `invoice` table find a unique list of all `billing_postal_code`s.

SELECT DISTINCT billing_postal_code
FROM invoice

3. From the `customer` table find a unique list of all `company`s.

SELECT DISTINCT company
FROM customer

## Delete Rows

### Summary

Always do a select before a delete to make sure you get back exactly what you want and only what you want to delete! Since we cannot delete anything from the pre-defined tables ( foreign key restraints ), use the following SQL code to create a dummy table:

<details>

<summary> <code> practice_delete TABLE </code> </summary>

```sql
CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);

SELECT * FROM practice_delete;
```

</details>

### Instructions

<details>

<summary> <code> Syntax Hint </code> </summary>

```sql
DELETE FROM [table] WHERE [condition]
```

</details>

<br />

1. Copy, paste, and run the SQL code from the summary.

DONE

2. Delete all `'bronze'` entries from the table.

DELETE FROM practice_delete 
WHERE type = 'bronze'

3. Delete all `'silver'` entries from the table.

DELETE FROM practice_delete 
WHERE type = 'silver'

4. Delete all entries whose value is equal to `150`.

DELETE FROM practice_delete 
WHERE value = 150

## eCommerce Simulation - No Hints **SEE createTable.sql FOR ANSWERS**

### Summary

Let's simulate an e-commerce site. We're going to need users, products, and orders.

* users need a name and an email.
* products need a name and a price
* orders need a ref to product.
* All 3 need primary keys.

### Instructions

* Create 3 tables following the criteria in the summary.

* Add some data to fill up each table.
  * At least 3 users, 3 products, 3 orders.
  
* Run queries against your data.
  * Get all products for the first order.

  * Get all orders.

  * Get the total cost of an order ( sum the price of all products on an order ).
  
* Add a foreign key reference from orders to users.

* Update the orders table to link a user to each order.

* Run queries against your data.
  * Get all orders for a user.

  * Get how many orders each user has.


### Black Diamond

* Get the total amount on all orders for each user.

### Resources

<details>

<summary> <code> SQL </code> </summary>

* [SQL Teaching](http://www.sqlteaching.com)
* [SQL Bolt](http://www.sqlbolt.com)

</details>


## Contributions

If you see a problem or a typo, please fork, make the necessary changes, and create a pull request so we can review your changes and merge them into the master repo and branch.

## Copyright

© DevMountain LLC, 2017. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.

<p align="center">
<img src="https://s3.amazonaws.com/devmountain/readme-logo.png" width="250">
</p>
