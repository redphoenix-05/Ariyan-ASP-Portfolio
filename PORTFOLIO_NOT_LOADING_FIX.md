# ?? Portfolio Not Loading - Troubleshooting Guide

## ?? **Issue:** Nothing appears when running the project

Your ASP.NET Web Forms portfolio project builds successfully but shows a blank page or doesn't load when you run it. Here are the step-by-step solutions:

## ?? **Immediate Solutions to Try:**

### **1. Check Your Browser URL**
When you press F5, make sure the URL is:
- `http://localhost:[port]/Default.aspx` OR
- `http://localhost:[port]/` (should redirect to Default.aspx)

If you see a different URL or error page, that's the issue.

### **2. Test with the Diagnostic Page**
Navigate to: `http://localhost:[port]/Test.aspx`

This page will:
- ? Confirm ASP.NET is working
- ? Show system information
- ? Test Default.aspx accessibility
- ? Provide direct links to all pages

### **3. Force Clear Browser Cache**
- Press `Ctrl + F5` to hard refresh
- Or clear browser cache manually
- Try opening in an incognito/private window

### **4. Check Project Startup Settings**
1. **Right-click your project** in Solution Explorer
2. Select **"Properties"**
3. Go to **"Web"** tab
4. Under **"Start Action"**, select:
   - ? **"Specific Page"** and enter `Default.aspx`
   - OR ? **"Current Page"** if Default.aspx is open

### **5. Verify Default Document**
Your `Web.config` has been updated with:
```xml
<defaultDocument>
  <files>
    <clear />
    <add value="Default.aspx" />
  </files>
</defaultDocument>
```

## ?? **Advanced Debugging Steps:**

### **Step 1: Check IIS Express**
1. Look for **IIS Express** icon in system tray (bottom right)
2. Right-click it and check if your site is listed
3. If not running, restart Visual Studio

### **Step 2: Check Console for Errors**
1. Open browser **Developer Tools** (F12)
2. Check **Console** tab for JavaScript errors
3. Check **Network** tab for failed requests

### **Step 3: Verify File Structure**
Your project should have:
```
?? Project Root/
??? ?? Default.aspx ?
??? ?? Default.aspx.cs ?
??? ?? Default.aspx.designer.cs ?
??? ?? Site.Master ?
??? ?? Site.Master.cs ?
??? ?? Web.config ?
??? ?? Global.asax ?
??? ?? Global.asax.cs ?
??? ?? Content/
    ??? ?? Site.css ?
```

### **Step 4: Check Build Output**
1. Go to **View** ? **Output**
2. Select **"Build"** from dropdown
3. Look for any warnings or errors

### **Step 5: Debug Mode Check**
In Web.config, ensure:
```xml
<compilation debug="true" targetFramework="4.7.2" />
<customErrors mode="Off" />
```

## ??? **Common Fixes:**

### **Fix 1: Rebuild Solution**
1. **Build** ? **Clean Solution**
2. **Build** ? **Rebuild Solution**
3. Press **F5** to run

### **Fix 2: Reset IIS Express**
1. Close Visual Studio
2. Delete folder: `%USERPROFILE%\Documents\IISExpress\config\`
3. Restart Visual Studio
4. Run project again

### **Fix 3: Check Port Conflicts**
1. In project properties ? **Web** tab
2. Note the **Project URL** (e.g., `http://localhost:12345`)
3. Try changing the port number if needed

### **Fix 4: Disable Authentication (Temporarily)**
In Web.config, comment out:
```xml
<!-- Temporarily disable for testing
<authentication mode="Forms">
  <forms loginUrl="~/AdminLogin.aspx" timeout="30" />
</authentication>
-->
```

## ?? **Step-by-Step Testing Process:**

### **Test 1: Basic ASP.NET**
1. Navigate to: `http://localhost:[port]/Test.aspx`
2. If this loads ? ASP.NET is working
3. If not ? IIS Express issue

### **Test 2: Default Page**
1. From Test.aspx, click "Test Default.aspx" button
2. Click the generated Default.aspx link
3. Check if it loads

### **Test 3: Direct Navigation**
1. Manually type: `http://localhost:[port]/Default.aspx`
2. Press Enter
3. Should load the portfolio

### **Test 4: CSS and Resources**
1. Check if you can access: `http://localhost:[port]/Content/Site.css`
2. Should show CSS file content
3. If 404 ? resource path issues

## ?? **Alternative Testing Methods:**

### **Method 1: Try Different Browsers**
- Chrome
- Firefox
- Edge
- Internet Explorer (if available)

### **Method 2: Try Different URLs**
- `http://localhost:[port]/`
- `http://localhost:[port]/Default.aspx`
- `http://127.0.0.1:[port]/Default.aspx`

### **Method 3: Check Windows Firewall**
- Temporarily disable Windows Firewall
- Test if page loads
- Re-enable firewall if this fixes it

## ?? **If Nothing Works:**

### **Emergency Diagnostic Commands:**
Run these in **Package Manager Console**:

```bash
# Check if project compiles
Update-Package -Reinstall
```

### **Last Resort - Clean Start:**
1. **File** ? **New** ? **Project**
2. Create **ASP.NET Web Application (.NET Framework)**
3. Choose **Web Forms** template
4. Copy your content files over

## ? **Success Indicators:**

You'll know it's working when you see:
- ?? **Navigation bar** with your name
- ?? **Hero section** with profile photo
- ?? **Statistics cards** (8 Apps, 15 Technologies, etc.)
- ?? **Skills section** with progress bars
- ?? **Featured projects** section
- ?? **Call to action** section

## ?? **Updated Files for Debugging:**

I've updated these files to help with debugging:
1. ? **Web.config** - Disabled custom errors, added default document
2. ? **Test.aspx.cs** - Enhanced with system diagnostics
3. ? **Build configuration** - Verified successful

## ?? **Next Steps:**

1. **Try Test.aspx first**: Navigate to `http://localhost:[port]/Test.aspx`
2. **Use the diagnostic information** it provides
3. **Follow the troubleshooting steps** based on what you find
4. **Report back** with what you see in Test.aspx

**The most likely issue is either a URL problem or IIS Express configuration. The Test.aspx page will help identify which one!** ??