import express from 'express';
import { createAnnouncement, getAnnouncement } from '../controllers/announcmentcontroller.js';
import { protect } from '../middleware/auth.middleware.js';

const router = express.Router();

// Announcement routes
router.post('/home/addannouncements', protect, createAnnouncement);
router.get('/home/getannouncements', protect, getAnnouncement);

export default router;