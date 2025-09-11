"use client";

import { useEffect, useState } from "react";
import { useRouter, useParams } from "next/navigation";
import api from "@/lib/api";
import toast from "react-hot-toast";
//import CardForm from "@/components/CardForm";
import CardForm from "../../components/CardForm";
import { cardSchema, CardFormData } from "@/lib/validation";

export default function EditCardPage() {
  const router = useRouter();
  const params = useParams();
  const cardId = params.cardId as string;

  const [card, setCard] = useState<CardFormData | null>(null);

  useEffect(() => {
    api.put(`/cards/${cardId}`)
      .then(res => setCard(res.data.data))
      .catch(() => {
        toast.error("Failed to load card");
        router.push("/cards");
      });
  }, [cardId, router]);

  async function handleSave(data: CardFormData) {
    try {
      cardSchema.parse(data);
      await api.put(`/cards/${cardId}`, data);
      toast.success("Card updated!");
      router.push("/cards");
    } catch {
      toast.error("Failed to update card");
    }
  }

  return card ? <CardForm initial={card} onSave={handleSave} /> : <p>Loading...</p>;
}
