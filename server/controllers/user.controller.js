import User from '../models/user.model.js';

const getUserDetails = async (req, res) => {
    const userId = req.user.userId;

    try {
        const user = await User.findOne({"_id":userId}); // Exclude password
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }
        res.status(200).json({
            "name":user.name,
            "email":user.email,
            "role":user.role
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

export { getUserDetails };

// http://localhost:3000/api/user/details
// header: Authorization
// Bearer <token>


