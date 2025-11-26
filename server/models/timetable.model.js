import mongoose from 'mongoose';

const TimetableSchema = new mongoose.Schema({
  course: { type: String, required: true },
  year: { type: String, required: true },
  section: { type: String, required: true },
  imageUrl: { type: String, required: true },
  uploadedAt: { type: Date, default: Date.now },
});

export default mongoose.model('Timetable', TimetableSchema);
