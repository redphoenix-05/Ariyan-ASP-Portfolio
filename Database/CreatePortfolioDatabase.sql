-- Portfolio Database Schema
-- Create Database
CREATE DATABASE PortfolioDatabase;
GO

USE PortfolioDatabase;
GO

-- Admin Users Table
CREATE TABLE AdminUsers (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastLoginDate DATETIME NULL
);

-- Skills Table
CREATE TABLE Skills (
    SkillId INT IDENTITY(1,1) PRIMARY KEY,
    SkillName NVARCHAR(100) NOT NULL,
    SkillType NVARCHAR(50) NOT NULL, -- 'Technical' or 'Soft'
    ProficiencyLevel INT NOT NULL CHECK (ProficiencyLevel BETWEEN 1 AND 100),
    Description NVARCHAR(500) NULL,
    IconClass NVARCHAR(50) NULL, -- For FontAwesome or other icon classes
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Projects Table
CREATE TABLE Projects (
    ProjectId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    TechStack NVARCHAR(500) NOT NULL, -- Comma separated technologies
    GitHubLink NVARCHAR(500) NULL,
    DemoLink NVARCHAR(500) NULL,
    ImagePath NVARCHAR(500) NULL,
    DisplayOrder INT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Achievements Table
CREATE TABLE Achievements (
    AchievementId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    AchievementDate DATE NOT NULL,
    Organization NVARCHAR(200) NULL,
    ImagePath NVARCHAR(500) NULL,
    DisplayOrder INT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Education Table
CREATE TABLE Education (
    EducationId INT IDENTITY(1,1) PRIMARY KEY,
    Degree NVARCHAR(200) NOT NULL,
    Institution NVARCHAR(200) NOT NULL,
    StartYear INT NOT NULL,
    EndYear INT NULL, -- NULL for ongoing
    GPA DECIMAL(3,2) NULL,
    Description NVARCHAR(500) NULL,
    DisplayOrder INT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Certificates Table
CREATE TABLE Certificates (
    CertificateId INT IDENTITY(1,1) PRIMARY KEY,
    CertificateName NVARCHAR(200) NOT NULL,
    Provider NVARCHAR(200) NOT NULL,
    IssueDate DATE NOT NULL,
    ExpiryDate DATE NULL,
    VerificationLink NVARCHAR(500) NULL,
    ImagePath NVARCHAR(500) NULL,
    DisplayOrder INT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Contact Messages Table
CREATE TABLE ContactMessages (
    MessageId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(200) NOT NULL,
    Subject NVARCHAR(300) NULL,
    Message NVARCHAR(MAX) NOT NULL,
    IsRead BIT DEFAULT 0,
    IsReplied BIT DEFAULT 0,
    ReceivedDate DATETIME DEFAULT GETDATE(),
    RepliedDate DATETIME NULL,
    IPAddress NVARCHAR(50) NULL
);

-- Portfolio Info Table (for About Me section)
CREATE TABLE PortfolioInfo (
    InfoId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200) NOT NULL,
    Tagline NVARCHAR(300) NOT NULL,
    AboutDescription NVARCHAR(MAX) NOT NULL,
    ProfileImagePath NVARCHAR(500) NULL,
    BannerImagePath NVARCHAR(500) NULL,
    ResumeFilePath NVARCHAR(500) NULL,
    PhoneNumber NVARCHAR(20) NULL,
    Email NVARCHAR(200) NULL,
    Address NVARCHAR(300) NULL,
    LinkedInProfile NVARCHAR(300) NULL,
    GitHubProfile NVARCHAR(300) NULL,
    TwitterProfile NVARCHAR(300) NULL,
    FacebookProfile NVARCHAR(300) NULL,
    ModifiedDate DATETIME DEFAULT GETDATE()
);

-- Insert Default Admin User (password: Admin@123)
INSERT INTO AdminUsers (Username, PasswordHash, Email) 
VALUES ('admin', 'AQAAAAEAACcQAAAAEF/1JayQT+VQpVJPW9KqSrVzI+Uy8q5jKjGjGJfAQg/9FJvHzDvHzDvHzDvHzDvH', 'admin@portfolio.com');

-- Insert Sample Portfolio Info
INSERT INTO PortfolioInfo (FullName, Tagline, AboutDescription, Email)
VALUES ('Your Name', 'Full Stack Developer | Software Engineer', 'I am a passionate software developer with expertise in various technologies...', 'your.email@example.com');

-- Insert Sample Skills
INSERT INTO Skills (SkillName, SkillType, ProficiencyLevel, IconClass) VALUES
('C#', 'Technical', 90, 'fab fa-microsoft'),
('ASP.NET', 'Technical', 85, 'fas fa-code'),
('SQL Server', 'Technical', 80, 'fas fa-database'),
('JavaScript', 'Technical', 75, 'fab fa-js-square'),
('HTML/CSS', 'Technical', 85, 'fab fa-html5'),
('Bootstrap', 'Technical', 80, 'fab fa-bootstrap'),
('Git', 'Technical', 75, 'fab fa-git-alt'),
('Problem Solving', 'Soft', 90, 'fas fa-lightbulb'),
('Team Work', 'Soft', 85, 'fas fa-users'),
('Communication', 'Soft', 80, 'fas fa-comments');

-- Insert Sample Project
INSERT INTO Projects (Title, Description, TechStack, GitHubLink) VALUES
('Portfolio Website', 'A responsive personal portfolio website built with ASP.NET Web Forms', 'ASP.NET Web Forms, C#, SQL Server, Bootstrap, JavaScript', 'https://github.com/yourusername/portfolio');

-- Insert Sample Achievement
INSERT INTO Achievements (Title, Description, AchievementDate, Organization) VALUES
('Best Student Award', 'Received best student award for academic excellence', '2023-06-15', 'University Name');

-- Insert Sample Education
INSERT INTO Education (Degree, Institution, StartYear, EndYear) VALUES
('Bachelor of Computer Science', 'University Name', 2020, 2024);

-- Insert Sample Certificate
INSERT INTO Certificates (CertificateName, Provider, IssueDate, VerificationLink) VALUES
('Microsoft Certified: Azure Fundamentals', 'Microsoft', '2023-08-15', 'https://verify.microsoft.com/cert123');

GO