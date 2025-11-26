// import Announcement from '../models/announcement.model.js';


// export const createAnnouncement = async (req, res) => {
//     try {
//         // const { Category, priority, Title,Subtitle,date,time,Description } = req.body;
//         // console.log(req.body);
//         const { category, priority, title, subtitle, date, time, description } = req.body;


//         const announcementExists = await Announcement.findOne({ Title });
//         if (announcementExists) {
//             return res.status(400).json({ message: 'Announcment already exists' });
//         }
//         const announcement = await Announcement.create({
//             Category, priority, Title,Subtitle,date,time,Description 
//         });

//         if (announcement){
//             res.status(201).json({
//                 Category: announcement.Category,
//                 priority: announcement.priority,
//                 Title: announcement.Title,
//                 Subtitle: announcement.Subtitle,
//                 date: announcement.date,
//                 time: announcement.time,
//                 Description: announcement.Description,
//             });
//         }
//     } catch (error) {
//         res.status(500).json({ message: error.message });
//     }
// };









import Announcement from '../models/announcement.model.js';

export const createAnnouncement = async (req, res) => {
  try {
    const { category, priority, title, subtitle, date, time, description } = req.body;
    console.log("📩 Received:", req.body);

    // Check for duplicate title
    const announcementExists = await Announcement.findOne({ Title: title });
    if (announcementExists) {
      return res.status(400).json({ message: 'Announcement already exists' });
    }

    // Create a new announcement
    const announcement = await Announcement.create({
      Category: category,
      priority,
      Title: title,
      Subtitle: subtitle,
      date,
      time,
      Description: description,
    });

    // Send success response
    res.status(201).json({
      Category: announcement.Category,
      priority: announcement.priority,
      Title: announcement.Title,
      Subtitle: announcement.Subtitle,
      date: announcement.date,
      time: announcement.time,
      Description: announcement.Description,
    });
  } catch (error) {
    console.error("❌ Error creating announcement:", error);
    res.status(500).json({ message: error.message });
  }
};



export const getAnnouncement = async (req, res) => {
  try {
    const announcements = await Announcement.find(); // Fetch all contact documents
    // console.log(contacts);
    return res.status(200).json(announcements);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};