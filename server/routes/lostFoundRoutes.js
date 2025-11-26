import express from "express";
import upload from "../middleware/upload.js";
import { protect } from "../middleware/auth.middleware.js";
import { createItem, getAllItems, deleteItem } from "../controllers/lostFoundController.js";

const router = express.Router();

// Create lost & found item
router.post(
  "/add",
  protect,
  upload.single("image"),
  createItem
);

// Get all items
router.get("/all", getAllItems);

// Delete item - only uploader can delete
router.delete("/delete/:id", protect, deleteItem);

export default router;
