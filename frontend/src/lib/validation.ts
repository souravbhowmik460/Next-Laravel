// src/lib/validation.ts
import { z } from "zod";

export const profileSchema = z.object({
  firstName: z.string().min(1, "First name is required"),
  lastName: z.string().min(1, "Last name is required"),
  photo: z.string().url("Invalid photo URL").optional().or(z.literal("")),
  designation: z.string().min(1, "Designation is required"),
  phone: z.string().min(10, "Phone number must be at least 10 digits"),
  email: z.string().email("Invalid email address"),
});

export const businessSchema = z.object({
  company: z.string().min(1, "Company is required"),
  role: z.string().min(1, "Role is required"),
  services: z.array(z.string()).optional(),
});

export const socialSchema = z.object({
  linkedin: z.string().url("Invalid LinkedIn URL").optional().or(z.literal("")),
  twitter: z.string().optional(),
  instagram: z.string().optional(),
  facebook: z.string().optional(),
  website: z.string().url("Invalid website URL").optional().or(z.literal("")),
});

export const aboutSchema = z.object({
  bio: z.string().min(5, "Bio must be at least 5 characters"),
  experience: z.string().min(1, "Experience is required"),
});

export const ctaSchema = z.object({
  call: z.string().optional(),
  whatsapp: z.string().optional(),
  email: z.string().email("Invalid CTA email").optional(),
  website: z.string().url("Invalid CTA website").optional().or(z.literal("")),
});

export const cardSchema = z.object({
  profile: profileSchema,
  business: businessSchema,
  social: socialSchema,
  about: aboutSchema,
  cta: ctaSchema,
});

export type CardFormData = z.infer<typeof cardSchema>;
