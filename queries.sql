-- 1. Location of User 
SELECT * FROM post
WHERE location IN ('agra' ,'adyar','adari');


-- 2. Most Followed Hashtag
SELECT hashtag_name AS 'Hashtags', COUNT(hashtag_follow.hashtag_id) AS 'Total Follows' 
FROM hashtag_follow, hashtags 
WHERE hashtags.hashtag_id = hashtag_follow.hashtag_id
GROUP BY hashtag_follow.hashtag_id
ORDER BY COUNT(hashtag_follow.hashtag_id) DESC LIMIT 5;

-- 3. Most Used Hashtags
SELECT 
	hashtag_name AS 'Trending Hashtags', 
    COUNT(post_tags.hashtag_id) AS 'Times Used'
FROM hashtags,post_tags
WHERE hashtags.hashtag_id = post_tags.hashtag_id
GROUP BY post_tags.hashtag_id
ORDER BY COUNT(post_tags.hashtag_id) DESC LIMIT 10;


-- 4. Most Inactive User
SELECT user_id, username AS 'Most Inactive User'
FROM users
WHERE user_id NOT IN (SELECT user_id FROM post);

 
-- 5. Most Likes Posts
SELECT post_likes.user_id, post_likes.post_id, COUNT(post_likes.post_id) 
FROM post_likes, post
WHERE post.post_id = post_likes.post_id 
GROUP BY post_likes.post_id
ORDER BY COUNT(post_likes.post_id) DESC ;

-- 6. Average post per user
SELECT ROUND((COUNT(post_id) / COUNT(DISTINCT user_id) ),2) AS 'Average Post per User' 
FROM post;

-- 7. no. of login by per user
SELECT user_id, email, username, login.login_id AS login_number
FROM users 
NATURAL JOIN login;


-- 8. User who liked every single post (CHECK FOR BOT)
SELECT username, Count(*) AS num_likes 
FROM users 
INNER JOIN post_likes ON users.user_id = post_likes.user_id 
GROUP  BY post_likes.user_id 
HAVING num_likes = (SELECT Count(*) FROM   post); 

-- 9. User Never Comment 
SELECT user_id, username AS 'User Never Comment'
FROM users
WHERE user_id NOT IN (SELECT user_id FROM comments);

-- 10. User who commented on every post (CHECK FOR BOT)
SELECT username, Count(*) AS num_comment 
FROM users 
INNER JOIN comments ON users.user_id = comments.user_id 
GROUP  BY comments.user_id 
HAVING num_comment = (SELECT Count(*) FROM comments); 


-- 11. User Not Followed by anyone
SELECT user_id, username AS 'User Not Followed by anyone'
FROM users
WHERE user_id NOT IN (SELECT followee_id FROM follows);

-- 12. User Not Following Anyone
SELECT user_id, username AS 'User Not Following Anyone'
FROM users
WHERE user_id NOT IN (SELECT follower_id FROM follows);

-- 13. Posted ATLEAST ONCE
SELECT user_id, COUNT(user_id) AS post_count FROM post
GROUP BY user_id
HAVING post_count > 0
ORDER BY COUNT(user_id) DESC;


-- 14. Followers > 10
CREATE OR REPLACE VIEW GRREATER_10 AS 
SELECT followee_id, COUNT(follower_id) AS follower_count FROM follows
GROUP BY followee_id
HAVING follower_count > 1
ORDER BY COUNT(follower_id) DESC;

#DROP VIEW GRREATER_10; 
SELECT * FROM GRREATER_10;

-- 15. Any specific word in comment
SELECT * FROM comments
WHERE comment_text REGEXP'love';


-- 16. Longest captions in post
SELECT user_id, caption, LENGTH(post.caption) AS caption_length FROM post
ORDER BY caption_length DESC LIMIT 5;

-- 17. user engagement analysis
SELECT u.user_id, u.username,
       COUNT(DISTINCT p.post_id) AS posts_created,
       COUNT(DISTINCT c.comment_id) AS comments_made
FROM users u
LEFT JOIN post p ON u.user_id = p.user_id
LEFT JOIN comments c ON u.user_id = c.user_id
LEFT JOIN post_likes l ON u.user_id = l.user_id
GROUP BY u.user_id, u.username
ORDER BY (posts_created + comments_made ) DESC;


-- 18. content analysis based on location 
SELECT p.location,
       COUNT(*) AS total_posts,
       AVG(LENGTH(p.caption)) AS avg_caption_length,
       COUNT(DISTINCT ht.hashtag_id) AS total_hashtags_used
FROM post p
LEFT JOIN post_tags pt ON p.post_id = pt.post_id
LEFT JOIN hashtags ht ON pt.hashtag_id = ht.hashtag_id
GROUP BY p.location
ORDER BY total_posts DESC;

-- 19. identify influential users 
WITH follower_counts AS (
  SELECT follower_id, COUNT(*) AS follower_count
  FROM follows
  GROUP BY follower_id
),
user_engagement AS (
  SELECT u.user_id,
         COUNT(DISTINCT p.post_id) AS posts_created,
         COUNT(DISTINCT c.comment_id) AS comments_made
  FROM users u
  LEFT JOIN post p ON u.user_id = p.user_id
  LEFT JOIN comments c ON u.user_id = c.user_id
  LEFT JOIN post_likes l ON u.user_id = l.user_id
  GROUP BY u.user_id
)
SELECT ue.user_id,  fc.follower_count, #users.useranme,
       (ue.posts_created + ue.comments_made ) AS total_engagement
FROM user_engagement ue
INNER JOIN follower_counts fc ON ue.user_id = fc.follower_id
ORDER BY total_engagement DESC, fc.follower_count DESC
LIMIT 10;

-- 20. Analyze popular post by time  
SELECT DATE(p.created_at) AS post_date,
       COUNT(*) AS posts_created,
       AVG(LENGTH(p.caption)) AS avg_caption_length
FROM post p
LEFT JOIN post_likes l ON p.post_id = l.post_id
GROUP BY DATE(p.created_at)
ORDER BY post_date DESC
LIMIT 7;

-- 21. Identify trending topics based on commments 
WITH comment_words AS (
  SELECT comment_id,
         SUBSTRING_INDEX(comment_text, ' ', 3) AS first_three_words
  FROM comments
)
SELECT cw.first_three_words, COUNT(*) AS mentions
FROM comment_words cw
GROUP BY cw.first_three_words
ORDER BY mentions DESC
LIMIT 10;

-- 22. 
SELECT u.username, COUNT(f.follower_id) AS followers, 
  SUM(p.likes + p.comments + p.shares) / COUNT(p.post_id) AS avg_engagement
FROM users u
LEFT JOIN followers f ON u.user_id = f.follower_id
LEFT JOIN post p ON u.user_id = p.user_id
GROUP BY u.username
ORDER BY (followers * avg_engagement) DESC;

-- 23.Analyze the most frequent locations used in posts
SELECT location, COUNT(*) AS post_count
FROM post
WHERE location IS NOT NULL
GROUP BY location
ORDER BY post_count DESC
LIMIT 10;

-- 24.  User Engagement by Time
SELECT DATE(created_at) AS post_date, COUNT(*) AS post_count
FROM post
GROUP BY DATE(created_at)
ORDER BY post_date;

