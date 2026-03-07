/* CREATE  a new table called persons with column: id, persons_name, birth_date, and phone*/
CREATE TABLE person(
id INT NOT NULL,
persons_name VARCHAR(50) NOT NULL,
birth_date DATE,
phone VARCHAR(15) NOT NULL,
email VARCHAR(50) NOT NULL,
CONSTRAINT pk_person PRIMARY KEY(id)
)





