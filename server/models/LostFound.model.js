import mongoose from "mongoose";

const lostFoundSchema = new mongoose.Schema(
  {
    title: String,
    description: String,
    location: String,
    dateFound: String,
    imageUrl: String,

    uploadedBy: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },

    uploaderRole: String,
  },
  { timestamps: true }
);

export default mongoose.model("LostFound", lostFoundSchema);
