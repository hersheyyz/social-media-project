DROP database social_media;
CREATE DATABASE social_media;
USE social_media;

CREATE TABLE users (
    user_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    profile_photo_url VARCHAR(255) DEFAULT 'https://picsum.photos/100',
    bio VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE users
ADD email VARCHAR(30) NOT NULL;

CREATE TABLE photos (
    photo_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    photo_url VARCHAR(255) NOT NULL UNIQUE,
    post_id	INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    size FLOAT CHECK (size<5)
);

CREATE TABLE videos (
  video_id INTEGER AUTO_INCREMENT PRIMARY KEY,
  video_url VARCHAR(255) NOT NULL UNIQUE,
  post_id INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  size FLOAT CHECK (size<10)  
);

CREATE TABLE post (
    post_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    photo_id INTEGER,
    video_id INTEGER,
    user_id INTEGER NOT NULL,
    caption VARCHAR(200), 
    location VARCHAR(50) ,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(photo_id) REFERENCES photos(photo_id),
    FOREIGN KEY(video_id) REFERENCES videos(video_id)
);

CREATE TABLE comments (
    comment_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(post_id) REFERENCES post(post_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);

CREATE TABLE post_likes (
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(post_id) REFERENCES post(post_id),
    PRIMARY KEY(user_id, post_id)
);

CREATE TABLE comment_likes (
    user_id INTEGER NOT NULL,
    comment_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(comment_id) REFERENCES comments(comment_id),
    PRIMARY KEY(user_id, comment_id)
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(user_id),
    FOREIGN KEY(followee_id) REFERENCES users(user_id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE hashtags (
  hashtag_id INTEGER AUTO_INCREMENT PRIMARY KEY,
  hashtag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE hashtag_follow (
	user_id INTEGER NOT NULL,
    hashtag_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(hashtag_id) REFERENCES hashtags(hashtag_id),
    PRIMARY KEY(user_id, hashtag_id)
);

CREATE TABLE post_tags (
    post_id INTEGER NOT NULL,
    hashtag_id INTEGER NOT NULL,
    FOREIGN KEY(post_id) REFERENCES post(post_id),
    FOREIGN KEY(hashtag_id) REFERENCES hashtags(hashtag_id),
    PRIMARY KEY(post_id, hashtag_id)
);

CREATE TABLE bookmarks (
  post_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(post_id) REFERENCES post(post_id),
  FOREIGN KEY(user_id) REFERENCES users(user_id),
  PRIMARY KEY(user_id, post_id)
);

CREATE TABLE login (
  login_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  ip VARCHAR(50) NOT NULL,
  login_time TIMESTAMP NOT NULL DEFAULT NOW(),
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);

# QUERIES FOR INSERTION IN DATABASE 
INSERT INTO users(username, profile_photo_url, bio,email) VALUES 
("kanavphull","https://pbs.twimg.com/profile_images/1386885117428191232/70SyHOxP_400x400.jpg","Hedonist yet Spiritual || IT at NITJ 2024",'as1mobiles@gmail.com'),
('raj gupta' , '/klsadf893724:f//432' , 'soon to be updated','admin@1shopbuy.com'),
('Sahib Singh' , 'https://pbs.twimg.com/profile_images/1465003815820693506/gbTJoe66_400x400.jpg' ,"Life is a journey, It drives you MAD.|| IT NITJ'24",'12angeldesignworld@gmail.com');

INSERT INTO users(username, profile_photo_url, bio,email) VALUES 
('Sakshi Warandani' , "https://vader.news/__export/1612817390103/sites/gadgets/img/2021/02/08/ian_somerhalder_vampires.jpg_246448593.jpg" , "NITJ wish me on 23 jan",'deepak@24sevenindia.com'),
("Omnicron Larson", "/sdfvsdf", "Heart Stealer",'101cartinfo@gmail.com'),
("dettol sharma", "/sdfvsdf", "Dettol Stealer",'the.yellow.gold@gmail.com'),
('sunil' , '/yisadf324//' , 'hotel manageemnt ','deepak@24sevenindia.com'),
('sanjay' , '/fduiahj43' , 'football lover','deepak@24sevenindia.com' ),
('Axel Sivert Anker' , '/adaskjnas','Norwegian','gazender.686@gmail.com'),
('Steven','/acdsccsdc', 'living life my way','sravi07@yahoo.com'),
('Jack','https://picsum.photos/100','𝐖𝐞𝐥𝐜𝐨𝐦𝐞 𝐓𝐨 𝐌𝐲 𝐏𝐫𝐨𝐟𝐢𝐥𝐞','contact@21fools.com'),
('Oliver','https://picsum.photos/101','𝐎𝐟𝐟𝐢𝐜𝐢𝐚𝐥 𝐀𝐜𝐜𝐨𝐮𝐧𝐭','the.yellow.gold@gmail.com'),
('James','https://picsum.photos/102','𝐖𝐢𝐬𝐡 𝐌𝐞 𝐎𝐧 𝟑 𝐎𝐜𝐭𝐨𝐛𝐞𝐫','contact@21fools.com'),
('Charlie','https://picsum.photos/103','aap yha aae kisliye','sravi07@yahoo.com'),
('Harris','https://picsum.photos/104','𝐒𝐚𝐧𝐬𝐤𝐚𝐫𝐢 𝐋𝐚𝐝𝐤𝐚','pawan.modi1@gmail.com'),
('Lewis','https://picsum.photos/105','aapne bulaya isilye','as1mobiles@gmail.com'),
('Leo','https://picsum.photos/106','𝐆𝐲𝐦 𝐋ø𝐯è𝐫','pawan.modi1@gmail.com'),
('Noah','https://picsum.photos/107','aae hai toh kaam bi btiye','sunglasses.24@gmail.com'),
('Alfie','https://picsum.photos/108','𝐒𝐢𝐧𝐠𝐥𝐞','deepak@24sevenindia.com'),
('Rory','https://picsum.photos/109','phle zara aap muskurae','pawan.modi1@gmail.com'),
('Alexander','https://picsum.photos/110','𝐑𝐞𝐬𝐩𝐞𝐜𝐭 𝐅𝐨𝐫 𝐀𝐥𝐥','umesh.agarwal@24x7safebuy.com');


-- follows Database

INSERT INTO follows(follower_id, followee_id) VALUES (1, 1);
INSERT INTO follows(follower_id, followee_id) VALUES (2, 2);
INSERT INTO follows(follower_id, followee_id) VALUES (3, 9);
INSERT INTO follows(follower_id, followee_id) VALUES (4, 4);
INSERT INTO follows(follower_id, followee_id) VALUES (5, 19);
INSERT INTO follows(follower_id, followee_id) VALUES (6, 16);
INSERT INTO follows(follower_id, followee_id) VALUES (7, 12);
INSERT INTO follows(follower_id, followee_id) VALUES (8, 8);
INSERT INTO follows(follower_id, followee_id) VALUES (9, 9);
INSERT INTO follows(follower_id, followee_id) VALUES (10 , 10);
INSERT INTO follows(follower_id, followee_id) VALUES (11, 11);
INSERT INTO follows(follower_id, followee_id) VALUES (12, 15);
INSERT INTO follows(follower_id, followee_id) VALUES (13, 9);
INSERT INTO follows(follower_id, followee_id) VALUES (14, 14);
INSERT INTO follows(follower_id, followee_id) VALUES (15, 17);
INSERT INTO follows(follower_id, followee_id) VALUES (16, 16);
INSERT INTO follows(follower_id, followee_id) VALUES (17, 3);
INSERT INTO follows(follower_id, followee_id) VALUES (18, 18);
INSERT INTO follows(follower_id, followee_id) VALUES (19, 1);
INSERT INTO follows(follower_id, followee_id) VALUES (20, 20);
INSERT INTO follows(follower_id, followee_id) VALUES (21, 21);

-- HASHTAGS DATABASE 

INSERT INTO HASHTAGS(hashtag_name) VALUES (' #joinbtsarmy');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #kisaansupport');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #fitnessfreak');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #runforunity');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #studentlivesmatter');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #cancellJEEiit');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #REOPEN colleges');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #party');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #followme');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #christmas');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #socialmedia');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #family');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #festivesale');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #sunnyday');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #enjoy');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #weekendmasti');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #love');
INSERT INTO HASHTAGS(hashtag_name) VALUES ('  #instagood');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #photooftheday');
INSERT INTO HASHTAGS(hashtag_name) VALUES ('  #beautiful');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #fashion');
INSERT INTO HASHTAGS(hashtag_name) VALUES ('  #tbt');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #happy');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #cute');
INSERT INTO HASHTAGS(hashtag_name) VALUES ('  #followme');
INSERT INTO HASHTAGS(hashtag_name) VALUES ('  #like4like');
INSERT INTO HASHTAGS(hashtag_name) VALUES ('  #follow');
INSERT INTO HASHTAGS(hashtag_name) VALUES ('  #me');
INSERT INTO HASHTAGS(hashtag_name) VALUES ('  #picoftheday');
INSERT INTO HASHTAGS(hashtag_name) VALUES (' #selfie');
INSERT INTO HASHTAGS(hashtag_name) VALUES ('#GOGREEN ');


-- photo Database


INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/100', 26, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/101', 27, 1);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/102', 28, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/103', 29, 1);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/104', 30, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/105', 31, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/106', 32, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/107', 33, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/108', 34, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/109', 35, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/110', 36, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/111', 37, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/112', 38, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/113', 39, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/114', 40, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/115', 41, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/116', 42, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/117', 43, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/118', 44, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/119', 45, 1);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/120', 46, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/121', 47, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/122', 48, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/123', 49, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/124', 50, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/125', 76, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/126', 77, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/127', 78, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/128', 79, 1);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/129', 80, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/130', 81, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/131', 82, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/132', 83, 1);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/133', 84, 1);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/134', 85, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/135', 86, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/136', 87, 1);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/137', 88, 4);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/138', 89, 1);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/139', 90, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/140', 91, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/141', 92, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/142', 93, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/143', 94, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/144', 95, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/145', 96, 1);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/146', 97, 2);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/147', 98, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/148', 99, 3);
INSERT INTO photos(photo_url, post_id, size) VALUE ('https://picsum.photos/149', 100, 2);



