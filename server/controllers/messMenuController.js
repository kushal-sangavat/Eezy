// // import fs from 'fs';
// // import path from 'path';
// // import puppeteer from 'puppeteer';
// // import MessMenu from "../models/MessMenu.model.js";

// // // CREATE MENU
// // // export const createMenu = async (req, res) => {
// // //   try {
// // //     const menu = await MessMenu.create(req.body);
// // //     res.status(201).json(menu);
// // //   } catch (err) {
// // //     res.status(500).json({ error: err.message });
// // //   }
// // // };



// // // CREATE MENU (delete old and insert new)
// // export const createMenu = async (req, res) => {
// //   try {
// //     // 1️⃣ Delete all previous menus
// //     await MessMenu.deleteMany({});

// //     // 2️⃣ Create new menu
// //     const menu = await MessMenu.create(req.body);

// //     res.status(201).json(menu);
// //   } catch (err) {
// //     res.status(500).json({ error: err.message });
// //   }
// // };


// // // GET ALL MENUS
// // export const getMenus = async (req, res) => {
// //   try {
// //     const menus = await MessMenu.find().sort({ createdAt: -1 });
// //     res.status(200).json(menus);
// //   } catch (err) {
// //     res.status(500).json({ error: err.message });
// //   }
// // };

// // // GET MENU BY ID
// // export const getMenuById = async (req, res) => {
// //   try {
// //     const menu = await MessMenu.findById(req.params.id);
// //     res.status(200).json(menu);
// //   } catch (err) {
// //     res.status(500).json({ error: err.message });
// //   }
// // };

// // // UPDATE MENU
// // export const updateMenu = async (req, res) => {
// //   try {
// //     const updatedMenu = await MessMenu.findByIdAndUpdate(
// //       req.params.id,
// //       req.body,
// //       { new: true }
// //     );
// //     res.status(200).json(updatedMenu);
// //   } catch (err) {
// //     res.status(500).json({ error: err.message });
// //   }
// // };
























// // import fs from 'fs';
// // import MessMenu from "../models/MessMenu.model.js";
// // import puppeteer from "puppeteer";


// // /* existing controllers (createMenu, getMenus, getMenuById, updateMenu) */
// // /* ... keep your previously posted controller functions ... */

// // /* CREATE MENU (delete old then add new) */
// // export const createMenu = async (req, res) => {
// //   try {
// //     await MessMenu.deleteMany({});
// //     const menu = await MessMenu.create(req.body);
// //     res.status(201).json(menu);
// //   } catch (err) {
// //     res.status(500).json({ error: err.message });
// //   }
// // };



// import fs from "fs";
// import path from "path";
// import puppeteer from "puppeteer";

// const pdfPath = "uploads/menu.pdf";
// const pngPath = "uploads/menu.png";

// // ------------------------
// // CREATE MENU (Auto Save PDF + PNG)
// // ------------------------
// export const createMenu = async (req, res) => {
//   try {
//     // 1️⃣ DELETE previous menu
//     await MessMenu.deleteMany({});

//     // 2️⃣ DELETE old PDF / PNG if exist
//     if (fs.existsSync(pdfPath)) fs.unlinkSync(pdfPath);
//     if (fs.existsSync(pngPath)) fs.unlinkSync(pngPath);

//     // 3️⃣ Save the new menu
//     const newMenu = await MessMenu.create(req.body);

//     // 4️⃣ Generate fresh PDF + PNG
//     const html = generateMenuHTML(newMenu);

//     // Launch Puppeteer
//     const browser = await puppeteer.launch({
//       args: ["--no-sandbox", "--disable-setuid-sandbox"],
//     });
//     const page = await browser.newPage();

//     await page.setContent(html, { waitUntil: "networkidle0" });

//     // Save PDF
//     await page.pdf({
//       path: pdfPath,
//       format: "A4",
//       printBackground: true,
//     });

//     // Save PNG
//     await page.setViewport({ width: 1200, height: 1800 });
//     await page.screenshot({
//       path: pngPath,
//       fullPage: true,
//       type: "png",
//     });

//     await browser.close();

//     res.status(201).json({
//       message: "Menu created & files generated",
//       menu: newMenu,
//     });

//   } catch (err) {
//     console.error("Error:", err);
//     res.status(500).json({ error: err.message });
//   }
// };


// export const getMenus = async (req, res) => {
//   try {
//     const menus = await MessMenu.find().sort({ createdAt: -1 });
//     res.status(200).json(menus);
//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };

// export const getMenuById = async (req, res) => {
//   try {
//     const menu = await MessMenu.findById(req.params.id);
//     res.status(200).json(menu);
//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };

// export const updateMenu = async (req, res) => {
//   try {
//     const updatedMenu = await MessMenu.findByIdAndUpdate(
//       req.params.id,
//       req.body,
//       { new: true }
//     );
//     res.status(200).json(updatedMenu);
//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// };

// /* -------------------------
//    New: generateMenuFile
//    ------------------------- */
// const LOGO_LOCAL_PATH = '/mnt/data/43283ce2-2992-42b9-8540-ff77ddd5b5c9.png'; // developer-provided path

