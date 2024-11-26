"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateOpenAiResponsesController = void 0;
const openai_1 = __importDefault(require("openai"));
const generateOpenAiResponsesController = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
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
        const openai = new openai_1.default({
            apiKey: process.env.OPENAI_API_KEY,
        });
        const response = yield openai.chat.completions.create({
            model: "gpt-4o-mini",
            messages,
            temperature: 1,
            max_tokens: 256,
            top_p: 1,
            frequency_penalty: 0,
            presence_penalty: 0,
        });
        return res.json({ data: response });
    }
    catch (error) {
        console.error("Error while generating OpenAI response:", error);
        res.status(500).json({ data: error.message || "Internal Server Error" });
    }
});
exports.generateOpenAiResponsesController = generateOpenAiResponsesController;