-- video Database


INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=1TKJvWbZErY', 1, 1);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=dcgeBa78WE8', 2, 8);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=vOfgVs6blGU', 3, 3);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=gDGbwhoWRBQ', 4, 2);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=UAj7FB-BFGg', 5, 1);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=RzppsLjuSaI', 6, 3);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=E1GLuxJ9mkU', 7, 3);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=tjrFQQjTI6c', 8, 2);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=IwNSd7m2HRg', 9, 7);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=4javFbk9Kn8', 10, 9);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=BuX7TQc4a0E', 11, 4);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=4xx0YqaFalo', 12, 7);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=n3LCQiuQn9o', 13, 2);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=x9bmo0aPd0s', 14, 1);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=UkTWeGJewTQ', 15, 1);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=6GwUPaJh2Jg', 16, 9);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=odHuMbTWIvU', 17, 4);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=XxvEchaofrs', 18, 8);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=3ZvSg5aU23E', 19, 6);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=yBJM2RbLefA', 20, 5);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=q6wb-EWR_lM', 21, 6);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=PcCDzONDVsA', 22, 1);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=2ne9HcY53AY', 23, 8);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=OJeynsIPj9I', 24, 9);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=kRGjTgObzX0', 25, 4);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=btWZo8gUv-o', 51, 3);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=7j338SJZjoM', 52, 4);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=fidBadXy1dw', 53, 5);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=1iem1pT2MkQ', 54, 7);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=4N0ew6JMlss', 55, 4);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=GXCdTSGNcOc', 56, 6);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=JFoJCMXzLLw', 57, 4);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=V-egEzLjnhc', 58, 5);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=6B5UK2GC3gY', 59, 2);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=MVRRN6TABcs', 60, 2);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=1ABkmrZxQkQ', 61, 5);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=cUz49dk86m8', 62, 9);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=36BiplVD_Ng', 63, 7);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=EoGYHDqbabw', 64, 9);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=i1CmuuabIok', 65, 5);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=gurapeu6PBk', 66, 9);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=coHgDPBMLKg', 67, 7);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=racdVMrEghs', 68, 6);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=FKtbZtI0VJ0', 69, 9);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=bWqt7op1VpI', 70, 2);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=V_wXW4J73os', 71, 7);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=sHg9e9a_cYM', 72, 8);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=oaJJvO8Tte8', 73, 1);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=ancKcoTvdYY', 74, 3);
INSERT INTO videos(video_url, post_id, size) VALUE ('https://www.youtube.com/watch?v=n6kEYFPvtBY', 75, 8);


