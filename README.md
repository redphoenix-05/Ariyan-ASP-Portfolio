# Personal Portfolio Website

A modern, responsive personal portfolio website built with ASP.NET Web Forms and SQL Server.

## Features

### Public Portfolio Sections
- **Home**: Introduction, tagline, and profile photo with animated statistics
- **About Me**: Personal background, skills overview, and contact information
- **Skills**: Technical and soft skills with proficiency levels (dynamically loaded from database)
- **Projects**: Portfolio projects with descriptions, tech stack, and demo/GitHub links
- **Achievements**: Awards, recognitions, and milestones
- **Education**: Academic background and qualifications
- **Certificates**: Professional certifications with verification links
- **Contact**: Contact form with email notifications and message storage

### Admin Panel Features
- **Secure Login**: Password-hashed authentication system
- **Dashboard**: Overview with statistics and recent activity
- **Content Management**: Full CRUD operations for all portfolio sections
- **Message Management**: View, reply to, and delete contact messages
- **Email Integration**: Gmail SMTP for contact notifications and replies

## Technology Stack

- **Backend**: ASP.NET Web Forms (C#), .NET Framework 4.7.2
- **Database**: SQL Server with parameterized queries
- **Frontend**: HTML5, CSS3, Bootstrap 5, JavaScript
- **Icons**: Font Awesome 6
- **Email**: Gmail SMTP integration
- **Security**: Forms authentication, session management, password hashing

## Design Features

- **Responsive Design**: Mobile-first approach with Bootstrap
- **Modern UI**: Clean, professional design with smooth animations
- **Dark/Light Mode**: Theme toggle functionality
- **Interactive Elements**: Animated skill bars, counters, and hover effects
- **Accessibility**: Semantic HTML and proper ARIA labels

## Getting Started

### Prerequisites

- Visual Studio 2017 or later
- .NET Framework 4.7.2
- SQL Server or SQL Server Express LocalDB
- IIS Express (included with Visual Studio)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/redphoenix-05/Ariyan-ASP-Portfolio.git
   cd Ariyan-ASP-Portfolio
   ```

2. **Restore NuGet packages**
   ```bash
   nuget restore
   ```

3. **Set up the database**
   - Execute the SQL script in `Database/CreatePortfolioDatabase.sql`
   - Update the connection string in `Web.config` if needed

4. **Configure email settings** (Optional)
   - Update the SMTP settings in `Web.config` with your Gmail credentials
   - Use an App Password for Gmail SMTP authentication

5. **Build and run the project**
   - Open `WebApplication1.sln` in Visual Studio
   - Build the solution (Ctrl+Shift+B)
   - Run the project (F5)

### Default Admin Credentials

- **Username**: `admin`
- **Password**: `Admin@123`
- **Admin URL**: `/AdminLogin.aspx`

?? **Important**: Change the default password after first login!

## Project Structure

```
??? Database/                 # SQL database schema and scripts
??? App_Code/                # Helper classes and utilities
??? Admin/                   # Admin panel pages
??? Content/                 # CSS stylesheets
??? Scripts/                 # JavaScript files
??? Images/                  # Static images and placeholders
??? Properties/              # Assembly information
??? *.aspx                   # Public portfolio pages
??? *.aspx.cs               # Code-behind files
??? Site.Master             # Master page layout
??? Web.config              # Application configuration
```

## Key Features Breakdown

### Security Features
- Password hashing with salt
- Forms authentication
- Session management
- SQL injection prevention with parameterized queries
- Admin area protection
- CSRF protection

### Database Schema
- **AdminUsers**: Admin authentication
- **PortfolioInfo**: Personal information and social links
- **Skills**: Technical and soft skills with proficiency levels
- **Projects**: Portfolio projects with media and links
- **Achievements**: Awards and recognitions
- **Education**: Academic background
- **Certificates**: Professional certifications
- **ContactMessages**: Contact form submissions

### Email Integration
- Contact form notifications
- Admin reply functionality
- Gmail SMTP configuration
- HTML email templates

## Customization

### Updating Personal Information
1. Login to admin panel at `/AdminLogin.aspx`
2. Navigate to Profile Settings
3. Update your information, photos, and social links

### Adding Content
Use the admin panel to manage:
- Skills and proficiency levels
- Project portfolio with images
- Achievements and awards
- Education history
- Professional certificates

### Styling
- Modify `Content/Site.css` for custom styles
- Update Bootstrap classes in ASPX files
- Customize color scheme in CSS variables

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Internet Explorer 11+

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

**Your Name** - [your.email@example.com](mailto:your.email@example.com)

Project Link: [https://github.com/redphoenix-05/Ariyan-ASP-Portfolio](https://github.com/redphoenix-05/Ariyan-ASP-Portfolio)

## Acknowledgments

- Bootstrap for responsive design framework
- Font Awesome for icons
- Google Fonts for typography
- Microsoft for ASP.NET Web Forms framework

---

? **Star this repository if you found it helpful!**