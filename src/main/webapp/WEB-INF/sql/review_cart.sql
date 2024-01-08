use webtest;
 
drop table review;

use shop;

create table review(
   rnum int not null auto_increment primary key,
   content varchar(500) not null,
   regdate date not null,
   id varchar(10) not null,
   star int not null DEFAULT 0,
   contentsno int not null,
   pname varchar(50) NOT NULL,
   foreign key(contentsno) references contents(contentsno)
   
);

CREATE TABLE `cart` (
  `cartno` int NOT NULL AUTO_INCREMENT primary key,
  `count` int NOT NULL,
  `contentsno` int NOT NULL,
  `id` varchar(10) NOT NULL,
  `size` varchar(3) DEFAULT NULL,
  FOREIGN KEY (`contentsno`) REFERENCES `contents` (`contentsno`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`id`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);