-- post_database


insert into post (post_id,photo_id,video_id,user_id,caption,location) values
(1,15,3,1,'HEY!!','VHA JHA KOI AATA JAATA NI'),
(2,21,47,2,'Live a good story.','The Red Fort, Delhi.'),
(3,45,6,3,'Escape the ordinary.','The Taj Mahal, Agra.'),
(4,7,37,4,'The best is yet to come.','Pangong Lake, Ladakh.'),
(5,4,22,5,'These are days we live for.','Valley of Flowers, Nainital.'),
(6,37,18,6,'Life happens, coffee helps.','Jaisalmer Fort, Jaisalmer.'),
(7,11,12,7,'Short sassy cute & classy.','Ruins of Hampi, Karnataka.'),
(8,50,30,8,'The future is bright.','Ghats at Varanasi, Uttar Pradesh.'),
(9,15,31,9,'Namastay in bed.','Backwaters, Kerala.'),
(10,10,44,10,'I have more issues than vogue.','abhayapuri'),
(11,8,32,11,'Life is short. Smile while you still have teeth.','achabbal'),
(12,9,25,12,'Ah, a perfectly captured selfie!','achalpur'),
(13,4,13,13,'Let’s just be who we are.','achhnera'),
(14,36,12,14,'One bad chapter doesn’t me','adari'),
(15,45,40,15,'Cinderella never asked for a prince.','adalaj'),
(16,39,17,16,'A selfie is worth a thousand words.','adilabad'),
(17,7,31,17,'Born to stand out with selfies.','adityana'),
(18,17,27,18,'I’m sorry I exist, here, a selfie.','pereyaapatna'),
(19,49,48,19,'….','adoni'),
(20,44,30,20,'dfgfsggf','adoor'),
(21,18,8,21,'4545','adyar');


