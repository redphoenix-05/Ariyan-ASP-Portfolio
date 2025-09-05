-- Quick Database Setup for Portfolio
-- This can be run in SQL Server Management Studio or Visual Studio SQL Server Object Explorer

-- Simple version for local development
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PortfolioDatabase')
BEGIN
    CREATE DATABASE PortfolioDatabase;
END
GO

USE PortfolioDatabase;
GO

-- Check if tables exist before creating
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AdminUsers' AND xtype='U')
BEGIN
    CREATE TABLE AdminUsers (
        UserId INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(255) NOT NULL,
        Email NVARCHAR(100) NOT NULL,
        CreatedDate DATETIME DEFAULT GETDATE(),
        LastLoginDate DATETIME NULL
    );
    
    -- Insert default admin user (password: Admin@123 - will be hashed when first used)
    INSERT INTO AdminUsers (Username, PasswordHash, Email) 
    VALUES ('admin', 'Admin@123', 'admin@portfolio.com');
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='PortfolioInfo' AND xtype='U')
BEGIN
    CREATE TABLE PortfolioInfo (
        InfoId INT IDENTITY(1,1) PRIMARY KEY,
        FullName NVARCHAR(200) NOT NULL,
        Tagline NVARCHAR(300) NOT NULL,
        AboutDescription NVARCHAR(MAX) NOT NULL,
        ProfileImagePath NVARCHAR(500) NULL,
        Email NVARCHAR(200) NULL,
        PhoneNumber NVARCHAR(20) NULL,
        Address NVARCHAR(300) NULL,
        LinkedInProfile NVARCHAR(300) NULL,
        GitHubProfile NVARCHAR(300) NULL,
        TwitterProfile NVARCHAR(300) NULL,
        FacebookProfile NVARCHAR(300) NULL,
        ModifiedDate DATETIME DEFAULT GETDATE()
    );
    
    -- Insert sample portfolio info
    INSERT INTO PortfolioInfo (FullName, Tagline, AboutDescription, Email, GitHubProfile)
    VALUES (
        'Ariyan Rahman', 
        'Full Stack Developer | ASP.NET Specialist',
        'I am a passionate software developer with expertise in ASP.NET Web Forms, C#, SQL Server, and modern web technologies. I love creating efficient, scalable applications that solve real-world problems.',
        'ariyan.rahman@example.com',
        'https://github.com/redphoenix-05/Ariyan-ASP-Portfolio'
    );
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Skills' AND xtype='U')
BEGIN
    CREATE TABLE Skills (
        SkillId INT IDENTITY(1,1) PRIMARY KEY,
        SkillName NVARCHAR(100) NOT NULL,
        SkillType NVARCHAR(50) NOT NULL,
        ProficiencyLevel INT NOT NULL CHECK (ProficiencyLevel BETWEEN 1 AND 100),
        IconClass NVARCHAR(50) NULL,
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    
    -- Insert sample skills
    INSERT INTO Skills (SkillName, SkillType, ProficiencyLevel, IconClass) VALUES
    ('C#', 'Technical', 90, 'fab fa-microsoft'),
    ('ASP.NET Web Forms', 'Technical', 85, 'fas fa-code'),
    ('SQL Server', 'Technical', 80, 'fas fa-database'),
    ('JavaScript', 'Technical', 75, 'fab fa-js-square'),
    ('HTML/CSS', 'Technical', 85, 'fab fa-html5'),
    ('Bootstrap', 'Technical', 80, 'fab fa-bootstrap');
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Projects' AND xtype='U')
BEGIN
    CREATE TABLE Projects (
        ProjectId INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Description NVARCHAR(MAX) NOT NULL,
        TechStack NVARCHAR(500) NOT NULL,
        GitHubLink NVARCHAR(500) NULL,
        DemoLink NVARCHAR(500) NULL,
        ImagePath NVARCHAR(500) NULL,
        DisplayOrder INT DEFAULT 0,
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    
    -- Insert sample project
    INSERT INTO Projects (Title, Description, TechStack, GitHubLink, DisplayOrder) VALUES
    (
        'Portfolio Website', 
        'A responsive personal portfolio website built with ASP.NET Web Forms, featuring admin panel, contact system, and dynamic content management.',
        'ASP.NET Web Forms, C#, SQL Server, Bootstrap 5, JavaScript, Font Awesome',
        'https://github.com/redphoenix-05/Ariyan-ASP-Portfolio',
        1
    );
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ContactMessages' AND xtype='U')
BEGIN
    CREATE TABLE ContactMessages (
        MessageId INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(200) NOT NULL,
        Subject NVARCHAR(300) NULL,
        Message NVARCHAR(MAX) NOT NULL,
        IsRead BIT DEFAULT 0,
        IsReplied BIT DEFAULT 0,
        ReceivedDate DATETIME DEFAULT GETDATE(),
        IPAddress NVARCHAR(50) NULL
    );
END
GO

-- Verify setup
SELECT 'Database setup completed successfully!' AS Status;
SELECT 'Admin Users: ' + CAST(COUNT(*) AS VARCHAR) AS AdminCount FROM AdminUsers;
SELECT 'Portfolio Info: ' + CAST(COUNT(*) AS VARCHAR) AS InfoCount FROM PortfolioInfo;
SELECT 'Skills: ' + CAST(COUNT(*) AS VARCHAR) AS SkillsCount FROM Skills;
SELECT 'Projects: ' + CAST(COUNT(*) AS VARCHAR) AS ProjectsCount FROM Projects;