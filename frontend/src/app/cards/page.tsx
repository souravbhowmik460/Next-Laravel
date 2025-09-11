"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import api from "@/lib/api";
import toast, { Toaster } from "react-hot-toast";

interface Card {
  id: number;
  profile: {
    firstName?: string;
    lastName?: string;
    designation?: string;
    email?: string;
  };
}

export default function CardsPage() {
  const [cards, setCards] = useState<Card[]>([]);
  const [loading, setLoading] = useState(true);
  const router = useRouter();

  // Load cards
  useEffect(() => {
    const userId = localStorage.getItem("userId");
    if (!userId) {
      router.push("/login");
      return;
    }

    setLoading(true);
    api
      .get(`/cards/${userId}`)
      .then((res) => setCards(res.data.data))
      .catch(() => toast.error("Failed to fetch cards"))
      .finally(() => setLoading(false));
  }, [router]);

  async function deleteCard(cardId: number) {
    if (!confirm("Are you sure you want to delete this card?")) return;

    try {
      await api.delete(`/cards/${cardId}`);
      setCards(cards.filter((c) => c.id !== cardId));
      toast.success("Card deleted successfully");
    } catch {
      toast.error("Failed to delete card");
    }
  }

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <Toaster position="top-right" />
      <div className="max-w-5xl mx-auto">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-3xl font-bold text-gray-800">Your Cards</h1>
          <button
            onClick={() => router.push("/cards/new")}
            className="bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-500 transition"
          >
            + New Card
          </button>
        </div>

        {loading ? (
          <p className="text-center text-gray-500">Loading...</p>
        ) : cards.length === 0 ? (
          <p className="text-center text-gray-500">
            No cards found. Click <b>New Card</b> to create one!
          </p>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
            {cards.map((c) => (
              <div
                key={c.id}
                className="bg-white shadow rounded-xl p-5 hover:shadow-lg transition flex flex-col justify-between"
              >
                <div>
                  <h2 className="text-lg font-semibold text-gray-800">
                    {c.profile?.firstName || "Unnamed"}{" "}
                    {c.profile?.lastName || ""}
                  </h2>
                  <p className="text-sm text-gray-500">
                    {c.profile?.designation || "No designation"}
                  </p>
                  <p className="text-sm text-gray-400">
                    {c.profile?.email || ""}
                  </p>
                </div>

                <div className="mt-4 flex justify-between gap-2">
                  <button
                    onClick={() => router.push(`/cards/${c.id}`)}
                    className="bg-indigo-100 text-indigo-700 px-3 py-1 rounded hover:bg-indigo-200 text-sm"
                  >
                    Edit
                  </button>
                  <button
                    onClick={() => deleteCard(c.id)}
                    className="bg-red-100 text-red-700 px-3 py-1 rounded hover:bg-red-200 text-sm"
                  >
                    Delete
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
