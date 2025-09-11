"use client";

import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import api from "@/lib/api";
import CardForm, { CardFormData, cardSchema } from "../../components/CardForm";

export default function NewCardPage() {
  const router = useRouter();

  async function handleSave(data: CardFormData) {
    try {
      cardSchema.parse(data);
      const res = await api.post("/cards", data);
      toast.success("Card created!");
      router.push(`/cards/${res.data.data.id}`);
    } catch (err: any) {
      toast.error(err.response?.data?.message || "Failed to create card");
    }
  }

  return <CardForm onSave={handleSave} />;
}
