# ?? How to Add Your Profile Picture

## ?? Quick Setup Guide

Your portfolio is already configured to display your profile picture with a stunning **glowing red border effect**! Here's exactly what you need to do:

### 1. **Prepare Your Profile Picture**

#### Recommended Specifications:
- **Format**: JPG, PNG, or WebP
- **Size**: 800x800 pixels (square) or 1200x1200 pixels for best quality
- **File Size**: Under 2MB for fast loading
- **Background**: Either transparent (PNG) or a clean background

#### Photo Tips:
- Use good lighting (natural light works best)
- Face should be clearly visible
- Professional or semi-professional appearance
- High resolution for crisp display

### 2. **Where to Place Your Profile Picture**

#### Option A: Replace the Existing Placeholder
```
?? Ariyan-ASP-Portfolio/
??? ?? Images/
?   ??? ?? profile-placeholder.jpg  ? Replace this file
```

**Steps:**
1. Navigate to: `C:\Users\Ariyan\source\repos\Ariyan-ASP-Portfolio\Images\`
2. Delete or rename `profile-placeholder.jpg`
3. Add your photo and name it `profile-placeholder.jpg`

#### Option B: Use Your Own Filename
```
?? Ariyan-ASP-Portfolio/
??? ?? Images/
?   ??? ?? profile-placeholder.jpg  ? Keep this as backup
?   ??? ?? ariyan-profile.jpg       ? Add your new photo
```

**Steps:**
1. Add your photo to the `Images` folder
2. Update the code to use your filename (see Step 3)

### 3. **Update the Code (If Using Option B)**

#### Update Default.aspx:
Find this line (around line 35):
```aspx
ImageUrl="~/Images/profile-placeholder.jpg"
```
Change to:
```aspx
ImageUrl="~/Images/ariyan-profile.jpg"
```

#### Update About.aspx:
Find this line (around line 25):
```aspx
ImageUrl="~/Images/profile-placeholder.jpg"
```
Change to:
```aspx
ImageUrl="~/Images/ariyan-profile.jpg"
```

### 4. **File Naming Conventions**

#### Recommended Names:
- `ariyan-profile.jpg`
- `profile-photo.jpg`
- `headshot.jpg`
- `avatar.jpg`

#### Avoid Special Characters:
? Don't use: `my photo!@#.jpg`, `Ariyan's Picture.png`
? Use instead: `ariyan-photo.jpg`, `profile-picture.png`

## ?? Glowing Red Border Effect Features

Your profile picture will automatically have:

### ? Visual Effects:
- **Animated Red Glow**: Continuously pulsing red border
- **Hover Enhancement**: Stronger glow and slight scale on hover
- **Multiple Shadow Layers**: Creates depth and professional look
- **Theme Responsive**: Adapts to dark/light theme

### ?? Technical Details:
```css
/* The glowing effect includes: */
- 4px solid red border
- Multiple layered shadows (20px, 40px, 60px, 80px)
- Smooth 0.4s transitions
- Infinite alternating animation (3s cycle)
- Hover scaling (1.05x) with enhanced glow
```

## ?? Display Locations

Your profile picture appears in:

1. **Home Page Hero Section**
   - Size: ~280px max-width
   - Shape: Circular (border-radius: 50%)
   - Effect: Medium red glow

2. **About Page Profile Section**
   - Size: ~350px max-width  
   - Shape: Rounded rectangle (border-radius: 20px)
   - Effect: Enhanced red glow with larger shadows

## ?? Testing Your Changes

### After adding your photo:

1. **Build the project:**
   ```
   Press F5 in Visual Studio
   ```

2. **Or view the demo:**
   ```
   Open portfolio-demo.html in browser
   ```

3. **Check both pages:**
   - Home page: Circular profile image
   - About page: Larger rectangular profile image

## ?? Troubleshooting

### Common Issues:

#### Image Not Showing:
- ? Check file path is correct
- ? Ensure file is in `Images` folder
- ? Verify filename matches code
- ? Check file permissions

#### Image Too Large/Small:
- ? CSS automatically handles sizing
- ? Use max-width constraints in CSS
- ? Optimize image file size if loading slowly

#### Glow Effect Not Working:
- ? Clear browser cache (Ctrl+F5)
- ? Check CSS variables are loaded
- ? Verify theme toggle is working

## ?? File Structure Example

```
?? Your Portfolio/
??? ?? Images/
?   ??? ?? ariyan-profile.jpg      ? Your main profile photo
?   ??? ?? profile-placeholder.jpg  ? Backup/fallback
?   ??? ?? logo.png                ? Optional: Site logo
?   ??? ?? favicon.ico             ? Optional: Browser icon
??? ?? Default.aspx                ? Home page
??? ?? About.aspx                  ? About page
??? ?? Content/
    ??? ?? Site.css                ? Glowing effect styles
```

## ?? Next Steps

1. **Add your profile picture** using the guide above
2. **Test the glowing red border effect**
3. **Optionally customize colors** in Site.css
4. **Add more images** for projects (place in Images folder)

## ?? Need Help?

The glowing red border effect is fully implemented and will work automatically once you add your profile picture! The effect includes:

- **Continuous subtle animation**
- **Enhanced hover effects**  
- **Multiple shadow layers**
- **Theme-responsive colors**

Just add your photo and enjoy the professional glowing effect! ?