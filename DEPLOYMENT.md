# Hostinger पर Deployment Guide (हिंदी)

## 📋 Requirements (आवश्यक चीजें)

1. **Node.js** (v18 या नया) - Local build के लिए
2. **pnpm** या **npm** package manager
3. **Hostinger File Manager** या **FTP Client** (FileZilla आदि)

---

## 🚀 Step-by-Step Deployment Process

### Step 1: Dependencies Install करें

Project folder में terminal/command prompt खोलें और run करें:

```bash
# अगर pnpm installed है:
pnpm install

# या npm use करें:
npm install
```

### Step 2: Production Build बनाएं

```bash
# pnpm के साथ:
pnpm run build

# या npm के साथ:
npm run build
```

यह command `dist/` folder बनाएगी जिसमें सभी production-ready files होंगी।

### Step 3: Build Verify करें

Build के बाद `dist/` folder में ये files होनी चाहिए:

```
dist/
├── index.html          (main page)
├── terms.html          (terms page)
├── app.js              (compiled JavaScript)
├── i18n/
│   ├── en-US.json      (English translations)
│   └── zh-CN.json      (Chinese translations)
└── userscript/
    └── gemini-watermark-remover.user.js
```

### Step 4: Hostinger पर Upload करें

#### Method 1: File Manager के through (Recommended)

1. **Hostinger hPanel** में login करें
2. **File Manager** open करें
3. `public_html` folder में जाएं (या subdomain/domain का root folder)
4. `dist/` folder की **सभी files और folders** select करें
5. **Upload** करें
6. जरूरी हो तो `index.html` को root में move करें

#### Method 2: FTP Client के through (FileZilla)

1. **FileZilla** या कोई FTP client open करें
2. Hostinger FTP credentials से connect करें:
   - **Host:** ftp.yourdomain.com (या Hostinger द्वारा दिया गया host)
   - **Username:** आपका FTP username
   - **Password:** आपका FTP password
   - **Port:** 21
3. Remote side पर `public_html` folder में जाएं
4. Local side पर `dist/` folder select करें
5. सभी files को drag & drop करके upload करें

### Step 5: File Permissions Set करें

Hostinger File Manager में:
- Folders: **755** permissions
- Files: **644** permissions

(आमतौर पर ये automatically set हो जाती हैं)

### Step 6: Website Test करें

Browser में अपनी website खोलें:
```
https://yourdomain.com
```

Check करें:
- ✅ Website load हो रही है
- ✅ Images upload हो रहे हैं
- ✅ Watermark removal काम कर रहा है
- ✅ Language switch button काम कर रहा है

---

## ⚠️ Important Notes (महत्वपूर्ण बातें)

### 1. Subdomain/Subdirectory के लिए

अगर आप subdomain या subdirectory में deploy कर रहे हैं:

**Subdomain example:**
- Files upload करें: `public_html/subdomain/` में
- या: Hostinger में subdomain का अलग folder बनाएं

**Subdirectory example:**
- Files upload करें: `public_html/watermark-remover/` में
- Website URL: `https://yourdomain.com/watermark-remover/`

### 2. .htaccess File (Optional)

अगर clean URLs चाहिए या SPA routing चाहिए, `dist/` folder में `.htaccess` file create करें:

```apache
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  RewriteRule ^index\.html$ - [L]
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule . /index.html [L]
</IfModule>
```

### 3. CORS/Headers (अगर जरूरत हो)

अगर API calls के लिए headers चाहिए, `.htaccess` में add करें:

```apache
<IfModule mod_headers.c>
  Header set Access-Control-Allow-Origin "*"
  Header set Access-Control-Allow-Methods "GET, POST, OPTIONS"
</IfModule>
```

### 4. HTTPS Check करें

SSL certificate properly configured होना चाहिए (Hostinger में usually auto होता है)।

---

## 🔄 Updates के लिए

अगर बाद में code update करना हो:

1. Local पर changes करें
2. फिर से `pnpm run build` या `npm run build` run करें
3. नई `dist/` folder की files को Hostinger पर upload करें (old files को replace करें)

---

## 🐛 Troubleshooting

### Problem: Website load नहीं हो रही
- ✅ Check करें कि `index.html` root में है
- ✅ File permissions check करें (755/644)
- ✅ Browser console में errors check करें (F12)

### Problem: Images/Assets load नहीं हो रहे
- ✅ File paths check करें (relative paths सही हैं या नहीं)
- ✅ `i18n/` folder properly uploaded है या नहीं
- ✅ Browser Network tab में failed requests check करें

### Problem: Build error आ रहा है
- ✅ Node.js version check करें (v18+ required)
- ✅ Dependencies properly install हुईं या नहीं (`pnpm install` / `npm install`)
- ✅ `node_modules` folder delete करके फिर से install करें

---

## 📞 Support

अगर कोई problem हो तो:
- GitHub Issues: https://github.com/journey-ad/gemini-watermark-remover/issues
- Hostinger Support: Hostinger support team से contact करें

---

## ✅ Checklist Before Going Live

- [ ] Local पर build successfully हुआ
- [ ] `dist/` folder में सभी required files हैं
- [ ] Files properly uploaded हुईं
- [ ] Website browser में load हो रही है
- [ ] Watermark removal functionality test हुई
- [ ] Mobile और desktop दोनों में test किया
- [ ] SSL/HTTPS properly configured है

---

**Good luck with your deployment! 🎉**