-- post_tag Database

INSERT INTO post_tags(post_id, hashtag_id) VALUE (1, 13);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (2, 27);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (3, 20);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (4, 22);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (5, 22);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (6, 3);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (7, 14);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (8, 11);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (9, 1);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (10, 24);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (11, 7);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (12, 11);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (13, 8);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (14, 20);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (15, 28);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (16, 20);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (17, 5);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (18, 24);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (19, 4);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (20, 22);
INSERT INTO post_tags(post_id, hashtag_id) VALUE (21, 22);

-- post_likes

INSERT INTO POST_LIKES(user_id,post_id) VALUES (1,1);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (2,2);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (3,3);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (4,4);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (5,5);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (6,6);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (7,7);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (8,8);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (9,9);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (10,10);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (11,11);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (12,12);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (13,13);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (14,14);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (15,15);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (16,16);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (17,17);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (18,18);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (19,19);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (20,20);
INSERT INTO POST_LIKES(user_id,post_id) VALUES (21,21);

#bookmarks

INSERT INTO bookmarks(post_id, user_id) VALUE (1, 1);
INSERT INTO bookmarks(post_id, user_id) VALUE (2, 2);
INSERT INTO bookmarks(post_id, user_id) VALUE (3, 3);
INSERT INTO bookmarks(post_id, user_id) VALUE (4, 4);
INSERT INTO bookmarks(post_id, user_id) VALUE (5, 5);
INSERT INTO bookmarks(post_id, user_id) VALUE (6, 6);
INSERT INTO bookmarks(post_id, user_id) VALUE (7, 7);
INSERT INTO bookmarks(post_id, user_id) VALUE (8, 8);
INSERT INTO bookmarks(post_id, user_id) VALUE (9, 9);
INSERT INTO bookmarks(post_id, user_id) VALUE (10, 10);
INSERT INTO bookmarks(post_id, user_id) VALUE (11, 11);
INSERT INTO bookmarks(post_id, user_id) VALUE (12, 12);
INSERT INTO bookmarks(post_id, user_id) VALUE (13, 13);
INSERT INTO bookmarks(post_id, user_id) VALUE (14, 14);
INSERT INTO bookmarks(post_id, user_id) VALUE (15, 15);
INSERT INTO bookmarks(post_id, user_id) VALUE (16, 16);
INSERT INTO bookmarks(post_id, user_id) VALUE (18, 17);
INSERT INTO bookmarks(post_id, user_id) VALUE (19, 19);
INSERT INTO bookmarks(post_id, user_id) VALUE (20, 20);
INSERT INTO bookmarks(post_id, user_id) VALUE (21, 21);


