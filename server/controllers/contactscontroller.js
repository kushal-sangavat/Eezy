import Contact from '../models/addcontact.model.js';



export const addcontact = async (req, res) => {
    try {
        const { role, name, position, department,phone,email,location } = req.body;

        const userExists = await Contact.findOne({ email });
        if (userExists) {
            return res.status(400).json({ message: 'User already exists' });
        }
        const user = await Contact.create({
            role, name, position, department,phone,email,location
        });
        if (user) {
            res.status(201).json({
                role: user.role,
                name: user.name,
                position:user.position,
                department:user.department,
                phone: user.phone,
                email: user.email,
                location: user.location,
            });
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};




export const getContact = async (req, res) => {
  try {
    const contacts = await Contact.find(); // Fetch all contact documents
    // console.log(contacts);
    return res.status(200).json(contacts);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};