// function menuToHtml(menu, base64Logo) {
//   // menu.days expected with keys Monday..Sunday or Sunday..Saturday
//   // Build a two-column table: Day | Breakfast | Lunch | Snacks | Dinner
//   const days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
//   // If your DB uses different ordering or names, adjust accordingly.

//   const notes = menu.notes || "";

//   const rowHtml = days.map(day => {
//     const d = menu.days?.[day] || {};
//     return `
//       <tr>
//         <td style="padding:8px;border:1px solid #ddd;white-space:nowrap">${day}</td>
//         <td style="padding:8px;border:1px solid #ddd">${(d.breakfast || '').replace(/\n/g,'<br>')}</td>
//         <td style="padding:8px;border:1px solid #ddd">${(d.lunch || '').replace(/\n/g,'<br>')}</td>
//         <td style="padding:8px;border:1px solid #ddd">${(d.snacks || '').replace(/\n/g,'<br>')}</td>
//         <td style="padding:8px;border:1px solid #ddd">${(d.dinner || '').replace(/\n/g,'<br>')}</td>
//       </tr>
//     `;
//   }).join('');

//   const from = menu.fromDate ? new Date(menu.fromDate).toLocaleDateString() : '';
//   const to = menu.toDate ? new Date(menu.toDate).toLocaleDateString() : '';

//   return `
//     <!doctype html>
//     <html>
//     <head>
//       <meta charset="utf-8"/>
//       <title>Mess Menu</title>
//       <style>
//         body { font-family: Arial, Helvetica, sans-serif; margin: 20px; color: #222 }
//         .header { display:flex; align-items:center; gap:12px; margin-bottom:10px; }
//         .logo { width:80px; height:80px; object-fit:cover; border-radius:6px; }
//         h1 { margin:0; font-size:18px; }
//         .sub { color:#555; font-size:12px; }
//         table { width:100%; border-collapse:collapse; margin-top:12px; }
//         th { text-align:left; padding:10px; border:1px solid #ddd; background:#f4f6f8; }
//         td { vertical-align:top; }
//         .notes { margin-top:14px; font-size:12px; color:#444; }
//       </style>
//     </head>
//     <body>
//       <div class="header">
//         ${base64Logo ? `<img src="data:image/png;base64,${base64Logo}" class="logo" />` : ''}
//         <div>
//           <h1>Mess Menu (${from} — ${to})</h1>
//           <div class="sub">Full weekly menu</div>
//         </div>
//       </div>

//       <table>
//         <thead>
//           <tr>
//             <th style="width:10%">Day</th>
//             <th style="width:22%">Breakfast (8-9 AM)</th>
//             <th style="width:22%">Lunch (12-2 PM)</th>
//             <th style="width:18%">High Tea (5-6 PM)</th>
//             <th style="width:28%">Dinner (8-10 PM)</th>
//           </tr>
//         </thead>
//         <tbody>
//           ${rowHtml}
//         </tbody>
//       </table>

//       <div class="notes">
//         <strong>Notes:</strong> ${notes || '—'}
//       </div>
//     </body>
//     </html>
//   `;
// }

// export const generateMenuFile = async (req, res) => {
//   try {
//     // fetch latest menu (most recent created)
//     const menu = await MessMenu.findOne().sort({ createdAt: -1 }).lean();
//     if (!menu) {
//       return res.status(404).json({ message: "No menu found" });
//     }

//     // try to read local logo image and convert to base64
//     let base64Logo = null;
//     try {
//       const logoBuffer = fs.readFileSync(LOGO_LOCAL_PATH);
//       base64Logo = logoBuffer.toString('base64');
//     } catch (e) {
//       // if image isn't present, we still continue without logo
//       console.warn("Logo not found at path, continuing without logo:", LOGO_LOCAL_PATH);
//     }

//     const html = menuToHtml(menu, base64Logo);

//     // Launch puppeteer (headless chrome)
//     const browser = await puppeteer.launch({
//       args: ['--no-sandbox', '--disable-setuid-sandbox'],
//     });
//     const page = await browser.newPage();

//     await page.setContent(html, { waitUntil: 'networkidle0' });

//     const format = (req.query.format || 'pdf').toLowerCase(); // pdf or png

//     if (format === 'png') {
//       // set viewport width to A4-like width for good render
//       await page.setViewport({ width: 1200, height: 1600 });
//       const imageBuffer = await page.screenshot({ fullPage: true, type: 'png' });
//       await browser.close();
//       res.setHeader('Content-Type', 'image/png');
//       res.setHeader('Content-Disposition', `attachment; filename="menu-${Date.now()}.png"`);
//       return res.send(imageBuffer);
//     } else {
//       // pdf
//       const pdfBuffer = await page.pdf({
//         format: 'A4',
//         printBackground: true,
//         margin: { top: '20px', bottom: '20px', left: '20px', right: '20px' }
//       });
//       await browser.close();
//       res.setHeader('Content-Type', 'application/pdf');
//       res.setHeader('Content-Disposition', `attachment; filename="menu-${Date.now()}.pdf"`);
//       return res.send(pdfBuffer);
//     }
//   } catch (err) {
//     console.error("Error generating menu file:", err);
//     return res.status(500).json({ error: err.message || 'Server error' });
//   }
// };










