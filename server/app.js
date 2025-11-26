import express from 'express';
import cors from 'cors';
import path from "path";
import dotenv from 'dotenv';
import connectDB from './config/database.js';
import authRoutes from './routes/auth.routes.js';
import userRoutes from './routes/user.routes.js';
import addcontactRoutes from './routes/contact.routes.js'
import anouncmentRoutes from './routes/announcment.routes.js'
import timetableRoutes from './routes/timetables.routes.js'

import messMenuRoutmes from "./routes/messMenuRoutes.js";
import lostFoundRoutes from "./routes/lostFoundRoutes.js";



dotenv.config();


// Initialize express
const app = express();

// Connect to database
connectDB();

// Middlewares
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/uploads", express.static(path.resolve("uploads")));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/user', userRoutes);
app.use('/api', addcontactRoutes );
app.use('/api', anouncmentRoutes );
app.use('/api', timetableRoutes );
app.use("/api/menu", messMenuRoutmes);
app.use("/api/lostfound", lostFoundRoutes);



// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ message: 'Something went wrong!' });
});

// Basic route
app.get('/', (req, res) => {
    res.json({ message: 'Welcome to JKLU Eezy API' });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
