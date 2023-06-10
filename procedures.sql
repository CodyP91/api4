-- Procedure to add a new client
DELIMITER //
CREATE PROCEDURE add_new_client(IN username_input VARCHAR(255), IN password_input TEXT)
BEGIN
    INSERT INTO client (username, password, joined_on) VALUES (username_input, password_input, CURDATE());
    SELECT LAST_INSERT_ID() AS client_id;
END //
DELIMITER ;

-- Procedure to add a new login
DELIMITER //
CREATE PROCEDURE add_new_login(IN username_input VARCHAR(255), IN password_input TEXT, IN token_input VARCHAR(255))
BEGIN
    DECLARE client_id INT;
    SELECT id INTO client_id FROM client WHERE username = username_input AND password = password_input;
    INSERT INTO login (client_id, token) VALUES (client_id, token_input);
END //
DELIMITER ;

-- Procedure to add a new post
DELIMITER //
CREATE PROCEDURE add_new_post(IN token_input VARCHAR(255), IN content_input TEXT)
BEGIN
    DECLARE client_id INT;
    SELECT client_id INTO client_id FROM login WHERE token = token_input;
    INSERT INTO post (client_id, content, created_at) VALUES (client_id, content_input, CURDATE());
    SELECT LAST_INSERT_ID() AS post_id;
END //
DELIMITER ;

-- Procedure to delete a client
DELIMITER //
CREATE PROCEDURE delete_client(IN username_input VARCHAR(255), IN password_input TEXT)
BEGIN
    DELETE FROM client WHERE username = username_input AND password = password_input;
END //
DELIMITER ;

-- Procedure to delete a post
DELIMITER //
CREATE PROCEDURE delete_post(IN token_input VARCHAR(255), IN post_id_input INT)
BEGIN
    DECLARE client_id INT;
    SELECT client_id INTO client_id FROM login WHERE token = token_input;
    DELETE FROM post WHERE client_id = client_id AND id = post_id_input;
END //
DELIMITER ;

-- Procedure to delete a login token
DELIMITER //
CREATE PROCEDURE delete_login(IN token_input VARCHAR(255))
BEGIN
    DELETE FROM login WHERE token = token_input;
END //
DELIMITER ;

-- Procedure to update a post
DELIMITER //
CREATE PROCEDURE update_post(IN token_input VARCHAR(255), IN post_id_input INT, IN content_input TEXT)
BEGIN
    DECLARE client_id INT;
    SELECT client_id INTO client_id FROM login WHERE token = token_input;
    UPDATE post SET content = content_input WHERE client_id = client_id AND id = post_id_input;
END //
DELIMITER ;
