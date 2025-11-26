import LostFound from "../models/LostFound.model.js";

export const createItem = async (req, res) => {
  try {
    const { title, description, location, dateFound } = req.body;

    if (!req.file) {
      return res.status(400).json({ message: "Image is required" });
    }

    const newItem = await LostFound.create({
      title,
      description,
      location,
      dateFound,
      imageUrl: `/uploads/${req.file.filename}`,
      uploadedBy: req.user.userId,
      uploaderRole: req.user.role,
    });

    res.status(201).json({ message: "Item added", item: newItem });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const getAllItems = async (req, res) => {
  try {
    const items = await LostFound.find().sort({ createdAt: -1 });
    res.json(items);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const deleteItem = async (req, res) => {
  try {
    const item = await LostFound.findById(req.params.id);

    if (!item) {
      return res.status(404).json({ message: "Item not found" });
    }

    // Only uploader can delete
    if (item.uploadedBy.toString() !== req.user.userId) {
      return res.status(403).json({ message: "Unauthorized to delete" });
    }

    await item.deleteOne();
    res.json({ message: "Item deleted successfully" });

  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
