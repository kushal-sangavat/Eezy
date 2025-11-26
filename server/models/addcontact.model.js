import mongoose from 'mongoose';

const ContactSchema = new mongoose.Schema({

    role: {
        type: String,
        enum: ['faculty', 'admin', 'security', 'health','mess'],
        required: [true, 'role is required']
    },
    name: {
        type: String,
        required: [true, 'Name is required']
    },
    position: {
        type: String,
        required: [true, 'Position is required']
    },
    department: {
        type: String,
        required: [true, 'Department is required']
    },
    phone: {
        type: String,
        required: [true, 'Phone number is required'],
        match: [/^\+?[0-9]{7,15}$/, 'Please enter a valid phone number']
    },
    email: {
        type: String,
        required: [true, 'Email is required'],
        unique: true,
        lowercase: true,
        match: [/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/, 'Please enter a valid email']
    },
    location: {
        type: String,
        required: [true, 'Location is required']
    },
}, {
    timestamps: true
});


const Contact = mongoose.model('Contact_Directory', ContactSchema);
export default Contact;
