import mongoose from "mongoose";

const mealSchema = new mongoose.Schema({
  breakfast: { type: String, default: "" },
  lunch: { type: String, default: "" },
  snacks: { type: String, default: "" },
  dinner: { type: String, default: "" },
});

const messMenuSchema = new mongoose.Schema(
  {
    fromDate: { type: Date, required: true },
    toDate: { type: Date, required: true },

    days: {
      Sunday: mealSchema,
      Monday: mealSchema,
      Tuesday: mealSchema,
      Wednesday: mealSchema,
      Thursday: mealSchema,
      Friday: mealSchema,
      Saturday: mealSchema,
    },

    notes: { type: String, default: "" },
  },
  { timestamps: true }
);

export default mongoose.model("MessMenu", messMenuSchema);
