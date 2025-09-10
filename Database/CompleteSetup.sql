-- Complete Portfolio Database Setup Script
-- Run this script in SQL Server Management Studio or Visual Studio

-- Step 1: Create Database (if it doesn't exist)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'PortfolioDatabase')
BEGIN
    CREATE DATABASE PortfolioDatabase;
    PRINT 'Database PortfolioDatabase created successfully.';
END
ELSE
BEGIN
    PRINT 'Database PortfolioDatabase already exists.';
END
GO

-- Step 2: Use the database
USE PortfolioDatabase;
GO

-- Step 3: Create all tables
-- Skills Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Skills]') AND type in (N'U'))
BEGIN
    CREATE TABLE Skills (
        SkillId INT IDENTITY(1,1) PRIMARY KEY,
        SkillName NVARCHAR(100) NOT NULL,
        SkillCategory NVARCHAR(50) NOT NULL,
        ProficiencyLevel INT NOT NULL CHECK (ProficiencyLevel BETWEEN 1 AND 100),
        IconClass NVARCHAR(50) NULL,
        Description NVARCHAR(500) NULL,
        DisplayOrder INT DEFAULT 0,
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'Skills table created successfully.';
END
GO

-- Projects Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Projects]') AND type in (N'U'))
BEGIN
    CREATE TABLE Projects (
        ProjectId INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Description NVARCHAR(MAX) NOT NULL,
        TechStack NVARCHAR(500) NOT NULL,
        GitHubLink NVARCHAR(500) NULL,
        DemoLink NVARCHAR(500) NULL,
        ImagePath NVARCHAR(500) NULL,
        ProjectType NVARCHAR(50) NOT NULL,
        Status NVARCHAR(20) DEFAULT 'Completed',
        DisplayOrder INT DEFAULT 0,
        IsFeatured BIT DEFAULT 0,
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'Projects table created successfully.';
END
GO

-- Achievements Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Achievements]') AND type in (N'U'))
BEGIN
    CREATE TABLE Achievements (
        AchievementId INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Description NVARCHAR(MAX) NOT NULL,
        AchievementDate DATE NOT NULL,
        Organization NVARCHAR(200) NULL,
        Category NVARCHAR(50) NULL,
        ImagePath NVARCHAR(500) NULL,
        VerificationLink NVARCHAR(500) NULL,
        DisplayOrder INT DEFAULT 0,
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'Achievements table created successfully.';
END
GO

-- Education Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Education]') AND type in (N'U'))
BEGIN
    CREATE TABLE Education (
        EducationId INT IDENTITY(1,1) PRIMARY KEY,
        Degree NVARCHAR(200) NOT NULL,
        Institution NVARCHAR(200) NOT NULL,
        StartYear INT NOT NULL,
        EndYear INT NULL,
        Grade NVARCHAR(20) NULL,
        FieldOfStudy NVARCHAR(200) NULL,
        Description NVARCHAR(500) NULL,
        Location NVARCHAR(100) NULL,
        DisplayOrder INT DEFAULT 0,
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'Education table created successfully.';
END
GO

-- Admin Users Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AdminUsers]') AND type in (N'U'))
BEGIN
    CREATE TABLE AdminUsers (
        UserId INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(255) NOT NULL,
        Email NVARCHAR(100) NOT NULL,
        CreatedDate DATETIME DEFAULT GETDATE(),
        LastLoginDate DATETIME NULL
    );
    PRINT 'AdminUsers table created successfully.';
END
GO