-- comment Database


INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',1,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',2,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',3,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',4,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',5,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',6,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',7,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',8,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',9,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',10,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',11,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',12,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',13,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',14,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',15,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',16,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',17,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',18,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',19,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',20,1);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great man',21,1);


INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('looking greate bhai',2,2);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('nice place keep enjoying',3,3);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('great bhai meetu soon ',4,4);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('aag lga di bhai',5,5);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('briallant keep working',6,6);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('soon will join you all',7,7);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('nice man !! loved it',8,8);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('bawnadar aayega abb ',9,9);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('boht tezz ho rhe ho ',10,10);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('bade acche ho beta',11,11);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('rakh neeche rakh teri toh',12,12);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('kaise ho bro',13,13);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('aag lga di h bss fire extinguisher bulana pdega',14,14);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('ek kahani h jo sabko sunnani h jakne wako ki toh rooh bhi jaalani h',15,15);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('mast h bhai , mill tabb btata hu kon mast h ',16,16);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('sahi lgg rha h bss ',17,17);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('I think this is the best I’ve seen till now.',18,18);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES (' Not enough for me, you are everything.',19,19);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES (' Just when I couldn’t love you more. You posted this pic and my jaw dropped to the floor.',20,20);
INSERT INTO COMMENTS(comment_text ,post_id,user_id) VALUES ('You are a symbol of beauty.',21,21);

-- comment likes database 

INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(1 , 1);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(2 , 2);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(3 , 3);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(4 , 4);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(5 , 5);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(6 , 6);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(7 , 7);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(8 , 8);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(9 , 9);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(10 , 10);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(11 , 11);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(12 , 12);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(13 , 13);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(14 , 14);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(15 , 15);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(16 , 16);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(17 , 17);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(18 , 18);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(19 , 19);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(20 , 20);
INSERT INTO COMMENT_LIKES(user_id,comment_id) VALUES(21 , 21);

delete  from comment_likes where user_id = 16;
-- hashtag_follow

insert into hashtag_follow (user_id,hashtag_id) values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20),
(21,21);


-- LOGIN TABLE DATABASE

INSERT INTO LOGIN(user_id , ip) VALUES (1,'186.83.147.14');
INSERT INTO LOGIN(user_id , ip) VALUES (2,'95.43.246.66');
INSERT INTO LOGIN(user_id , ip) VALUES (3,'105.238.37.204');
INSERT INTO LOGIN(user_id , ip) VALUES (4,'13.120.97.136');
INSERT INTO LOGIN(user_id , ip) VALUES (5,'0.83.214.172');
INSERT INTO LOGIN(user_id , ip) VALUES (6,'20.182.93.222');
INSERT INTO LOGIN(user_id , ip) VALUES (7,'200.237.53.32');
INSERT INTO LOGIN(user_id , ip) VALUES (8,'41.81.231.81');
INSERT INTO LOGIN(user_id , ip) VALUES (9,'24.223.2.33');
INSERT INTO LOGIN(user_id , ip) VALUES (10,'8.168.37.68');
INSERT INTO LOGIN(user_id , ip) VALUES (11,'129.91.145.75');
INSERT INTO LOGIN(user_id , ip) VALUES (12,'8.65.175.204');
INSERT INTO LOGIN(user_id , ip) VALUES (13,'242.220.82.190');
INSERT INTO LOGIN(user_id , ip) VALUES (14,'107.137.170.154');
INSERT INTO LOGIN(user_id , ip) VALUES (15,'206.40.219.225');
INSERT INTO LOGIN(user_id , ip) VALUES (16,'136.186.80.29');
INSERT INTO LOGIN(user_id , ip) VALUES (17,'234.153.100.73');
INSERT INTO LOGIN(user_id , ip) VALUES (18,'137.168.133.16');
INSERT INTO LOGIN(user_id , ip) VALUES (19,'248.119.108.48');
INSERT INTO LOGIN(user_id , ip) VALUES (20,'92.178.211.66');
INSERT INTO LOGIN(user_id , ip) VALUES (21,'25.177.94.84');



select * from comments;
 
delete from follows where follower_id = 1;
delete from comments where user_id = 20;