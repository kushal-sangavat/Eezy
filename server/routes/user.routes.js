import express from 'express';
import { getUserDetails } from '../controllers/user.controller.js';
import { protect } from '../middleware/auth.middleware.js';

const router = express.Router();

// Auth routes
router.get('/details', protect, getUserDetails);

export default router;
