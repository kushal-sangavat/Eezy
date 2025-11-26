import mongoose from 'mongoose';

const AnnouncementSchema = new mongoose.Schema({
    Category: {
        type: String,
        required: [true, 'Category is required'],
        enum: ['Event', 'Academic', 'Social', 'Hostel', 'Mess'],
    },
    priority: {
        type: String,
        required: [true, 'priority is required'],
        enum: ['High', 'Medium', 'Low'],
    },
    Title: {
        type: String,
        required: [true, 'Title is required']
    },
    Subtitle: {
        type: String,
        required: [true, 'subtitle is required']
    },
    date: {
        type: String, // 🗓 Store formatted date only, e.g. "2025-10-27"
        default: () => {
            const now = new Date();
            return now.toISOString().split('T')[0]; // e.g. "2025-10-27"
        }
    },
    time: {
        type: String, // ⏰ Store formatted time only, e.g. "14:35"
        default: () => {
            const now = new Date();
            return now.toTimeString().split(' ')[0].slice(0,5); // e.g. "14:35"
        }
    },
    Description: {
        type: String,
        required: [true, 'Content is required']
    },
}, {
});

const Announcement = mongoose.model('Announcement', AnnouncementSchema);
export default Announcement;    