import fs from "fs";
import path from "path";
import puppeteer from "puppeteer";
import MessMenu from "../models/MessMenu.model.js";

const pdfPath = path.resolve("uploads/menu.pdf");
const pngPath = path.resolve("uploads/menu.png");

// Ensure uploads folder exists
if (!fs.existsSync("uploads")) {
  fs.mkdirSync("uploads");
}

/* ------------------------
   Helper: HTML Generator
------------------------ */















function generateMenuHTML(menu) {
  const daysOrder = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  const rowHtml = daysOrder.map(day => {
    const d = menu.days[day] || {};
    return `
      <tr>
        <td>${day}</td>
        <td>${d.breakfast?.replace(/\n/g, "<br>") || ""}</td>
        <td>${d.lunch?.replace(/\n/g, "<br>") || ""}</td>
        <td>${d.snacks?.replace(/\n/g, "<br>") || ""}</td>
        <td>${d.dinner?.replace(/\n/g, "<br>") || ""}</td>
      </tr>
    `;
  }).join("");

  const fromDate = new Date(menu.fromDate).toLocaleDateString("en-IN", { day: "numeric", month: "long" });
  const toDate = new Date(menu.toDate).toLocaleDateString("en-IN", { day: "numeric", month: "long" });

  const notes = menu.notes?.replace(/\n/g, "<br>") || "—";

  return `
  <html>
  <head>
    <style>
      body { 
        font-family: Arial, Helvetica, sans-serif;  
        background: white;
        padding: 25px;
        color: #000;
      }

      h2 {
        text-align: center;
        margin-bottom: 20px;
        font-size: 22px;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        background: white;
      }

      th, td {
        border: 1px solid black;
        padding: 8px;
        vertical-align: top;
        font-size: 13px;
      }

      th {
        font-weight: bold;
        background: #f2f2f2;
        text-align: center;
      }

      .notes {
        margin-top: 20px;
        font-size: 12px;
        color: #333;
      }
    </style>
  </head>

  <body>
    <h2>Mess Menu (${fromDate} – ${toDate})</h2>

    <table>
      <thead>
        <tr>
          <th>Day</th>
          <th>Breakfast (8–9 AM)</th>
          <th>Lunch (12–2 PM)</th>
          <th>High Tea (5–6 PM)</th>
          <th>Dinner (8–10 PM)</th>
        </tr>
      </thead>
      <tbody>
        ${rowHtml}
      </tbody>
    </table>

    <div class="notes">
      <p><strong>Notes:</strong></p>
      <p>${notes}</p>
    </div>
  </body>
  </html>
  `;
}





















/* ------------------------
   CREATE MENU + generate PDF/PNG
------------------------ */
export const createMenu = async (req, res) => {
  try {
    // delete old DB menus
    await MessMenu.deleteMany({});

    // delete old files
    if (fs.existsSync(pdfPath)) fs.unlinkSync(pdfPath);
    if (fs.existsSync(pngPath)) fs.unlinkSync(pngPath);

    // create new menu
    const menu = await MessMenu.create(req.body);

    // generate HTML
    const html = generateMenuHTML(menu);

    const browser = await puppeteer.launch({
      args: ["--no-sandbox", "--disable-setuid-sandbox"],
    });

    const page = await browser.newPage();
    await page.setContent(html, { waitUntil: "networkidle0" });

    // save PDF
    const pdfBuffer = await page.pdf({
      format: "A4",
      printBackground: true,
    });
    fs.writeFileSync(pdfPath, pdfBuffer);

    // save PNG
    await page.setViewport({ width: 1200, height: 1600 });
    const pngBuffer = await page.screenshot({ fullPage: true });
    fs.writeFileSync(pngPath, pngBuffer);

    await browser.close();

    res.status(201).json({
      message: "Menu created + files generated",
      menu,
      pdfUrl: "/uploads/menu.pdf",
      pngUrl: "/uploads/menu.png",
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
};


/* ------------------------
   GET MENU LIST
------------------------ */
export const getMenus = async (req, res) => {
  try {
    const menus = await MessMenu.find();
    res.status(200).json(menus);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/* ------------------------
   GET MENU BY ID
------------------------ */
export const getMenuById = async (req, res) => {
  try {
    const menu = await MessMenu.findById(req.params.id);
    res.status(200).json(menu);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/* ------------------------
   UPDATE MENU
------------------------ */
export const updateMenu = async (req, res) => {
  try {
    const menu = await MessMenu.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    res.status(200).json(menu);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/* ------------------------
   DOWNLOAD PDF / PNG
------------------------ */
export const getPDF = (req, res) => {
  res.sendFile(pdfPath);
};

export const getPNG = (req, res) => {
  res.sendFile(pngPath);
};
