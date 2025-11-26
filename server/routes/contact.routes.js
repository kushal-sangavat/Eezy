import express from 'express';
import { addcontact } from '../controllers/contactscontroller.js'
import { protect } from '../middleware/auth.middleware.js';
import { getContact } from '../controllers/contactscontroller.js';

const router = express.Router();

// Auth routes
router.post('/home/addcontact', protect, addcontact );
router.get("/home/getcontact", protect, getContact);

export default router;

