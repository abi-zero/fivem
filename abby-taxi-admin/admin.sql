CREATE TABLE `abby-taxi` (
    `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
    `name` VARCHAR(60) NOT NULL DEFAULT 'Unknown Player' , 
    `fare` INT NOT NULL DEFAULT '0' , 
    `playercut` INT NOT NULL DEFAULT '0' , 
    `businesscut` INT NOT NULL DEFAULT '0' 
) ENGINE = InnoDB; 