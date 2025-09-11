"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import toast from "react-hot-toast";
import api from "@/lib/api";
import { useRouter } from "next/navigation"; // For redirect

// Zod schema
const cardSchema = z.object({
  profile: z.object({
    firstName: z.string().min(1, "First name is required"),
    lastName: z.string().optional(),
    email: z.string().email("Invalid email").optional(),
    phone: z.string().optional(),
    designation: z.string().optional(),
  }),
  business: z.object({
    company: z.string().optional(),
    role: z.string().optional(),
    services: z.array(z.string()).optional(),
  }),
  social: z.object({
    linkedin: z.string().optional(),
    twitter: z.string().optional(),
    instagram: z.string().optional(),
    facebook: z.string().optional(),
    website: z.string().url("Must be a valid URL").optional(),
  }),
  about: z.object({
    bio: z.string().optional(),
    experience: z.string().optional(),
  }),
  cta: z.object({
    call: z.string().optional(),
    whatsapp: z.string().optional(),
    email: z.string().email("Invalid email").optional(),
    website: z.string().url("Must be a valid URL").optional(),
  }),
});

export type CardFormData = z.infer<typeof cardSchema>;

const TABS = ["Profile", "Business", "Social", "About", "CTA"];

// Pill-style Tabs component
function Tabs({ tabs, active, onChange }: { tabs: string[]; active: string; onChange: (tab: string) => void }) {
  return (
    <div className="flex gap-2 overflow-x-auto mb-6">
      {tabs.map((tab) => (
        <button
          key={tab}
          onClick={() => onChange(tab)}
          className={`
            py-2 px-5 rounded-full font-medium whitespace-nowrap
            transition-colors duration-200
            ${active === tab
              ? "bg-indigo-600 text-white shadow-lg"
              : "bg-gray-100 text-gray-700 hover:bg-indigo-100 hover:text-indigo-600"}
          `}
        >
          {tab}
        </button>
      ))}
    </div>
  );
}

export default function CardForm({
  initial,
}: {
  initial?: any;
}) {
  const router = useRouter();
  const [active, setActive] = useState("Profile");

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<CardFormData>({
    resolver: zodResolver(cardSchema),
    defaultValues: initial || {
      profile: {},
      business: {},
      social: {},
      about: {},
      cta: {},
    },
  });

  // Save handler
  const onSubmit = async (data: CardFormData) => {
    try {
      if (initial?.id) {
        await api.put(`/cards/${initial.id}`, data);
        toast.success("Card updated successfully!");
      } else {
        await api.post("/cards", data);
        toast.success("Card created successfully!");
      }

      // Redirect to card list page after success
      router.push("/cards"); // change this to your actual card list route
    } catch (err: any) {
      toast.error(err.response?.data?.message || "Failed to save card");
    }
  };

  // Delete handler
  const handleDelete = async () => {
    if (!initial?.id) return;
    if (!confirm("Are you sure you want to delete this card?")) return;

    try {
      await api.delete(`/cards/${initial.id}`);
      toast.success("Card deleted successfully!");
      router.push("/cards"); // redirect after delete
    } catch (err: any) {
      toast.error(err.response?.data?.message || "Failed to delete card");
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 flex justify-center items-start py-10 px-4">
      <div className="w-full max-w-4xl bg-white rounded-2xl shadow-xl p-8">
        <h1 className="text-2xl font-bold mb-4">Card Form</h1>
        <Tabs tabs={TABS} active={active} onChange={setActive} />

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
          {/* Profile */}
          {active === "Profile" && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block mb-1 font-medium">First Name</label>
                <input {...register("profile.firstName")} className="w-full border rounded-lg px-3 py-2" />
                {errors.profile?.firstName && <p className="text-red-500 text-sm">{errors.profile.firstName.message}</p>}
              </div>
              <div>
                <label className="block mb-1 font-medium">Last Name</label>
                <input {...register("profile.lastName")} className="w-full border rounded-lg px-3 py-2" />
              </div>
              <div>
                <label className="block mb-1 font-medium">Email</label>
                <input {...register("profile.email")} type="email" className="w-full border rounded-lg px-3 py-2" />
                {errors.profile?.email && <p className="text-red-500 text-sm">{errors.profile.email.message}</p>}
              </div>
              <div>
                <label className="block mb-1 font-medium">Phone</label>
                <input {...register("profile.phone")} className="w-full border rounded-lg px-3 py-2" />
              </div>
              <div className="md:col-span-2">
                <label className="block mb-1 font-medium">Designation</label>
                <input {...register("profile.designation")} className="w-full border rounded-lg px-3 py-2" />
              </div>
            </div>
          )}

          {/* Business */}
          {active === "Business" && (
            <div className="grid gap-4">
              <div>
                <label className="block mb-1 font-medium">Company</label>
                <input {...register("business.company")} className="w-full border rounded-lg px-3 py-2" />
              </div>
              <div>
                <label className="block mb-1 font-medium">Role</label>
                <input {...register("business.role")} className="w-full border rounded-lg px-3 py-2" />
              </div>
            </div>
          )}

          {/* Social */}
          {active === "Social" && (
            <div className="grid gap-4">
              <input {...register("social.linkedin")} placeholder="LinkedIn" className="w-full border rounded-lg px-3 py-2" />
              <input {...register("social.twitter")} placeholder="Twitter" className="w-full border rounded-lg px-3 py-2" />
              <input {...register("social.instagram")} placeholder="Instagram" className="w-full border rounded-lg px-3 py-2" />
              <input {...register("social.facebook")} placeholder="Facebook" className="w-full border rounded-lg px-3 py-2" />
              <input {...register("social.website")} placeholder="Website" className="w-full border rounded-lg px-3 py-2" />
            </div>
          )}

          {/* About */}
          {active === "About" && (
            <div className="grid gap-4">
              <div>
                <label className="block mb-1 font-medium">Bio</label>
                <textarea {...register("about.bio")} className="w-full border rounded-lg px-3 py-2" />
              </div>
              <div>
                <label className="block mb-1 font-medium">Experience</label>
                <textarea {...register("about.experience")} className="w-full border rounded-lg px-3 py-2" />
              </div>
            </div>
          )}

          {/* CTA */}
          {active === "CTA" && (
            <div className="grid gap-4">
              <input {...register("cta.call")} placeholder="Call number" className="w-full border rounded-lg px-3 py-2" />
              <input {...register("cta.whatsapp")} placeholder="WhatsApp number" className="w-full border rounded-lg px-3 py-2" />
              <input {...register("cta.email")} placeholder="Email" type="email" className="w-full border rounded-lg px-3 py-2" />
              <input {...register("cta.website")} placeholder="Website" className="w-full border rounded-lg px-3 py-2" />
            </div>
          )}

          {/* Buttons */}
          <div className="flex justify-between mt-6">
            {initial?.id && (
              <button
                type="button"
                onClick={handleDelete}
                className="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-400"
              >
                Delete
              </button>
            )}
            <button
              type="submit"
              disabled={isSubmitting}
              className="bg-indigo-600 text-white px-6 py-2 rounded-lg hover:bg-indigo-500 disabled:opacity-50"
            >
              {isSubmitting ? "Saving..." : "Save"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
