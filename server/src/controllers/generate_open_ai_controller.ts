import { Request, Response } from "express";
import OpenAI from "openai";

export const generateOpenAiResponsesController = async (
    req: Request,
    res: Response
) => {
    try {
        const { messages } = req.body;

        // Kiểm tra nếu `messages` không tồn tại hoặc không phải là mảng
        if (!messages || !Array.isArray(messages)) {
            return res.status(400).json({ error: "Invalid messages format. Expected an array." });
        }

        // Kiểm tra từng phần tử trong `messages` để đảm bảo dữ liệu hợp lệ
        for (const message of messages) {
            if (!message.role || !["system", "assistant", "user", "function", "tool"].includes(message.role)) {
                return res.status(400).json({
                    error: `Invalid role in message: ${JSON.stringify(message)}. Supported roles are 'system', 'assistant', 'user', 'function', 'tool'.`,
                });
            }
            if (!message.content || typeof message.content !== "string") {
                return res.status(400).json({
                    error: `Invalid content in message: ${JSON.stringify(message)}. Content must be a non-empty string.`,
                });
            }
        }

        const openai = new OpenAI({
            apiKey: process.env.OPENAI_API_KEY,
        });

        const response = await openai.chat.completions.create({
            model: "gpt-4o-mini",
            messages,
            temperature: 1,
            max_tokens: 256,
            top_p: 1,
            frequency_penalty: 0,
            presence_penalty: 0,
        });

        return res.json({ data: response });
    } catch (error: any) {
        console.error("Error while generating OpenAI response:", error);
        res.status(500).json({ data: error.message || "Internal Server Error" });
    }
};