-- Contact Messages Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactMessages]') AND type in (N'U'))
BEGIN
    CREATE TABLE ContactMessages (
        MessageId INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(200) NOT NULL,
        Subject NVARCHAR(300) NULL,
        Message NVARCHAR(MAX) NOT NULL,
        IsRead BIT DEFAULT 0,
        ReceivedDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'ContactMessages table created successfully.';
END
GO

-- Step 4: Clear existing data and insert fresh sample data
DELETE FROM Skills;
DELETE FROM Projects;
DELETE FROM Achievements;
DELETE FROM Education;
PRINT 'Existing data cleared.';

-- Insert Skills Data
INSERT INTO Skills (SkillName, SkillCategory, ProficiencyLevel, IconClass, DisplayOrder) VALUES
('Android Development', 'Mobile', 90, 'fab fa-android', 1),
('iOS Development', 'Mobile', 85, 'fab fa-apple', 2),
('React Native', 'Framework', 80, 'fab fa-react', 3),
('ASP.NET', 'Framework', 75, 'fab fa-microsoft', 4),
('Machine Learning', 'Technology', 70, 'fas fa-brain', 5),
('Cloud Services', 'Technology', 75, 'fas fa-cloud', 6),
('Java', 'Programming', 88, 'fab fa-java', 7),
('Kotlin', 'Programming', 85, 'fas fa-code', 8),
('Swift', 'Programming', 82, 'fab fa-swift', 9),
('Python', 'Programming', 75, 'fab fa-python', 10),
('JavaScript', 'Programming', 80, 'fab fa-js-square', 11),
('C#', 'Programming', 70, 'fas fa-code', 12),
('Firebase', 'Database', 85, 'fas fa-database', 13),
('MongoDB', 'Database', 75, 'fas fa-leaf', 14),
('SQL Server', 'Database', 70, 'fas fa-database', 15);
PRINT 'Skills data inserted successfully.';

-- Insert Projects Data
INSERT INTO Projects (Title, Description, TechStack, GitHubLink, DemoLink, ProjectType, Status, IsFeatured, DisplayOrder) VALUES
('Portfolio Mobile App', 'A cross-platform mobile application showcasing my portfolio with interactive features, smooth animations, and real-time data synchronization.', 'React Native,Firebase,Redux,TypeScript', 'https://github.com/redphoenix-05/Ariyan-ASP-Portfolio', '#', 'Mobile', 'Completed', 1, 1),
('E-Commerce Mobile App', 'Full-featured shopping application with payment integration, user authentication, order tracking, and comprehensive admin panel.', 'Flutter,Node.js,MongoDB,Stripe API', '#', '#', 'Mobile', 'Completed', 1, 2),
('ML-Powered Analytics', 'Machine learning application for data analysis and predictive modeling with real-time insights and visualization.', 'Python,TensorFlow,Flask,React', '#', '#', 'ML', 'In Progress', 1, 3),
('Weather Forecast App', 'Native Android application providing detailed weather forecasts with beautiful UI and location-based services.', 'Java,Android SDK,Weather API,Material Design', '#', '#', 'Mobile', 'Completed', 0, 4),
('Real-time Chat App', 'Real-time messaging application with group chats, file sharing, and user presence indicators.', 'React.js,Socket.io,Node.js,MongoDB', '#', '#', 'Web', 'Completed', 0, 5),
('Personal Finance Tracker', 'Mobile app for tracking personal expenses and income with detailed analytics and budget planning features.', 'Flutter,SQLite,Charts Library,Provider', '#', '#', 'Mobile', 'Completed', 0, 6),
('Recipe Sharing App', 'Social platform for sharing and discovering recipes with photo upload, rating system, and meal planning features.', 'React Native,Firebase,Redux,Image Picker', '#', '#', 'Mobile', 'In Progress', 0, 7),
('Learning Management System', 'Web-based LMS with course management, student enrollment, quiz system, and progress tracking capabilities.', 'ASP.NET MVC,Entity Framework,SQL Server,jQuery', '#', '#', 'Web', 'Completed', 0, 8);
PRINT 'Projects data inserted successfully.';

-- Insert Achievements Data
INSERT INTO Achievements (Title, Description, AchievementDate, Organization, Category, DisplayOrder) VALUES
('Best Mobile App Developer', 'Awarded for outstanding performance in mobile application development during university project showcase.', '2023-12-15', 'University Tech Fest', 'Academic', 1),
('Hackathon Winner', 'First place in 48-hour hackathon for developing innovative healthcare mobile application.', '2023-10-20', 'TechCrunch Hackathon', 'Competition', 2),
('Dean''s List Scholar', 'Achieved Dean''s List recognition for maintaining excellent academic performance with GPA above 3.8.', '2023-06-30', 'University', 'Academic', 3),
('Open Source Contributor', 'Contributed to multiple open source projects with over 500+ commits and 50+ pull requests merged.', '2023-08-15', 'GitHub Community', 'Professional', 4),
('Google Developer Challenge', 'Selected among top 100 developers in Google''s Android Development Challenge out of 10,000+ participants.', '2023-03-10', 'Google', 'Competition', 5);
PRINT 'Achievements data inserted successfully.';

-- Insert Education Data
INSERT INTO Education (Degree, Institution, StartYear, EndYear, Grade, FieldOfStudy, Location, DisplayOrder) VALUES
('Bachelor of Science in Computer Science & Engineering', 'Khulna University of Engineering & Technology', 2023, 2027, '3.85 GPA', 'Computer Science & Engineering', 'Dhaka, Bangladesh', 1),
('Higher Secondary Certificate (HSC)', 'Science College', 2019, 2021, '5.00 GPA', 'Science', 'Dhaka, Bangladesh', 2),
('Secondary School Certificate (SSC)', 'High School', 2009, 2019, '5.00 GPA', 'Science', 'Dhaka, Bangladesh', 3);
PRINT 'Education data inserted successfully.';

-- Insert default admin user if not exists
IF NOT EXISTS (SELECT * FROM AdminUsers WHERE Username = 'admin')
BEGIN
    INSERT INTO AdminUsers (Username, PasswordHash, Email) 
    VALUES ('admin', 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=', 'admin@portfolio.com');
    PRINT 'Default admin user created successfully.';
    PRINT 'Login credentials: Username: admin, Password: 2107045';
END
ELSE
BEGIN
    PRINT 'Admin user already exists.';
END
GO

-- Step 5: Verify data insertion
PRINT 'Database setup verification:';
PRINT 'Skills count: ' + CAST((SELECT COUNT(*) FROM Skills) AS VARCHAR(10));
PRINT 'Projects count: ' + CAST((SELECT COUNT(*) FROM Projects) AS VARCHAR(10));
PRINT 'Achievements count: ' + CAST((SELECT COUNT(*) FROM Achievements) AS VARCHAR(10));
PRINT 'Education count: ' + CAST((SELECT COUNT(*) FROM Education) AS VARCHAR(10));
PRINT 'Admin users count: ' + CAST((SELECT COUNT(*) FROM AdminUsers) AS VARCHAR(10));

PRINT 'Portfolio database setup completed successfully!';
PRINT 'You can now run your ASP.NET application and see dynamic content from the database.';
GO