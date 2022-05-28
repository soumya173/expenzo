CREATE TABLE `users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `type` int,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255),
  `created_at` timestamp DEFAULT now(),
  `mobile` varchar(255),
  `email` varchar(255),
  `password` varchar(255) NOT NULL,
  `mobile_verified` boolean DEFAULT false,
  `email_verified` boolean DEFAULT false
);

CREATE TABLE `userTypes` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL
);

CREATE TABLE `groups` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT null,
  `type` int,
  `notify_users` boolean DEFAULT false
);

CREATE TABLE `groupTypes` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL
);

CREATE TABLE `groupUserMappings` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `group_id` int,
  `user_id` int
);

CREATE TABLE `transactions` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `created_at` timestamp DEFAULT now(),
  `updated_at` timestamp DEFAULT now(),
  `added_by` int,
  `group_id` int,
  `amount` int DEFAULT 0,
  `description` varchar(255) DEFAULT null,
  `paid_by` int,
  `category_id` int
);

CREATE TABLE `categories` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon_url` varchar(255) DEFAULT null
);

CREATE TABLE `budgets` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `group_id` int,
  `amount` int NOT NULL,
  `created_at` timestamp DEFAULT now(),
  `updated_at` timestamp DEFAULT now(),
  `created_by` int,
  `applicable_from` timestamp DEFAULT now(),
  `applicable_to` timestamp DEFAULT now()
);

CREATE TABLE `budgetCategoryWise` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `budget_id` int,
  `category_id` int,
  `amount` int NOT NULL
);

CREATE TABLE `notifications` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `created_at` timestamp DEFAULT now(),
  `description` varchar(255) NOT NULL,
  `group_id` int
);

CREATE TABLE `notificationReadBy` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `notification_id` int,
  `read_at` timestamp DEFAULT now(),
  `read_by` int
);

ALTER TABLE `users` ADD FOREIGN KEY (`type`) REFERENCES `userTypes` (`id`);

ALTER TABLE `groups` ADD FOREIGN KEY (`type`) REFERENCES `groupTypes` (`id`);

ALTER TABLE `groupUserMappings` ADD FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`);

ALTER TABLE `groupUserMappings` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `transactions` ADD FOREIGN KEY (`added_by`) REFERENCES `users` (`id`);

ALTER TABLE `transactions` ADD FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`);

ALTER TABLE `transactions` ADD FOREIGN KEY (`paid_by`) REFERENCES `users` (`id`);

ALTER TABLE `transactions` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

ALTER TABLE `budgets` ADD FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`);

ALTER TABLE `budgets` ADD FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

ALTER TABLE `budgetCategoryWise` ADD FOREIGN KEY (`budget_id`) REFERENCES `budgets` (`id`);

ALTER TABLE `budgetCategoryWise` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

ALTER TABLE `notifications` ADD FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`);

ALTER TABLE `notificationReadBy` ADD FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`);

ALTER TABLE `notificationReadBy` ADD FOREIGN KEY (`read_by`) REFERENCES `users` (`id`);

-- Create default configurations
INSERT INTO `userTypes` (`name`) VALUES ("ADMIN"), ("USER");
INSERT INTO `groupTypes` (`name`) VALUES ("EXPENSE_TRACKER"), ("BILL_SPLITTER");
INSERT INTO `categories` (`name`) VALUES ("Groceries"), ("Bills"), ("Transportation"), ("Home Maintenance"), ("Medicines"), ("Vegetables"), ("Personal Care"), ("Movies"), ("Eating Out"), ("Clothes/Gadgets"), ("Others"), ("Luxury"), ("Food/Fruits");
INSERT INTO `users` (`type`, `fname`, `lname`, `mobile`, `email`, `password`, `mobile_verified`, `email_verified`) VALUES (1, "Admin", "Admin", "1234567890", "admin@admin.com", "password", true, true), (2, "User", "User", "1234567891", "user@user.com", "password", true, true);