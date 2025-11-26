import express from 'express';
import { addtimeTable, gettimeTable } from '../controllers/timetablecontroller.js';
import { protect } from '../middleware/auth.middleware.js';

const router = express.Router();

// Announcement routes
router.post('/home/addtimetable', protect, addtimeTable);
router.get('/home/timetable', protect, gettimeTable);

export default router;