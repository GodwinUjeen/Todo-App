import express, { Request, Response } from "express";
import { Todo } from "../models/userModel";

const router = express.Router();

//POST Request

router.post("/add", async (req: Request, res: Response) => {
    const { title, description } = req.body;

    const dataItem = Todo.set({ title, description });

    await dataItem.save();
    console.log(dataItem);

    return res.status(200).json({
        data: dataItem,
    });
});

// GET Request

router.get("/", async (req: Request, res: Response) => {
    try {
        const dataItem = await Todo.find({});

        res.status(200).json({
            data: dataItem,
        });
    } catch (error) {
        console.log(error);
    }
});

// DELETE Request

router.delete("/delete", async (req: Request, res: Response) => {
    const filter = { _id: req.body.id };
    console.log(filter);
    const dataItem = await Todo.deleteOne(filter)
        .then((data) => { res.json({ data: data }) })
        .catch((error) => { return res.send(error) });
});


// UPDATE Request
router.put("/update", async (req: Request, res: Response) => {
    const filter = {
        _id: req.body.id,
    };
    console.log(filter);

    const updatedData = {
        title: req.body.title,
        description: req.body.description,
    };

    const dataItem = await Todo.updateOne(filter, updatedData, {
        new: true,
    })
        .then((data) =>
            res.json({
                data: data,
            })
        )
        .catch((error) => {
            return res.send(error);
        });
});


export { router };
