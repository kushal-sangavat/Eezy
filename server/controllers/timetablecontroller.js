import Timetable from '../models/timetable.model.js';

// Upload timetable
export const addtimeTable = async (req, res) => {
  try {
    const { course, year, section } = req.body;
    if (!req.file) return res.status(400).json({ message: 'No file uploaded' });

    const imageUrl = req.file.location;

    // ✅ Check if existing timetable exists → replace it
    const existing = await Timetable.findOne({ course, year, section });
    if (existing) {
      existing.imageUrl = imageUrl;
      existing.uploadedAt = new Date();
      await existing.save();
      return res.status(200).json({ message: 'Timetable updated', data: existing });
    }

    // ✅ Create new entry
    const timetable = await Timetable.create({ course, year, section, imageUrl });
    res.status(201).json({ message: 'Timetable uploaded', data: timetable });
  } catch (error) {
    console.error('Upload timetable error:', error);
    res.status(500).json({ message: error.message });
  }
};

// Get all timetables
export const gettimeTable = async (req, res) => {
  try {
    const timetables = await Timetable.find().sort({ uploadedAt: -1 });
    res.status(200).json(timetables);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
