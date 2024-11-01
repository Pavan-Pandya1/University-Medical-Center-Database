CREATE TRIGGER update_book_last_modified 
BEFORE UPDATE ON books 
FOR EACH ROW 
SET NEW.last_modified = NOW();


CREATE TRIGGER insert_book_rating 
AFTER INSERT ON books 
FOR EACH ROW 
INSERT INTO ratings (book_id, rating) VALUES (NEW.id, 0);


CREATE TRIGGER delete_book_ratings 
AFTER DELETE ON books 
FOR EACH ROW 
DELETE FROM ratings WHERE book_id = OLD.id;


CREATE TRIGGER prevent_rating_update 
BEFORE UPDATE ON books 
FOR EACH ROW 
BEGIN 
    IF (OLD.title != NEW.title OR OLD.author != NEW.author) AND (SELECT COUNT(*) FROM ratings WHERE book_id = OLD.id) > 0 THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot update title or author for a book that has been rated'; 
    END IF; 
END;
