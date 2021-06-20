import express, { Request, Response } from "express";
import { router } from './routes/routes';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import cors from 'cors';

dotenv.config();

const app = express();

app.use(cors());

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

mongoose.connect(process.env.MONGODB_URL as string, { useUnifiedTopology: true, useNewUrlParser: true }, () => { console.log("DB Connected...") });

app.use("/", router)

app.listen(process.env.PORT || 3000, () => {
    console.log("Server is rocking at 3000");
});