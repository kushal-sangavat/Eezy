// import express from "express";
// import { protect } from '../middleware/auth.middleware.js';
// import {
//   createMenu,
//   getMenus,
//   getMenuById,
//   updateMenu,
//   generateMenuFile
// } from "../controllers/messMenuController.js";

// const router = express.Router();

// router.post("/add",protect, createMenu);   // Add new menu
// router.get("/all",protect, getMenus);      // Get all menus
// router.get("/:id",protect, getMenuById);   // Get single menu
// router.put("/update/:id",protect, updateMenu); // Update menu
// router.get("/file", protect, generateMenuFile);
// router.get("/download/pdf", getPDF);
// router.get("/download/png", getPNG);


// export default router;













import express from "express";
import { protect } from "../middleware/auth.middleware.js";

import {
  createMenu,
  getMenus,
  getMenuById,
  updateMenu,
  getPDF,
  getPNG
} from "../controllers/messMenuController.js";

const router = express.Router();

router.post("/add", protect, createMenu);
router.get("/all", protect, getMenus);
router.get("/:id", protect, getMenuById);
router.put("/update/:id", protect, updateMenu);

router.get("/download/pdf", getPDF);
router.get("/download/png", getPNG);

export default router;
